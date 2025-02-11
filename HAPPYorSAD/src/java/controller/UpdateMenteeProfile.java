/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.DAOuser;

/**
 *
 * @author admin
 */
@WebServlet(name = "UpdateMenteeProfile", urlPatterns = {"/updatementeeprofile"})
public class UpdateMenteeProfile extends HttpServlet {

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
        DAOuser mente = new DAOuser();

        // Get ID parameter
        String idParam = request.getParameter("id");
        int id = 0;

        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                id = Integer.parseInt(idParam);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid ID format!");
                request.getRequestDispatcher("/CRUD/updateMenteeProfile.jsp").forward(request, response);
                return;
            }
        } else {
            request.setAttribute("error", "ID parameter is missing!");
            request.getRequestDispatcher("/CRUD/updateMenteeProfile.jsp").forward(request, response);
            return;
        }

        if ("GET".equalsIgnoreCase(request.getMethod())) {
            User mentee = mente.getMenteeById(id);
            request.setAttribute("mentee", mentee);
            request.setAttribute("email", mentee.getEmail());
            request.getRequestDispatcher("/CRUD/updateMenteeProfile.jsp").forward(request, response);
            return;
        }

        String avatar = request.getParameter("avatar");
        String username = request.getParameter("username");
        String fullname = request.getParameter("fullname");
        String dob = request.getParameter("dateOfBirth");
        String gender = request.getParameter("gender");
        String address = request.getParameter("address");

        java.sql.Date DOB = null;
        if (dob != null && !dob.isEmpty()) {
            DOB = java.sql.Date.valueOf(dob);
        } else {
            request.setAttribute("error", "Date of birth cannot be empty!");
            request.getRequestDispatcher("/CRUD/updateMenteeProfile.jsp").forward(request, response);
            return;
        }

        User mentee = new User();
        mentee.setAvatarPath(avatar);
        mentee.setUsername(username);
        mentee.setFullname(fullname);
        mentee.setDateOfBirth(DOB);
        mentee.setGender(gender);
        mentee.setAddress(address);

        boolean isUpdated = mente.updateMenteeProfile(mentee);
        if (isUpdated) {
            request.setAttribute("successMessage", "Profile updated successfully!");
            request.getRequestDispatcher("/view/Course.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Unable to update profile!");
            request.getRequestDispatcher("/CRUD/updateMenteeProfile.jsp").forward(request, response);
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
