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

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import model.DAOCourse;
import model.DAORequest;


/**
 *
 * @author Acer
 */
public class CreateRequest extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        DAORequest dao = new DAORequest();
//        DAOCourse daoCourse = new DAOCourse();
//        ArrayList<Course> listCourse = new ArrayList<>();
//        int mentorId = Integer.parseInt(request.getParameter("mentorId"));
//        listCourse = daoCourse.getCourseByMentorId(mentorId);
//        HttpSession session = request.getSession();
//        session.setAttribute("listAllCourse", listCourse);
//        int userId = 5; // Sau này thay bằng session.getAttribute("userId") khi có đăng nhập
//
//        // Lấy menteeId từ userId
//        int menteeId = dao.getMenteeIdByUserId(userId);
//        
//        String title = request.getParameter("title").trim();
//        String dateStr = request.getParameter("deadline_date");
//        String timeStr = request.getParameter("deadline_hour");
//        String content = request.getParameter("content").trim();
//        String status = "Open";
//        String[] courseIdsArray = request.getParameterValues("courseIds");
//        String courseIds = String.join(",", courseIdsArray);
//        LocalDate deadlineDate = LocalDate.parse(dateStr.trim());
//        LocalTime deadlineHour = LocalTime.parse(timeStr.trim());
//        Request newRequest = new Request(menteeId, title, deadlineDate, deadlineHour, content, status, LocalDateTime.MAX, LocalDateTime.MAX, courseIds);
//        boolean success = dao.createRequest(newRequest);
//        
//        if (success) {
//            response.sendRedirect("CreateRequests");
//            request.getRequestDispatcher("CRUD/CreateRequest.jsp").forward(request, response);
//        } else {
//            response.sendRedirect("CreateRequests?error=create_failed");
//            request.getRequestDispatcher("CRUD/CreateRequest.jsp").forward(request, response);
//        }
//    }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    DAORequest dao = new DAORequest();
    DAOCourse daoCourse = new DAOCourse();
    HttpSession session = request.getSession();

    // Lấy mentorId từ request, nếu null thì mặc định -1
    String mentorIdStr = request.getParameter("mentorId");
    int mentorId = (mentorIdStr != null && !mentorIdStr.isEmpty()) ? Integer.parseInt(mentorIdStr) : -1;

    if (mentorId != -1) {
        ArrayList<Course> listCourse = daoCourse.getCourseByMentorId(mentorId);
        session.setAttribute("listAllCourse", listCourse);
    }

    // Lấy menteeId từ userId (fix cứng userId = 5, sau này lấy từ session)
    int userId = 5;
    int menteeId = dao.getMenteeIdByUserId(userId);

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
    String status = "Open";

    // Xử lý danh sách courseIds (có thể null)
    String courseIds = (courseIdsArray != null) ? String.join(",", courseIdsArray) : "";

    try {
        LocalDate deadlineDate = LocalDate.parse(dateStr.trim());
        LocalTime deadlineHour = LocalTime.parse(timeStr.trim());

        Request newRequest = new Request(menteeId, title, deadlineDate, deadlineHour, content, status, LocalDateTime.now(), LocalDateTime.now(), courseIds);
        boolean success = dao.createRequest(newRequest);

        if (success) {
            response.sendRedirect("CreateRequest?success=true");
        } else {
            request.setAttribute("error", "Tạo request thất bại.");
            request.getRequestDispatcher("CRUD/CreateRequest.jsp").forward(request, response);
        }
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("error", "Lỗi xử lý dữ liệu. Kiểm tra định dạng ngày giờ.");
        request.getRequestDispatcher("CRUD/CreateRequest.jsp").forward(request, response);
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
        processRequest(request, response);
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
