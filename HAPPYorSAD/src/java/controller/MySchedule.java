/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.DAOMentor;
import model.DAOmentor_Slot;
import model.DAOschedule;

/**
 *
 * @author Ann
 */
public class MySchedule extends HttpServlet {

    private final DAOmentor_Slot daoMs = new DAOmentor_Slot();
    private final DAOschedule daoSc = new DAOschedule();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
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

        if (selectedMonthStr != null && !selectedMonthStr.isEmpty() && selectedYearStr != null && !selectedYearStr.isEmpty()) {
            selectedMonth = Integer.parseInt(selectedMonthStr);
            selectedYear = Integer.parseInt(selectedYearStr);
        }

        List<entity.Schedule> schedules = daoSc.getSchedulesByMonth(selectedYear, selectedMonth);
        request.setAttribute("schedules", schedules);
        request.setAttribute("selectedMonth", selectedMonth);
        request.setAttribute("selectedYear", selectedYear);

        String[] weekDays = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
        request.setAttribute("weekDays", weekDays);

        int weekOffset = 0;
        String weekOffsetStr = request.getParameter("weekOffset");
        if (weekOffsetStr != null) {
            try {
                weekOffset = Integer.parseInt(weekOffsetStr);
            } catch (NumberFormatException e) {
            }
        }

        List<String> weekDates = new ArrayList<>();
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        LocalDate currentDate = LocalDate.now();
        LocalDate selectedMonthStart = LocalDate.of(selectedYear, selectedMonth, 1);
        LocalDate selectedMonthEnd = selectedMonthStart.plusMonths(1).minusDays(1); // Last day of the selected month
        LocalDate targetDate = currentDate.isBefore(selectedMonthStart) ? selectedMonthStart : currentDate;

        Calendar calendar = Calendar.getInstance();
        calendar.setTime(Date.valueOf(targetDate));
        int daysUntilMonday = (Calendar.MONDAY - calendar.get(Calendar.DAY_OF_WEEK) + 7) % 7;
        calendar.add(Calendar.DATE, daysUntilMonday);
        calendar.add(Calendar.WEEK_OF_YEAR, weekOffset);

        // Check if the next week would exceed the end of the month
        Calendar nextWeekCheck = (Calendar) calendar.clone();
        nextWeekCheck.add(Calendar.WEEK_OF_YEAR, 1);
        LocalDate nextWeekStartDate = new java.sql.Date(nextWeekCheck.getTimeInMillis()).toLocalDate();
        boolean canNextWeek = nextWeekStartDate.isBefore(selectedMonthEnd) || nextWeekStartDate.isEqual(selectedMonthEnd);

        for (int i = 0; i < 7; i++) {
            String formattedDate = new java.sql.Date(calendar.getTimeInMillis()).toLocalDate().format(dateFormatter);
            weekDates.add(formattedDate);
            calendar.add(Calendar.DATE, 1);
        }

        request.setAttribute("weekDates", weekDates);
        String weekStartDate = weekDates.isEmpty() ? "" : weekDates.get(0);
        String weekEndDate = weekDates.isEmpty() ? "" : weekDates.get(6);
        request.setAttribute("weekOffset", weekOffset);
        request.setAttribute("weekStartDate", weekStartDate);
        request.setAttribute("weekEndDate", weekEndDate);
        request.setAttribute("canNextWeek", canNextWeek); // Pass this to JSP to control the "Next Week" button

        Map<String, List<entity.Slot>> slotsByDay = new HashMap<>();
        if (mentorId != null) {
            for (String dateStr : weekDates) {
                java.sql.Date date = java.sql.Date.valueOf(dateStr);
                String formattedDate = date.toLocalDate().format(dateFormatter);
                List<entity.Slot> slots = daoMs.getSlotsByDate1(date, mentorId);
                slotsByDay.put(formattedDate, slots);
            }
        }
        request.setAttribute("slotsByDay", slotsByDay);

        request.getRequestDispatcher("view/MySchedule.jsp").forward(request, response);
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
        return "Your Schedule Management Servlet";
    }
}
