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
@WebServlet(name="ReviewMentor", urlPatterns={"/reviewmentor"})
public class ReviewMentor extends HttpServlet {
   
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
        DAORateMentor dao = new DAORateMentor();
        int mentorId = Integer.parseInt(request.getParameter("mentorId"));
        List<MentorReview> review = dao.getReviewByMentorId(mentorId);
        request.setAttribute("reviews", review);
        request.getRequestDispatcher("ReviewMentor.jsp").forward(request, response);
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
        DAORateMentor dao = new DAORateMentor();
        int mentorId = Integer.parseInt(request.getParameter("mentorId"));
        int menteeId = Integer.parseInt(request.getParameter("menteeId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String commit = request.getParameter("commit");
        
        boolean isSuccess = dao.submitReview(mentorId, menteeId, rating, commit);
        
        if (isSuccess) {
            response.sendRedirect("ReviewMentor.jsp?mentorId = " + mentorId);
        } else {
            request.setAttribute("error", "Submit review is failed! Try again.");
            request.getRequestDispatcher("ReviewMentor.jsp").forward(request, response);
        }
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
