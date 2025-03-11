package controller;

import entity.Course;
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
import model.DAOCourse;
import entity.Slot;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.format.TextStyle;
import java.time.temporal.ChronoUnit;
import java.time.format.DateTimeParseException;
import model.DAOMentor;
import model.DAORequest;
import entity.Schedule;
import entity.Transaction;
import java.sql.SQLException;
import java.time.DayOfWeek;
import java.time.Month;
import java.util.logging.Level;
import model.TransactionDAO;

@MultipartConfig
public class test extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(Schedule.class.getName());
    private static final DAOmentee daoMentee = new DAOmentee();
    private static final DAOslot daoSlot = new DAOslot();
    private static final DAObook daoB = new DAObook();
    private static final DAOCourse daoC = new DAOCourse();
    private final DAOschedule daoSc = new DAOschedule();
    private static Map<String, Long> requestTimestamps = new HashMap<>();
    private static final Map<String, String> processedSubmissions = new HashMap<>();
    private static final long REQUEST_TIMEOUT = 2000;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Giữ nguyên logic doPost hiện tại
        HttpSession session = request.getSession();
        DAORequest daorequest = new DAORequest();
        TransactionDAO daowallet = new TransactionDAO();
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        LocalDate startDate = LocalDate.now(); // Lấy ngày hiện tại
        String endDateStr = request.getParameter("enddate");
        String service = request.getParameter("service");
        String usernamementee = (String) session.getAttribute("usernameUser");
        Double walletbalance = (Double) session.getAttribute("walletBalance");
        LocalDate endDate = null;
        String sessionId = request.getSession().getId();
        long currentTime = System.currentTimeMillis();
        long lastRequestTime = requestTimestamps.getOrDefault(sessionId, 0L);
        String submissionId = request.getParameter("submissionId");
        System.out.println("Received POST request at " + new java.util.Date() + " for session: " + sessionId + " with action: " + request.getParameter("service"));

        if (currentTime - lastRequestTime < REQUEST_TIMEOUT) {
            LOGGER.warning("Blocked duplicate request for session: " + sessionId + " within " + REQUEST_TIMEOUT + "ms");
            response.setContentType("text/plain");
            response.getWriter().write("Request ignored: Too frequent submission.");
            return;
        }

        synchronized (processedSubmissions) {
            if (submissionId != null && processedSubmissions.containsKey(submissionId)) {
                LOGGER.warning("Blocked duplicate request for session: " + sessionId + ", submissionId: " + submissionId);
                response.setContentType("text/plain");
                response.getWriter().write("Request ignored: Duplicate submission detected.");
                return;
            }
            if (submissionId != null) {
                processedSubmissions.put(submissionId, sessionId);
            }
        }
        requestTimestamps.put(sessionId, currentTime);

        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
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
            String requestId_raw = request.getParameter("requestId");
            Set<String> tempSlotBooked = (Set<String>) session.getAttribute("tempSlotBooked");
            LOGGER.info("Processing submit with tempSlotBooked: " + tempSlotBooked);
            if (tempSlotBooked != null && !tempSlotBooked.isEmpty()) {
                totalSlots = tempSlotBooked.size();
                totalprice = totalSlots * price;

                if (requestId_raw == null) {
                    if (totalprice > 0 && walletbalance != null && walletbalance >= totalprice) {
                        daowallet.updateHold(usernamementee, totalprice);
                        double balance = daowallet.getBalance(usernamementee);
                        double totalbalance = daowallet.getTotalBalance(usernamementee);
                        double hold = daowallet.getHold(usernamementee);
                        DAOCourse dao = new DAOCourse();
                        String coursename = dao.getCourseName(courseId);
                        daowallet.createTransaction(usernamementee, totalprice, "WITHDRAW", "Thanh toan khoa hoc " + coursename);
                        session.setAttribute("walletBalance", balance);
                        session.setAttribute("walletTotalbalance", totalbalance);
                        session.setAttribute("walletHold", hold);
                        Request requests = new Request(menteeId, mentorId, title, totalSlots, totalprice, startDate, endDate, content, "Open", courseId);

                        int newRequestId;
                        try {
                            LOGGER.info("Attempting to insert new request: " + requests);
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

        // Lấy các tham số từ request (bao gồm từ JSP)
        String mentorIdStr = request.getParameter("mentorId");
        String courseIdStr = request.getParameter("courseId");
        String selectedMonthStr = request.getParameter("month"); // Từ JSP
        String selectedYearStr = request.getParameter("year");   // Từ JSP
        String weekOffsetStr = request.getParameter("weekOffset"); // Từ JSP
        String service = request.getParameter("service");
        int mentorId = (mentorIdStr != null && !mentorIdStr.isEmpty()) ? Integer.parseInt(mentorIdStr) : 0;
        int courseId = (courseIdStr != null && !courseIdStr.isEmpty()) ? Integer.parseInt(courseIdStr) : 0;
        int weekOffset = (weekOffsetStr != null && !weekOffsetStr.isEmpty()) ? Integer.parseInt(weekOffsetStr) : 0;

        Mentor mentor = daomentor.getMentorByID(mentorId);
        double price = Double.parseDouble(request.getParameter("price"));

        // Gán các giá trị cơ bản vào request
        request.setAttribute("mentorrequest", mentor);
        request.setAttribute("mentorId", mentorId);
        request.setAttribute("courseId", courseId);
        request.setAttribute("price", price);
        if ("update".equals(service)) {
            request.setAttribute("title", request.getParameter("title"));
            request.setAttribute("content", request.getParameter("content"));
            request.setAttribute("startdate", LocalDate.now().toString()); // Lấy ngày hiện tại và chuyển thành String
            request.setAttribute("enddate", request.getParameter("enddate"));
            request.setAttribute("requestId", request.getParameter("requestId"));
        }

        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            LOGGER.warning("User not logged in. Redirecting to login.");
            redirect(response, "view/LoginUser.jsp");
            return;
        }

        Integer menteeId = DAOmentee.getMenteeIdByUserId(userId);
        LOGGER.info("Mentee ID retrieved: " + menteeId);

        // Xử lý tháng và năm từ request hoặc mặc định là hiện tại
        int selectedMonth;
        int selectedYear;

        if (selectedMonthStr != null && selectedYearStr != null && !selectedMonthStr.isEmpty() && !selectedYearStr.isEmpty()) {
            try {
                selectedMonth = Month.valueOf(selectedMonthStr.toUpperCase()).getValue(); // Chuyển từ tên tháng sang số
                selectedYear = Integer.parseInt(selectedYearStr);
            } catch (IllegalArgumentException e) {
                selectedMonth = LocalDate.now().getMonthValue();
                selectedYear = LocalDate.now().getYear();
                LOGGER.info("Invalid month/year parameters: " + selectedMonthStr + "/" + selectedYearStr + ". Defaulting to current: " + selectedMonth + "/" + selectedYear);
            }
        } else {
            selectedMonth = LocalDate.now().getMonthValue();
            selectedYear = LocalDate.now().getYear();
            LOGGER.info("No month/year provided. Defaulting to current: " + selectedMonth + "/" + selectedYear);
        }

        // Lấy schedule dựa trên tháng/năm hoặc mặc định
        List<Schedule> schedules = daoSc.getSchedulesByMonth(selectedYear, selectedMonth);
        int scheduleId = schedules.isEmpty() ? 1 : schedules.get(0).getId(); // Lấy schedule đầu tiên nếu có

        java.sql.Date startDate = daoSc.getStartDateByScheduleId(scheduleId);
        java.sql.Date endDate = daoSc.getEndDateByScheduleId(scheduleId);
        if (startDate == null || endDate == null) {
            LOGGER.severe("Schedule start or end date not found for scheduleId: " + scheduleId);
            redirect(response, "test1.jsp");
            return;
        }

        // Tính toán tuần dựa trên weekOffset
        LocalDate baseDate = LocalDate.of(selectedYear, selectedMonth, 1); // Ngày đầu tháng
        LocalDate firstDayOfWeek = baseDate.plusWeeks(weekOffset); // Ngày đầu tuần dựa trên offset
        LocalDate lastDayOfWeek = calculateLastDayOfWeek(firstDayOfWeek, endDate.toLocalDate());

        // Điều chỉnh ranh giới tuần
        weekOffset = adjustWeekBoundaries(startDate.toLocalDate(), endDate.toLocalDate(), firstDayOfWeek, lastDayOfWeek, weekOffset);

        // Cập nhật lại firstDayOfWeek và lastDayOfWeek sau khi điều chỉnh
        firstDayOfWeek = baseDate.plusWeeks(weekOffset);
        lastDayOfWeek = calculateLastDayOfWeek(firstDayOfWeek, endDate.toLocalDate());

        // Tạo dữ liệu cho JSP
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        Map<String, List<Slot>> slotsByDay = new LinkedHashMap<>();
        Map<String, Map<String, String>> weekDateInfoMap = new LinkedHashMap<>();
        List<String> formattedWeekDates = new ArrayList<>();

        LocalDate currentDay = firstDayOfWeek;
        while (!currentDay.isAfter(lastDayOfWeek)) {
            String formattedDate = currentDay.format(dateFormatter);
            java.sql.Date sqlDate = java.sql.Date.valueOf(currentDay);
            List<Slot> slots = daoSlot.getSlotsByDate2(sqlDate, mentorId);
            slotsByDay.put(formattedDate, slots);

            Map<String, String> dateInfo = Map.of(
                    "dayOfWeek", currentDay.getDayOfWeek().getDisplayName(TextStyle.FULL, Locale.ENGLISH),
                    "day", String.valueOf(currentDay.getDayOfMonth()),
                    "month", currentDay.getMonth().getDisplayName(TextStyle.FULL, Locale.ENGLISH),
                    "year", String.valueOf(currentDay.getYear())
            );
            weekDateInfoMap.put(formattedDate, dateInfo);
            formattedWeekDates.add(formattedDate);
            currentDay = currentDay.plusDays(1);
        }

        Map<Integer, String> slotTimeMap = Map.of(
                1, "07:30:00", 2, "10:00:00", 3, "13:00:00", 4, "15:30:00", 5, "19:30:00"
        );

        // Gán dữ liệu vào request
        Course c = daoC.getCourseByIdd(courseId);
        Mentor m = daomentor.getMentorByIdd(mentorId);
        Map<String, List<entity.Schedule>> schedulesByMonth = daoSc.getSchedulesByMonth();

        request.setAttribute("course", c);
        request.setAttribute("mentorrequest", m);
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
        request.setAttribute("currentMonth", Month.of(selectedMonth).getDisplayName(TextStyle.FULL, Locale.ENGLISH)); // Để hiển thị trên JSP

        request.getRequestDispatcher("test1.jsp").forward(request, response);
    }

    // Các hàm helper mới
    private LocalDate calculateLastDayOfWeek(LocalDate firstDay, LocalDate endDate) {
        LocalDate potentialLastDay = firstDay.plusDays(6);
        return potentialLastDay.isAfter(endDate) ? endDate : potentialLastDay;
    }

    private int adjustWeekBoundaries(LocalDate startDate, LocalDate endDate,
            LocalDate firstDayOfWeek, LocalDate lastDayOfWeek, int weekOffset) {
        int adjustedOffset = weekOffset; // Sử dụng tham số weekOffset được truyền vào
        if (firstDayOfWeek.isBefore(startDate)) {
            firstDayOfWeek = startDate;
            lastDayOfWeek = calculateLastDayOfWeek(firstDayOfWeek, endDate);
            adjustedOffset = 0;
        } else if (lastDayOfWeek.isAfter(endDate)) {
            lastDayOfWeek = endDate;
            firstDayOfWeek = lastDayOfWeek.minusDays(6).isBefore(startDate)
                    ? startDate
                    : lastDayOfWeek.minusDays(6);
            adjustedOffset = (int) ChronoUnit.WEEKS.between(startDate, firstDayOfWeek);
        }
        return adjustedOffset;
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
