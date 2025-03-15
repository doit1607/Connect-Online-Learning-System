/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Mentee;
import entity.Mentee_Slot;
import entity.Mentor_Slot;
import entity.Request;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Month;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import model.DAOMentor;
import model.DAOmentee;
import model.DAOschedule;
import model.DAOslot;
import entity.Slot;
import model.DAORequest;
import model.DAOatt;
import model.DAOmentee_Slot;
import model.DAOmentor_Slot;

/**
 *
 * @author Ann
 */
public class Attendance extends HttpServlet {

    private static final java.util.logging.Logger LOGGER = java.util.logging.Logger.getLogger(Attendance.class.getName());
    private final DAOslot daoSlot = new DAOslot();
    private final DAOmentor_Slot daoMSL = new DAOmentor_Slot();
    private final DAOmentee_Slot daoMeSL = new DAOmentee_Slot();

    private final DAOschedule daoSc = new DAOschedule();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Attendance</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Attendance at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("/HAPPYorSAD/view/LoginUser.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        Integer mentorId = DAOMentor.getMentorIdByUserId(userId);

        int selectedMonth = LocalDate.now().getMonthValue();
        int selectedYear = LocalDate.now().getYear();
        String selectedMonthStr = request.getParameter("month");
        String selectedYearStr = request.getParameter("year");

        if (selectedMonthStr != null && selectedYearStr != null && !selectedMonthStr.isEmpty() && !selectedYearStr.isEmpty()) {
            try {
                selectedMonth = Integer.parseInt(selectedMonthStr);
                selectedYear = Integer.parseInt(selectedYearStr);
                LOGGER.info("User selected month: " + selectedMonth + ", year: " + selectedYear);
            } catch (NumberFormatException e) {
                LOGGER.warning("Invalid month/year format, defaulting to current: " + e.getMessage());
            }
        } else {
            LOGGER.info("No month/year selected, using default: " + selectedMonth + ", " + selectedYear);
        }

        List<entity.Schedule> schedules = daoSc.getSchedulesByMonth(selectedYear, selectedMonth);
        String scheduleHeader = "Schedules for " + Month.of(selectedMonth) + " " + selectedYear;
        request.setAttribute("scheduleHeader", scheduleHeader);
        request.setAttribute("schedules", schedules);
        request.setAttribute("selectedMonth", selectedMonth);
        request.setAttribute("selectedYear", selectedYear);

        int scheduleId = -1;
        String scheduleIdStr = request.getParameter("scheduleId");
        if (scheduleIdStr != null && !scheduleIdStr.isEmpty()) {
            try {
                scheduleId = Integer.parseInt(scheduleIdStr);
            } catch (NumberFormatException e) {
                LOGGER.info("Invalid scheduleId, defaulting to -1: " + e.getMessage());
            }
        } else if (!schedules.isEmpty()) {
            scheduleId = schedules.get(0).getId();
        }
        request.setAttribute("scheduleId", scheduleId);

        String[] weekDays = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
        request.setAttribute("weekDays", weekDays);

        int weekOffset = 0;
        String weekOffsetStr = request.getParameter("weekOffset");
        if (weekOffsetStr != null) {
            try {
                weekOffset = Integer.parseInt(weekOffsetStr);
            } catch (NumberFormatException e) {
                LOGGER.warning("Invalid weekOffset, defaulting to 0: " + e.getMessage());
            }
        }

        List<String> weekDates = new ArrayList<>();
        java.sql.Date startDate = daoSc.getStartDateByScheduleId(scheduleId);
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        if (startDate != null) {
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(startDate);
            calendar.add(Calendar.WEEK_OF_YEAR, weekOffset);
            calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);

            for (int i = 0; i < 7; i++) {
                weekDates.add(new java.sql.Date(calendar.getTimeInMillis()).toLocalDate().format(dateFormatter));
                calendar.add(Calendar.DATE, 1);
            }
        }
        request.setAttribute("weekDates", weekDates);

        String weekStartDate = weekDates.isEmpty() ? "" : weekDates.get(0);
        String weekEndDate = weekDates.isEmpty() ? "" : weekDates.get(6);
        request.setAttribute("weekOffset", weekOffset);
        request.setAttribute("weekStartDate", weekStartDate);
        request.setAttribute("weekEndDate", weekEndDate);

        Map<String, List<entity.Mentor_Slot>> slotsByDay = new HashMap<>();
        if (startDate != null && mentorId != null) {
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(startDate);
            calendar.add(Calendar.WEEK_OF_YEAR, weekOffset);
            calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);

