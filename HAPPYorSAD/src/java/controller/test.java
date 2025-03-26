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
import model.DAOmentee_Slot;
import model.DAOmentor_Slot;
import model.TransactionDAO;

@MultipartConfig
public class test extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(test.class.getName()); // Sửa tên Logger để phản ánh lớp hiện tại
    private static final DAOmentee daoMentee = new DAOmentee();
    private static final DAOmentor_Slot daoMentorSL = new DAOmentor_Slot();
    private static final DAOmentee_Slot daoMenteeSL = new DAOmentee_Slot();
    private static final DAOslot daoSlot = new DAOslot();
    private static final DAObook daoB = new DAObook();
    private static final DAOCourse daoC = new DAOCourse();
    private final DAOschedule daoSc = new DAOschedule();
    private static Map<String, Long> requestTimestamps = new HashMap<>();
    private static final Map<String, String> processedSubmissions = new HashMap<>();
    private static final long REQUEST_TIMEOUT = 2000;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LOGGER.info("Received GET request");
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LOGGER.info("Received POST request at " + new java.util.Date());
        HttpSession session = request.getSession();
        DAORequest daorequest = new DAORequest();
        TransactionDAO daowallet = new TransactionDAO();
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        LocalDate startDate = LocalDate.now();
        String endDateStr = request.getParameter("enddate");

        String service = request.getParameter("service");
        String usernamementee = (String) session.getAttribute("usernameUser");
        Double walletbalance = (Double) session.getAttribute("walletBalance");
        LocalDate endDate = null;
        String sessionId = session.getId();
        long currentTime = System.currentTimeMillis();
        long lastRequestTime = requestTimestamps.getOrDefault(sessionId, 0L);
        String submissionId = request.getParameter("submissionId");

        LOGGER.info("Session ID: " + sessionId + ", Service: " + service + ", Submission ID: " + submissionId);

        if (currentTime - lastRequestTime < REQUEST_TIMEOUT) {
            LOGGER.warning("Blocked duplicate request for session: " + sessionId + " within " + REQUEST_TIMEOUT + "ms");
            response.setContentType("text/plain");
            response.getWriter().write("Request ignored: Too frequent submission.");
            return;
        }

        synchronized (processedSubmissions) {
            if (submissionId != null && processedSubmissions.containsKey(submissionId)) {
                LOGGER.warning("Blocked duplicate submission for session: " + sessionId + ", submissionId: " + submissionId);
                response.setContentType("text/plain");
                response.getWriter().write("Request ignored: Duplicate submission detected.");
                return;
            }
            if (submissionId != null) {
                processedSubmissions.put(submissionId, sessionId);
                LOGGER.info("Added submission ID: " + submissionId + " to processed submissions");
            }
        }
        requestTimestamps.put(sessionId, currentTime);
        LOGGER.info("Updated request timestamp for session: " + sessionId);

        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            if (endDateStr != null && !endDateStr.isEmpty()) {
                endDate = LocalDate.parse(endDateStr, formatter);
                LOGGER.info("Parsed endDate: " + endDate);
            }
        } catch (DateTimeParseException e) {
            LOGGER.severe("Invalid date format for endDate: " + endDateStr);
            request.setAttribute("errorMessage", "Invalid date format.");
            response.setContentType("text/plain");
            response.getWriter().write("Invalid date format.");
            return;
        } catch (Exception e) {
            LOGGER.severe("Unexpected error parsing date: " + e.getMessage());
        }

        DAOMentor daomentor = new DAOMentor();
        int menteeId = daorequest.getMenteeIdByUserId((Integer) session.getAttribute("userId"));
        LOGGER.info("Mentee ID: " + menteeId);
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
        LOGGER.info("Mentor retrieved: " + (mentor != null ? mentor.toString() : "null"));

        String action = request.getParameter("action");
        LOGGER.info("Action: " + action);
        if ("book".equals(action)) {
            String[] tempSlots = request.getParameterValues("tempSlotBooked");
            LOGGER.info("Temp slots received: " + Arrays.toString(tempSlots));
            if (tempSlots != null && tempSlots.length > 0) {
                Set<String> tempSlotBooked = new HashSet<>(Arrays.asList(tempSlots));
                session.setAttribute("tempSlotBooked", tempSlotBooked);
                String responseMessage = "Đã lưu tạm " + tempSlotBooked.size() + " slot.";
                LOGGER.info("Saved tempSlotBooked to session: " + tempSlotBooked);
                response.setContentType("text/plain");
                response.getWriter().write(responseMessage);
            } else {
                LOGGER.warning("No slots selected for booking");
                response.setContentType("text/plain");
                response.getWriter().write("Không có slot nào được chọn.");
            }
            return;
        }

        if ("clear".equals(action)) {
            LOGGER.info("Clearing tempSlotBooked from session");
            session.removeAttribute("tempSlotBooked");
            response.setContentType("text/plain");
            response.getWriter().write("Đã xóa tất cả slot tạm.");
            return;
        }

        if ("submit".equals(service)) {
            String requestId_raw = request.getParameter("requestId");
            Set<String> tempSlotBooked = (Set<String>) session.getAttribute("tempSlotBooked");
            LOGGER.info("Processing submit with tempSlotBooked: " + tempSlotBooked);

            if (tempSlotBooked != null && !tempSlotBooked.isEmpty()) {
                totalSlots = tempSlotBooked.size();
                totalprice = totalSlots * price;
                LOGGER.info("Total slots: " + totalSlots + ", Total price: " + totalprice);

                if (requestId_raw == null) {
                    // Trường hợp request mới
                    if (totalprice > 0 && walletbalance != null && walletbalance >= totalprice) {
                        LOGGER.info("Processing wallet transaction for user: " + usernamementee + ", Amount: " + totalprice);

                        // Cập nhật hold trước
                        daowallet.updateHold(usernamementee, totalprice);

                        // Lấy thông tin wallet cập nhật
                        double balance = daowallet.getBalance(usernamementee);
                        double totalbalance = daowallet.getTotalBalance(usernamementee);
                        double hold = daowallet.getHold(usernamementee);

                        DAOCourse dao = new DAOCourse();
                        String coursename = dao.getCourseName(courseId);
                        daowallet.createTransaction(usernamementee, totalprice, "HOLD", "Hold for course " + coursename);

                        session.setAttribute("walletBalance", balance);
                        session.setAttribute("walletTotalbalance", totalbalance);
                        session.setAttribute("walletHold", hold);

                        Request requests = new Request(menteeId, mentorId, title, totalSlots, totalprice, startDate, endDate, content, "Open", courseId);
                        LOGGER.info("Inserting new request: " + requests);
                        int newRequestId = daorequest.insertRequestAndGetId(requests);
                        LOGGER.info("Inserted new request with ID: " + newRequestId);

                        int bookedCount = 0;
                        for (String slot : tempSlotBooked) {
                            LOGGER.info("Processing slot: " + slot);
                            String[] parts = slot.split("_");
                            String slotDate = parts[0];
                            int slotNumber = Integer.parseInt(parts[1]);
                            Integer slotId = daoMenteeSL.getSlotId(slotDate, slotNumber);
                            if (slotId != null) {
                                boolean success = daoMenteeSL.bookSlot(menteeId, slotId, newRequestId, "Pending");
                                if (success) {
                                    bookedCount++;
                                }
                            } else {
                                LOGGER.warning("Slot not available: " + slot);
                            }
                        }
                        LOGGER.info("Booked " + bookedCount + " slots for request ID: " + newRequestId);

                        session.removeAttribute("tempSlotBooked");
                        session.setAttribute("msg", "Your request submit successfully! Booked " + bookedCount + " slot(s).");
                    } else {
                        LOGGER.warning("Insufficient balance or invalid total price: " + totalprice + ", Wallet balance: " + walletbalance);
                        response.setContentType("text/plain");
                        response.getWriter().write("Insufficient balance or invalid total price.");
                        return;
                    }
                } else {
                    // Trường hợp update request
                    int requestId = Integer.parseInt(requestId_raw);
                    Request existingRequest = daorequest.getRequestById(requestId);
                    if (existingRequest != null) {
                        if (totalprice > 0 && walletbalance != null && walletbalance >= totalprice) {
                            LOGGER.info("Processing wallet transaction for existing request: " + requestId);

                            // Cập nhật hold trước
                            daowallet.updateHold(usernamementee, totalprice);
                            // Cập nhật thông tin wallet
                            double balance = daowallet.getBalance(usernamementee);
                            double totalbalance = daowallet.getTotalBalance(usernamementee);
                            double hold = daowallet.getHold(usernamementee);

                            DAOCourse dao = new DAOCourse();
                            String coursename = dao.getCourseName(courseId);
                            daowallet.createTransaction(usernamementee, totalprice, "HOLD", "Hold for course " + coursename);

                            session.setAttribute("walletBalance", balance);
                            session.setAttribute("walletTotalbalance", totalbalance);
                            session.setAttribute("walletHold", hold);

                            LOGGER.info("Deleting draft slots for request ID: " + requestId);
                            daoMenteeSL.deleteSlotsByRequestIdAndStatus(requestId, "Draft");

                            existingRequest.setTitle(title);
                            existingRequest.setContent(content);
                            existingRequest.setStartDate(startDate);
                            existingRequest.setEndDate(endDate);
                            existingRequest.setTotalSlot(totalSlots);
                            existingRequest.settotalprice(totalprice);
                            existingRequest.setStatus("Open");
                            LOGGER.info("Updating request ID: " + requestId);
                            daorequest.updateRequest(existingRequest);

                            int bookedCount = 0;
                            for (String slot : tempSlotBooked) {
                                LOGGER.info("Processing slot: " + slot);
                                String[] parts = slot.split("_");
                                String slotDate = parts[0];
                                int slotNumber = Integer.parseInt(parts[1]);
                                Integer slotId = daoMenteeSL.getSlotId(slotDate, slotNumber);
                                if (slotId != null) {
                                    boolean success = daoMenteeSL.bookSlot(menteeId, slotId, requestId, "Pending");
                                    if (success) {
                                        try {
                                            daoSlot.updateRequestIdForSlot(slotId, requestId);
                                            bookedCount++;
                                        } catch (SQLException ex) {
                                            Logger.getLogger(test.class.getName()).log(Level.SEVERE, null, ex);
                                        }
                                    }
                                } else {
                                    LOGGER.warning("Slot not available: " + slot);
                                }
                            }
                            LOGGER.info("Booked " + bookedCount + " slots for request ID: " + requestId);

                            session.removeAttribute("tempSlotBooked");
                            LOGGER.info("Request updated successfully: " + requestId);
                        } else {
                            LOGGER.warning("Insufficient balance for request update: " + requestId);
                            response.setContentType("text/plain");
                            response.getWriter().write("Insufficient balance or invalid total price.");
                            return;
                        }
                    } else {
                        LOGGER.warning("Request not found: " + requestId);
                        request.setAttribute("errorMessage", "Không tìm thấy yêu cầu cần cập nhật.");
                    }
                }
                LOGGER.info("Redirecting to ShowMenteeRequest");
                response.sendRedirect("ShowMenteeRequest");
                return;
            } else {
                LOGGER.warning("No slots booked temporarily");
                response.setContentType("text/plain");
                response.getWriter().write("No slots booked temporarily.");
                return;
            }
        }

        if ("save".equals(service)) {
            String requestId_raw = request.getParameter("requestId");
            String[] tempSlotBooked = request.getParameterValues("tempSlotBooked");
            double totalPrice = Double.parseDouble(request.getParameter("totalprice"));
            LOGGER.info("Processing save with tempSlotBooked: " + Arrays.toString(tempSlotBooked));

            if (tempSlotBooked != null && tempSlotBooked.length > 0) {
                totalSlots = tempSlotBooked.length;
                totalprice = totalSlots * price; // Giả sử price được định nghĩa trước đó trong servlet
                LOGGER.info("Total slots: " + totalSlots + ", Total price: " + totalprice);

                String savedSlotsString = String.join(",", tempSlotBooked); // Chuyển mảng tempSlotBooked thành chuỗi

                if (requestId_raw == null) {
                    // Trường hợp lưu mới (Insert)
                    Request requests = new Request(menteeId, mentorId, title, totalSlots, totalprice, startDate, endDate, content, "Draft", courseId);
                    LOGGER.info("Inserting new draft request: " + requests);
                    int newRequestId = daorequest.insertRequestAndGetId(requests);
                    if (newRequestId > 0) {
                        for (String slot : tempSlotBooked) {
                            LOGGER.info("Processing slot for draft: " + slot);
                            String[] parts = slot.split("_");
                            String slotDate = parts[0];
                            int slotNumber = Integer.parseInt(parts[1]);
                            Integer slotId = daoMenteeSL.getSlotId(slotDate, slotNumber);
                            if (slotId != null) {
                                daoMenteeSL.bookSlot(menteeId, slotId, newRequestId, "Draft");
                            } else {
                                LOGGER.warning("Slot not available: " + slot);
                            }
                        }
                        LOGGER.info("Saved draft request with ID: " + newRequestId);
                        // Gửi dữ liệu về JSP
                        request.setAttribute("requestId", newRequestId);
                        request.setAttribute("title", title);
                        request.setAttribute("content", content);
                        request.setAttribute("startdate", startDate);
                        request.setAttribute("enddate", endDate);
                        request.setAttribute("totalSlots", totalSlots);
                        request.setAttribute("totalprice", totalprice);
                        request.setAttribute("savedSlots", savedSlotsString); // Truyền chuỗi savedSlots
                    } else {
                        LOGGER.severe("Failed to save draft request");
                        request.setAttribute("errorMessage", "Failed to save draft request.");
                    }
                } else {
                    // Trường hợp cập nhật (Update)
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
                        LOGGER.info("Updating draft request ID: " + requestId);
                        if (daorequest.updateRequest(existingRequest)) {
                            daoMenteeSL.deleteSlotsByRequestIdAndStatus(requestId, "Draft");
                            for (String slot : tempSlotBooked) {
                                LOGGER.info("Processing slot for draft: " + slot);
                                String[] parts = slot.split("_");
                                String slotDate = parts[0];
                                int slotNumber = Integer.parseInt(parts[1]);
                                Integer slotId = daoMenteeSL.getSlotId(slotDate, slotNumber);
                                if (slotId != null) {
                                    daoMenteeSL.bookSlot(menteeId, slotId, requestId, "Draft");
                                }
                            }
                            LOGGER.info("Updated draft request ID: " + requestId);
                            // Gửi dữ liệu về JSP
                            request.setAttribute("requestId", requestId);
                            request.setAttribute("title", title);
                            request.setAttribute("content", content);
                            request.setAttribute("startdate", startDate);
                            request.setAttribute("enddate", endDate);
                            request.setAttribute("totalSlots", totalSlots);
                            request.setAttribute("totalprice", totalprice);
                            request.setAttribute("savedSlots", savedSlotsString); // Truyền chuỗi savedSlots
                        } else {
                            LOGGER.severe("Failed to update draft request: " + requestId);
                            request.setAttribute("errorMessage", "Failed to update draft request.");
                        }
                    } else {
                        LOGGER.warning("Request not found: " + requestId);
                        request.setAttribute("errorMessage", "Không tìm thấy yêu cầu cần cập nhật.");
                    }
                }

                // Forward về JSP để hiển thị dữ liệu đã lưu
                LOGGER.info("Redirecting to ShowMenteeRequest");
                response.sendRedirect("ShowMenteeRequest");
                return;

            } else {
                LOGGER.warning("No slots selected for saving draft");
                request.setAttribute("errorMessage", "Vui lòng chọn ít nhất một slot để lưu.");
                session.setAttribute("msg", "Please select at least one slot to save.");
                request.getRequestDispatcher("test1.jsp").forward(request, response);
                return;
            }
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LOGGER.info("Processing request");
        HttpSession session = request.getSession();
        DAOMentor daomentor = new DAOMentor();
        DAOCourse daocourse = new DAOCourse();

        String mentorIdStr = request.getParameter("mentorId");
        String courseIdStr = request.getParameter("courseId");
        String selectedMonthStr = request.getParameter("month");
        String selectedYearStr = request.getParameter("year");
        String weekOffsetStr = request.getParameter("weekOffset");
        String service = request.getParameter("service");
        LOGGER.info("Parameters - Mentor ID: " + mentorIdStr + ", Course ID: " + courseIdStr + ", Service: " + service);

        int mentorId = (mentorIdStr != null && !mentorIdStr.isEmpty()) ? Integer.parseInt(mentorIdStr) : 0;
        int courseId = (courseIdStr != null && !courseIdStr.isEmpty()) ? Integer.parseInt(courseIdStr) : 0;
        int weekOffset = (weekOffsetStr != null && !weekOffsetStr.isEmpty()) ? Integer.parseInt(weekOffsetStr) : 0;

        Mentor mentor = daomentor.getMentorByID(mentorId);
        String price_raw = request.getParameter("price");
        double price = (price_raw != null) ? Double.parseDouble(price_raw) : 0.0;

        request.setAttribute("mentorrequest", mentor);
        request.setAttribute("mentorId", mentorId);
        request.setAttribute("courseId", courseId);

        if ("update".equals(service)) {
            LOGGER.info("Processing update service");
            request.setAttribute("title", request.getParameter("title"));
            request.setAttribute("content", request.getParameter("content"));
            request.setAttribute("startdate", LocalDate.now().toString());
            request.setAttribute("enddate", request.getParameter("enddate"));
            request.setAttribute("requestId", request.getParameter("requestId"));

            String requestIdStr = request.getParameter("requestId");
            if (requestIdStr != null && !requestIdStr.isEmpty()) {
                int requestId = Integer.parseInt(requestIdStr);
                Request existingRequest = new DAORequest().getRequestById(requestId);
                if (existingRequest != null) {
                    int totalSlots = existingRequest.getTotalSlot();
                    double totalPrice = existingRequest.gettotalprice();
                    request.setAttribute("totalSlots", totalSlots);
                    request.setAttribute("totalprice", totalPrice);

                    double pricee = (totalSlots != 0) ? totalPrice / totalSlots : 0.0;
                    request.setAttribute("pricee", pricee);
                    LOGGER.info("Calculated price = " + totalPrice + " / " + totalSlots + " = " + pricee);
                } else {
                    LOGGER.warning("Request not found for ID: " + requestId);
                    request.setAttribute("price", price); // Giữ giá trị mặc định nếu không tìm thấy
                }
            }
        }

        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            LOGGER.warning("User not logged in. Redirecting to login.");
            redirect(response, "view/LoginUser.jsp");
            return;
        }

        Integer menteeId = DAOmentee.getMenteeIdByUserId(userId);
        LOGGER.info("Mentee ID retrieved: " + menteeId);

        int selectedMonth = (selectedMonthStr != null && !selectedMonthStr.isEmpty())
                ? Month.valueOf(selectedMonthStr.toUpperCase()).getValue() : LocalDate.now().getMonthValue();
        int selectedYear = (selectedYearStr != null && !selectedYearStr.isEmpty())
                ? Integer.parseInt(selectedYearStr) : LocalDate.now().getYear();
        LOGGER.info("Selected month: " + selectedMonth + ", Year: " + selectedYear);

        List<Schedule> schedules = daoSc.getSchedulesByMonth(selectedYear, selectedMonth);
        int scheduleId = schedules.isEmpty() ? 1 : schedules.get(0).getId();
        LOGGER.info("Schedule ID: " + scheduleId);

        java.sql.Date startDate = daoSc.getStartDateByScheduleId(scheduleId);
        java.sql.Date endDate = daoSc.getEndDateByScheduleId(scheduleId);
        if (startDate == null || endDate == null) {
            LOGGER.severe("Schedule start or end date not found for scheduleId: " + scheduleId);
            redirect(response, "test1.jsp");
            return;
        }

        LocalDate baseDate = LocalDate.of(selectedYear, selectedMonth, 1);
        LocalDate firstDayOfWeek = baseDate.plusWeeks(weekOffset);
        LocalDate lastDayOfWeek = calculateLastDayOfWeek(firstDayOfWeek, endDate.toLocalDate());
        weekOffset = adjustWeekBoundaries(startDate.toLocalDate(), endDate.toLocalDate(), firstDayOfWeek, lastDayOfWeek, weekOffset);
        firstDayOfWeek = baseDate.plusWeeks(weekOffset);
        lastDayOfWeek = calculateLastDayOfWeek(firstDayOfWeek, endDate.toLocalDate());
        LOGGER.info("Week boundaries - First day: " + firstDayOfWeek + ", Last day: " + lastDayOfWeek);

        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        Map<String, List<Slot>> slotsByDay = new LinkedHashMap<>();
        Map<String, Map<String, String>> weekDateInfoMap = new LinkedHashMap<>();
        List<String> formattedWeekDates = new ArrayList<>();

        Map<String, String> slotStatusMap = new LinkedHashMap<>(); // Map để lưu trạng thái của slot

        // Lấy danh sách slot Studying của mentee
        Set<String> studyingSlots = getStudyingSlotsForMentee(menteeId);
