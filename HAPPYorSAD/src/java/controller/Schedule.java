package controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DAObook;
import model.DAOmentee;
import model.DAOschedule;
import model.DAOslot;
import entity.Slot;

public class Schedule extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(Schedule.class.getName());
    private static final DAOmentee daoMentee = new DAOmentee();
    private static final DAOslot daoSlot = new DAOslot();
    private static final DAObook daoB = new DAObook();
    private final DAOschedule daoSc = new DAOschedule();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;
        if (userId == null) {
            LOGGER.warning("User not logged in. Redirecting to login.");
            redirect(response, "view/LoginUser.jsp");
            return;
        }
        String action = Optional.ofNullable(request.getParameter("action")).orElse("");
        LOGGER.info("Action received: " + action);
        Integer menteeId = DAOmentee.getMenteeIdByUserId(userId);
        LOGGER.info("Mentee ID retrieved: " + menteeId);
        Integer mentorId = 1;
//        Integer scheduleId = DAOschedule.getScheduleIdsByMentorId(mentorId);
        Integer scheduleId = 1;
        LOGGER.info("Schedule ID for mentor " + mentorId + ": " + scheduleId);
        if (scheduleId == null) {
            LOGGER.warning("Schedule ID not found for mentor ID: " + mentorId);
            return;
        }
        java.sql.Date startDate = daoSc.getStartDateByScheduleId(scheduleId);
        java.sql.Date endDate = daoSc.getEndDateByScheduleId(scheduleId);
        if (startDate == null || endDate == null) {
            LOGGER.severe("Schedule start or end date not found for scheduleId: " + scheduleId);
            redirect(response, "Schedule?action=list&error=noScheduleDates");
            return;
        }
        SimpleDateFormat dayFormatter = new SimpleDateFormat("yyyy-MM-dd");
        request.setAttribute("weekDays", new String[]{"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"});
        if (startDate == null) {
            LOGGER.severe("Start date not found for schedule ID: " + scheduleId);
            return;
        }
        LOGGER.info("Start date for schedule: " + startDate);
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(startDate);
        Map<Integer, java.sql.Date> closestWeekDates = new LinkedHashMap<>();
        Calendar tempCal = (Calendar) calendar.clone();
        int startDayOfWeek = tempCal.get(Calendar.DAY_OF_WEEK);
        int adjustedStartDay = (startDayOfWeek == Calendar.SUNDAY) ? 7 : startDayOfWeek - 1;
        closestWeekDates.put(adjustedStartDay, new java.sql.Date(tempCal.getTimeInMillis()));
        if (adjustedStartDay != 1) {
            tempCal.add(Calendar.DAY_OF_MONTH, 8 - adjustedStartDay);
        }
        closestWeekDates.put(1, new java.sql.Date(tempCal.getTimeInMillis())); // Monday
        for (int i = 1; i <= 7; i++) {
            if (!closestWeekDates.containsKey(i)) {
                tempCal.add(Calendar.DAY_OF_MONTH, 1);
                closestWeekDates.put(i, new java.sql.Date(tempCal.getTimeInMillis()));
            }
        }
        LOGGER.info("Updated weekDates mapping: " + closestWeekDates.values());
        java.sql.Date[] weekDates = new java.sql.Date[7];
        for (int i = 1; i <= 7; i++) {  // i chạy từ 1 đến 7 cho các ngày trong tuần
            weekDates[i - 1] = closestWeekDates.get(i); // Lấy giá trị từ closestWeekDates
        }
        LOGGER.info("Week Dates before conversion: " + Arrays.toString(weekDates));
        List<String> originalDatesList = new ArrayList<>();
        for (java.sql.Date date : weekDates) {
            if (date != null) {
                originalDatesList.add(date.toString()); // Chuyển thành YYYY-MM-DD
            } else {
                originalDatesList.add("null"); // Để kiểm tra trong JSP
            }
        }
        LOGGER.info("Original Dates List: " + originalDatesList);
        request.setAttribute("originalDatesList", originalDatesList);
        Map<String, List<Slot>> slotsByDay = new HashMap<>();
        Map<Integer, String> slotTimeMap = new HashMap<>();
        slotTimeMap.put(1, "07:30:00");
        slotTimeMap.put(2, "10:00:00");
        slotTimeMap.put(3, "13:00:00");
        slotTimeMap.put(4, "15:30:00");
        slotTimeMap.put(5, "19:30:00");
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        List<String> formattedWeekDates = new ArrayList<>();
        for (int i = 0; i < 7; i++) {
            java.sql.Date date = closestWeekDates.get(i + 1);
            if (date != null) {
                String formattedDate = formatter.format(date);
                formattedWeekDates.add(formattedDate);
                List<Slot> slots = daoSlot.getSlotsByDate1(date, mentorId);
                LOGGER.info("Slots for date " + date + ": " + slots);
                LOGGER.info("Formatted Date Key: " + formattedDate);
                slotsByDay.put(formattedDate, slots);
                LOGGER.info("Date key: " + dayFormatter.format(date));

            }
        }

        for (Map.Entry<String, List<Slot>> entry : slotsByDay.entrySet()) {
            LOGGER.info("Stored Key: " + entry.getKey() + " | Slots: " + entry.getValue());
        }
                request.getParameterMap().forEach((key, value) -> LOGGER.info("Param: " + key + " = " + Arrays.toString(value)));


        request.setAttribute("weekDates", formattedWeekDates);
        request.setAttribute("slotsByDay", slotsByDay);
        request.setAttribute("slotTimeMap", slotTimeMap);
        LOGGER.info("Updated weekDates mapping: " + Arrays.toString(weekDates));
        LOGGER.info("Slots retrieved for date :" + slotsByDay);
        LOGGER.info("slotsByDay keys: " + slotsByDay.keySet());
        System.out.println("Available Keys in slotsByDay: " + slotsByDay.keySet());

        try {
            switch (action) {
                case "tempBook":
                    handleTempBook(request, session, response);
                    break;
                case "confirmBook":
                    handleConfirmBook(session, response, menteeId);
                    break;
                default:
                    request.getRequestDispatcher("view/book.jsp").forward(request, response);
            }
        } catch (Exception e) {
            LOGGER.severe("Error processing request: " + e.getMessage());
            throw new ServletException(e);
        }
    }

    private void handleTempBook(HttpServletRequest request, HttpSession session, HttpServletResponse response) throws IOException {
        String slotDateStr = request.getParameter("slotDate");
        String slotNumberStr = request.getParameter("slotNumber");
        request.getParameterMap().forEach((key, value) -> LOGGER.info("Param: " + key + " = " + Arrays.toString(value)));


        LOGGER.info("Received request parameters: slotDateStr=" + slotDateStr + ", slotNumberStr=" + slotNumberStr);

        Integer slotNumber;
        try {
            slotNumber = Integer.parseInt(slotNumberStr);
        } catch (NumberFormatException e) {
            LOGGER.warning("Invalid slotNumber: " + slotNumberStr);
            redirect(response, "Schedule?action=list&error=invalidSlotNumber");
            return;
        }
        Map<Integer, String> slotTimeMap = getSlotTimeMap();
        if (!slotTimeMap.containsKey(slotNumber)) {
            LOGGER.warning("Slot number out of range: " + slotNumber);
            redirect(response, "Schedule?action=list&error=invalidSlotNumber");
            return;
        }
        LOGGER.info("Validated slotNumber: " + slotNumber + " (" + slotTimeMap.get(slotNumber) + ")");

        Integer mentorId = 1;
        Integer scheduleId = DAOschedule.getScheduleIdsByMentorId(mentorId);
        LOGGER.info("Schedule ID for mentor " + mentorId + ": " + scheduleId);

        if (scheduleId == null) {
            LOGGER.warning("Schedule ID not found for mentor ID: " + mentorId);
            return;
        }
        java.sql.Date startDate = daoSc.getStartDateByScheduleId(scheduleId);
        java.sql.Date endDate = daoSc.getEndDateByScheduleId(scheduleId);
        if (startDate == null || endDate == null) {
            LOGGER.severe("Schedule start or end date not found for scheduleId: " + scheduleId);
            redirect(response, "Schedule?action=list&error=noScheduleDates");
            return;
        }
        LOGGER.info("Schedule start date: " + startDate + ", end date: " + endDate);

        try {
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            java.sql.Date slotDate = new java.sql.Date(formatter.parse(slotDateStr).getTime());
            List<java.sql.Date> repeatDates = getDatesWithSameWeekday(slotDate, startDate, endDate);
            LOGGER.info("Received repeateDate: " + repeatDates);
            if (repeatDates == null || repeatDates.isEmpty()) {
                LOGGER.warning("No valid repeat dates found.");
                redirect(response, "Schedule?action=list&error=noRepeatDates");
                return;
            }
            Map<Integer, List<java.sql.Date>> tempSlots = (Map<Integer, List<java.sql.Date>>) session.getAttribute("tempSlots");
            tempSlots.computeIfAbsent(slotNumber, k -> new ArrayList<>()).addAll(repeatDates);
            LOGGER.info("Parsed slotDate: " + slotDate);
            if (tempSlots == null) {
                tempSlots = new HashMap<>();
                session.setAttribute("tempSlots", tempSlots);
            }

            List<java.sql.Date> slotList = tempSlots.computeIfAbsent(slotNumber, k -> new ArrayList<>());
            slotList.addAll(repeatDates);
            slotList.add(slotDate);

            session.setAttribute("tempSlots", tempSlots);
            LOGGER.info("Updated tempSlots: " + tempSlots);
            request.getParameterMap().forEach((key, value) -> LOGGER.info("Request param: " + key + " = " + Arrays.toString(value)));
            request.getParameterMap().forEach((key, value) -> LOGGER.info(key + " = " + Arrays.toString(value)));

        } catch (ParseException e) {
            LOGGER.severe("Error parsing slotDate: " + e.getMessage());
            redirect(response, "Schedule?action=list&error=dateFormat");
        }
    }

    private void handleConfirmBook(HttpSession session, HttpServletResponse response, Integer menteeId) throws IOException {
        Map<java.sql.Date, List<String>> tempSlots = (Map<java.sql.Date, List<String>>) session.getAttribute("tempSlots");

        if (tempSlots == null || tempSlots.isEmpty()) {
            LOGGER.warning("No slots selected");
            return;
        }

        for (Map.Entry<java.sql.Date, List<String>> entry : tempSlots.entrySet()) {
            java.sql.Date slotDate = entry.getKey();
            for (String startTime : entry.getValue()) {
                LOGGER.info("Processing booking for date " + slotDate + " and time " + startTime);
                Integer slotNumberId = daoB.getSlotNumberIdByDateAndTime(slotDate, startTime);
                if (slotNumberId != null) {
                    Integer slotId = daoB.getSlotIdByDateAndNumber(slotDate, slotNumberId);
                    if (slotId != null) {
                        daoSlot.bookSlot(slotId, menteeId);
                        LOGGER.info("Booked slot " + slotId + " for mentee " + menteeId);
                    }
                }
            }
        }
        session.removeAttribute("tempSlots");
        LOGGER.info("Temporary slots cleared after booking confirmation.");
    }

    private List<java.sql.Date> getDatesWithSameWeekday(java.sql.Date slotDate, java.sql.Date startDate, java.sql.Date endDate) {
        List<java.sql.Date> matchingDates = new ArrayList<>();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(slotDate);
        int selectedDayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);

        calendar.setTime(startDate);
        while (!calendar.getTime().after(endDate)) {
            if (calendar.get(Calendar.DAY_OF_WEEK) == selectedDayOfWeek) {
                matchingDates.add(new java.sql.Date(calendar.getTimeInMillis()));
            }
            calendar.add(Calendar.DATE, 1);
        }

        return matchingDates;
    }

    private Map<Integer, String> getSlotTimeMap() {
        return Map.of(
                1, "07:30:00",
                2, "10:00:00",
                3, "13:00:00",
                4, "15:30:00",
                5, "19:30:00"
        );
    }

    private void redirect(HttpServletResponse response, String url) throws IOException {
        LOGGER.info("Redirecting to: " + url);
        response.sendRedirect(url);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
}
