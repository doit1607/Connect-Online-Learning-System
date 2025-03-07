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
    private static Map<String, Long> requestTimestamps = new HashMap<>();
    private static final Map<String, String> processedSubmissions = new HashMap<>(); // Track processed submission IDs
    private static final long REQUEST_TIMEOUT = 2000;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Existing doPost logic remains unchanged
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
        String sessionId = request.getSession().getId();
        long currentTime = System.currentTimeMillis();
        long lastRequestTime = requestTimestamps.getOrDefault(sessionId, 0L);
        System.out.println("Received POST request at " + new java.util.Date() + " for session: " + sessionId + " with action: " + request.getParameter("service"));

        if (currentTime - lastRequestTime < REQUEST_TIMEOUT) {
            System.out.println("Blocked duplicate request for session: " + sessionId);
            response.getWriter().write("Request ignored: Duplicate submission detected.");
            return;
        }

        requestTimestamps.put(sessionId, currentTime);
        System.out.println("Processing new request for session: " + sessionId);
        String submissionId = request.getParameter("submissionId");

        synchronized (processedSubmissions) {
            if (submissionId != null && processedSubmissions.containsKey(submissionId)) {
                LOGGER.warning("Duplicate submission detected for submissionId: " + submissionId);
                response.setContentType("text/plain");
                response.getWriter().write("Request ignored: Duplicate submission detected.");
                return;
            }
            if (submissionId != null) {
                processedSubmissions.put(submissionId, sessionId);
            }
        }

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
        System.out.println("Received action: " + action);
        System.out.println("Received tempSlotBooked values: " + Arrays.toString(request.getParameterValues("tempSlotBooked")));
        if ("book".equals(action)) {
            String[] tempSlots = request.getParameterValues("tempSlotBooked");
            System.out.println("Received tempSlots: " + Arrays.toString(tempSlots));
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
            // Existing submit logic remains unchanged
            String requestId_raw = request.getParameter("requestId");
            @SuppressWarnings("unchecked")
            Set<String> tempSlotBooked = (Set<String>) session.getAttribute("tempSlotBooked");
            LOGGER.info("Processing submit with tempSlotBooked: " + tempSlotBooked);
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

                        int newRequestId;
                        try {
                            LOGGER.info("Attempting to insert new request: " + requests);
                            if (!daorequest.insertRequest(requests)) {
                                response.setContentType("text/plain");
                                response.getWriter().write("Failed to create request.");
                                return;
                            }
                            newRequestId = daorequest.insertRequestAndGetId(requests);
                            LOGGER.info("Inserted new request with ID: " + newRequestId);
                        } catch (SQLException ex) {
                            LOGGER.log(Level.SEVERE, "Error inserting request", ex);
                            response.setContentType("text/plain");
                            response.getWriter().write("Database error occurred.");
                            return;
                        }

                        int bookedCount = 0;
                        for (String slot : tempSlotBooked) {
                            LOGGER.info("Processing slot: " + slot);
                            String[] parts = slot.split("_");
                            String slotDate = parts[0];
                            int slotNumber = Integer.parseInt(parts[1]);
                            Integer slotId = daoSlot.getSlotId(slotDate, slotNumber);
                            if (slotId != null) {
                                boolean success = daoSlot.bookSlot(slotId, menteeId);
                                if (success) {
                                    try {
                                        LOGGER.info("Attempting to update slot ID: " + slotId + " with request ID: " + newRequestId);
                                        daoSlot.updateRequestIdForSlot(slotId, newRequestId);
                                        LOGGER.info("Updated slot ID: " + slotId + " with request ID: " + newRequestId);
                                        bookedCount++;
                                        LOGGER.info("Booked: " + slot);
                                    } catch (SQLException ex) {
                                        LOGGER.log(Level.SEVERE, "Error updating slot request ID", ex);
                                    }
                                } else {
                                    LOGGER.warning("no ava: " + slot);
                                }
                            } else {
                                LOGGER.warning("no available: " + slot);
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
                        LOGGER.info("Attempting to update request ID: " + requestId);
                        daorequest.updateRequest(existingRequest);
                        LOGGER.info("Updated request ID: " + requestId);

                        int bookedCount = 0;
                        for (String slot : tempSlotBooked) {
                            LOGGER.info("Processing slot: " + slot);
                            String[] parts = slot.split("_");
                            String slotDate = parts[0];
                            int slotNumber = Integer.parseInt(parts[1]);
                            Integer slotId = daoSlot.getSlotId(slotDate, slotNumber);
                            if (slotId != null) {
                                boolean success = daoSlot.bookSlot(slotId, menteeId);
                                if (success) {
                                    try {
                                        LOGGER.info("Attempting to update slot ID: " + slotId + " with request ID: " + requestId);
                                        daoSlot.updateRequestIdForSlot(slotId, requestId);
                                        LOGGER.info("Updated slot ID: " + slotId + " with request ID: " + requestId);
                                        bookedCount++;
                                        LOGGER.info("Booked: " + slot);
                                    } catch (SQLException ex) {
                                        LOGGER.log(Level.SEVERE, "Error updating slot request ID", ex);
                                    }
                                } else {
                                    LOGGER.warning("no ava: " + slot);
                                }
                            } else {
                                LOGGER.warning("no available: " + slot);
                            }
                        }
                        try {
                            LOGGER.info("Removing old slots for request ID: " + requestId);
                            daoSlot.removeRequestIdFromSlots(requestId);

                        } catch (SQLException ex) {
                            LOGGER.log(Level.SEVERE, "Error removing old slots", ex);
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

        // Lấy scheduleId từ request nếu có, mặc định là 1 nếu không cung cấp
        String scheduleIdStr = request.getParameter("scheduleId");
        int scheduleId = (scheduleIdStr != null && !scheduleIdStr.isEmpty()) ? Integer.parseInt(scheduleIdStr) : 1;

        // Lấy thông tin tháng và năm từ request
        String selectedMonthStr = request.getParameter("month");
        String selectedYearStr = request.getParameter("year");
        int selectedMonth, selectedYear;

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

            // Tìm scheduleId tương ứng với tháng/năm đã chọn
            List<Schedule> schedules = daoSc.getSchedulesByMonth(selectedYear, selectedMonth);
            if (!schedules.isEmpty()) {
                scheduleId = schedules.get(0).getId(); // Lấy scheduleId đầu tiên của tháng
                LOGGER.info("Updated scheduleId to " + scheduleId + " based on selected month/year: " + selectedMonth + "/" + selectedYear);
            } else {
                LOGGER.warning("No schedules found for " + selectedMonth + "/" + selectedYear + ". Keeping scheduleId: " + scheduleId);
            }
        } else {
            selectedMonth = LocalDate.now().getMonthValue();
            selectedYear = LocalDate.now().getYear();
            LOGGER.info("Defaulting to current month/year: " + selectedMonth + "/" + selectedYear);
        }

        // Lấy startDate và endDate từ scheduleId
        java.sql.Date startDate = daoSc.getStartDateByScheduleId(scheduleId);
        java.sql.Date endDate = daoSc.getEndDateByScheduleId(scheduleId);
        LOGGER.info("Date " + startDate + " - " + endDate);
        if (startDate == null || endDate == null) {
            LOGGER.severe("Schedule start or end date not found for scheduleId: " + scheduleId);
            redirect(response, "test1.jsp");
            return;
        }

        // Xử lý weekOffset
        int weekOffset = Optional.ofNullable(request.getParameter("weekOffset")).map(Integer::parseInt).orElse(0);
        if ("previousWeek".equals(action)) {
            weekOffset = weekOffset - 1;
            LOGGER.info("Moving to previous week. New weekOffset: " + weekOffset);
        } else if ("nextWeek".equals(action)) {
            weekOffset += 1;
            LOGGER.info("Moving to next week. New weekOffset: " + weekOffset);
        }

        // Tính toán ngày bắt đầu và kết thúc của tuần dựa trên startDate và weekOffset
        LocalDate firstDayOfWeek = startDate.toLocalDate().plusWeeks(weekOffset);
        LocalDate lastDayOfWeek = firstDayOfWeek.plusDays(6).isAfter(endDate.toLocalDate()) ? endDate.toLocalDate() : firstDayOfWeek.plusDays(6);

        // Ngăn chặn vượt quá giới hạn của schedule
        if (firstDayOfWeek.isBefore(startDate.toLocalDate())) {
            firstDayOfWeek = startDate.toLocalDate();
            lastDayOfWeek = firstDayOfWeek.plusDays(6).isAfter(endDate.toLocalDate()) ? endDate.toLocalDate() : firstDayOfWeek.plusDays(6);
            weekOffset = 0;
            LOGGER.info("Adjusted to start of schedule: " + firstDayOfWeek + " to " + lastDayOfWeek);
        } else if (lastDayOfWeek.isAfter(endDate.toLocalDate())) {
            lastDayOfWeek = endDate.toLocalDate();
            firstDayOfWeek = lastDayOfWeek.minusDays(6).isBefore(startDate.toLocalDate()) ? startDate.toLocalDate() : lastDayOfWeek.minusDays(6);
            weekOffset = (int) ((endDate.toLocalDate().toEpochDay() - startDate.toLocalDate().toEpochDay()) / 7);
            LOGGER.info("Adjusted to end of schedule: " + firstDayOfWeek + " to " + lastDayOfWeek);
        }

        LOGGER.info("Final week of schedule: " + firstDayOfWeek + " to " + lastDayOfWeek);

        // Populate slots và dữ liệu tuần
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

        // Chuẩn bị dữ liệu tháng cho dropdown
        Map<String, List<entity.Schedule>> schedulesByMonth = daoSc.getSchedulesByMonth();
        request.setAttribute("months", schedulesByMonth.keySet());
        request.setAttribute("schedulesByMonth", schedulesByMonth);
        request.setAttribute("weekDateInfoMap", weekDateInfoMap);
        request.setAttribute("formattedWeekDates", formattedWeekDates);
        request.setAttribute("weekOffset", weekOffset);
        request.setAttribute("slotsByDay", slotsByDay);
        request.setAttribute("slotTimeMap", slotTimeMap);
        request.setAttribute("scheduleId", scheduleId);
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
