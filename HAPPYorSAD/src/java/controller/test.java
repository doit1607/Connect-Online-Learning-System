package controller;

import entity.Mentor;
import entity.Request;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import jakarta.servlet.annotation.MultipartConfig;
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
import java.sql.SQLException;
import java.time.DayOfWeek;
import java.time.Month;
import java.util.logging.Level;
import model.DAOCourse;
import model.TransactionDAO;

@MultipartConfig
public class test extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(Schedule.class.getName());
    private static final DAOmentee daoMentee = new DAOmentee();
    private static final DAOslot daoSlot = new DAOslot();
    private static final DAObook daoB = new DAObook();
    private final DAOschedule daoSc = new DAOschedule();

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
            if (startDateStr != null && !startDateStr.isEmpty()) {
                startDate = LocalDate.parse(startDateStr, formatter);
            }
            if (endDateStr != null && !endDateStr.isEmpty()) {
                endDate = LocalDate.parse(endDateStr, formatter);
            }
        } catch (DateTimeParseException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Invalid date format.");
            response.setContentType("text/plain");
            response.getWriter().write("Invalid date format.");
            return;
        } catch (Exception e) {
            e.printStackTrace();
        }

        DAOMentor daomentor = new DAOMentor();
        int menteeId = daorequest.getMenteeIdByUserId((Integer) session.getAttribute("userId"));
        String mentorIdStr = request.getParameter("mentorId");
        String courseIdStr = request.getParameter("courseId");
        String priceStr = request.getParameter("price");
        String totalSlotsStr = request.getParameter("totalSlots");
        String totalpriceStr = request.getParameter("totalprice");

        int mentorId = (mentorIdStr != null && !mentorIdStr.isEmpty()) ? Integer.parseInt(mentorIdStr) : 0;
        int courseId = (courseIdStr != null && !courseIdStr.isEmpty()) ? Integer.parseInt(courseIdStr) : 0;
        double price = (priceStr != null && !priceStr.isEmpty()) ? Double.parseDouble(priceStr) : 0.0;
        int totalSlots = (totalSlotsStr != null && !totalSlotsStr.isEmpty()) ? Integer.parseInt(totalSlotsStr) : 0;
        double totalprice = (totalpriceStr != null && !totalpriceStr.isEmpty()) ? Double.parseDouble(totalpriceStr) : 0.0;

        Mentor mentor = daomentor.getMentorByID(mentorId);

        String action = request.getParameter("action");
        System.out.println("Received action: " + action); // Debug
        System.out.println("Received tempSlotBooked values: " + Arrays.toString(request.getParameterValues("tempSlotBooked"))); // Debug
        if ("book".equals(action)) {
            String[] tempSlots = request.getParameterValues("tempSlotBooked");
            System.out.println("Received tempSlots: " + Arrays.toString(tempSlots)); // Debug
            if (tempSlots != null && tempSlots.length > 0) {
                Set<String> tempSlotBooked = new HashSet<>(Arrays.asList(tempSlots));
                session.setAttribute("tempSlotBooked", tempSlotBooked);
                String responseMessage = "Đã lưu tạm " + tempSlotBooked.size() + " slot.";
                response.setContentType("text/plain");
                response.getWriter().write(responseMessage);
                System.out.println("Saved tempSlotBooked to session: " + tempSlotBooked + ", Response: " + responseMessage);
            } else {
                String errorMessage = "Không có slot nào được chọn.";
                response.setContentType("text/plain");
                response.getWriter().write(errorMessage);
                System.out.println(errorMessage);
            }
            return;
        }

        if ("clear".equals(action)) {
            session.removeAttribute("tempSlotBooked");
            String responseMessage = "Đã xóa tất cả slot tạm.";
            response.setContentType("text/plain");
            response.getWriter().write(responseMessage);
            System.out.println("Cleared tempSlotBooked, Response: " + responseMessage);
            return;
        }

        if ("submit".equals(service)) {
            String requestId_raw = request.getParameter("requestId");
            @SuppressWarnings("unchecked")
            Set<String> tempSlotBooked = (Set<String>) session.getAttribute("tempSlotBooked");
            if (tempSlotBooked != null && !tempSlotBooked.isEmpty()) {
                totalSlots = tempSlotBooked.size();
                totalprice = totalSlots * price;

                if (requestId_raw == null) {
                    if (totalprice > 0 && walletbalance != null && walletbalance >= totalprice) {
                        daowallet.updateHold(usernamementee, totalprice);
                        daowallet.withdrawToWallet(usernamementee, totalprice);
                        double balance = daowallet.getBalance(usernamementee);
                        session.setAttribute("walletBalance", balance);
                        Request requests = new Request(menteeId, mentorId, title, totalSlots, totalprice, startDate, endDate, content, "Open", courseId);

                        // Sử dụng insertRequestAndGetId để lấy ID của request vừa chèn
                        int newRequestId;
                        try {
                            if (!daorequest.insertRequest(requests)) { // Nếu insertRequest trả về false
                                response.setContentType("text/plain");
                                response.getWriter().write("Failed to create request.");
                                return;
                            }
                            newRequestId = daorequest.insertRequestAndGetId(requests); // Lấy ID của request vừa chèn
                        } catch (SQLException ex) {
                            LOGGER.log(Level.SEVERE, "Error inserting request", ex);
                            response.setContentType("text/plain");
                            response.getWriter().write("Database error occurred.");
                            return;
                        }

                        // Đẩy slot vào database
                        int bookedCount = 0;
                        for (String slot : tempSlotBooked) {
                            String[] parts = slot.split("_");
                            String slotDate = parts[0];
                            int slotNumber = Integer.parseInt(parts[1]);
                            Integer slotId = daoSlot.getSlotId(slotDate, slotNumber);
                            if (slotId != null) {
                                boolean success = daoSlot.bookSlot(slotId, menteeId);
                                if (success) {
                                    try {
                                        daoSlot.updateRequestIdForSlot(slotId, newRequestId);
                                    } catch (SQLException ex) {
                                        LOGGER.log(Level.SEVERE, "Error updating slot request ID", ex);
                                    }
                                    bookedCount++;
                                    LOGGER.info("Booked: " + slot);
                                } else {
                                    LOGGER.warning("no ava: " + slot);
                                }
                            } else {
                                LOGGER.warning("no avalable: " + slot);
                            }
                        }

                        session.removeAttribute("tempSlotBooked");
                        session.setAttribute("msg", "Your request submit successfully! Booked " + bookedCount + " slot(s).");
                    } else {
                        response.setContentType("text/plain");
                        response.getWriter().write("Insufficient balance or invalid total price.");
                        return;
                    }
                } else {
                    int requestId = Integer.parseInt(requestId_raw);
                    Request existingRequest = daorequest.getRequestById(requestId);
                    if (existingRequest != null) {
                        existingRequest.setTitle(title);
                        existingRequest.setContent(content);
                        existingRequest.setStartDate(startDate);
                        existingRequest.setEndDate(endDate);
                        existingRequest.setTotalSlot(totalSlots);
                        existingRequest.settotalprice(totalprice);
                        existingRequest.setStatus("Open");
                        daorequest.updateRequest(existingRequest);

                        try {
                            // Đẩy slot vào database
                            daoSlot.removeRequestIdFromSlots(requestId); // Xóa request_id cũ (nếu cần)
                        } catch (SQLException ex) {
                            LOGGER.log(Level.SEVERE, "Error removing old slots", ex);
                        }
                        int bookedCount = 0;
                        for (String slot : tempSlotBooked) {
                            String[] parts = slot.split("_");
                            String slotDate = parts[0];
                            int slotNumber = Integer.parseInt(parts[1]);
                            Integer slotId = daoSlot.getSlotId(slotDate, slotNumber);
                            if (slotId != null) {
                                boolean success = daoSlot.bookSlot(slotId, menteeId);
                                if (success) {
                                    try {
                                        daoSlot.updateRequestIdForSlot(slotId, requestId);
                                    } catch (SQLException ex) {
                                        LOGGER.log(Level.SEVERE, "Error updating slot request ID", ex);
                                    }
                                    bookedCount++;
                                    LOGGER.info("Booked: " + slot);
                                } else {
                                    LOGGER.warning("no ava: " + slot);
                                }
                            } else {
                                LOGGER.warning("no avalable: " + slot);
                            }
                        }

                        session.removeAttribute("tempSlotBooked");
                        LOGGER.info("Request updated successfully: " + requestId);
                    } else {
                        request.setAttribute("errorMessage", "Không tìm thấy yêu cầu cần cập nhật.");
                        LOGGER.warning("Request with ID " + requestId + " not found.");
                    }
                }
                response.sendRedirect("ShowMenteeRequest");
                return;
            } else {
                response.setContentType("text/plain");
                response.getWriter().write("No slots booked temporarily.");
                return;
            }
        }

        if ("save".equals(service)) {
            String requestId_raw = request.getParameter("requestId");
            @SuppressWarnings("unchecked")
            Set<String> tempSlotBooked = (Set<String>) session.getAttribute("tempSlotBooked");
            if (tempSlotBooked != null && !tempSlotBooked.isEmpty()) {
                totalSlots = tempSlotBooked.size();
                totalprice = totalSlots * price;

                if (requestId_raw == null) {
                    Request requests = new Request(menteeId, mentorId, title, totalSlots, totalprice, startDate, endDate, content, "Draft", courseId);
                    if (!daorequest.insertRequest(requests)) {
                        request.setAttribute("errorMessage", "Failed to save draft request.");
                        LOGGER.warning("Failed to save draft request.");
                    }
                    session.removeAttribute("tempSlotBooked");
                } else {
                    int requestId = Integer.parseInt(requestId_raw);
                    Request existingRequest = daorequest.getRequestById(requestId);
                    if (existingRequest != null) {
                        existingRequest.setTitle(title);
                        existingRequest.setContent(content);
                        existingRequest.setStartDate(startDate);
                        existingRequest.setEndDate(endDate);
                        existingRequest.setTotalSlot(totalSlots);
                        existingRequest.settotalprice(totalprice);
                        existingRequest.setStatus("Draft");
                        if (!daorequest.updateRequest(existingRequest)) {
                            request.setAttribute("errorMessage", "Failed to update draft request.");
                            LOGGER.warning("Failed to update draft request: " + requestId);
                        }
                        session.removeAttribute("tempSlotBooked");
                    } else {
                        request.setAttribute("errorMessage", "Không tìm thấy yêu cầu cần cập nhật.");
                    }
                }
            }
            response.sendRedirect("ShowMenteeRequest");
            return;
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        DAOMentor daomentor = new DAOMentor();
        DAOCourse daocourse = new DAOCourse();
        String mentorIdStr = request.getParameter("mentorId");
        String courseIdStr = request.getParameter("courseId");
        int mentorId = (mentorIdStr != null && !mentorIdStr.isEmpty()) ? Integer.parseInt(mentorIdStr) : 0;
        int courseId = (courseIdStr != null && !courseIdStr.isEmpty()) ? Integer.parseInt(courseIdStr) : 0;
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
        int scheduleId = (scheduleIdStr != null && !scheduleIdStr.isEmpty()) ? Integer.parseInt(scheduleIdStr) : -1;
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

            // Lưu scheduleId đầu tiên vào session nếu có lịch trình
            scheduleId = schedules.get(0).getId();
            request.setAttribute("scheduleId", scheduleId);
        }

        request.setAttribute("schedules", schedules);
        request.setAttribute("selectedMonth", selectedMonth);
        request.setAttribute("selectedYear", selectedYear);

        LOGGER.info("Action received: " + action);
