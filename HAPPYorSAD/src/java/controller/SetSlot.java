package controller;

import model.DAOmentor_Slot;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DAOMentor;
import model.DAOschedule;
import model.DAOslot;
import entity.Schedule;
import entity.TempSlot;
import java.util.logging.Logger;

public class SetSlot extends HttpServlet {

    private final DAOslot daoSlot = new DAOslot();
    private final DAOschedule daoSc = new DAOschedule();
    private final DAOmentor_Slot daoMs = new DAOmentor_Slot();
    private static final Logger LOGGER = Logger.getLogger(SetSlot.class.getName());

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

        // Lấy scheduleId từ session nếu có, nếu không thì dùng mặc định
        Integer sessionScheduleId = (Integer) session.getAttribute("currentScheduleId");
        LocalDate currentDate = LocalDate.now();
        LocalDate nextMonthDate = currentDate.plusMonths(1);
        int nextMonth = nextMonthDate.getMonthValue();
        int nextYear = nextMonthDate.getYear();
        int nextScheduleId = (sessionScheduleId != null) ? sessionScheduleId : daoSc.getScheduleIdByMonth(nextMonth, nextYear);

        // Handle specific actions
        if ("changeMonth".equals(action)) {
            handleChangeMonth(request, response, mentorId);
            return;
        } else if ("selectSchedule".equals(action)) {
            String scheduleIdStr = request.getParameter("scheduleId");
            if (scheduleIdStr != null) {
                int selectedScheduleId = Integer.parseInt(scheduleIdStr);
                Schedule selectedSchedule = daoSc.getScheduleById(selectedScheduleId);
                if (selectedSchedule != null && selectedSchedule.getStart_date() != null) {
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(selectedSchedule.getStart_date());
                    nextMonth = cal.get(Calendar.MONTH) + 1;
                    nextYear = cal.get(Calendar.YEAR);
                    nextScheduleId = selectedScheduleId;
                    session.setAttribute("currentScheduleId", nextScheduleId); // Cập nhật session
                    updateScheduleData(request, nextScheduleId, mentorId);
                }
            }
        } else if ("POST".equalsIgnoreCase(request.getMethod())) {
            if ("add".equals(action)) {
                handleAddSlot(request, response, session, nextScheduleId, mentorId);
                return;
            } else if ("save".equals(action)) {
                handleSaveSlots(request, response, session, nextScheduleId, mentorId);
                return;
            } else if ("addSchedule".equals(action)) {
                handleAddSchedule(request, response, mentorId, nextMonth, nextYear);
                return;
            } else if ("deleteTemp".equals(action)) {
                handleDeleteTempSlot(request, response, session, nextScheduleId, mentorId);
                return;
            } else if ("resetRejectedSlots".equals(action)) {
                handleResetRejectedSlots(request, response, session, nextScheduleId, mentorId);
                return;
            }
        }

        if (nextScheduleId != -1 && hasRejectedSlots(nextScheduleId, mentorId)) {
            request.setAttribute("hasRejectedSlots", true);
        } else {
            request.setAttribute("hasRejectedSlots", false);
        }

