package controller;

import entity.Mentor;
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
import model.DAOschedule;

public class AttendanceMentee extends HttpServlet {

    private final DAOslot daoSlot = new DAOslot();
    private final DAOmentee daoMentee = new DAOmentee();
    private final DAOMentor daoMentor = new DAOMentor();
    private static final java.util.logging.Logger LOGGER = java.util.logging.Logger.getLogger(Attendance.class.getName());
    private final DAOschedule daoSc = new DAOschedule();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("/HAPPYorSAD/view/LoginUser.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        Integer menteeId = daoMentee.getMenteeIdByUserId(userId); // Assume this method exists

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

        Map<String, List<Slot>> slotsByDay = new HashMap<>();
        // Fetch slots for the mentee using DAOslot
        if (startDate != null && menteeId != null) {
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(startDate);
            calendar.add(Calendar.WEEK_OF_YEAR, weekOffset);
            calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);

            for (int i = 0; i < 7; i++) {
                java.sql.Date date = new java.sql.Date(calendar.getTimeInMillis());
                String formattedDate = date.toLocalDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                slotsByDay.put(formattedDate, daoSlot.getSlotsByDate3(date, menteeId));
                calendar.add(Calendar.DATE, 1);
            }
        }

        request.setAttribute("weekDates", weekDates);
        request.setAttribute("slotsByDay", slotsByDay);
        request.setAttribute("weekStartDate", weekStartDate);
        request.setAttribute("weekEndDate", weekEndDate);
        request.setAttribute("selectedMonth", selectedMonth);
        request.setAttribute("selectedYear", selectedYear);
        request.setAttribute("weekOffset", weekOffset);

        request.getRequestDispatcher("/view/AttendanceMentee.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("getMentorInfo".equals(action)) {
            String date = request.getParameter("date");
            int slotNumber = Integer.parseInt(request.getParameter("slot"));
            Slot slot = daoSlot.getSlotByDateAndNumber(date, slotNumber);

            Mentor mentor = daoMentor.getMentorBySlotId(date, slotNumber); // Assume this method exists
            request.setAttribute("mentor", mentor);
            request.setAttribute("selectedDate", date);
            request.setAttribute("selectedSlot", slotNumber);
            request.setAttribute("showModal", true);
            doGet(request, response);
        } else if ("confirmAttendance".equals(action)) {
            String date = request.getParameter("date");
            int slotNumber = Integer.parseInt(request.getParameter("slot"));
            Slot slot = daoSlot.getSlotByDateAndNumber(date, slotNumber);
            if (slot != null && "presentPending".equals(slot.getStatus())) {
                try {
                    daoSlot.updateSlotStatus(slot.getId(), "present"); // Confirm as present
                    request.setAttribute("message", "Attendance confirmed successfully!");
                } catch (SQLException ex) {
                    Logger.getLogger(AttendanceMentee.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            doGet(request, response);
        }
    }
}
