/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.MentorCourse;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.stream.Collectors;
import model.DAOCourse;

/**
 *
 * @author admin
 */
public class ApproveCourse extends HttpServlet {

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
        DAOCourse dao = new DAOCourse();

        String status = request.getParameter("status");
        String searchQuery = request.getParameter("searchQuery");

        if (searchQuery != null) {
            searchQuery = searchQuery.trim().toLowerCase();
        }

        // Mặc định lấy trang 1 nếu không có index
        String indexPage = request.getParameter("index");
        if (indexPage == null) {
            indexPage = "1";
        }
        int index = Integer.parseInt(indexPage);

        int count = dao.getTotalRequest();
        int endPage = count / 5;
        if (count % 5 != 0) {
            endPage++;
        }
        List<MentorCourse> courseList;

        // Lọc theo trạng thái trước
        if ("approved".equals(status)) {
            courseList = dao.getApprovedCourses();
        } else if ("rejected".equals(status)) {
            courseList = dao.getRejectedCourses();
        } else {
            courseList = dao.getPendingCourses(index);
            status = "pending"; // Gán mặc định để không bị lỗi khi hiển thị
        }

        // Lọc tiếp theo từ khóa tìm kiếm
        if (searchQuery != null && !searchQuery.isEmpty()) {
            final String finalSearchQuery = searchQuery;
            courseList = courseList.stream()
                    .filter(c -> c.getName().toLowerCase().contains(finalSearchQuery)
                    || c.getTitle().toLowerCase().contains(finalSearchQuery))
                    .collect(Collectors.toList());
        }

        // Gửi dữ liệu lên JSP
        request.setAttribute("courseList", courseList);
        request.setAttribute("searchQuery", searchQuery);
        request.setAttribute("status", status);
        request.setAttribute("tag", index);
        request.setAttribute("endPage", endPage);

        // Chuyển hướng đúng trang JSP
        if ("approved".equals(status)) {
            request.getRequestDispatcher("/view/CourseApprove.jsp").forward(request, response);
        } else if ("rejected".equals(status)) {
            request.getRequestDispatcher("/view/CourseReject.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/view/ApproveCourse.jsp").forward(request, response);
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
        DAOCourse dao = new DAOCourse();
        String action = request.getParameter("action");
        int mentorId = Integer.parseInt(request.getParameter("mentorId"));
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        String status = request.getParameter("status");

        if ("approve".equals(action)) {
            dao.updateCourseStatus(mentorId, courseId, "approved");
            response.sendRedirect("ApproveCourse?status=approved");
            return;
        } else if ("reject".equals(action)) {
            dao.updateCourseStatus(mentorId, courseId, "rejected");
            response.sendRedirect("ApproveCourse?status=rejected");
            return;
        }

        List<MentorCourse> pendingCourses;
        if (status == null || status.isEmpty()) {
            pendingCourses = dao.getAllCourses(); // Lấy tất cả khóa học
        } else {
            pendingCourses = dao.getCoursesByStatus(status); // Lọc theo trạng thái
        }

        request.setAttribute("pendingCourses", pendingCourses);
        request.getRequestDispatcher("/view/ApproveCourse.jsp").forward(request, response);
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
