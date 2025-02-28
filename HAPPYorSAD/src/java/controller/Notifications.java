/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.DAOAcceptCV;

/**
 *
 * @author admin
 */
public class Notifications extends HttpServlet {

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
        DAOAcceptCV dao = new DAOAcceptCV();
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        String username =  session.getAttribute("usernameUser").toString();

        List<String> notifications = (List<String>) session.getAttribute("cvNotifications");
        if (notifications == null) {
            notifications = new ArrayList<>();
        }

        if ("viewNotifications".equals(action)) {
            notifications = dao.getNotifications(username);
            
            session.setAttribute("cvNotifications", notifications);
        }

        if ("deleteNotification".equals(action)) {
            dao.deleteNotification(username);
            notifications.clear();
            session.setAttribute("cvNotifications", notifications);
        } else if ("deleteSingleNotification".equals(action)) {
            String notificationToRemove = request.getParameter("notificationMessage");
            if (notificationToRemove != null && notifications.contains(notificationToRemove)) {
                dao.deleteSingleNotification(username, notificationToRemove);
                notifications = dao.getNotifications(username); 
                session.setAttribute("cvNotifications", notifications);
            }
        }

        request.getRequestDispatcher("/view/Notifications.jsp").forward(request, response);
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
        request.getRequestDispatcher("/view/Notifications.jsp").forward(request, response);
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
