/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Course;
import entity.Request;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import model.DAOCourse;
import model.DAORequest;
import model.DAObook;
import model.DAOmentee;
import model.DAOslot;

/**
 *
 * @author Acer
 */
public class CreateRequest extends HttpServlet {

    DAORequest dao = new DAORequest();
    DAOCourse daoCourse = new DAOCourse();
    DAOslot daoSlot = new DAOslot();
    Integer menteeId = 0;
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        menteeId = (Integer) session.getAttribute("menteeId");
        if (menteeId == null) {
            response.sendRedirect("view/LoginUser.jsp"); // Chuyển hướng đến trang đăng nhập nếu chưa có menteeId
            return;
        }
        String mentorIdParam = request.getParameter("mentorId");
        Integer mentorId = (Integer) session.getAttribute("mentorId");
        mentorId = Integer.parseInt(mentorIdParam);
        request.setAttribute("mentorId", mentorId); // Lưu vào session

        if (mentorId != null) {
            ArrayList<Course> listCourse = daoCourse.getCourseByMentorId(mentorId);
            session.setAttribute("listAllCourse", listCourse);
        }
//        String action = request.getParameter("action");
//        if (action == null) {
//            action = "list";
//        }
//
//      
//        DAOslot daoSlot = new DAOslot();
//
//        try {
//            switch (action) {
//                case "list" -> {
//                    List<entity.Slot> slots = new ArrayList<>();
//                    Date slotDay = null;
//                    String dateString = request.getParameter("slotDate");
//                    SimpleDateFormat formatter = new SimpleDateFormat("MM-dd-yyyy");
//                    try {
//                        java.util.Date utilDate = null;
//                        if (dateString == null) {
//                            utilDate = new java.util.Date();
//                        } else {
//                            utilDate = formatter.parse(dateString);
//                        }
//                        java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
//
//                        slots = daoSlot.getSlotsByDate(sqlDate, 1);
//                    } catch (Exception e) {
//                        e.printStackTrace();
//                    }
//                    if (slots != null) {
//                        for (entity.Slot slot : slots) {
//                            System.out.println(slots);
//                        }
//                    }
//
//                    List<String> dates = new ArrayList<>();
//                    List<entity.Slot> morningSlots = new ArrayList<>();
//                    List<entity.Slot> afternoonSlots = new ArrayList<>();
//                    List<entity.Slot> eveningSlots = new ArrayList<>();
//
//                    for (entity.Slot slot : slots) {
//                        LocalTime startTime = slot.getStartTime().toLocalTime();
//
//                        if (startTime.isBefore(LocalTime.of(12, 0))) {
//                            morningSlots.add(slot);
//                        } else if (startTime.isBefore(LocalTime.of(18, 0))) {
//                            afternoonSlots.add(slot);
//                        } else {
//                            eveningSlots.add(slot);
//                        }
//                    }
//                    int month = request.getParameter("month") != null ? Integer.parseInt(request.getParameter("month")) : LocalDate.now().getMonthValue();
//                    int year = request.getParameter("year") != null ? Integer.parseInt(request.getParameter("year")) : LocalDate.now().getYear();
//                    LocalDate firstDay = LocalDate.of(year, month, 1);
//                    int dayOfWeek = firstDay.getDayOfWeek().getValue(); // 1 (Monday) - 7 (Sunday)
//                    if (dayOfWeek == 7) {
//                        dayOfWeek = 0;
//                    }
//                    for (int i = 0; i < dayOfWeek; i++) {
//                        dates.add("");
//                    }
//                    int daysInMonth = firstDay.lengthOfMonth();
//                    for (int i = 1; i <= daysInMonth; i++) {
//                        dates.add(String.valueOf(i));
//                    }
//                    while (dates.size() % 7 != 0) {
//                        dates.add("");
//                    }
//                    request.setAttribute("dates", dates);
//                    request.setAttribute("morningSlots", morningSlots);
//                    request.setAttribute("afternoonSlots", afternoonSlots);
//                    request.setAttribute("eveningSlots", eveningSlots);
//                    request.setAttribute("monthName", firstDay.getMonth().name());
//                    request.setAttribute("currentMonth", month);
//                    request.setAttribute("currentYear", year);
//
//                    request.setAttribute("slots", slots);
//                    request.setAttribute("selectedDate", slotDay);
//
//                    request.getRequestDispatcher("CRUD/CreateRequest.jsp").forward(request, response);
//                }
//
//                case "book" -> {
//                    DAObook daoB = new DAObook();
//                    String slotDateStr = request.getParameter("slotDate"); // Get slot date from request
//                    String[] startTimes = request.getParameterValues("startTimes"); // Get multiple start times
//
//                    try {
//                        if (slotDateStr == null || slotDateStr.trim().isEmpty()) {
//                            System.out.println(" slot_Date parameter is missing from the request!");
//                            response.sendRedirect("errorPage.jsp?message=Missing slot date");
//                            return;
//                        }
//                        if (startTimes == null || startTimes.length == 0) {
//                            System.out.println(" startTimes parameter is missing from the request!");
//                            response.sendRedirect("errorPage.jsp?message=Missing start time");
//                            return;
//                        }
//
//                        System.out.println("Received slotDateStr: " + slotDateStr);
//                        System.out.println("Received startTimes: " + Arrays.toString(startTimes));
//
//                        SimpleDateFormat formatter = new SimpleDateFormat("MM-dd-yyyy");
//                        java.util.Date utilDate = formatter.parse(slotDateStr);
//                        java.sql.Date slotDate = new java.sql.Date(utilDate.getTime());
//                        System.out.println("Converted slotDate: " + slotDate);
//
//                        List<Integer> slotIds = new ArrayList<>(); // Danh sách chứa các slotId hợp lệ
//                        boolean hasValidSlot = false;
//                        for (String startTime : startTimes) {
//                            Integer slotNumberId = daoB.getSlotNumberIdByDateAndTime(slotDate, startTime);
//                            if (slotNumberId == null) {
//                                System.out.println("Slot number ID not found for time: " + startTime);
//                                continue; // Bỏ qua slot không tìm thấy
//                            }
//
//                            Integer slotId = daoB.getSlotIdByDateAndNumber(slotDate, slotNumberId);
//                            if (slotId == null) {
//                                System.out.println("Slot ID not found for time: " + startTime);
//                                continue; // Bỏ qua slot không tìm thấy
//                            }
//                            System.out.println("Found slotId: " + slotId);
//                            slotIds.add(slotId);
//                            hasValidSlot = true;
//                        }
//                        if (hasValidSlot) {
//                            boolean success = daoSlot.bookMultipleSlots(slotIds, menteeId);
//
//                            if (success) {
//                                System.out.println("All bookings successful!");
//                                response.sendRedirect("CreateRequest");
//                            } else {
//                                System.out.println("Some bookings failed!");
//                                response.sendRedirect("CreateRequest?action=partial_success");
//                            }
//                        } else {
//                            System.out.println("No valid slots found!");
//                            response.sendRedirect("CreateRequest?action=no_slots");
//                        }
//                    } catch (ParseException e) {
//                        System.out.println(" Date/Time format error: " + e.getMessage());
//                        response.sendRedirect("errorPage.jsp?message=Invalid date/time format");
//                    } catch (Exception e) {
//                        System.out.println(" System error: " + e.getMessage());
//                        response.sendRedirect("errorPage.jsp?message=Unexpected system error");
//                    }
//                }
//
//                default ->
//                    response.sendRedirect("CreateRequest?action=list");
//            }
//        } catch (Exception e) {
//            throw new ServletException(e);
//        }

