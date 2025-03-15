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
import java.util.function.Supplier;

public class SetSlot extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(Slot.class.getName());
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

        // Default values for month and year
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

        // Get schedules for the selected month/year
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

        // Prepare week days and dates
        String[] weekDays = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
        request.setAttribute("weekDays", weekDays);

        // Lấy giá trị weekOffset từ request (mặc định là 0 nếu không có)
        int weekOffset = 0;
        String weekOffsetStr = request.getParameter("weekOffset");
        if (weekOffsetStr != null) {
            try {
                weekOffset = Integer.parseInt(weekOffsetStr);
            } catch (NumberFormatException e) {
                LOGGER.warning("Invalid weekOffset, defaulting to 0: " + e.getMessage());
            }
        }

        // Tính toán ngày bắt đầu dựa trên weekOffset và startDate của schedule
        List<String> weekDates = new ArrayList<>();
        java.sql.Date startDate = daoSc.getStartDateByScheduleId(scheduleId);
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        if (startDate != null) {
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(startDate);
            calendar.add(Calendar.WEEK_OF_YEAR, weekOffset); // Dịch chuyển tuần theo weekOffset
            calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY); // Đảm bảo tuần bắt đầu từ thứ Hai

            for (int i = 0; i < 7; i++) {
                weekDates.add(new java.sql.Date(calendar.getTimeInMillis()).toLocalDate().format(dateFormatter));
                calendar.add(Calendar.DATE, 1);
            }
        }
        request.setAttribute("weekDates", weekDates);

        // Cập nhật weekStartDate và weekEndDate
        String weekStartDate = weekDates.isEmpty() ? "" : weekDates.get(0);
        String weekEndDate = weekDates.isEmpty() ? "" : weekDates.get(6);
        request.setAttribute("weekOffset", weekOffset);
        request.setAttribute("weekStartDate", weekStartDate);
        request.setAttribute("weekEndDate", weekEndDate);

        // Slots by day
        Map<String, List<entity.Slot>> slotsByDay = new HashMap<>();
        if (startDate != null && mentorId != null) {
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(startDate);
            calendar.add(Calendar.WEEK_OF_YEAR, weekOffset); // Dịch chuyển tuần theo weekOffset
            calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY); // Đảm bảo tuần bắt đầu từ thứ Hai

            for (int i = 0; i < 7; i++) {
                java.sql.Date date = new java.sql.Date(calendar.getTimeInMillis());
                String formattedDate = date.toLocalDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                slotsByDay.put(formattedDate, daoMs.getSlotsByDate1(date, mentorId));
                calendar.add(Calendar.DATE, 1);
            }
        }
        System.out.println("HELOOOOOOOOOOOOOOOO" + slotsByDay);
        request.setAttribute("slotsByDay", slotsByDay);

        // Handle actions
        if ("add".equals(action)) {
            handleAddSlot(request, response, session, scheduleId, mentorId);
            return;
        } else if ("save".equals(action)) {
            handleSaveSlots(request, response, session, scheduleId, mentorId);
            return;
        } else if ("addSchedule".equals(action)) {
            LOGGER.info("Before handleAddSchedule: selectedMonth = " + selectedMonth + ", selectedYear = " + selectedYear);
            handleAddSchedule(request, response, mentorId, selectedMonth, selectedYear);
            return;
        } else if ("selectSchedule".equals(action)) {
            session.setAttribute("scheduleId", scheduleId);
            request.getRequestDispatcher("view/SetSlot.jsp").forward(request, response);
            return;
        }

        request.getRequestDispatcher("view/SetSlot.jsp").forward(request, response);
    }

    private void handleAddSlot(HttpServletRequest request, HttpServletResponse response, HttpSession session, int scheduleId, Integer mentorId)
            throws IOException, ServletException {
        String slotDateStr = request.getParameter("slot_date");
        String slotNumberStr = request.getParameter("slotNumber");
        Map<Integer, String> slotTimeMap = Map.of(1, "07:30:00", 2, "10:00:00", 3, "13:00:00", 4, "15:30:00", 5, "19:30:00");
        LOGGER.info("Received slotDateStr: " + slotDateStr + ", slotNumberStr: " + slotNumberStr);
        if (slotDateStr != null && slotNumberStr != null) {
            Date selectedDate = Date.valueOf(slotDateStr);
            int slotNumber = Integer.parseInt(slotNumberStr);
            String startTime = slotTimeMap.get(slotNumber);
            LOGGER.info("Parsed selectedDate: " + selectedDate + ", slotNumber: " + slotNumber + ", startTime: " + startTime);
            Map<Date, List<TempSlot>> tempSlotsByDate = (Map<Date, List<TempSlot>>) session.getAttribute("tempSlotsByDate");
            if (tempSlotsByDate == null) {
                tempSlotsByDate = new HashMap<>();
            }
            java.sql.Date startDate = daoSc.getStartDateByScheduleId(scheduleId);
            if (startDate == null) {
                LOGGER.warning("Invalid schedule ID: " + scheduleId);
                response.getWriter().write("Invalid schedule");
                return;
            }
            LOGGER.info("Fetched startDate from DB: " + startDate);
            Calendar cal = Calendar.getInstance();
            cal.setTime(startDate);
            int month = cal.get(Calendar.MONTH);
            int year = cal.get(Calendar.YEAR);

            cal.setTime(selectedDate);
            int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
            LOGGER.info("Selected date corresponds to dayOfWeek: " + dayOfWeek);

            cal.setTime(startDate);
            cal.set(Calendar.DAY_OF_MONTH, 1);
            while (cal.get(Calendar.MONTH) == month && cal.get(Calendar.YEAR) == year) {
                if (cal.get(Calendar.DAY_OF_WEEK) == dayOfWeek) {
                    Date date = new Date(cal.getTimeInMillis());
                    List<TempSlot> tempSlots = tempSlotsByDate.getOrDefault(date, new ArrayList<>());
                    // Lấy slotId từ DAOslot dựa trên scheduleId, date, slotNumber

                    int slotId = daoSlot.getSlotId(scheduleId, date, slotNumber);

                    System.out.println("Slot ID: " + slotId);
                    System.out.println("Schedule ID: " + scheduleId + " Date: " + date + " Slot Number: " + slotNumber);

                    if (slotId > 0) { // Kiểm tra slot có tồn tại trong bảng slots không
                        if (tempSlots.stream().noneMatch(slot -> slot.getSlotNumber() == slotNumber)) {
                            TempSlot newSlot = new TempSlot(scheduleId, date, slotNumber, startTime, "Available");
                            tempSlots.add(newSlot);
                            tempSlotsByDate.put(date, tempSlots);
                            LOGGER.info("Added TempSlot with slotId: " + slotId + ", details: " + newSlot);
                        } else {
                            LOGGER.info("TempSlot already exists in session for slotId: " + slotId
                                    + ", date: " + date + ", slotNumber: " + slotNumber);
                        }
                    } else {
                        LOGGER.warning("No slot found in database for scheduleId: " + scheduleId
                                + ", date: " + date + ", slotNumber: " + slotNumber);
                    }
                }
                cal.add(Calendar.DATE, 1);
            }
            session.setAttribute("tempSlotsByDate", tempSlotsByDate);
            LOGGER.info("Updated tempSlotsByDate in session");
            response.getWriter().write("success");
        } else {
            LOGGER.warning("Invalid input: slotDateStr or slotNumberStr is null");
            response.getWriter().write("Invalid input");
        }
    }

    private void handleSaveSlots(HttpServletRequest request, HttpServletResponse response, HttpSession session, int scheduleId, Integer mentorId)
            throws ServletException, IOException {
        Map<Date, List<TempSlot>> tempSlotsByDate = (Map<Date, List<TempSlot>>) session.getAttribute("tempSlotsByDate");
        if (tempSlotsByDate != null && !tempSlotsByDate.isEmpty()) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            for (Map.Entry<Date, List<TempSlot>> entry : tempSlotsByDate.entrySet()) {
                Date slotDate = entry.getKey(); // Đây là slot_date
                for (TempSlot slot : entry.getValue()) {
                    int slotNumber = slot.getSlotNumber(); // Đây là slot_number_id

                    // Lấy slotId từ DAOslot dựa trên scheduleId, slotDate, slotNumber
                    int slotId = daoSlot.getSlotId(scheduleId, slotDate, slotNumber);
                    System.out.println("Slot ID: " + slotId);
                    System.out.println("Schedule ID: " + scheduleId + " Date: " + slotDate + " Slot Number: " + slotNumber);
//                    if (slotId <= 0) { // Nếu slot chưa tồn tại, tạo mới
//                        slotId = daoSlot.createSlot(scheduleId, slotDate, slotNumber, slot.getStartTime(), "Available");
//                        LOGGER.info("Created new slot with slotId: " + slotId + " for date: " + sdf.format(slotDate));
//                    }
                    if (slotId > 0) { // Nếu slotId hợp lệ (tồn tại hoặc vừa tạo)
//                        daoMs.addSlotss(mentorId, slotId, "Available");
                        daoMs.addSlotss(mentorId, slotId, "nonAvailable");
                        LOGGER.info("Saved slot for mentorId: " + mentorId + ", slotId: " + slotId
                                + ", scheduleId: " + scheduleId + ", date: " + sdf.format(slotDate)
                                + ", slotNumber: " + slotNumber);
                    } else {
                        LOGGER.severe("Failed to get or create slotId for scheduleId: " + scheduleId
                                + ", date: " + sdf.format(slotDate) + ", slotNumber: " + slotNumber);
                    }
                }
            }
            session.removeAttribute("tempSlotsByDate");
            request.setAttribute("message", "Slots saved successfully!");
        } else {
            request.setAttribute("message", "No slots to save.");
        }
        request.getRequestDispatcher("view/SetSlot.jsp").forward(request, response);
    }

    private void handleAddSchedule(HttpServletRequest request, HttpServletResponse response, int mentorId, int selectedMonth, int selectedYear) throws IOException {
        LOGGER.info("Starting handleAddSchedule for mentorId: " + mentorId + ", selectedMonth: " + selectedMonth + ", selectedYear: " + selectedYear);

        int scheduleId = daoSc.getScheduleIdByMonth(selectedMonth, selectedYear);
        LOGGER.info("Before scheduleId: " + scheduleId);

        java.sql.Date start_date = daoSc.getStartDateByScheduleId(scheduleId);
        LOGGER.info("Current scheduleId: " + scheduleId + ", startDate: " + start_date);

        int nextMonth = (selectedMonth % 12) + 1;
        int nextYear = (selectedMonth == 12) ? selectedYear + 1 : selectedYear;

        LOGGER.info("Next month: " + nextMonth + ", Next year: " + nextYear);

        int nextScheduleId = daoSc.getScheduleIdByMonth(nextMonth, nextYear);
        LOGGER.info("Next scheduleId found: " + nextScheduleId);
        if (scheduleId == -1) {
            LOGGER.warning("No schedule found for selected month. Aborting addSchedule.");
            return;
        }

        boolean success = daoSc.addSchedule(mentorId, nextScheduleId);
        if (success) {
            LOGGER.info("Mentor linked successfully to scheduleId: " + nextScheduleId);
        } else {
            LOGGER.warning("Failed to link mentor to scheduleId: " + nextScheduleId);
        }

        try {
            request.getRequestDispatcher("view/SetSlot.jsp").forward(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(Slot.class.getName()).log(Level.SEVERE, null, ex);
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