//        LOGGER.info("Studying slots for mentee " + menteeId + ": " + studyingSlots);

        LocalDate currentDay = firstDayOfWeek;
        while (!currentDay.isAfter(lastDayOfWeek)) {
            String formattedDate = currentDay.format(dateFormatter);
            java.sql.Date sqlDate = java.sql.Date.valueOf(currentDay);
            List<Slot> slots = daoMentorSL.getSlotsByDateForRequest(sqlDate, mentorId);
//            System.out.println("hellooo" + slots);
            slotsByDay.put(formattedDate, slots);

            Map<String, String> dateInfo = Map.of(
                    "dayOfWeek", currentDay.getDayOfWeek().getDisplayName(TextStyle.FULL, Locale.ENGLISH),
                    "day", String.valueOf(currentDay.getDayOfMonth()),
                    "month", currentDay.getMonth().getDisplayName(TextStyle.FULL, Locale.ENGLISH),
                    "year", String.valueOf(currentDay.getYear())
            );
            weekDateInfoMap.put(formattedDate, dateInfo);
            formattedWeekDates.add(formattedDate);

            for (int slotNumber = 1; slotNumber <= 5; slotNumber++) {
                String slotKey = formattedDate + "_" + slotNumber;

                // 1. Kiểm tra trạng thái Studying của mentee trước (giữ nguyên logic cũ)
                if (studyingSlots.contains(slotKey)) {
                    slotStatusMap.put(slotKey, "Duplicated"); // Slot đã học bởi mentee này
//                    LOGGER.info("Slot " + slotKey + " -> Studying (Mentee)");
                    continue; // Bỏ qua các kiểm tra tiếp theo nếu mentee đã Studying
                }

                // 2. Kiểm tra trạng thái thực tế của mentor từ Mentor_Slot
                boolean mentorSlotFound = false;
                String mentorStatus = "Available"; // Mặc định là Available nếu không tìm thấy slot
                for (Slot slot : slots) {
                    if (slot.getSlotNumber() == slotNumber) {
                        mentorSlotFound = true;
                        mentorStatus = slot.getStatus(); // Lấy trạng thái thực tế từ Mentor_Slot
                        break;
                    }
                }

                // 3. Xác định trạng thái slot dựa trên trạng thái của mentor
                if (mentorSlotFound) {
                    slotStatusMap.put(slotKey, mentorStatus); // Sử dụng trạng thái thực tế của mentor
//                    LOGGER.info("Slot " + slotKey + " -> " + mentorStatus + " (Mentor)");
                } else {
                    slotStatusMap.put(slotKey, "Available"); // Không có slot của mentor -> Available
//                    LOGGER.info("Slot " + slotKey + " -> Available (No Mentor Slot)");
                }
            }

            currentDay = currentDay.plusDays(1);
        }
        LOGGER.info("Generated slots by day: " + slotsByDay.size() + " days");

        Map<Integer, String> slotTimeMap = Map.of(1, "07:30:00", 2, "10:00:00", 3, "13:00:00", 4, "15:30:00", 5, "19:30:00");

        Course c = daoC.getCourseByIdd(courseId);
        Mentor m = daomentor.getMentorByIdd(mentorId);
        Map<String, List<Schedule>> schedulesByMonth = daoSc.getMentorSchedulesByMonth();

        request.setAttribute("slotStatusMap", slotStatusMap); // Truyền trạng thái slot sang JSP
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
        request.setAttribute("mentorId", mentorId);
        request.setAttribute("courseId", courseId);
        request.setAttribute("price", price);
        LOGGER.info("Final price before forward: " + request.getAttribute("price"));
        request.setAttribute("currentMonth", Month.of(selectedMonth).getDisplayName(TextStyle.FULL, Locale.ENGLISH));
        LOGGER.info("Before forwarding to test1.jsp");
        LOGGER.info("weekDateInfoMap: " + weekDateInfoMap);
        LOGGER.info("slotsByDay: " + slotsByDay);
        request.getRequestDispatcher("test1.jsp").forward(request, response);
        LOGGER.info("After forwarding to test1.jsp");
    }

    private LocalDate calculateLastDayOfWeek(LocalDate firstDay, LocalDate endDate) {
        LocalDate potentialLastDay = firstDay.plusDays(6);
        return potentialLastDay.isAfter(endDate) ? endDate : potentialLastDay;
    }

    private int adjustWeekBoundaries(LocalDate startDate, LocalDate endDate, LocalDate firstDayOfWeek, LocalDate lastDayOfWeek, int weekOffset) {
        int adjustedOffset = weekOffset;
        if (firstDayOfWeek.isBefore(startDate)) {
            firstDayOfWeek = startDate;
            lastDayOfWeek = calculateLastDayOfWeek(firstDayOfWeek, endDate);
            adjustedOffset = 0;
        } else if (lastDayOfWeek.isAfter(endDate)) {
            lastDayOfWeek = endDate;
            firstDayOfWeek = lastDayOfWeek.minusDays(6).isBefore(startDate) ? startDate : lastDayOfWeek.minusDays(6);
            adjustedOffset = (int) ChronoUnit.WEEKS.between(startDate, firstDayOfWeek);
        }
        LOGGER.info("Adjusted week offset: " + adjustedOffset);
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
        LOGGER.info("Matching dates with same weekday: " + matchingDates.size());
        return matchingDates;
    }

    private Set<String> getStudyingSlotsForMentee(int menteeId) {
        Set<String> studyingSlots = new HashSet<>();
        DAOmentee_Slot daoMenteeSlot = new DAOmentee_Slot();
        List<Slot> bookedSlots = daoMenteeSlot.getSlotsByMenteeIdAndStatus(menteeId, "Studying");

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        for (Slot slot : bookedSlots) {
            String slotDate = slot.getSlotDate().toLocalDate().format(formatter);
            int slotNumber = slot.getSlotNumber(); // Giả sử Slot có thuộc tính slotNumber
            String slotKey = slotDate + "_" + slotNumber;
            studyingSlots.add(slotKey);
        }
        LOGGER.info("Found " + studyingSlots.size() + " studying slots for mentee ID: " + menteeId);
        return studyingSlots;
    }

    private void redirect(HttpServletResponse response, String url) throws IOException {
        LOGGER.info("Redirecting to: " + url);
        response.sendRedirect(url);
    }

}