        setCommonAttributes(request, nextMonth, nextYear, nextScheduleId, mentorId);
        session.removeAttribute("message");
        request.getRequestDispatcher("view/SetSlot.jsp").forward(request, response);
    }

    private void handleResetRejectedSlots(HttpServletRequest request, HttpServletResponse response,
            HttpSession session, int scheduleId, Integer mentorId) throws IOException {
        try {
            // Delete all rejected slots
            daoMs.deleteRejectedSlotsByMentorAndSchedule(mentorId, scheduleId);
            session.setAttribute("message", "Rejected slots have been cleared. You can now set new slots.");
        } catch (Exception e) {
            session.setAttribute("message", "Failed to reset rejected slots: " + e.getMessage());
        }
        response.sendRedirect("/HAPPYorSAD/SetSlot");
    }

    private void handleChangeMonth(HttpServletRequest request, HttpServletResponse response, Integer mentorId)
            throws ServletException, IOException {
        String direction = request.getParameter("direction");
        String currentScheduleIdStr = request.getParameter("currentScheduleId");
        HttpSession session = request.getSession(false);

        int currentScheduleId = Integer.parseInt(currentScheduleIdStr);
        Schedule currentSchedule = daoSc.getScheduleById(currentScheduleId);
        if (currentSchedule == null || currentSchedule.getStart_date() == null) {
            session.setAttribute("message", "Invalid current schedule");
            response.sendRedirect("/HAPPYorSAD/SetSlot");
            return;
        }

        LocalDate currentStartDate = currentSchedule.getStart_date().toLocalDate();
        LocalDate newStartDate;
        if ("next".equals(direction)) {
            newStartDate = currentStartDate.plusMonths(1);
        } else {
            newStartDate = currentStartDate.minusMonths(1);
            LocalDate currentDate = LocalDate.now();
            if (newStartDate.isBefore(currentDate.plusMonths(1))) {
                newStartDate = currentDate.plusMonths(1);
            }
        }

        int newMonth = newStartDate.getMonthValue();
        int newYear = newStartDate.getYear();
        int newScheduleId = daoSc.getScheduleIdByMonth(newMonth, newYear);

        if (newScheduleId == -1) {
            session.setAttribute("message", "No schedule exists for " + newMonth + "/" + newYear + ". Please add a new schedule.");
            setCommonAttributes(request, newMonth, newYear, newScheduleId, mentorId);
            request.getRequestDispatcher("view/SetSlot.jsp").forward(request, response);
            return;
        }

        // Làm mới tempSlotsByDate khi chuyển tháng
        session.removeAttribute("tempSlotsByDate"); // Xóa dữ liệu cũ
        session.setAttribute("currentScheduleId", newScheduleId);
        if (newScheduleId != -1 && hasRejectedSlots(newScheduleId, mentorId)) {
            request.setAttribute("hasRejectedSlots", true);
        } else {
            request.setAttribute("hasRejectedSlots", false);
        }

        setCommonAttributes(request, newMonth, newYear, newScheduleId, mentorId);
        request.getRequestDispatcher("view/SetSlot.jsp").forward(request, response);
    }

    private void setCommonAttributes(HttpServletRequest request, int nextMonth, int nextYear, int nextScheduleId, Integer mentorId) {
        String[] monthNames = {"January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"};
        request.setAttribute("nextMonth", monthNames[nextMonth - 1]);
        request.setAttribute("nextYear", nextYear);
        request.setAttribute("nextScheduleId", nextScheduleId);

        // Fixed weekdays starting from Monday
        String[] weekDays = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
        request.setAttribute("weekDays", weekDays);

        List<String> nextWeekDates = new ArrayList<>();
        java.sql.Date nextStartDate = daoSc.getStartDateByScheduleId(nextScheduleId);
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        if (nextStartDate != null) {
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(nextStartDate);
            int startDayOfWeek = calendar.get(Calendar.DAY_OF_WEEK); // 1 = Sunday, 2 = Monday, ..., 7 = Saturday
            int startMonth = calendar.get(Calendar.MONTH); // 0-based
            int startYear = calendar.get(Calendar.YEAR);

            // Find the closest Monday in the same month
            int daysFromMonday = (startDayOfWeek == 1) ? 6 : startDayOfWeek - 2; // Days since last Monday
            calendar.add(Calendar.DATE, -daysFromMonday); // Go back to previous Monday
            if (calendar.get(Calendar.MONTH) != startMonth || calendar.get(Calendar.YEAR) != startYear) {
                // If previous Monday is in a different month, go forward to the next Monday in the same month
                calendar.setTime(nextStartDate);
                int daysToNextMonday = (startDayOfWeek == 1) ? 1 : 9 - startDayOfWeek; // Days to next Monday
                calendar.add(Calendar.DATE, daysToNextMonday);
            }

            // Generate the week starting from the closest Monday
            for (int i = 0; i < 7; i++) {
                String formattedDate = new java.sql.Date(calendar.getTimeInMillis()).toLocalDate().format(dateFormatter);
                nextWeekDates.add(formattedDate);
                calendar.add(Calendar.DATE, 1);
            }
        }
        request.setAttribute("nextWeekDates", nextWeekDates);

        Map<String, List<entity.Slot>> nextSlotsByDay = new HashMap<>();
        if (nextStartDate != null && mentorId != null) {
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(nextStartDate);
            int startDayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
            int startMonth = calendar.get(Calendar.MONTH);
            int startYear = calendar.get(Calendar.YEAR);

            int daysFromMonday = (startDayOfWeek == 1) ? 6 : startDayOfWeek - 2;
            calendar.add(Calendar.DATE, -daysFromMonday);
            if (calendar.get(Calendar.MONTH) != startMonth || calendar.get(Calendar.YEAR) != startYear) {
                calendar.setTime(nextStartDate);
                int daysToNextMonday = (startDayOfWeek == 1) ? 1 : 9 - startDayOfWeek;
                calendar.add(Calendar.DATE, daysToNextMonday);
            }

            for (int i = 0; i < 7; i++) {
                java.sql.Date date = new java.sql.Date(calendar.getTimeInMillis());
                String formattedDate = date.toLocalDate().format(dateFormatter);
                List<entity.Slot> slots = daoMs.getSlotsByDate1(date, mentorId);
                nextSlotsByDay.put(formattedDate, slots);
                calendar.add(Calendar.DATE, 1);
            }
        }
        request.setAttribute("nextSlotsByDay", nextSlotsByDay);

        List<Schedule> allAssignedSchedules = daoSc.getAssignedSchedulesByMentor(mentorId);
        List<Schedule> assignedSchedulesForDropdown = new ArrayList<>();
        LocalDate currentDate = LocalDate.now();
        int currentMonth = currentDate.getMonthValue();
        int currentYear = currentDate.getYear();
        for (Schedule schedule : allAssignedSchedules) {
            Date startDate = schedule.getStart_date();
            if (startDate != null) {
                Calendar cal = Calendar.getInstance();
                cal.setTime(startDate);
                int scheduleMonth = cal.get(Calendar.MONTH) + 1;
                int scheduleYear = cal.get(Calendar.YEAR);
                if (!(scheduleMonth == currentMonth && scheduleYear == currentYear)) {
                    assignedSchedulesForDropdown.add(schedule);
                }
            }
        }
        request.setAttribute("assignedSchedulesForDropdown", assignedSchedulesForDropdown);
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
                response.sendRedirect("/HAPPYorSAD/SetSlot");
                return;
            }

            Calendar cal = Calendar.getInstance();
            cal.setTime(startDate);
            int month = cal.get(Calendar.MONTH);
            int year = cal.get(Calendar.YEAR);

            cal.setTime(selectedDate);
            int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);

            cal.setTime(startDate);
            cal.set(Calendar.DAY_OF_MONTH, 1);
            while (cal.get(Calendar.MONTH) == month && cal.get(Calendar.YEAR) == year) {
                if (cal.get(Calendar.DAY_OF_WEEK) == dayOfWeek) {
                    Date date = new Date(cal.getTimeInMillis());
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
        response.sendRedirect("/HAPPYorSAD/SetSlot");
    }

    private void updateScheduleData(HttpServletRequest request, int scheduleId, Integer mentorId) {
        List<String> nextWeekDates = new ArrayList<>();
        java.sql.Date nextStartDate = daoSc.getStartDateByScheduleId(scheduleId);
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        if (nextStartDate != null) {
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(nextStartDate);
            int startDayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
            int startMonth = calendar.get(Calendar.MONTH);
            int startYear = calendar.get(Calendar.YEAR);

            int daysFromMonday = (startDayOfWeek == 1) ? 6 : startDayOfWeek - 2;
            calendar.add(Calendar.DATE, -daysFromMonday);
            if (calendar.get(Calendar.MONTH) != startMonth || calendar.get(Calendar.YEAR) != startYear) {
                calendar.setTime(nextStartDate);
                int daysToNextMonday = (startDayOfWeek == 1) ? 1 : 9 - startDayOfWeek;
                calendar.add(Calendar.DATE, daysToNextMonday);
            }

            for (int i = 0; i < 7; i++) {
                String formattedDate = new java.sql.Date(calendar.getTimeInMillis()).toLocalDate().format(dateFormatter);
                nextWeekDates.add(formattedDate);
                calendar.add(Calendar.DATE, 1);
            }
        }
        request.setAttribute("nextWeekDates", nextWeekDates);

        Map<String, List<entity.Slot>> nextSlotsByDay = new HashMap<>();
        if (nextStartDate != null && mentorId != null) {
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(nextStartDate);
            int startDayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
            int startMonth = calendar.get(Calendar.MONTH);
            int startYear = calendar.get(Calendar.YEAR);

            int daysFromMonday = (startDayOfWeek == 1) ? 6 : startDayOfWeek - 2;
            calendar.add(Calendar.DATE, -daysFromMonday);
            if (calendar.get(Calendar.MONTH) != startMonth || calendar.get(Calendar.YEAR) != startYear) {
                calendar.setTime(nextStartDate);
                int daysToNextMonday = (startDayOfWeek == 1) ? 1 : 9 - startDayOfWeek;
                calendar.add(Calendar.DATE, daysToNextMonday);
            }

            for (int i = 0; i < 7; i++) {
                java.sql.Date date = new java.sql.Date(calendar.getTimeInMillis());
                String formattedDate = date.toLocalDate().format(dateFormatter);
                List<entity.Slot> slots = daoMs.getSlotsByDate1(date, mentorId);
                nextSlotsByDay.put(formattedDate, slots);
                calendar.add(Calendar.DATE, 1);
            }
        }
        request.setAttribute("nextSlotsByDay", nextSlotsByDay);
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
        response.sendRedirect("/HAPPYorSAD/SetSlot");
    }

    private void handleAddSchedule(HttpServletRequest request, HttpServletResponse response, int mentorId, int selectedMonth, int selectedYear)
            throws IOException {
        HttpSession session = request.getSession(false);
        int nextMonth = (selectedMonth % 12) + 1;
        int nextYear = (selectedMonth == 12) ? selectedYear + 1 : selectedYear;
        int nextScheduleId = daoSc.getScheduleIdByMonth(nextMonth, nextYear);

        while (nextScheduleId != -1 && daoSc.isScheduleAssignedToMentor(mentorId, nextScheduleId)) {
            nextMonth = (nextMonth % 12) + 1;
            nextYear = (nextMonth == 1) ? nextYear + 1 : nextYear;
            nextScheduleId = daoSc.getScheduleIdByMonth(nextMonth, nextYear);
        }

        if (nextScheduleId == -1) {
            session.setAttribute("message", "No existing schedule for " + nextMonth + "/" + nextYear + ". Please contact admin to create one.");
            response.sendRedirect("/HAPPYorSAD/SetSlot");
            return;
        }

        boolean success = daoSc.addSchedule(mentorId, nextScheduleId);
        if (success) {
            session.setAttribute("scheduleId", nextScheduleId);
            session.setAttribute("message", "Schedule for " + nextMonth + "/" + nextYear + " added successfully!");
            response.sendRedirect("/HAPPYorSAD/SetSlot?scheduleId=" + nextScheduleId);
        } else {
            session.setAttribute("message", "Failed to add schedule for " + nextMonth + "/" + nextYear + ".");
            response.sendRedirect("/HAPPYorSAD/SetSlot");
        }
    }

    private boolean hasRejectedSlots(int scheduleId, Integer mentorId) {
        LOGGER.info("Checking for rejected slots - Mentor ID: " + mentorId + ", Schedule ID: " + scheduleId);

        List<entity.Slot> slots = daoMs.getSlotsByMentorAndSchedule(mentorId, scheduleId);

        if (slots == null || slots.isEmpty()) {
            LOGGER.info("No slots found for Mentor ID: " + mentorId + ", Schedule ID: " + scheduleId);
            return false;
        }

        // Log danh sách slot lấy được
        for (entity.Slot slot : slots) {
            LOGGER.info("Slot ID: " + slot.getId() + ", Status: " + slot.getStatus());
        }

        boolean hasRejected = slots.stream()
                .filter(slot -> slot.getStatus() != null) // Kiểm tra null để tránh NullPointerException
                .anyMatch(slot -> "Rejected".equalsIgnoreCase(slot.getStatus())); // Không phân biệt hoa thường

        LOGGER.info("Result: " + (hasRejected ? "There are rejected slots." : "No rejected slots found."));

        return hasRejected;
    }

    private void handleDeleteTempSlot(HttpServletRequest request, HttpServletResponse response, HttpSession session,
            int scheduleId, Integer mentorId) throws IOException {
        String slotDateStr = request.getParameter("slot_date");
        String slotNumberStr = request.getParameter("slotNumber");

        if (slotDateStr != null && slotNumberStr != null) {
            Date slotDate = Date.valueOf(slotDateStr);
            int slotNumber = Integer.parseInt(slotNumberStr);

            Map<Date, List<TempSlot>> tempSlotsByDate = (Map<Date, List<TempSlot>>) session.getAttribute("tempSlotsByDate");
            if (tempSlotsByDate != null) {
                List<TempSlot> tempSlots = tempSlotsByDate.get(slotDate);
                if (tempSlots != null) {
                    tempSlots.removeIf(slot -> slot.getSlotNumber() == slotNumber);
                    if (tempSlots.isEmpty()) {
                        tempSlotsByDate.remove(slotDate);
                    } else {
                        tempSlotsByDate.put(slotDate, tempSlots);
                    }
                    session.setAttribute("tempSlotsByDate", tempSlotsByDate);
                    session.setAttribute("message", "Temporary slot removed successfully");
                }
            }
        }
        response.sendRedirect("/HAPPYorSAD/SetSlot");
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
        return "General Availability Management Servlet";
    }
}
