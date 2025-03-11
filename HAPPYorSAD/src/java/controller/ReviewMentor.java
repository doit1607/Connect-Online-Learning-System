/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Mentor;
import entity.MentorReview;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.DAORateMentor;
import model.DAOuser;

/**
 *
 * @author admin
 */
@WebServlet(name = "ReviewMentor", urlPatterns = {"/reviewmentor"})
public class ReviewMentor extends HttpServlet {

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
        DAORateMentor dao = new DAORateMentor();

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("usernameUser");
        String requestStatus = dao.getRequestStatusByMentee(username);
        session.setAttribute("menteeRequestStatus", requestStatus);

        int menteeId = dao.getMenteeIdByUsername(username);
        session.setAttribute("menteeID", menteeId);

        List<Mentor> mentorList = dao.getAllMentors(menteeId);
        request.setAttribute("mentorList", mentorList);

        List<Integer> reviewedMentorIds = dao.getReviewedMentorsByMentee(username);
        session.setAttribute("reviewedMentorIds", reviewedMentorIds);

        String mentorIdStr = request.getParameter("mentorId");
        //String menteeIdStr = request.getParameter("menteeId");
        String ratingStr = request.getParameter("rating");
        String comment = request.getParameter("comment");

        if (isEmpty(mentorIdStr) || isEmpty(ratingStr)) {
            request.setAttribute("error", "Missing required fields: mentorId, menteeId, or rating.");
            request.getRequestDispatcher("/view/ReviewMentor.jsp").forward(request, response);
            return;
        }

        int mentorId = Integer.parseInt(mentorIdStr);
        //int menteeId = Integer.parseInt(menteeIdStr);
        int rating = Integer.parseInt(ratingStr);

        boolean isSuccess = dao.submitReview(mentorId, menteeId, rating, comment);

        if (isSuccess) {
            request.setAttribute("success", "Your review has been submitted successfully!");
        } else {
            request.setAttribute("error", "Failed to submit review. Please try again.");
        }
        request.getRequestDispatcher("/view/ReviewMentor.jsp").forward(request, response);

    }

    private boolean isEmpty(String str) {
        return str == null || str.trim().isEmpty();
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