            for (int i = 0; i < 7; i++) {
                java.sql.Date date = new java.sql.Date(calendar.getTimeInMillis());
                String formattedDate = date.toLocalDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                slotsByDay.put(formattedDate, daoMSL.getSlotsByDateMentorAttendance(date, mentorId));
                calendar.add(Calendar.DATE, 1);
            }
        }
        request.setAttribute("slotsByDay", slotsByDay);

        request.getRequestDispatcher("view/Attendance.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println("Received action: " + action); // Debug action
        DAOmentee daoM = new DAOmentee();
        DAOatt daoA = new DAOatt();
        DAORequest daoR = new DAORequest();
        try {
            if ("getMentees".equals(action)) {
                String date = request.getParameter("date");
                String slotNumberStr = request.getParameter("slot");
                int slotNumber = Integer.parseInt(slotNumberStr);

                System.out.println("Fetching mentees for Date: " + date + ", Slot: " + slotNumber);

                Mentee m = daoMeSL.getMenteeBySlotId(date, slotNumber);
                if (m != null) {
                    System.out.println("Mentee found: " + m.getImage() + " and " + m.getName() + " (" + m.getEmail() + ")");
                } else {
                    System.out.println("No mentee found for Date: " + date + ", Slot: " + slotNumber);
                }

                Slot slot = daoSlot.getSlotByDateAndNumber(date, slotNumber);

                request.setAttribute("slot", slot); // Add slot to retrieve status
                request.setAttribute("mentee", m);
                request.setAttribute("selectedDate", date);
                request.setAttribute("selectedSlot", slotNumber);
                request.setAttribute("showModal", true);

                doGet(request, response);
            } else if ("saveAttendance".equals(action)) {
                String date = request.getParameter("date");
                String slotNumberStr = request.getParameter("slot");
                String status = request.getParameter("status"); // present or absent

                int slotNumber = Integer.parseInt(slotNumberStr);
                System.out.println("Updating attendance for Date: " + date + ", Slot: " + slotNumber + " to " + status);

                // Lấy slot từ DAO
                Mentor_Slot slot = (Mentor_Slot) daoMSL.getSlotsByDateMentorAtt(date, slotNumber);
                String menteeStatus = status.equals("present") ? "confirm_present" : "confirm_absent";
                Mentee_Slot menteeSlot = daoMeSL.getMenteeSlotsByMentorSlotId(slot.getSlot_id());
                if (menteeSlot != null) {
                    daoMeSL.updateSlotStatus(menteeSlot.getSlot_id(), menteeStatus);
                    System.out.println("Mentee slots updated to " + menteeStatus);
                } else {
                    System.out.println("No mentee slots found for this mentor slot");
                }

                if (slot != null) {

                    // Cập nhật trạng thái slot
                    daoMSL.updateSlotStatus(slot.getSlot_id(), status);
                    System.out.println("Slot updated successfully to " + status);

                    // Lấy requestId từ slot (giả định Slot có thuộc tính requestId)
                    int requestId = slot.getRequest_id();

                    // Kiểm tra xem tất cả slot của requestId có "present" không
//                    boolean allPresent = daoA.checkAllSlotsPresent(requestId);
//                    System.out.println(requestId);
//
//                    if (allPresent) {
//                        Request requestDetails = daoR.getRequestById(requestId); // Lấy thông tin request
//                        System.out.println(requestDetails);
//                        System.out.println("Đã hoàn thành khóa tất cả Slot trong request");
//                        if (requestDetails != null) {
//                            Mentee mentee = daoM.getMenteeById(requestDetails.getMenteeId()); // Lấy mentee dựa trên menteeId từ request
//                            if (mentee != null) {
//                                String notification = "Đã hoàn thành " + requestDetails.getTitle() + " của " + mentee.getName() + ". Nhấn để xác nhận.";
//                                request.setAttribute("notification", notification);
//                                request.setAttribute("requestId", requestId);
//                            } else {
//                                System.out.println("Mentee not found for requestId: " + requestId);
//                            }
//                        } else {
//                            System.out.println("Request details not found for requestId: " + requestId);
//                        }
//                    }
                } else {
                    System.out.println("Failed to update slot status: Slot not found");
                }

                request.setAttribute("message", "Attendance saved successfully!");
                doGet(request, response);
            } else if ("viewAttendance".equals(action)) {
                // New action to view attendance details for marked slots
                String date = request.getParameter("date");
                String slotNumberStr = request.getParameter("slot");
                int slotNumber = Integer.parseInt(slotNumberStr);

                System.out.println("Viewing attendance for Date: " + date + ", Slot: " + slotNumber);

                Mentee m = daoM.getMenteeBySlotId(date, slotNumber);
                if (m != null) {
                    System.out.println("Mentee found: " + m.getImage() + " and " + m.getName() + " (" + m.getEmail() + ")");
                } else {
                    System.out.println("No mentee found for Date: " + date + ", Slot: " + slotNumber);
                }

                Slot slot = daoSlot.getSlotByDateAndNumber(date, slotNumber);
                if (slot == null) {
                    System.out.println("Slot not found for Date: " + date + ", Slot: " + slotNumber);
                }

                request.setAttribute("slot", slot); // Add slot to retrieve status
                request.setAttribute("mentee", m);
                request.setAttribute("selectedDate", date);
                request.setAttribute("selectedSlot", slotNumber);
                request.setAttribute("showModal", true);

                doGet(request, response); // Reload the page with modal data
            } else {
                System.out.println("Unknown action: " + action);
                request.setAttribute("error", "Invalid action.");
                doGet(request, response);
            }
        } catch (Exception e) {
            System.out.println("Error processing action: " + action);
            e.printStackTrace(); // Log the error
            request.setAttribute("error", "An error occurred. Please try again.");
            doGet(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet for managing attendance of mentees without JSON";
    }
}
