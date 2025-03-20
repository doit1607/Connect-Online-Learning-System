package controller;

import entity.Mentor;
import entity.Mentor_Slot;
import java.io.IOException;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import model.DAOMentor;
import model.DAOmentor_Slot;

public class ConfirmSchedule extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ConfirmSchedule.class.getName());
    private final DAOMentor daoMentor = new DAOMentor();
    private final DAOmentor_Slot daoMs = new DAOmentor_Slot();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        LOGGER.info("Processing request for ConfirmSchedule servlet");

        if (session == null || session.getAttribute("userId") == null) {
            LOGGER.warning("No active session or user not logged in");
            response.sendRedirect("/HAPPYorSAD/view/LoginUser.jsp");
            return;
        }

        String action = request.getParameter("action");
        LOGGER.info("Action requested: " + action);

        if ("acceptAllSlots".equals(action)) {
            handleAcceptAllSlots(request, response);
        } else if ("rejectAllSlots".equals(action)) {
            handleRejectAllSlots(request, response);
        } else {
            handleFilterMentors(request, response);
        }
    }

    private void handleFilterMentors(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String monthStr = request.getParameter("month");
        String status = request.getParameter("status");
        String mentorSearch = request.getParameter("mentorSearch");
        String sort = request.getParameter("sort");

        LOGGER.info("Filtering mentors with parameters - month: " + monthStr
                + ", status: " + status
                + ", mentorSearch: " + mentorSearch
                + ", sort: " + sort);

        try {
            Integer month = (monthStr != null && !monthStr.isEmpty()) ? Integer.parseInt(monthStr) : null;

            if (mentorSearch != null && !mentorSearch.isEmpty()) {
                int mentorId = daoMentor.getMentorIdByNameOrId(mentorSearch);
                if (mentorId > 0) {
                    String mentorName = daoMentor.getMentorNameById(mentorId);

                    if (month == null) {
                        // Hiển thị danh sách tháng dựa trên trạng thái
                        if (status == null || status.isEmpty() || status.equals("nonAvailable")) {
                            List<Integer> monthsWithPendingSchedules = daoMs.getMonthsWithPendingSchedules(mentorId);
                            request.setAttribute("monthsWithPendingSchedules", monthsWithPendingSchedules);
                            request.setAttribute("selectedMentorName", mentorName);
                            request.setAttribute("selectedMentorId", mentorId);
                        } else if (status.equals("Available")) {
                            List<Integer> monthsWithAcceptedSchedules = daoMs.getMonthsWithAcceptedSchedules(mentorId);
                            request.setAttribute("monthsWithAcceptedSchedules", monthsWithAcceptedSchedules);
                            request.setAttribute("selectedMentorName", mentorName);
                            request.setAttribute("selectedMentorId", mentorId);
                        }
                    } else {
                        // Hiển thị lịch trình chi tiết trong tháng với filter status
                        List<Mentor_Slot> allSlots = daoMs.getFilteredSlots(month, status, mentorSearch);
                        if (!allSlots.isEmpty()) {
                            if ("dateAsc".equals(sort)) {
                                Collections.sort(allSlots, Comparator.comparing(Mentor_Slot::getSlot_date));
                            } else if ("dateDesc".equals(sort)) {
                                Collections.sort(allSlots, Comparator.comparing(Mentor_Slot::getSlot_date, Comparator.reverseOrder()));
                            }

                            Mentor_Slot[][] scheduleMatrix = new Mentor_Slot[5][7];
                            Calendar cal = Calendar.getInstance();

                            for (Mentor_Slot slot : allSlots) {
                                Date slotDate = slot.getSlot_date();
                                cal.setTime(slotDate);
                                int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK) - 2;
                                if (dayOfWeek < 0) {
                                    dayOfWeek = 6;
                                }
                                int slotNumber = slot.getSlot_number_id() - 1;
                                if (slotNumber >= 0 && slotNumber < 5 && dayOfWeek >= 0 && dayOfWeek < 7) {
                                    scheduleMatrix[slotNumber][dayOfWeek] = slot;
                                }
                            }

                            request.setAttribute("scheduleMatrix", scheduleMatrix);
                            request.setAttribute("allSlots", allSlots);
                            request.setAttribute("selectedMentorId", mentorId);
                            request.setAttribute("selectedMentorName", mentorName);
                        }
                    }
                } else {
                    LOGGER.info("No mentor found for search: " + mentorSearch);
                }
            } else {
                List<Mentor> mentorsWithPendingSchedules = daoMentor.getMentorsWithPendingSchedules();
                request.setAttribute("mentorsWithPendingSchedules", mentorsWithPendingSchedules);
                LOGGER.info("Retrieved " + mentorsWithPendingSchedules.size() + " mentors with pending schedules");
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error filtering mentors: " + e.getMessage(), e);
            request.setAttribute("message", "Error occurred while filtering mentors.");
        }

        LOGGER.info("Forwarding to ScheduleManager.jsp");
        request.getRequestDispatcher("view/ScheduleManager.jsp").forward(request, response);
    }

    private void handleAcceptAllSlots(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String mentorIdStr = request.getParameter("mentorId");
        String[] slotIds = request.getParameterValues("slotIds");

        LOGGER.info("Confirming all slots for mentorId: " + mentorIdStr
                + ", number of slots: " + (slotIds != null ? slotIds.length : 0));

        if (mentorIdStr == null || slotIds == null || slotIds.length == 0) {
            LOGGER.warning("Missing mentorId or slotIds in request parameters");
            request.setAttribute("message", "Missing mentor ID or slots to confirm.");
            handleFilterMentors(request, response);
            return;
        }

        try {
            int mentorId = Integer.parseInt(mentorIdStr);
            int confirmedCount = 0;

            for (String slotIdStr : slotIds) {
                int slotId = Integer.parseInt(slotIdStr);
                if (slotId > 0) {
                    daoMs.updateSlotStatus2(mentorId, slotId, "Available");
                    LOGGER.info("Confirmed slot ID " + slotId + " for mentorId: " + mentorId);
                    confirmedCount++;
                }
            }
            LOGGER.info("Successfully confirmed " + confirmedCount + " slots");
            request.setAttribute("message", "Confirmed " + confirmedCount + " slots successfully!");
        } catch (NumberFormatException e) {
            LOGGER.warning("Invalid mentorId format: " + mentorIdStr);
            request.setAttribute("message", "Invalid mentor ID.");
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "SQL error: " + ex.getMessage(), ex);
        }
        handleFilterMentors(request, response);
    }

    private void handleRejectAllSlots(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String mentorIdStr = request.getParameter("mentorId");
        String[] slotIds = request.getParameterValues("slotIds");

        LOGGER.info("Rejecting all slots for mentorId: " + mentorIdStr
                + ", number of slots: " + (slotIds != null ? slotIds.length : 0));

        if (mentorIdStr == null || slotIds == null || slotIds.length == 0) {
            LOGGER.warning("Missing mentorId or slotIds in request parameters");
            request.setAttribute("message", "Missing mentor ID or slots to reject.");
            handleFilterMentors(request, response);
            return;
        }

        try {
            int mentorId = Integer.parseInt(mentorIdStr);
            int rejectedCount = 0;

            for (String slotIdStr : slotIds) {
                int slotId = Integer.parseInt(slotIdStr);
                if (slotId > 0) {
                    daoMs.updateSlotStatus2(mentorId, slotId, "Rejected");
                    LOGGER.info("Rejected slot ID " + slotId + " for mentorId: " + mentorId);
                    rejectedCount++;
                }
            }
            LOGGER.info("Successfully rejected " + rejectedCount + " slots");
            request.setAttribute("message", "Rejected " + rejectedCount + " slots successfully!");
        } catch (NumberFormatException e) {
            LOGGER.warning("Invalid mentorId format: " + mentorIdStr);
            request.setAttribute("message", "Invalid mentor ID.");
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "SQL error: " + ex.getMessage(), ex);
        }
        handleFilterMentors(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LOGGER.info("Received GET request");
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LOGGER.info("Received POST request");
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for Manager to Confirm Mentor Schedules";
    }
}