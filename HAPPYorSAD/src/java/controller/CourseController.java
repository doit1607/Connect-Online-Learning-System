/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import entity.Course;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import model.DAOCourse;

/**
 *
 * @author admin
 */
@WebServlet(name="CourseController", urlPatterns={"/createCourse"})
public class CourseController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        DAOCourse dao = new DAOCourse();
        try (PrintWriter out = response.getWriter()) {
            String service = request.getParameter("service");
            
            if (service.equals("createCourse")) {
                String submit = request.getParameter("submit");
                if (submit == null) {
                    request.getRequestDispatcher("createCourse.jsp").forward(request, response);
                } else {
                    // get data
                    String title = request.getParameter("title");
                    String description = request.getParameter("description");
                    String managerId = request.getParameter("managerId");
                    String mentorId = request.getParameter("mentorId");
                    String createAt = request.getParameter("createdAt");
                    String updateAt = request.getParameter("updatedAt");
                    String courseMajorId = request.getParameter("courseMajorId");
                    
                    //convert
                    int courseMajorID = Integer.parseInt(courseMajorId);
                    int managerID = Integer.parseInt(managerId);
                    int mentorID = Integer.parseInt(mentorId);
                    LocalDateTime createdAt = LocalDateTime.parse(createAt);
                    LocalDateTime updatedAt = LocalDateTime.parse(updateAt);
                    Course cr = new Course(title, description, managerID, mentorID, createdAt, updatedAt, courseMajorID);
                    dao.createCourse(cr);
                    response.sendRedirect("/HAPPYorSAD/Course");
                }
            } 
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
