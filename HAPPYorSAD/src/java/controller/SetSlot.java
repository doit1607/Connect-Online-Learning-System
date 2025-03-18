package controller;

import model.DAOmentor_Slot;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Month;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DAOMentor;
import model.DAOschedule;
import model.DAOslot;
import entity.SlotTemplate;
import entity.Schedule;
import entity.TempSlot;

public class SetSlot extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(SetSlot.class.getName());
    private final DAOslot daoSlot = new DAOslot();
    private final DAOschedule daoSc = new DAOschedule();
    private final DAOmentor_Slot daoMs = new DAOmentor_Slot();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("/HAPPYorSAD/view/LoginUser.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        Integer mentorId = DAOMentor.getMentorIdByUserId(userId);
        String action = request.getParameter("action");

        // Default values for "Your Schedule" (current month)
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
        }

        // Get schedules for "Your Schedule" (current month or selected)
        List<Schedule> schedules = daoSc.getSchedulesByMonth(selectedYear, selectedMonth);
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
            scheduleId = schedules.get(0).getId(); // Default to first schedule
        }
        request.setAttribute("scheduleId", scheduleId);

        // Calculate next month for "General Availability"
        LocalDate nextMonthDate = LocalDate.now().plusMonths(1);
        int nextMonth = nextMonthDate.getMonthValue();
        int nextYear = nextMonthDate.getYear();
        int nextScheduleId = daoSc.getScheduleIdByMonth(nextMonth, nextYear);
        LOGGER.log(Level.INFO, "Next month for General Availability: {0}/{1}, scheduleId: {2}",
                new Object[]{nextMonth, nextYear, nextScheduleId});
        request.setAttribute("nextMonth", nextMonth);
        request.setAttribute("nextYear", nextYear);
        request.setAttribute("nextScheduleId", nextScheduleId);

        // Prepare week days and dates for "Your Schedule"
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
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        // Calculate the nearest future Monday
        LocalDate currentDate = LocalDate.now(); // Today: 2025-03-18
        LocalDate selectedMonthStart = LocalDate.of(selectedYear, selectedMonth, 1);
        LocalDate targetDate = currentDate.isBefore(selectedMonthStart) ? selectedMonthStart : currentDate;

        Calendar calendar = Calendar.getInstance();
        calendar.setTime(Date.valueOf(targetDate));
        int daysUntilMonday = (Calendar.MONDAY - calendar.get(Calendar.DAY_OF_WEEK) + 7) % 7;
        calendar.add(Calendar.DATE, daysUntilMonday);
        calendar.add(Calendar.WEEK_OF_YEAR, weekOffset);
        String nextMonday = new java.sql.Date(calendar.getTimeInMillis()).toLocalDate().format(dateFormatter);
        weekDates.add(nextMonday); // Monday is the nearest future Monday (e.g., 2025-04-07)
        LOGGER.info("Next Monday: " + nextMonday);

        // Add the first week of the month for Tuesday-Sunday (e.g., 2025-04-01 to 2025-04-06)
        calendar.setTime(Date.valueOf(selectedMonthStart)); // Start from April 1st
        for (int i = 0; i < 6; i++) {
            String formattedDate = new java.sql.Date(calendar.getTimeInMillis()).toLocalDate().format(dateFormatter);
            weekDates.add(formattedDate);
            LOGGER.info("Week date " + weekDays[i + 1] + ": " + formattedDate);
            calendar.add(Calendar.DATE, 1);
        }

        request.setAttribute("weekDates", weekDates);
        // Adjust weekStartDate and weekEndDate to reflect Tuesday-Sunday
        String weekStartDate = weekDates.isEmpty() ? "" : weekDates.get(1); // April 1st
        String weekEndDate = weekDates.isEmpty() ? "" : weekDates.get(6);   // April 6th
        request.setAttribute("weekOffset", weekOffset);
        request.setAttribute("weekStartDate", weekStartDate);
        request.setAttribute("weekEndDate", weekEndDate);

        // Slots by day for "Your Schedule"
        Map<String, List<entity.Slot>> slotsByDay = new HashMap<>();
        if (mentorId != null) {
            for (String dateStr : weekDates) {
                java.sql.Date date = java.sql.Date.valueOf(dateStr);
                String formattedDate = date.toLocalDate().format(dateFormatter);
                List<entity.Slot> slots = daoMs.getSlotsByDate1(date, mentorId);
                slotsByDay.put(formattedDate, slots);
                LOGGER.info("Slots for " + formattedDate + ": " + slots.size());
            }
        }
        request.setAttribute("slotsByDay", slotsByDay);

        // Slots by day for "General Availability" (next month)
        // Slots by day for "General Availability" (next month)
        List<String> nextWeekDates = new ArrayList<>();
        java.sql.Date nextStartDate = daoSc.getStartDateByScheduleId(nextScheduleId);
        if (nextStartDate != null) {
            calendar = Calendar.getInstance();
            calendar.setTime(nextStartDate);
            // Instead of forcing to Monday, start from nextStartDate and adjust if needed
            LOGGER.info("Start date for nextWeekDates: " + nextStartDate);

            for (int i = 0; i < 7; i++) {
                String formattedDate = new java.sql.Date(calendar.getTimeInMillis()).toLocalDate().format(dateFormatter);
                nextWeekDates.add(formattedDate);
                LOGGER.info("Next week date " + i + ": " + formattedDate);
                calendar.add(Calendar.DATE, 1);
            }
        } else {
            LOGGER.warning("nextStartDate is null for nextScheduleId: " + nextScheduleId);
        }
        request.setAttribute("nextWeekDates", nextWeekDates);

        Map<String, List<entity.Slot>> nextSlotsByDay = new HashMap<>();
        if (nextStartDate != null && mentorId != null) {
            calendar = Calendar.getInstance();
            calendar.setTime(nextStartDate); // Reset calendar to nextStartDate
            // Remove the DAY_OF_WEEK reset to ensure we start from nextStartDate

            for (int i = 0; i < 7; i++) {
                java.sql.Date date = new java.sql.Date(calendar.getTimeInMillis());
                String formattedDate = date.toLocalDate().format(dateFormatter);
                List<entity.Slot> slots = daoMs.getSlotsByDate1(date, mentorId);
                nextSlotsByDay.put(formattedDate, slots);
                LOGGER.info("Next slots for " + formattedDate + ": " + slots.size());
                LOGGER.info("Date: " + formattedDate + ", Slots: " + slots);
                calendar.add(Calendar.DATE, 1);
            }
        }
        request.setAttribute("nextSlotsByDay", nextSlotsByDay);
        // Lấy danh sách các tháng đã set slot (trừ tháng hiện tại) cho General Availability
        int currentMonth = currentDate.getMonthValue();
        int currentYear = currentDate.getYear();

        List<Schedule> allAssignedSchedules = daoSc.getAssignedSchedulesByMentor(mentorId);
        List<String> assignedMonthsForGeneral = new ArrayList<>();

        for (Schedule schedule : allAssignedSchedules) {
            Date startDatee = schedule.getStart_date();
            if (startDatee != null) {
                Calendar cal = Calendar.getInstance();
                cal.setTime(startDatee);
                int scheduleMonth = cal.get(Calendar.MONTH) + 1;
                int scheduleYear = cal.get(Calendar.YEAR);

                if (!(scheduleMonth == currentMonth && scheduleYear == currentYear)) {
                    assignedMonthsForGeneral.add(scheduleMonth + " " + scheduleYear);
                }
            }
        }

        request.setAttribute("assignedMonthsForGeneral", assignedMonthsForGeneral);
        LOGGER.log(Level.INFO, "Assigned months for General Availability for mentorId {0}: {1}",
                new Object[]{mentorId, assignedMonthsForGeneral});

        // Handle actions for POST requests
        if ("POST".equalsIgnoreCase(request.getMethod()) && action != null) {
            if ("add".equals(action)) {
                handleAddSlot(request, response, session, nextScheduleId, mentorId);
                return;
            } else if ("save".equals(action)) {
                handleSaveSlots(request, response, session, nextScheduleId, mentorId);
                return;
            } else if ("addSchedule".equals(action)) {
                handleAddSchedule(request, response, mentorId, nextMonth, nextYear);
                return;
            } else if ("selectSchedule".equals(action)) {
                session.setAttribute("scheduleId", scheduleId);
            }
        }

        request.getRequestDispatcher("view/SetSlot.jsp").forward(request, response);
    }

    private void handleAddSlot(HttpServletRequest request, HttpServletResponse response, HttpSession session, int scheduleId, Integer mentorId)
            throws IOException {
        String slotDateStr = request.getParameter("slot_date");
        String slotNumberStr = request.getParameter("slotNumber");
        Map<Integer, String> slotTimeMap = Map.of(1, "07:30:00", 2, "10:00:00", 3, "13:00:00", 4, "15:30:00", 5, "19:30:00");

        if (slotDateStr != null && slotNumberStr != null) {
            Date selectedDate = Date.valueOf(slotDateStr);
            int slotNumber = Integer.parseInt(slotNumberStr);
            String startTime = slotTimeMap.get(slotNumber);

            Map<Date, List<TempSlot>> tempSlotsByDate = (Map<Date, List<TempSlot>>) session.getAttribute("tempSlotsByDate");
            if (tempSlotsByDate == null) {
                tempSlotsByDate = new HashMap<>();
            }

            java.sql.Date startDate = daoSc.getStartDateByScheduleId(scheduleId);
            if (startDate == null) {
                session.setAttribute("message", "Invalid schedule");
                response.sendRedirect("SetSlot");
                return;
            }

            Calendar cal = Calendar.getInstance();
            cal.setTime(startDate);
            int month = cal.get(Calendar.MONTH);
            int year = cal.get(Calendar.YEAR);

            cal.setTime(selectedDate);
            int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
            LOGGER.info("Selected day of week: " + dayOfWeek + " for date: " + selectedDate);

            cal.setTime(startDate);
            cal.set(Calendar.DAY_OF_MONTH, 1);
            while (cal.get(Calendar.MONTH) == month && cal.get(Calendar.YEAR) == year) {
                if (cal.get(Calendar.DAY_OF_WEEK) == dayOfWeek) {
                    Date date = new Date(cal.getTimeInMillis());
                    LOGGER.info("Found matching day: " + date);
                    List<TempSlot> tempSlots = tempSlotsByDate.getOrDefault(date, new ArrayList<>());
                    int slotId = daoSlot.getSlotId(scheduleId, date, slotNumber);

                    if (slotId > 0) {
                        if (tempSlots.stream().noneMatch(slot -> slot.getSlotNumber() == slotNumber)) {
                            TempSlot newSlot = new TempSlot(scheduleId, date, slotNumber, startTime, "Available");
                            tempSlots.add(newSlot);
                            tempSlotsByDate.put(date, tempSlots);
                        }
                    }
                }
                cal.add(Calendar.DATE, 1);
            }
            session.setAttribute("tempSlotsByDate", tempSlotsByDate);
            session.setAttribute("message", "Slot added successfully");
        } else {
            session.setAttribute("message", "Invalid input");
        }
        response.sendRedirect("SetSlot");
    }

    private void handleSaveSlots(HttpServletRequest request, HttpServletResponse response, HttpSession session, int scheduleId, Integer mentorId)
            throws IOException {
        Map<Date, List<TempSlot>> tempSlotsByDate = (Map<Date, List<TempSlot>>) session.getAttribute("tempSlotsByDate");
        if (tempSlotsByDate != null && !tempSlotsByDate.isEmpty()) {
            for (Map.Entry<Date, List<TempSlot>> entry : tempSlotsByDate.entrySet()) {
                Date slotDate = entry.getKey();
                for (TempSlot slot : entry.getValue()) {
                    int slotNumber = slot.getSlotNumber();
                    int slotId = daoSlot.getSlotId(scheduleId, slotDate, slotNumber);
                    if (slotId > 0) {
                        daoMs.addSlotss(mentorId, slotId, "nonAvailable");
                    }
                }
            }
            session.removeAttribute("tempSlotsByDate");
            session.setAttribute("message", "Slots saved successfully!");
        } else {
            session.setAttribute("message", "No slots to save.");
        }
        response.sendRedirect("SetSlot");
    }

    private void handleAddSchedule(HttpServletRequest request, HttpServletResponse response, int mentorId, int selectedMonth, int selectedYear)
            throws IOException {
        HttpSession session = request.getSession(false);
        LOGGER.log(Level.INFO, "Starting handleAddSchedule for mentorId: {0}, selectedMonth: {1}, selectedYear: {2}",
                new Object[]{mentorId, selectedMonth, selectedYear});

        int nextMonth = (selectedMonth % 12) + 1;
        int nextYear = (selectedMonth == 12) ? selectedYear + 1 : selectedYear;
        int nextScheduleId = daoSc.getScheduleIdByMonth(nextMonth, nextYear);

        LOGGER.log(Level.INFO, "Checking initial next month: {0}/{1}, scheduleId: {2}",
                new Object[]{nextMonth, nextYear, nextScheduleId});

        while (nextScheduleId != -1 && daoSc.isScheduleAssignedToMentor(mentorId, nextScheduleId)) {
            nextMonth = (nextMonth % 12) + 1;
            nextYear = (nextMonth == 1) ? nextYear + 1 : nextYear;
            nextScheduleId = daoSc.getScheduleIdByMonth(nextMonth, nextYear);
            LOGGER.log(Level.INFO, "Month {0}/{1} already assigned, checking next: {2}/{3}, scheduleId: {4}",
                    new Object[]{selectedMonth, selectedYear, nextMonth, nextYear, nextScheduleId});
        }

        if (nextScheduleId == -1) {
            LOGGER.log(Level.WARNING, "No schedule available for month {0}/{1}, creating a new one",
                    new Object[]{nextMonth, nextYear});
            session.setAttribute("message", "No existing schedule for " + nextMonth + "/" + nextYear + ". Please contact admin to create one.");
            response.sendRedirect("SetSlot");
            return;
        }

        LOGGER.log(Level.INFO, "Attempting to add schedule with mentorId: {0}, nextScheduleId: {1}",
                new Object[]{mentorId, nextScheduleId});
        boolean success = daoSc.addSchedule(mentorId, nextScheduleId);

        if (success) {
            LOGGER.log(Level.INFO, "Successfully added schedule for mentorId: {0}, scheduleId: {1}",
                    new Object[]{mentorId, nextScheduleId});
            session.setAttribute("scheduleId", nextScheduleId);
            session.setAttribute("message", "Schedule for " + nextMonth + "/" + nextYear + " added successfully!");
            response.sendRedirect("SetSlot?month=" + nextMonth + "&year=" + nextYear);
        } else {
            LOGGER.log(Level.SEVERE, "Failed to add schedule for mentorId: {0}, scheduleId: {1}",
                    new Object[]{mentorId, nextScheduleId});
            session.setAttribute("message", "Failed to add schedule for " + nextMonth + "/" + nextYear + ".");
            response.sendRedirect("SetSlot");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Slot Management Servlet";
    }
}
