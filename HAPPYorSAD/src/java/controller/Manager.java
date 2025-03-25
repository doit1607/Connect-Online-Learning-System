/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import entity.MentorDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.DAOCourse;
import model.DAOMentor;
import model.DAORateMentor;
import model.DAORequest;
import model.DAOmentee;
import model.DAOuser;
import model.TransactionDAO;

/**
 *
 * @author admin
 */
public class Manager extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    

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
        DAOCourse dAOCourse = new DAOCourse();
        DAOMentor dAOMentor = new DAOMentor();
        DAOmentee dAOmentee = new DAOmentee();
        DAOuser dAOuser = new DAOuser();
        DAORequest dAORequest = new DAORequest();
        DAORateMentor dAORateMentor =  new DAORateMentor();
        TransactionDAO dAOTransaction = new TransactionDAO();
        
        
        
        Double earning = dAORequest.getTotalReceivedAmount()*0.2;
        
        int requestCompleted = dAORequest.getRequestCount("Closed");
                
        int mentorCount = dAOMentor.getAllMentor().size();
        int menteeCount = dAOmentee.getAllMentee().size();
        int courseCount = dAOCourse.getTotalCourse();
        
        List<MentorDTO> top10mentorByEarning = dAOMentor.getTop10Mentors(1);

        List<MentorDTO> top10mentorByRating = dAOMentor.getTop10Mentors(2);
        
        request.setAttribute("top10mentorByEarning", top10mentorByEarning);
        request.setAttribute("top10mentorByRating", top10mentorByRating);

        request.setAttribute("earning", earning);
        request.setAttribute("requestCompleted", requestCompleted);
        request.setAttribute("mentorCount", mentorCount);
        request.setAttribute("menteeCount", menteeCount);
        request.setAttribute("courseCount", courseCount);
        
        
        request.getRequestDispatcher("/view/Manager.jsp").forward(request, response);
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
