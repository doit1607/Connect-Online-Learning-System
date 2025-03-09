/*
 * Click nbfs://SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Connection;
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
import static java.lang.System.out;
import java.time.LocalDate;
import model.DBConnection; // Thay `mypackage` bằng package thật sự của Database

import java.time.Month;
import java.time.format.DateTimeFormatter;

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
        String action = request.getParameter("action");
        System.out.println("Action received: " + action);
        if (session == null || session.getAttribute("userId") == null) {
            System.out.println("User not logged in, redirecting to login page.");
            response.sendRedirect("/HAPPYorSAD/view/LoginUser.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        Integer mentorId = DAOMentor.getMentorIdByUserId(userId);

        System.out.println("User ID: " + userId);
        System.out.println("Mentor ID: " + mentorId);
        String scheduleIdStr = request.getParameter("scheduleId");
        int scheduleId = -1; // Mặc định nếu không có ID

        int selectedMonth, selectedYear;

        String selectedMonthStr = request.getParameter("month");
        String selectedYearStr = request.getParameter("year");
        LOGGER.info("Extracted month = " + selectedMonthStr + ", year = " + selectedYearStr);
        if (selectedMonthStr != null && selectedYearStr != null && !selectedMonthStr.isEmpty() && !selectedYearStr.isEmpty()) {
            try {
                selectedMonth = Integer.parseInt(selectedMonthStr);
            } catch (NumberFormatException e) {
                try {
                    Month monthEnum = Month.valueOf(selectedMonthStr.toUpperCase());
                    selectedMonth = monthEnum.getValue();
                } catch (IllegalArgumentException ex) {
                    selectedMonth = LocalDate.now().getMonthValue();
                    LOGGER.info("Invalid month parameter: " + selectedMonthStr + ". Defaulting to current month: " + selectedMonth);
                }
            }
            try {
                selectedYear = Integer.parseInt(selectedYearStr);
            } catch (NumberFormatException e) {
                selectedYear = LocalDate.now().getYear();
                LOGGER.info("Invalid year parameter: " + selectedYearStr + ". Defaulting to current year: " + selectedYear);
            }

            LOGGER.info("Selected Month = " + selectedMonth + ", Selected Year = " + selectedYear);

        } else {
            selectedMonth = LocalDate.now().getMonthValue();
            selectedYear = LocalDate.now().getYear();
            LOGGER.info("Defaulting to current month/year: " + selectedMonth + "/" + selectedYear);
        }
        List<Schedule> schedules = daoSc.getSchedulesByMonth(selectedYear, selectedMonth);
        response.setContentType("text/html");
        response.getWriter().write("<h3>Schedules for " + Month.of(selectedMonth) + " " + selectedYear + "</h3>");
        if (schedules.isEmpty()) {
            response.getWriter().write("<p>No schedules found.</p>");
            return;
        } else {
            response.getWriter().write("<ul>");
            for (Schedule schedule : schedules) {
                response.getWriter().write("<li data-schedule-id='" + schedule.getId() + "'>"
                        + "Schedule ID: " + schedule.getId()
                        + " - " + schedule.getStart_date() + "</li>");
            }
            response.getWriter().write("</ul>");
            scheduleId = schedules.get(0).getId();
            request.setAttribute("scheduleId", scheduleId);
        }

        request.setAttribute("schedules", schedules);
        request.setAttribute("selectedMonth", selectedMonth);
        request.setAttribute("selectedYear", selectedYear);

        String dateString = request.getParameter("slotDate");
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        SimpleDateFormat formatter = new SimpleDateFormat("MM-dd-yyyy");
        SimpleDateFormat dayFormatter = new SimpleDateFormat("EEEE");
        String[] weekDays = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
        request.setAttribute("weekDays", weekDays);

        LOGGER.info("Week Days Set: " + Arrays.toString(weekDays));
        java.sql.Date startDate = daoSc.getStartDateByScheduleId(scheduleId);
        LOGGER.info("Start Date Retrieved: " + startDate);
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(startDate);
        List<String> weekDates = new ArrayList<>();
        for (int i = 0; i < 7; i++) {
            java.sql.Date sqlDate = new java.sql.Date(calendar.getTimeInMillis());
            weekDates.add(sqlDate.toLocalDate().format(dateFormatter)); // Chuyển sang String
            calendar.add(Calendar.DATE, 1);
        }
        request.setAttribute("weekDates", weekDates);
        LOGGER.info("Week Dates Set: " + weekDates);
        Map<Integer, java.sql.Date> closestWeekDates = new LinkedHashMap<>();
        calendar.add(Calendar.DAY_OF_MONTH, -7);
        for (int i = 0; i < 7; i++) {
            closestWeekDates.put(i + 1, new java.sql.Date(calendar.getTimeInMillis()));
            calendar.add(Calendar.DAY_OF_MONTH, 1);
        }
        List<String> formattedWeekDates = new ArrayList<>();

        Map<String, Map<String, String>> weekDateInfoMap = new LinkedHashMap<>();
        for (int i = 0; i < 7; i++) {
            java.sql.Date date = closestWeekDates.get(i + 1);
            if (date != null) {
                LocalDate localDate = date.toLocalDate();
                String formattedDate = localDate.format(dateFormatter); // Format trực tiếp bằng DateTimeFormatter
                formattedWeekDates.add(formattedDate);
                LOGGER.info("Formatted Date Added: " + formattedDate);
            }
        }

        Map<String, List<entity.Slot>> slotsByDay = new HashMap<>();
        Map<Integer, String> slotTimeMap = Map.of(
                1, "07:30:00",
                2, "10:00:00",
                3, "13:00:00",
                4, "15:30:00",
                5, "19:30:00"
        );

        for (int i = 1; i <= 7; i++) {
            java.sql.Date date = closestWeekDates.get(i);
            if (date != null) {
                LocalDate localDate = date.toLocalDate();
                String formattedDate = localDate.format(dateFormatter);
                formattedWeekDates.add(formattedDate);
                List<entity.Slot> slots = daoSlot.getSlotsByDate1(date, mentorId);
                slotsByDay.put(formattedDate, slots);
                Map<String, String> dateInfo = new HashMap<>();
                dateInfo.put("dayOfWeek", weekDays[i - 1]);
                dateInfo.put("day", String.valueOf(localDate.getDayOfMonth()));
                dateInfo.put("month", localDate.getMonth().toString());
                dateInfo.put("year", String.valueOf(localDate.getYear()));
                weekDateInfoMap.put(formattedDate, dateInfo);
                LOGGER.info("Stored Slots for " + formattedDate + ": " + slotsByDay.get(formattedDate));
            }
        }
        request.setAttribute("slotsByDay", slotsByDay);

        Map<String, List<entity.Schedule>> schedulesByMonth = daoSc.getSchedulesByMonth();
        Set<String> months = schedulesByMonth.keySet();
        Map<String, List<entity.SlotTemplate>> availableSlotsByDate = new HashMap<>();

        for (String formattedDate : formattedWeekDates) {
            java.sql.Date sqlDate = java.sql.Date.valueOf(formattedDate);
            List<SlotTemplate> availableSlots = daoSc.getAvailableSlotNumbers(scheduleId, sqlDate);
            availableSlotsByDate.put(formattedDate, availableSlots);
            LOGGER.info("Date: " + formattedDate + " | Available Slots: " + availableSlots);
        }

        request.setAttribute("availableSlotsByDate", availableSlotsByDate);

        request.setAttribute("weekDateInfoMap", weekDateInfoMap);
        request.setAttribute("formattedWeekDates", formattedWeekDates);
        request.setAttribute("weekDateInfoMap", weekDateInfoMap);
        request.setAttribute("scheduleId", scheduleId);

        request.setAttribute("weekDays", weekDays); // If not already set
        request.setAttribute("months", months);
        request.setAttribute("weekDates", weekDates);
        System.out.println("🔍 Raw request parameters: " + request.getParameterMap());
        System.out.println("🔍 HTTP Method: " + request.getMethod());

        if ("add".equals(action)) {
            String slotDateStr = request.getParameter("slot_date");
            if (slotDateStr == null || slotDateStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Error: slot_date is missing or empty!");
            }
            if (!slotDateStr.matches("\\d{4}-\\d{2}-\\d{2}")) {
                throw new IllegalArgumentException("Error: Invalid date format. Expected YYYY-MM-DD.");
            }
            System.out.println("📌 Received slot_date: " + slotDateStr);
            String slotNumberStr = request.getParameter("slotNumber");
            Enumeration<String> params = request.getParameterNames();
            while (params.hasMoreElements()) {
                String param = params.nextElement();
                System.out.println("Param: " + param + " = " + request.getParameter(param));
            }
            Date formattedDay = Date.valueOf(slotDateStr);
            System.out.println("✅ Converted slot_date: " + formattedDay);

            System.out.println("🔍 Debugging Request Parameters:");
            System.out.println("   ➤ scheduleId: " + request.getParameter("scheduleId"));
            System.out.println("   ➤ slot_date: " + request.getParameter("slot_date"));
            System.out.println("   ➤ slotNumber: " + request.getParameter("slotNumber"));

            LOGGER.info("handleAddSlot called - scheduleId: " + scheduleId + ", date: " + formattedDay);
            Map<Date, List<TempSlot>> tempSlotsByDate = (Map<Date, List<TempSlot>>) session.getAttribute("tempSlotsByDate");
            if (tempSlotsByDate == null) {
                tempSlotsByDate = new HashMap<>();
            }
            List<TempSlot> tempSlots = tempSlotsByDate.getOrDefault(formattedDay, new ArrayList<>());
            LOGGER.info("Received slot_number_id: " + slotNumberStr);
            if (slotNumberStr != null && !slotNumberStr.isEmpty()) {
                try {
                    int slotNumber = Integer.parseInt(slotNumberStr);
                    String startTime = slotTimeMap.getOrDefault(slotNumber, "Unknown Time");
                    LOGGER.info("Mapped start_time: " + startTime);
                    boolean exists = tempSlots.stream().anyMatch(slot -> slot.getSlotNumber() == slotNumber);
                    if (!exists) {
                        TempSlot newSlot = new TempSlot(scheduleId, formattedDay, slotNumber, startTime);
                        tempSlots.add(newSlot);
                        tempSlotsByDate.put(formattedDay, tempSlots);
                        LOGGER.info("Slot added: " + newSlot);
                    } else {
                        LOGGER.info("Slot already exists, skipping...");
                    }
                    // Xử lý Repeat Slot nếu có
                    Date endTime = daoSc.getEndDateByScheduleId(scheduleId);
                    if (endTime != null) {
                        Calendar cal = Calendar.getInstance();
                        cal.setTime(formattedDay);

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
                    for (TempSlot tempSlot : tempSlots) {
                        LOGGER.info("ifnorrr: " + tempSlot);
                    }
                    LOGGER.info("Total days stored: " + tempSlotsByDate.size());
                    response.getWriter().write("success");

                } catch (NumberFormatException e) {
                    LOGGER.log(Level.SEVERE, "Error parsing slot number: " + e.getMessage(), e);
                }
                LOGGER.info("Received: scheduleId=" + scheduleId + ", date=" + formattedDay + ", slot=" + slotNumberStr);
            }
            request.setAttribute("message", "success");
            request.getRequestDispatcher("view/slot_list.jsp").forward(request, response);
            return;

        } else if ("save".equals(action)) {
            try {
                Map<Date, List<TempSlot>> tempSlotsByDate = (Map<Date, List<TempSlot>>) session.getAttribute("tempSlotsByDate");
                if (tempSlotsByDate == null || tempSlotsByDate.isEmpty()) {
                    LOGGER.info("⚠ No slots to save.");
                    request.setAttribute("message", "No slots to save."); // Thông báo nếu không có slot
                } else {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    for (Map.Entry<Date, List<TempSlot>> entry : tempSlotsByDate.entrySet()) {
                        Date formattedDay = entry.getKey();
                        List<TempSlot> tempSlots = entry.getValue();

                        for (TempSlot tempSlot : tempSlots) {
                            try {
                                int slotNumber = tempSlot.getSlotNumber();
                                String formattedDate = sdf.format(formattedDay);
                                daoSlot.addSlots(scheduleId, formattedDate, slotNumber);
                                LOGGER.info("✅ Saved slot: " + formattedDate + " - Slot " + slotNumber);
                            } catch (Exception e) {
                                LOGGER.info("❌ Error saving slot on " + formattedDay + " - Slot: " + tempSlot.getSlotNumber());
                            }
                        }
                    }
                    session.removeAttribute("tempSlotsByDate");
                    LOGGER.info("🗑 Cleared temporary slots after saving.");
                    request.setAttribute("message", "Slots saved successfully!"); // Thông báo thành công
                }
            } catch (Exception e) {
                LOGGER.log(Level.SEVERE, "🚨 Error during slot saving process: ", e);
                request.setAttribute("message", "Error saving slots: " + e.getMessage()); // Thông báo lỗi
            }
            // Forward về trang hiện tại thay vì redirect
            request.getRequestDispatcher("view/slot_list.jsp").forward(request, response);
            return;
        } else if ("delete".equals(action)) {
            Date endTime = daoSc.getEndDateByScheduleId(scheduleId);
            if (endTime != null) {
                if (formattedWeekDates == null || formattedWeekDates.isEmpty()) {
                    System.out.println("Error: formattedWeekDates is null or empty.");
                    return;
                }
                List<Date> datesToDelete = new ArrayList<>();
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

                for (String formattedDay : formattedWeekDates) {
                    try {
                        java.util.Date parsedDate = dateFormat.parse(formattedDay);
                        Calendar cal = Calendar.getInstance();
                        cal.setTime(parsedDate);

                        while (true) {
                            cal.add(Calendar.DATE, 7);
                            java.util.Date nextDate = cal.getTime();

                            if (nextDate.after(endTime)) {
                                break;
                            }

                            datesToDelete.add(new Date(nextDate.getTime()));
                        }

                        datesToDelete.add(new Date(parsedDate.getTime()));
                    } catch (ParseException e) {
                        System.out.println("Error parsing date: " + formattedDay);
                        e.printStackTrace();
                    }
                }
                if (datesToDelete.isEmpty()) {
                    System.out.println("No dates to delete.");
                    return;
                }
                System.out.println("Dates to delete: " + datesToDelete);
                for (Date formattedDay : datesToDelete) {
                    boolean isDeleted = daoSlot.deleteSlot(formattedDay, mentorId, scheduleId);
                    if (!isDeleted) {
                        System.out.println("Failed to delete slot for date: " + formattedDay);
                    }
                }
                System.out.println("Deleted slots successfully.");
            } else {
                System.out.println("Error: endTime is null.");
            }
        } else if ("addSchedule".equals(action)) {
            // Lấy scheduleId hiện tại từ request hoặc session
            if (scheduleIdStr == null || scheduleIdStr.isEmpty()) {
                scheduleIdStr = String.valueOf(session.getAttribute("scheduleId"));
            }
            if (scheduleIdStr == null || scheduleIdStr.equals("-1")) {
                LOGGER.info("No current schedule found.");
                response.setContentType("application/json");
                response.getWriter().write("{\"status\":\"error\",\"message\":\"No current schedule found.\"}");
                return;
            }
            int currentScheduleId = Integer.parseInt(scheduleIdStr);

            // Lấy thông tin tháng và năm hiện tại từ scheduleId hiện tại
            if (startDate == null) {
                LOGGER.info("Invalid current schedule ID: " + currentScheduleId);
                response.setContentType("application/json");
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Invalid current schedule.\"}");
                return;
            }
            Calendar cal = Calendar.getInstance();
            cal.setTime(startDate);
            int currentMonth = cal.get(Calendar.MONTH) + 1; // Tháng bắt đầu từ 0
            int currentYear = cal.get(Calendar.YEAR);

            // Tính tháng và năm tiếp theo
            cal.add(Calendar.MONTH, 1);
            int nextMonth = cal.get(Calendar.MONTH) + 1;
            int nextYear = cal.get(Calendar.YEAR);
            String nextMonthName = Month.of(nextMonth).toString(); // Lấy tên tháng (ví dụ: "April")

            // Kiểm tra xem lịch cho tháng tiếp theo đã tồn tại chưa
            scheduleId = daoSc.getScheduleIdByMonth(nextMonth, nextYear);
            // Thêm bản ghi vào bảng Mentor_schedule
            boolean isAdded = daoSc.addSchedule(mentorId, scheduleId);
            if (isAdded) {
                LOGGER.info("Added new entry to Mentor_schedule with mentorId: " + mentorId + ", scheduleId: " + scheduleId);
                session.setAttribute("scheduleId", scheduleId);
                request.setAttribute("scheduleId", scheduleId);
                request.setAttribute("selectedMonth", nextMonth);
                request.setAttribute("selectedYear", nextYear);

                // Trả về JSON với thông tin tháng và năm vừa thêm
                response.setContentType("application/json");
                response.getWriter().write("{\"status\":\"success\",\"month\":\"" + nextMonthName + "\",\"year\":" + nextYear + "}");
            } else {
                LOGGER.info("Failed to add new schedule to Mentor_schedule.");
                response.setContentType("application/json");
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Failed to add schedule.\"}");
            }
        }

        session.setAttribute("scheduleId", scheduleId);
        request.getRequestDispatcher("view/slot_list.jsp").forward(request, response);
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

        String action = request.getParameter("action");
        System.out.println("🟢 Action: " + action);

        String slotDate = request.getParameter("slot_date");
        String slotNumber = request.getParameter("slotNumber");
        String scheduleIdStr = request.getParameter("scheduleId");
        System.out.println("scheduleId: " + scheduleIdStr);

        System.out.println("📌 formattedDay: " + slotDate);
        System.out.println("📌 slotNumber: " + slotNumber);

        if (slotDate == null || slotNumber == null) {
            request.setAttribute("message", "Error: Missing parameters (slot_date or slotNumber)");
            request.getRequestDispatcher("view/slot_list.jsp").forward(request, response);
            return;
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
