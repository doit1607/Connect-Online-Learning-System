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
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class test extends HttpServlet {

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
        Integer scheduleId = 2;
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
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(startDate);
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String[] weekDays = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
        Map<Integer, java.sql.Date> closestWeekDates = new LinkedHashMap<>();
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
            }
        }
        Map<String, List<Slot>> slotsByDay = new HashMap<>();
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

                List<Slot> slots = daoSlot.getSlotsByDate1(date, mentorId);
                slotsByDay.put(formattedDate, slots);

                // Populate weekDateInfoMap
                Map<String, String> dateInfo = new HashMap<>();
                dateInfo.put("dayOfWeek", weekDays[i - 1]);
                dateInfo.put("day", String.valueOf(localDate.getDayOfMonth()));
                dateInfo.put("month", localDate.getMonth().toString());
                dateInfo.put("year", String.valueOf(localDate.getYear()));

                weekDateInfoMap.put(formattedDate, dateInfo);
                LOGGER.info("formattedDate: " + formattedDate + " | dateInfo: " + dateInfo);
                LOGGER.info("Date: " + formattedDate + " | Slots: " + slots);
            }
        }

        request.setAttribute("weekDateInfoMap", weekDateInfoMap);
        request.setAttribute("formattedWeekDates", formattedWeekDates);

        request.setAttribute("slotsByDay", slotsByDay);
        request.setAttribute("slotTimeMap", slotTimeMap);

        if ("book".equals(action)) {
            boolean repeat = "on".equals(request.getParameter("repeat"));

            String[] selectedSlots = request.getParameterValues("selectedSlots");

            if (selectedSlots == null || selectedSlots.length == 0) {
                LOGGER.warning("No slots selected");
                response.getWriter().write("Vui lòng chọn ít nhất một slot.");
                return;
            }

            List<String> finalSlots = new ArrayList<>(Arrays.asList(selectedSlots));
            List<String> slotsList = new ArrayList<>();

            for (String slot : selectedSlots) {
                String[] splitSlots = slot.split(",");
                slotsList.addAll(Arrays.asList(splitSlots));
            }

            System.out.println("Slots picked: " + String.join(", ", slotsList));

            if (repeat) {
                List<String> additionalSlots = new ArrayList<>();
                for (String slot : selectedSlots) {
                    String[] parts = slot.split("_");
                    Date slotDate = java.sql.Date.valueOf(parts[0]);
                    int slotNumber = Integer.parseInt(parts[1]);
                    calendar.setTime(slotDate);
                    LOGGER.info("Processing repeat booking for slot: " + slotDate + "_" + slotNumber);

                    while (true) {
                        calendar.add(Calendar.DATE, 7);
                        Date newSlotDate = new Date(calendar.getTimeInMillis());

                        if (newSlotDate.after(new Date())) {
                            LOGGER.info("Reached end date for repeat booking");
                            break;
                        }
                        String newSlot = newSlotDate + "_" + slotNumber;
                        additionalSlots.add(newSlot);
                        LOGGER.info("Generated additional slot: " + newSlot);
                    }
                }
                finalSlots.addAll(additionalSlots);
            }

            int bookedCount = 0;
            for (String slot : finalSlots) {
                String[] parts = slot.split("_");
                String slotDate = parts[0]; // YYYY-MM-DD
                int slotNumber = Integer.parseInt(parts[1]); // slotNumber
                Integer slotId = daoSlot.getSlotId(slotDate, slotNumber);

                if (slotId != null) {
                    boolean success = daoSlot.bookSlot(slotId, menteeId);
                    if (success) {
                        LOGGER.info("Booked: " + slot);
                    } else {
                        LOGGER.warning("no ava: " + slot);
                    }
                } else {
                    LOGGER.warning("no avalable: " + slot);
                }
            }

            if (bookedCount > 0) {
                response.getWriter().write("Booked for " + bookedCount + " slot.");
            } else {
                response.getWriter().write("Try again.");
            }

        } else {
            LOGGER.warning("Invalid action: " + action);
            request.getRequestDispatcher("test1.jsp").forward(request, response);
        }

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