        // Lấy dữ liệu từ request
        String title = request.getParameter("title");
        String dateStr = request.getParameter("deadline_date");
        String timeStr = request.getParameter("deadline_hour");
        String content = request.getParameter("content");
        String[] courseIdsArray = request.getParameterValues("courseIds");

        // Kiểm tra null hoặc rỗng để tránh lỗi parse
        if (title == null || dateStr == null || timeStr == null || content == null) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin.");
            request.getRequestDispatcher("CRUD/CreateRequest.jsp").forward(request, response);
            return;
        }
        title = title.trim();
        content = content.trim();

        // Xử lý danh sách courseIds (có thể null)
        if (courseIdsArray == null || courseIdsArray.length == 0) {
            request.setAttribute("error", "You must select at least one course.");
            request.getRequestDispatcher("CRUD/CreateRequest.jsp").forward(request, response);
            return;
        }

        String courseIds = String.join(",", courseIdsArray);

        try {
            LocalDate deadlineDate = LocalDate.parse(dateStr.trim());
            LocalTime deadlineHour = LocalTime.parse(timeStr.trim());

            Request newRequest = new Request(menteeId, mentorId, title, deadlineDate, deadlineHour, content, courseIds);
            boolean success = dao.createRequest(newRequest);

            if (success) {
                response.sendRedirect("CreateRequest?success=true");
            } else {
                request.setAttribute("error", "Tạo request thất bại.");
                request.getRequestDispatcher("CRUD/CreateRequest.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

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
        try {
            String action = request.getParameter("action");
            if (action == null) {
                action = "list";
            }

            switch (action) {
                case "list" -> {
                     List<entity.Slot> slots = new ArrayList<>();
                    Date slotDay = null;
                    String dateString = request.getParameter("slotDate");
                    SimpleDateFormat formatter = new SimpleDateFormat("MM-dd-yyyy");
                    try {
                        java.util.Date utilDate = null;
                        if (dateString == null) {
                            utilDate = new java.util.Date();
                        } else {
                            utilDate = formatter.parse(dateString);
                        }
                        java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());

                        slots = daoSlot.getSlotsByDate(sqlDate, 1);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    if (slots != null) {
                        for (entity.Slot slot : slots) {
                            System.out.println(slots);
                        }
                    }

                    List<String> dates = new ArrayList<>();
                    List<entity.Slot> morningSlots = new ArrayList<>();
                    List<entity.Slot> afternoonSlots = new ArrayList<>();
                    List<entity.Slot> eveningSlots = new ArrayList<>();

                    for (entity.Slot slot : slots) {
                        LocalTime startTime = slot.getStartTime().toLocalTime();

                        if (startTime.isBefore(LocalTime.of(12, 0))) {
                            morningSlots.add(slot);
                        } else if (startTime.isBefore(LocalTime.of(18, 0))) {
                            afternoonSlots.add(slot);
                        } else {
                            eveningSlots.add(slot);
                        }
                    }
                    int month = request.getParameter("month") != null ? Integer.parseInt(request.getParameter("month")) : LocalDate.now().getMonthValue();
                    int year = request.getParameter("year") != null ? Integer.parseInt(request.getParameter("year")) : LocalDate.now().getYear();
                    LocalDate firstDay = LocalDate.of(year, month, 1);
                    int dayOfWeek = firstDay.getDayOfWeek().getValue(); // 1 (Monday) - 7 (Sunday)
                    if (dayOfWeek == 7) {
                        dayOfWeek = 0;
                    }
                    for (int i = 0; i < dayOfWeek; i++) {
                        dates.add("");
                    }
                    int daysInMonth = firstDay.lengthOfMonth();
                    for (int i = 1; i <= daysInMonth; i++) {
                        dates.add(String.valueOf(i));
                    }
                    while (dates.size() % 7 != 0) {
                        dates.add("");
                    }
                    request.setAttribute("dates", dates);
                    request.setAttribute("morningSlots", morningSlots);
                    request.setAttribute("afternoonSlots", afternoonSlots);
                    request.setAttribute("eveningSlots", eveningSlots);
                    request.setAttribute("monthName", firstDay.getMonth().name());
                    request.setAttribute("currentMonth", month);
                    request.setAttribute("currentYear", year);
                    request.setAttribute("slots", slots);
                    request.setAttribute("selectedDate", slotDay);

                    request.getRequestDispatcher("CRUD/CreateRequest.jsp").forward(request, response);
                }
                default ->
                    response.sendRedirect("CreateRequest?action=list");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
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
        try {
            String action = request.getParameter("action");
            if (action == null) {
                action = "create";
            }

            switch (action) {
                case "book" -> {
                    DAObook daoB = new DAObook();
                    String slotDateStr = request.getParameter("slotDate");
                    String[] startTimes = request.getParameterValues("startTimes");

                    try {
                        if (slotDateStr == null || slotDateStr.trim().isEmpty()) {
                            response.sendRedirect("errorPage.jsp?message=Missing slot date");
                            return;
                        }
                        if (startTimes == null || startTimes.length == 0) {
                            response.sendRedirect("errorPage.jsp?message=Missing start time");
                            return;
                        }

                        SimpleDateFormat formatter = new SimpleDateFormat("MM-dd-yyyy");
                        java.util.Date utilDate = formatter.parse(slotDateStr);
                        java.sql.Date slotDate = new java.sql.Date(utilDate.getTime());

                        List<Integer> slotIds = new ArrayList<>();
                        boolean hasValidSlot = false;
                        for (String startTime : startTimes) {
                            Integer slotNumberId = daoB.getSlotNumberIdByDateAndTime(slotDate, startTime);
                            if (slotNumberId == null) {
                                continue;
                            }

                            Integer slotId = daoB.getSlotIdByDateAndNumber(slotDate, slotNumberId);
                            if (slotId == null) {
                                continue;
                            }

                            slotIds.add(slotId);
                            hasValidSlot = true;
                        }
                        if (hasValidSlot) {
                            boolean success = daoSlot.bookMultipleSlots(slotIds, menteeId);
                            if (success) {
                                response.sendRedirect("CreateRequest");
                            } else {
                                response.sendRedirect("CreateRequest?action=partial_success");
                            }
                        } else {
                            response.sendRedirect("CreateRequest?action=no_slots");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
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
