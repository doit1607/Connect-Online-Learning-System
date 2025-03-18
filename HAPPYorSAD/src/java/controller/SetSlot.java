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

        LocalDate nextMonthDate = LocalDate.now().plusMonths(1);
        int nextMonth = nextMonthDate.getMonthValue();
        int nextYear = nextMonthDate.getYear();
        int nextScheduleId = daoSc.getScheduleIdByMonth(nextMonth, nextYear);

        String scheduleIdStr = request.getParameter("scheduleId");
        if ("selectSchedule".equals(action) && scheduleIdStr != null) {
            int selectedScheduleId = Integer.parseInt(scheduleIdStr);
            Schedule selectedSchedule = daoSc.getScheduleById(selectedScheduleId);
            if (selectedSchedule != null && selectedSchedule.getStart_date() != null) {
                Calendar cal = Calendar.getInstance();
                cal.setTime(selectedSchedule.getStart_date());
                nextMonth = cal.get(Calendar.MONTH) + 1; // Tháng bắt đầu từ 0
                nextYear = cal.get(Calendar.YEAR);
                nextScheduleId = selectedSchedule.getId();

                // Cập nhật dữ liệu liên quan khi chọn schedule
                updateScheduleData(request, nextScheduleId, mentorId);
            }
        }

        request.setAttribute("nextMonth", nextMonth);
        request.setAttribute("nextYear", nextYear);
        request.setAttribute("nextScheduleId", nextScheduleId);

        String[] weekDays = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
        request.setAttribute("weekDays", weekDays);

        List<String> nextWeekDates = new ArrayList<>();
        java.sql.Date nextStartDate = daoSc.getStartDateByScheduleId(nextScheduleId);
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        if (nextStartDate != null) {
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(nextStartDate);
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
        int currentMonth = LocalDate.now().getMonthValue();
        int currentYear = LocalDate.now().getYear();
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
                session.removeAttribute("message");
                request.getRequestDispatcher("view/SetSlot.jsp").forward(request, response);
            }
        }

        session.removeAttribute("message");
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