//        Integer scheduleId = DAOschedule.getScheduleIdsByMentorId(mentorId);
        java.sql.Date startDate = daoSc.getStartDateByScheduleId(scheduleId);
        java.sql.Date endDate = daoSc.getEndDateByScheduleId(scheduleId);
        LOGGER.info("Date " + startDate + " - " + endDate);
        if (startDate == null || endDate == null) {
            LOGGER.severe("Schedule start or end date not found for scheduleId: " + scheduleId);
            redirect(response, "test1.jsp");
            return;
        }
        int weekOffset = Optional.ofNullable(request.getParameter("weekOffset")).map(Integer::parseInt).orElse(0);
        LocalDate firstDayOfWeek = startDate.toLocalDate().plusWeeks(weekOffset);
        LocalDate lastDayOfWeek = firstDayOfWeek.plusDays(6).isAfter(endDate.toLocalDate()) ? endDate.toLocalDate() : firstDayOfWeek.plusDays(6);
        LOGGER.info("Displaying week from " + firstDayOfWeek + " to " + lastDayOfWeek);
        // Populate slots and week data
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        Map<String, List<Slot>> slotsByDay = new HashMap<>();
        Map<String, Map<String, String>> weekDateInfoMap = new LinkedHashMap<>();
        List<String> formattedWeekDates = new ArrayList<>();

        LocalDate currentDay = firstDayOfWeek;
        while (!currentDay.isAfter(lastDayOfWeek)) {
            String formattedDate = currentDay.format(dateFormatter);
            java.sql.Date sqlDate = java.sql.Date.valueOf(currentDay);
            List<Slot> slots = daoSlot.getSlotsByDate2(sqlDate, mentorId);
            slotsByDay.put(formattedDate, slots);

            Map<String, String> dateInfo = new HashMap<>();
            dateInfo.put("dayOfWeek", currentDay.getDayOfWeek().toString());
            dateInfo.put("day", String.valueOf(currentDay.getDayOfMonth()));
            dateInfo.put("month", currentDay.getMonth().toString());
            dateInfo.put("year", String.valueOf(currentDay.getYear()));
            weekDateInfoMap.put(formattedDate, dateInfo);

            formattedWeekDates.add(formattedDate);
            currentDay = currentDay.plusDays(1);
        }
        Map<Integer, String> slotTimeMap = Map.of(
                1, "07:30:00", 2, "10:00:00", 3, "13:00:00", 4, "15:30:00", 5, "19:30:00"
        );
        LOGGER.info("weekDateInfoMap: " + weekDateInfoMap);
        Map<String, List<entity.Schedule>> schedulesByMonth = daoSc.getSchedulesByMonth();
        request.setAttribute("months", schedulesByMonth.keySet());
        request.setAttribute("schedulesByMonth", schedulesByMonth);
        request.setAttribute("weekDateInfoMap", weekDateInfoMap);
        request.setAttribute("formattedWeekDates", formattedWeekDates);
        request.setAttribute("weekOffset", weekOffset);
        request.setAttribute("slotsByDay", slotsByDay);
        request.setAttribute("slotTimeMap", slotTimeMap);
        request.setAttribute("selectedYear", selectedYear);
        request.setAttribute("selectedMonth", selectedMonth);

        request.getRequestDispatcher("test1.jsp").forward(request, response);
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

    private void redirect(HttpServletResponse response, String url) throws IOException {
        LOGGER.info("Redirecting to: " + url);
        response.sendRedirect(url);
    }
}
