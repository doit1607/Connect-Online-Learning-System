/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Course;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.DAOCourse;

/**
 *
 * @author admin
 */
@WebServlet(name = "CreateCourse", urlPatterns = {"/createcourse"})
public class CreateCourse extends HttpServlet {

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
        String idStr = request.getParameter("id");
        String managerIdStr = request.getParameter("managerId");
        String mentorIdStr = request.getParameter("mentorId");
        String courseMajorIdStr = request.getParameter("courseMajorId");

        int id = (idStr != null && !idStr.isEmpty()) ? Integer.parseInt(idStr) : 0;
        int managerId = (managerIdStr != null && !managerIdStr.isEmpty()) ? Integer.parseInt(managerIdStr) : 0;
        int mentorId = (mentorIdStr != null && !mentorIdStr.isEmpty()) ? Integer.parseInt(mentorIdStr) : 0;
        int courseMajorId = (courseMajorIdStr != null && !courseMajorIdStr.isEmpty()) ? Integer.parseInt(courseMajorIdStr) : 0;

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String status = request.getParameter("status");

        Course course = new Course(id, title, description, managerId, mentorId, courseMajorId, status);
        DAOCourse dao = new DAOCourse();

        boolean isSuccess = dao.createCourse(course);
        if (isSuccess) {
            request.setAttribute("message", "Course added successfully!");
        } else {
            request.setAttribute("message", "Error adding course.");
        }

        request.getRequestDispatcher("/CRUD/CreateCourses.jsp").forward(request, response);

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
