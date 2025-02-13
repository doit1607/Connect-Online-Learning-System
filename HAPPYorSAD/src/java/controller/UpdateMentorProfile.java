/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import model.DAOuser;

/**
 *
 * @author admin
 */
@WebServlet(name = "UpdateMentorProfile", urlPatterns = {"/updatementorprofile"})
public class UpdateMentorProfile extends HttpServlet {

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
        DAOuser mento = new DAOuser();
        String username = request.getParameter("username");
        
        User u = mento.getMentorByUsername(username);
        request.setAttribute("mentor", u);
        request.getRequestDispatcher("/CRUD/updateMentorProfile.jsp").forward(request, response);

//        boolean isUpdated = mento.updateMentorProfile(u);
//        if (isUpdated) {
//            request.setAttribute("successMessage", "Profile updated successfully!");
//            request.getRequestDispatcher("Home").forward(request, response);
//        } else {
//            request.setAttribute("error", "Unable to update profile!");
//            request.setAttribute("mentor", u);
//            request.getRequestDispatcher("/CRUD/updateMentorProfile.jsp").forward(request, response);
//        }
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
        DAOuser mento = new DAOuser();
        String username = request.getParameter("username");
        String avatar = request.getParameter("avatar");
        String fullname = request.getParameter("fullname");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        Date dateOfBirth = null;
        try {
            String dob = request.getParameter("dateOfBirth");
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            dateOfBirth = formatter.parse(dob);
        } catch (Exception e) {
            e.printStackTrace();
        }
        mento.updateMentorProfile(username, avatar, fullname, address, dateOfBirth, gender);
        response.sendRedirect("updatementorprofile");
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
