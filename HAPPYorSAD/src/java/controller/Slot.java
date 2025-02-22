/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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

/**
 *
 * @author Ann
 */
public class Slot extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final Logger LOGGER = Logger.getLogger(Slot.class.getName());
    private final DAOslot daoSlot = new DAOslot();
    private final DAOschedule daoSc = new DAOschedule();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            System.out.println("User not logged in, redirecting to login page.");
            response.sendRedirect("/HAPPYorSAD/view/LoginUser.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        Integer mentorId = DAOMentor.getMentorIdByUserId(userId);
        Integer scheduleId = DAOschedule.getScheduleIdsByMentorId(mentorId);

        System.out.println("User ID: " + userId);
        System.out.println("Mentor ID: " + mentorId);

        if (scheduleId == null) {
            System.out.println("Schedule ID not found for mentor: " + mentorId);
            return;
        } else {
            System.out.println("Schedule ID: " + scheduleId);

        }

        String dateString = request.getParameter("slotDate");
        SimpleDateFormat formatter = new SimpleDateFormat("MM-dd-yyyy");
        SimpleDateFormat dayFormatter = new SimpleDateFormat("EEEE");
        String[] weekDays = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
        request.setAttribute("weekDays", weekDays);
        System.out.println("Week Days Set: " + Arrays.toString(weekDays));

        java.sql.Date startDate = daoSc.getStartDateByScheduleId(scheduleId);
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(startDate);

        java.sql.Date[] weekDates = new java.sql.Date[7];
        for (int i = 0; i < 7; i++) {
            weekDates[i] = new java.sql.Date(calendar.getTimeInMillis());
            calendar.add(Calendar.DATE, 1);
        }
        request.setAttribute("weekDates", weekDates);
        System.out.println("Week Dates Set: " + Arrays.toString(weekDates));
        String selectedDay = request.getParameter("day");
        if (selectedDay == null || selectedDay.isEmpty()) {
            selectedDay = "Monday";
        }
        request.setAttribute("selectedDay", selectedDay);
        System.out.println("Selected Day Set: " + selectedDay);
        java.sql.Date selectedDate = null;
        for (java.sql.Date weekDate : weekDates) {
            if (dayFormatter.format(weekDate).equalsIgnoreCase(selectedDay)) {
                selectedDate = weekDate;
                break;
            }
        }

        Date slotDate = new Date(calendar.getTimeInMillis());
        request.setAttribute("selectedDate", selectedDate);
        request.setAttribute("selectedDate", selectedDate);
        request.setAttribute("slots", daoSlot.getSlotsByDate1(selectedDate, mentorId));
        request.setAttribute("availableSlots", daoSc.getAvailableSlotNumbers(scheduleId, selectedDate));
        System.out.println("Slot Date: " + request.getAttribute("selectedDate"));
        String action = request.getParameter("action");

        System.out.println("Action received: " + action);

        if ("add".equals(action)) {
            handleAddSlot(session, request, scheduleId, selectedDate);
            LOGGER.info("handleAddSlot called with scheduleId: " + scheduleId + " and selectedDate: " + selectedDate);

        } else if ("save".equals(action)) {
            handleSaveSlot(session, request, scheduleId);
        } else if ("delete".equals(action)) {
            Date endTime = daoSc.getEndDateByScheduleId(scheduleId);
            if (endTime != null) {
                if (selectedDate == null) {
                    System.out.println("Error: selectedDate is null.");
                    return;
                }

                Calendar cal = Calendar.getInstance();
                cal.setTime(selectedDate);

                List<Date> datesToDelete = new ArrayList<>();

                while (true) {
                    cal.add(Calendar.DATE, 7);
                    java.util.Date nextDate = cal.getTime(); // Sử dụng java.util.Date

                    if (nextDate.after(endTime)) {
                        break;
                    }
                    Date sqlDate = new Date(nextDate.getTime());
                    datesToDelete.add(sqlDate);
                }
                datesToDelete.add(new Date(selectedDate.getTime()));

                if (datesToDelete.isEmpty()) {
                    System.out.println("No dates to delete.");
                    return;
                }

                System.out.println("Dates to delete: " + datesToDelete);
                for (Date date : datesToDelete) {
                    boolean isDeleted = daoSlot.deleteSlot(date, mentorId, scheduleId);
                    if (!isDeleted) {
                        System.out.println("Failed to delete slot for date: " + date);
                    }
                }

                System.out.println("Deleted slots successfully.");
            } else {
                System.out.println("Error: endTime is null.");
            }

        }
        request.getRequestDispatcher("view/slot_list.jsp").forward(request, response);
    }

    private void handleAddSlot(HttpSession session, HttpServletRequest request, int scheduleId, Date selectedDate) {
        LOGGER.info("handleAddSlot called with scheduleId: " + scheduleId + " and selectedDate: " + selectedDate);

        Map<Date, List<TempSlot>> tempSlotsByDate = (Map<Date, List<TempSlot>>) session.getAttribute("tempSlotsByDate");
        if (tempSlotsByDate == null) {
            tempSlotsByDate = new HashMap<>();
        }

        List<TempSlot> tempSlots = tempSlotsByDate.getOrDefault(selectedDate, new ArrayList<>());
        String slotNumberStr = request.getParameter("slot_number_id");
        LOGGER.info("Received slot_number_id: " + slotNumberStr);

        if (slotNumberStr != null && !slotNumberStr.isEmpty()) {
            try {
                int slotNumber = Integer.parseInt(slotNumberStr);
                Map<Integer, String> slotTimeMap = Map.of(
                        1, "07:30:00",
                        2, "10:00:00",
                        3, "13:00:00",
                        4, "15:30:00",
                        5, "19:30:00"
                );

                String startTime = slotTimeMap.getOrDefault(slotNumber, "Unknown Time");
                LOGGER.info("Mapped start_time: " + startTime);

                boolean exists = tempSlots.stream().anyMatch(slot -> slot.getSlotNumber() == slotNumber);
                if (!exists) {
                    TempSlot newSlot = new TempSlot(scheduleId, selectedDate, slotNumber, startTime);
                    tempSlots.add(newSlot);
                    tempSlotsByDate.put(selectedDate, tempSlots);
                    LOGGER.info("Slot added: " + newSlot);
                } else {
                    LOGGER.info("Slot already exists, skipping...");
                }

                Date endTime = daoSc.getEndDateByScheduleId(scheduleId);
                if (endTime != null) {
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(selectedDate);

                    while (true) {
                        cal.add(Calendar.DATE, 7);
                        Date nextDate = new Date(cal.getTimeInMillis());
                        if (nextDate.after(endTime)) {
                            break;
                        }

                        List<TempSlot> nextSlots = tempSlotsByDate.getOrDefault(nextDate, new ArrayList<>());
                        boolean nextExists = nextSlots.stream().anyMatch(slot -> slot.getSlotNumber() == slotNumber);
                        if (!nextExists) {
                            TempSlot repeatedSlot = new TempSlot(scheduleId, nextDate, slotNumber, startTime);
                            nextSlots.add(repeatedSlot);
                            tempSlotsByDate.put(nextDate, nextSlots);
                            LOGGER.info("Repeated weekly slot added for: " + nextDate);
                        }
                    }
                }
                session.setAttribute("tempSlotsByDate", tempSlotsByDate);
                LOGGER.info("Total days stored: " + tempSlotsByDate.size());
            } catch (NumberFormatException e) {
                LOGGER.log(Level.SEVERE, "Error parsing slot number: " + e.getMessage(), e);
            }
        }
    }

    private void handleSaveSlot(HttpSession session, HttpServletRequest request, int scheduleId) {

        Map<Date, List<TempSlot>> tempSlotsByDate = (Map<Date, List<TempSlot>>) session.getAttribute("tempSlotsByDate");

        if (tempSlotsByDate == null || tempSlotsByDate.isEmpty()) {
            LOGGER.info("No slots to save.");
            return;
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Map<Integer, Integer> slotPerDay = new HashMap<>();
        Calendar calendar = Calendar.getInstance();
        for (Map.Entry<Date, List<TempSlot>> entry : tempSlotsByDate.entrySet()) {
            Date slotDate = entry.getKey();
            List<TempSlot> tempSlots = entry.getValue();

            for (TempSlot tempSlot : tempSlots) {
                int slotNumber = tempSlot.getSlotNumber();
                daoSlot.addSlots(scheduleId, sdf.format(slotDate), slotNumber);

            }
        }
        session.removeAttribute("tempSlotsByDate");
    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
//        int numberOfRanges = 5;
//        List<Map<String, Object>> dateRanges = generateDateRanges(numberOfRanges);
//        request.setAttribute("dateRanges", dateRanges);
//        request.getRequestDispatcher("/dateFilterDropdown.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

//        String selectedDateRange = request.getParameter("dateFilter");
//        request.setAttribute("selectedDateRange", selectedDateRange);
//        List<Map<String, Object>> dateRanges = generateDateRanges(5); // Gọi lại để dropdown được tạo lại với dữ liệu
//        request.setAttribute("dateRanges", dateRanges); // Truyền lại danh sách dateRanges
//        request.getRequestDispatcher("/dateFilterDropdown.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
