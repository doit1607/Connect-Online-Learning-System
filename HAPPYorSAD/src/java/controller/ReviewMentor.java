/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.MentorReview;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.DAORateMentor;

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
        // Get mentorId safely
        String idParam = request.getParameter("mentorId");
        int mentorId = 0;

        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                mentorId = Integer.parseInt(idParam);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid mentor ID format!");
                request.getRequestDispatcher("/view/ReviewMentor.jsp").forward(request, response);
                return;
            }
        } else {
            request.setAttribute("error", "Mentor ID is missing!");
            request.getRequestDispatcher("/view/ReviewMentor.jsp").forward(request, response);
            return;
        }

        List<MentorReview> review = dao.getReviewByMentorId(mentorId);
        request.setAttribute("reviews", review);
        request.setAttribute("mentorId", mentorId);
        request.getRequestDispatcher("/view/ReviewMentor.jsp").forward(request, response);
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
        DAORateMentor dao = new DAORateMentor();
        int mentorId = 0, menteeId = 0, rating = 0;
        String comment = request.getParameter("comment");

        try {
            mentorId = Integer.parseInt(request.getParameter("mentorId"));
            menteeId = Integer.parseInt(request.getParameter("menteeId"));
            rating = Integer.parseInt(request.getParameter("rating"));
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input! Please enter valid numbers.");
            request.getRequestDispatcher("/view/ReviewMentor.jsp").forward(request, response);
        }
        
        if (rating < 1 || rating > 5) {
            request.setAttribute("error", "Rating should be between 1 and 5.");
            request.getRequestDispatcher("/view/ReviewMentor.jsp").forward(request, response);
            return;
        }

        boolean isSuccess = dao.submitReview(mentorId, menteeId, rating, comment);

        if (isSuccess) {
            request.setAttribute("success", "Rating submitted successfully!");
        } else {
            request.setAttribute("error", "Failed to submit rating. Please try again.");
        }

        request.getRequestDispatcher("/view/ReviewMentor.jsp").forward(request, response);
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
