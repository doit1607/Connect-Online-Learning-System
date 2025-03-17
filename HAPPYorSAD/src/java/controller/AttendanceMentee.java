package controller;

import entity.Mentee;
import entity.Mentee_Slot;
import entity.Mentor;
import entity.Request;
import entity.Slot;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DAOslot;
import model.DAOmentee;
import model.DAOMentor;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.Month;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.DAORequest;
import model.DAOatt;
import model.DAOmentee_Slot;
import model.DAOmentor_Slot;
import model.DAOschedule;
import java.time.temporal.ChronoUnit;

public class AttendanceMentee extends HttpServlet {

    private final DAOslot daoSlot = new DAOslot();
    private final DAOmentee daoMentee = new DAOmentee();
    private final DAOMentor daoMentor = new DAOMentor();
    private static final java.util.logging.Logger LOGGER = java.util.logging.Logger.getLogger(AttendanceMentee.class.getName());
    private final DAOschedule daoSc = new DAOschedule();
    private final DAOmentee_Slot daoMSL = new DAOmentee_Slot();
    private final DAOmentor_Slot daoMeSL = new DAOmentor_Slot();
    private final DAOatt daoA = new DAOatt();
    private final DAORequest daoRequest = new DAORequest();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("/HAPPYorSAD/view/LoginUser.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        Integer menteeId = daoMentee.getMenteeIdByUserId(userId);

        // Lấy thông báo từ session nếu có (sau redirect)
        String message = (String) session.getAttribute("message");
        String error = (String) session.getAttribute("error");
        Boolean showModal = (Boolean) session.getAttribute("showModal");
        Boolean showCompletionModal = (Boolean) session.getAttribute("showCompletionModal");
        if (message != null) {
            request.setAttribute("message", message);
            session.removeAttribute("message");
        }
        if (error != null) {
            request.setAttribute("error", error);
            session.removeAttribute("error");
        }
        if (showModal != null) {
            request.setAttribute("mentor", session.getAttribute("mentor"));
            request.setAttribute("slot", session.getAttribute("slot"));
            request.setAttribute("selectedDate", session.getAttribute("selectedDate"));
            request.setAttribute("selectedSlot", session.getAttribute("selectedSlot"));
            request.setAttribute("showModal", showModal);
            session.removeAttribute("mentor");
            session.removeAttribute("slot");
            session.removeAttribute("selectedDate");
            session.removeAttribute("selectedSlot");
            session.removeAttribute("showModal");
        }
        if (showCompletionModal != null) {
            request.setAttribute("notification", session.getAttribute("notification"));
            request.setAttribute("requestId", session.getAttribute("requestId"));
            request.setAttribute("showCompletionModal", showCompletionModal);
            session.removeAttribute("notification");
            session.removeAttribute("requestId");
            session.removeAttribute("showCompletionModal");
        }

        // Ưu tiên lấy month, year, weekOffset từ request attribute (nếu có từ doPost)
        Integer selectedMonthAttr = (Integer) request.getAttribute("selectedMonth");
        Integer selectedYearAttr = (Integer) request.getAttribute("selectedYear");
        Integer weekOffsetAttr = (Integer) request.getAttribute("weekOffset");

        int selectedMonth = (selectedMonthAttr != null) ? selectedMonthAttr : LocalDate.now().getMonthValue();
        int selectedYear = (selectedYearAttr != null) ? selectedYearAttr : LocalDate.now().getYear();
        int weekOffset = (weekOffsetAttr != null) ? weekOffsetAttr : -1; // -1 để đánh dấu chưa xác định

        // Lấy từ parameter nếu có
        String selectedMonthStr = request.getParameter("month");
        String selectedYearStr = request.getParameter("year");
        String weekOffsetStr = request.getParameter("weekOffset");

        if (selectedMonthStr != null && !selectedMonthStr.isEmpty()) {
            try {
                selectedMonth = Integer.parseInt(selectedMonthStr);
            } catch (NumberFormatException e) {
                LOGGER.warning("Invalid month format, using default or attribute: " + e.getMessage());
            }
        }
        if (selectedYearStr != null && !selectedYearStr.isEmpty()) {
            try {
                selectedYear = Integer.parseInt(selectedYearStr);
            } catch (NumberFormatException e) {
                LOGGER.warning("Invalid year format, using default or attribute: " + e.getMessage());
            }
        }
        if (weekOffsetStr != null && !weekOffsetStr.isEmpty()) {
            try {
                weekOffset = Integer.parseInt(weekOffsetStr);
            } catch (NumberFormatException e) {
                LOGGER.warning("Invalid weekOffset format, using default or attribute: " + e.getMessage());
            }
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

        java.sql.Date startDate = daoSc.getStartDateByScheduleId(scheduleId);
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        List<String> weekDates = new ArrayList<>();

        if (startDate != null) {
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(startDate);
            calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);

            if (weekOffset == -1) { // Truy cập lần đầu, hiển thị tuần chứa ngày hiện tại
                LocalDate startLocalDate = startDate.toLocalDate();
                LocalDate currentDate = LocalDate.now();
                long daysBetween = ChronoUnit.DAYS.between(startLocalDate, currentDate);
                weekOffset = (int) (daysBetween / 7);
                LOGGER.info("Calculated weekOffset for current week: " + weekOffset);
            }

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

        Map<String, List<Mentee_Slot>> slotsByDay = new HashMap<>();
        if (startDate != null && menteeId != null) {
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(startDate);
            calendar.add(Calendar.WEEK_OF_YEAR, weekOffset);
            calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);

            for (int i = 0; i < 7; i++) {
                java.sql.Date date = new java.sql.Date(calendar.getTimeInMillis());
                String formattedDate = date.toLocalDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                slotsByDay.put(formattedDate, daoMSL.getSlotsByDateMenteeAttendance(date, menteeId));
                calendar.add(Calendar.DATE, 1);
            }
        }

        System.out.println(slotsByDay);
        request.setAttribute("slotsByDay", slotsByDay);

        request.getRequestDispatcher("/view/AttendanceMentee.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("/HAPPYorSAD/view/LoginUser.jsp");
            return;
        }

        String action = request.getParameter("action");

        // Lấy các tham số month, year, weekOffset từ request
        String selectedMonthStr = request.getParameter("month");
        String selectedYearStr = request.getParameter("year");
        String weekOffsetStr = request.getParameter("weekOffset");

        int selectedMonth = LocalDate.now().getMonthValue();
        int selectedYear = LocalDate.now().getYear();
        int weekOffset = 0;

        if (selectedMonthStr != null && !selectedMonthStr.isEmpty()) {
            selectedMonth = Integer.parseInt(selectedMonthStr);
        }
        if (selectedYearStr != null && !selectedYearStr.isEmpty()) {
            selectedYear = Integer.parseInt(selectedYearStr);
        }
        if (weekOffsetStr != null && !weekOffsetStr.isEmpty()) {
            weekOffset = Integer.parseInt(weekOffsetStr);
        }

        try {
            if ("getMentorInfo".equals(action)) {
                String date = request.getParameter("date");
                int slotNumber = Integer.parseInt(request.getParameter("slot"));
                Slot slot = daoSlot.getSlotByDateAndNumberr(date, slotNumber);
                Mentor mentor = daoMeSL.getMentorBySlotId(date, slotNumber);

                // Lưu thông tin vào session để hiển thị modal sau redirect
                session.setAttribute("mentor", mentor);
                session.setAttribute("slot", slot);
                session.setAttribute("selectedDate", date);
                session.setAttribute("selectedSlot", slotNumber);
                session.setAttribute("showModal", true);

                // Redirect thay vì forward
                response.sendRedirect(request.getContextPath() + "/AttendanceMentee?month=" + selectedMonth + "&year=" + selectedYear + "&weekOffset=" + weekOffset);
            } else if ("confirmAttendance".equals(action)) {
                String date = request.getParameter("date");
                int slotNumber = Integer.parseInt(request.getParameter("slot"));
                String menteeConfirmation = request.getParameter("confirmation");

                Slot slot = daoSlot.getSlotByDateAndNumberr(date, slotNumber);
                if (slot != null) {
                    String currentStatus = slot.getStatus();
                    System.out.println("Current Status: " + currentStatus);
                    try {
                        if (currentStatus.equals("confirm_present") || currentStatus.equals("confirm_absent")) {
                            if ("confirm".equals(menteeConfirmation)) {
                                String finalStatus = currentStatus.equals("confirm_present") ? "present" : "absent";
                                daoMSL.updateMenteeSlotStatusCF(slot.getId(), finalStatus);

                                if ("absent".equals(finalStatus)) {
                                    daoMeSL.updateSlotStatus(slot.getId(), "Cancle");
                                } else if ("present".equals(finalStatus)) {
                                    daoMeSL.updateSlotStatus(slot.getId(), "Done");
                                }
                                LOGGER.info("Attendance confirmed as: " + finalStatus + " for Slot " + slotNumber + " on " + date);
                                session.setAttribute("message", "Attendance confirmed successfully as " + finalStatus + "!");

                                int requestId = slot.getRequest_id();
                                boolean allPresent = daoA.checkAllSlotsPresent(requestId);
                                System.out.println(requestId);

                                if (allPresent) {
                                    Request requestDetails = daoRequest.getRequestById(requestId);
                                    System.out.println(requestDetails);
                                    System.out.println("Đã hoàn thành khóa tất cả Slot trong request");
                                    if (requestDetails != null) {
                                        Mentee mentee = daoMentee.getMenteeById(requestDetails.getMenteeId());
                                        if (mentee != null) {
                                            String notification = "Đã hoàn thành " + requestDetails.getTitle() + " của " + mentee.getName() + ". Nhấn để xác nhận.";
                                            session.setAttribute("notification", notification);
                                            session.setAttribute("requestId", requestId);
                                            session.setAttribute("showCompletionModal", true);
                                        } else {
                                            System.out.println("Mentee not found for requestId: " + requestId);
                                        }
                                    } else {
                                        System.out.println("Request details not found for requestId: " + requestId);
                                    }
                                }
                            } else if ("reject".equals(menteeConfirmation)) {
                                daoMSL.updateMenteeSlotStatusCF(slot.getId(), "rejected_by_mentee");
                                daoMeSL.updateSlotStatus(slot.getId(), "Studying");
                                LOGGER.info("Mentee rejected confirmation for Slot " + slotNumber + " on " + date + ", status remains " + currentStatus);
                                session.setAttribute("message", "Attendance rejected. Please wait for mentor to update.");
                            }
                        } else {
                            LOGGER.warning("Slot status is not pending: " + currentStatus);
                            session.setAttribute("error", "Cannot confirm attendance: Status is already " + currentStatus);
                        }
                    } catch (SQLException ex) {
                        Logger.getLogger(AttendanceMentee.class.getName()).log(Level.SEVERE, "Error updating slot status", ex);
                        session.setAttribute("error", "An error occurred while confirming attendance.");
                    }
                } else {
                    LOGGER.warning("Slot not found for Date: " + date + ", Slot: " + slotNumber);
                    session.setAttribute("error", "Slot not found.");
                }

                // Redirect thay vì forward
                response.sendRedirect(request.getContextPath() + "/AttendanceMentee?month=" + selectedMonth + "&year=" + selectedYear + "&weekOffset=" + weekOffset);
            } else {
                LOGGER.warning("Unknown action: " + action);
                session.setAttribute("error", "Invalid action.");
                response.sendRedirect(request.getContextPath() + "/AttendanceMentee?month=" + selectedMonth + "&year=" + selectedYear + "&weekOffset=" + weekOffset);
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error processing action: " + action, e);
            session.setAttribute("error", "An error occurred. Please try again.");
            response.sendRedirect(request.getContextPath() + "/AttendanceMentee?month=" + selectedMonth + "&year=" + selectedYear + "&weekOffset=" + weekOffset);
        }
    }
}
