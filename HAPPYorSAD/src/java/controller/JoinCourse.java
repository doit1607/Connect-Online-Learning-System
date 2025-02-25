/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Course;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.DAOCourse;
import model.DAOMentor;

/**
 *
 * @author admin
 */
public class JoinCourse extends HttpServlet {

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
        DAOMentor dao = new DAOMentor();
        HttpSession session = request.getSession();
        String cvStatus = (String) session.getAttribute("cvStatus");

        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("Login.jsp?error=notLoggedIn");
            return;
        }

        int mentorId = dao.getMentorByUserId(userId);
        session.setAttribute("mentorId", mentorId);

        if (mentorId == -1 || !"approved".equals(cvStatus)) {
            response.sendRedirect("JoinCourse?error=notApproved");
            return;
        }

        int courseId;
        try {
            courseId = Integer.parseInt(request.getParameter("courseId"));
        } catch (NumberFormatException e) {
            response.sendRedirect("JoinCourse?error=invalidCourse");
            return;
        }
        
        List<Integer> joinedCourses = dao.getJoinedCoursesByMentorId(mentorId);
        if (joinedCourses.contains(courseId)) {
            response.sendRedirect("ShowAllCourse?error=alreadyJoined");
            return;
        }

        dao.MentorCourse(mentorId, courseId);

        joinedCourses = dao.getJoinedCoursesByMentorId(mentorId);
        session.setAttribute("joinedCourses", joinedCourses);

        DAOCourse dao1 = new DAOCourse();
        List<Course> listAllCourse = dao1.getAllCourseOrderByName();
        session.setAttribute("listAllCourse", listAllCourse);

        response.sendRedirect("ShowAllCourse");
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
