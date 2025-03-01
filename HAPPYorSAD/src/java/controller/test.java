package controller;

import entity.Mentor;
import entity.Request;
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
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import model.DAOMentor;
import model.DAORequest;
import entity.Schedule;
import entity.Transaction;
import java.time.Month;
import model.DAOCourse;
import model.TransactionDAO;

public class test extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(Schedule.class.getName());
    private static final DAOmentee daoMentee = new DAOmentee();
    private static final DAOslot daoSlot = new DAOslot();
    private static final DAObook daoB = new DAObook();
    private final DAOschedule daoSc = new DAOschedule();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        DAOMentor daomentor = new DAOMentor();
        DAOCourse daocourse = new DAOCourse();
        int mentorId = 0;
        int courseId = 0;
        double pricecourse = 0;
        String service = request.getParameter("service");
        if ("update".equals(service)) {
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String startDateStr = request.getParameter("startdate");
            String endDateStr = request.getParameter("enddate");
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate = null;
            Date endDate = null;
            try {
                if (startDateStr != null && !startDateStr.isEmpty()) {
                    startDate = sdf.parse(startDateStr);
                }
                if (endDateStr != null && !endDateStr.isEmpty()) {
                    endDate = sdf.parse(endDateStr);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            request.setAttribute("title", title);
            request.setAttribute("content", content);
            request.setAttribute("startdate", startDate);
            request.setAttribute("enddate", endDate);
            request.setAttribute("requestId", requestId);

        }
        mentorId = Integer.parseInt(request.getParameter("mentorId"));
        courseId = Integer.parseInt(request.getParameter("courseId"));
        Mentor mentor = daomentor.getMentorByID(mentorId);
        request.setAttribute("mentorrequest", mentor);
        request.setAttribute("mentorId", mentorId);
        request.setAttribute("courseId", courseId);
        double price = daocourse.getPriceCourse(courseId);
        request.setAttribute("price", price);

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

        // Lấy scheduleId từ request nếu có
        String scheduleIdStr = request.getParameter("scheduleId");
        int scheduleId = 1; // Mặc định nếu không có ID
//        if (scheduleIdStr == null || scheduleIdStr.isEmpty()) {
//            String selectedMonthStr = request.getParameter("month");
//            String selectedYearStr = request.getParameter("year");
//            int selectedMonth;
//            int selectedYear;
//
//            LOGGER.info("Extracted month = " + selectedMonthStr + ", year = " + selectedYearStr);
//            if (selectedMonthStr != null && selectedYearStr != null
//                    && !selectedMonthStr.isEmpty() && !selectedYearStr.isEmpty()) {
//                try {
//                    selectedMonth = Integer.parseInt(selectedMonthStr);
//                } catch (NumberFormatException e) {
//                    try {
//                        // Nếu không phải số, chuyển đổi tên tháng sang số (ví dụ: "March" -> 3)
//                        Month monthEnum = Month.valueOf(selectedMonthStr.toUpperCase());
//                        selectedMonth = monthEnum.getValue();
//                    } catch (IllegalArgumentException ex) {
//                        // Nếu tên tháng không hợp lệ, mặc định lấy tháng hiện tại
//                        selectedMonth = LocalDate.now().getMonthValue();
//                        LOGGER.info("Invalid month parameter: " + selectedMonthStr + ". Defaulting to current month: " + selectedMonth);
//                    }
//                }
//                try {
//                    selectedYear = Integer.parseInt(selectedYearStr);
//                } catch (NumberFormatException e) {
//                    selectedYear = LocalDate.now().getYear();
//                    LOGGER.info("Invalid year parameter: " + selectedYearStr + ". Defaulting to current year: " + selectedYear);
//                }
//                LOGGER.info("Selected Month = " + selectedMonth + ", Selected Year = " + selectedYear);
//            } else {
//                selectedMonth = LocalDate.now().getMonthValue();
//                selectedYear = LocalDate.now().getYear();
//                LOGGER.info("Defaulting to current month/year: " + selectedMonth + "/" + selectedYear);
//            }
//            LOGGER.info("Fetching schedules for: " + selectedMonth + "/" + selectedYear);
//            List<Schedule> schedules = daoSc.getSchedulesByMonth(selectedYear, selectedMonth);
//            response.setContentType("text/html");
//            response.getWriter().write("<h3>Schedules for " + Month.of(selectedMonth) + " " + selectedYear + "</h3>");
//            if (schedules.isEmpty()) {
//                response.getWriter().write("<p>No schedules found.</p>");
//                return;
//            } else {
//                response.getWriter().write("<ul>");
//                for (Schedule schedule : schedules) {
//                    response.getWriter().write("<li data-schedule-id='" + schedule.getId() + "'>"
//                            + "Schedule ID: " + schedule.getId()
//                            + " - " + schedule.getStart_date() + "</li>");
//                }
//                response.getWriter().write("</ul>");
//
//                // Lưu scheduleId đầu tiên vào session nếu có lịch trình
//                scheduleId = schedules.get(0).getId();
//                request.setAttribute("scheduleId", scheduleId);
//            }
//            LOGGER.info("Processing Schedule ID: " + scheduleId);
//
//        }
        LOGGER.info("Receive Schedule ID: " + scheduleId);
        LOGGER.info("Action received: " + action);
//        Integer scheduleId = DAOschedule.getScheduleIdsByMentorId(mentorId);
        LOGGER.info("Schedule ID for mentor " + mentorId + ": " + scheduleId);

        java.sql.Date startDate = daoSc.getStartDateByScheduleId(scheduleId);
        java.sql.Date endDate = daoSc.getEndDateByScheduleId(scheduleId);
        LOGGER.info("Date " + startDate + ": " + endDate);
        if (startDate == null || endDate == null) {
            LOGGER.severe("Schedule start or end date not found for scheduleId: " + scheduleId);
            redirect(response, "test1.jsp");
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
        Map<String, List<entity.Schedule>> schedulesByMonth = daoSc.getSchedulesByMonth();
        Set<String> months = schedulesByMonth.keySet();
        request.setAttribute("months", months);
        request.setAttribute("schedulesByMonth", schedulesByMonth);

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
        HttpSession session = request.getSession();
        DAORequest daorequest = new DAORequest();
        TransactionDAO daowallet = new TransactionDAO();
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String startDateStr = request.getParameter("startdate");
        String endDateStr = request.getParameter("enddate");
        String service = request.getParameter("service");
        String usernamementee = (String) session.getAttribute("usernameUser");
        Double walletbalance = (Double) session.getAttribute("walletBalance");
        LocalDate startDate = null;
        LocalDate endDate = null;

        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            startDate = LocalDate.parse(startDateStr, formatter);
            endDate = LocalDate.parse(endDateStr, formatter);
        } catch (DateTimeParseException e) {
            e.printStackTrace();

            request.setAttribute("errorMessage", "Invalid date format.");
            request.getRequestDispatcher("yourErrorPage.jsp").forward(request, response);
            return;
        } catch (Exception e) {
            e.printStackTrace();

        }
        DAOMentor daomentor = new DAOMentor();
        int menteeId = daorequest.getMenteeIdByUserId((Integer) session.getAttribute("userId"));
        int mentorId = Integer.parseInt(request.getParameter("mentorId"));
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        double price = Double.parseDouble(request.getParameter("price"));
        Mentor mentor = daomentor.getMentorByID(mentorId);
        int totalSlots = Integer.parseInt(request.getParameter("totalSlots"));
        double totalprice = Double.parseDouble(request.getParameter("totalprice"));
        if ("submit".equals(service)) {
            String requestId_raw = request.getParameter("requestId");
            if (requestId_raw == null) {
                daowallet.updateHold(usernamementee, totalprice);
                daowallet.withdrawToWallet(usernamementee, totalprice);
                double balance = daowallet.getBalance(usernamementee);
                session.setAttribute("walletBalance", balance);
                Request requests = new Request(menteeId, mentorId, title, totalSlots, totalprice, startDate, endDate, content, "Open", courseId);
                daorequest.insertRequest(requests);
                session.setAttribute("msg", "Your request submit successfully!");
            }
            else{
                
            }

            response.sendRedirect("ShowMenteeRequest");
        }
        if ("save".equals(service)) {
            String requestId_raw = request.getParameter("requestId");
            if (requestId_raw == null) {
                Request requests = new Request(menteeId, mentorId, title, totalSlots, totalprice, startDate, endDate, content, "Draft", courseId);
                daorequest.insertRequest(requests);
                response.sendRedirect("ShowMenteeRequest");
            } else {
                int requestId = Integer.parseInt(request.getParameter("requestId"));
            }

        }
    }
}
