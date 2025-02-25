/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Mentee;
import entity.Request;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.DAORequest;
import model.DAObook;
import model.DAOmentee;
import model.DAOslot;

/**
 *
 * @author Acer
 */
public class CreateRequest extends HttpServlet {

    DAOslot daoSlot = new DAOslot();
    DAORequest dao = new DAORequest();
    DAOmentee daom = new DAOmentee();
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
        HttpSession session = request.getSession();
        menteeId = (Integer) session.getAttribute("menteeId");
        if (menteeId == null) {
            response.sendRedirect("view/LoginUser.jsp");
            return;
        }
        Mentee mentee = daom.getMenteeById(menteeId);
        session.setAttribute("mentee", mentee);

//        String mentorIdParam = request.getParameter("mentorId");
//        String courseIdParam = request.getParameter("courseId");
//
//        System.out.println("mentorId từ request: " + mentorIdParam);
//        System.out.println("courseId từ request: " + courseIdParam);
//
//        if (mentorIdParam == null || courseIdParam == null) {
//            response.sendRedirect("CourseDetail.jsp?error=missingParameters");
//            return;
//        }
//
//        int mentorId = Integer.parseInt(mentorIdParam);
//        int courseId = Integer.parseInt(courseIdParam);
//        session.setAttribute("mentorId", mentorId);
//        session.setAttribute("courseId", courseId);
        String mentorIdParam = request.getParameter("mentorId");
        Integer mentorId = 3;
        if (mentorIdParam != null) {
            try {
                mentorId = Integer.valueOf(mentorIdParam);
                session.setAttribute("mentorId", mentorId); // Lưu vào session nếu cần
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        // Lấy courseId từ request
        String courseIdParam = request.getParameter("courseId");
        Integer courseId = 21;
        if (courseIdParam != null) {
            try {
                courseId = Integer.valueOf(courseIdParam);
                session.setAttribute("courseId", courseId); // Lưu vào session nếu cần
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        String title = request.getParameter("title");
        int totalSlot = Integer.parseInt(request.getParameter("total_slot"));
        LocalDate startDate = LocalDate.parse(request.getParameter("start_date"));
        LocalDate endDate = LocalDate.parse(request.getParameter("end_date"));
        String content = request.getParameter("content");

        String action1 = request.getParameter("action");
        String status = action1.equals("submit") ? "Open" : "Draft";

        Request newRequest = new Request(menteeId, mentorId, title, totalSlot, startDate, endDate, content, status, courseId);

        if (action1.equals("save_draft")) {
            dao.insertRequest(newRequest);
            response.sendRedirect("ShowMenteeRequest?menteeId=" + menteeId);

        } else if (action1.equals("submit")) {
            dao.insertRequest(newRequest);
            response.sendRedirect("ShowMenteeRequest?menteeId=" + menteeId);
        }
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
    // Lưu request dưới dạng "Draft"

}
