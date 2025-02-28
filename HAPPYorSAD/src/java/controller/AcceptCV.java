/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.CV;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import model.DAOAcceptCV;
import model.DAOuser;
import model.DaoCV;

/**
 *
 * @author admin
 */
public class AcceptCV extends HttpServlet {

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
        DAOAcceptCV dao = new DAOAcceptCV();
        DaoCV dao1 = new DaoCV();
        DAOuser dao2 = new DAOuser();

        String type = request.getParameter("status");
        String action = request.getParameter("action");
        String username = request.getParameter("username");

        User mentor = dao2.getMentorByUsername(username);
        request.setAttribute("mentor", mentor);

        if ("detail".equals(action)) {

            CV cv = dao1.getCVByUsername(username);
            request.setAttribute("cvDetail", cv);
            request.getRequestDispatcher("/view/CVDetail.jsp").forward(request, response);
            return;
        }

        // lay ra list CV da duoc approved
        if ("approved".equals(type)) {
            String searchQuery = request.getParameter("searchQuery");
            if (searchQuery != null) {
                searchQuery = searchQuery.trim().toLowerCase();
            }

            List<CV> cvApproved = dao1.getCVApproved();
            if (searchQuery != null && !searchQuery.isEmpty()) {
                final String finalSearchQuery = searchQuery;
                cvApproved = cvApproved.stream()
                        .filter(cv -> cv.getUsername().toLowerCase().contains(finalSearchQuery)
                        || (cv.getProfession() != null && cv.getProfession().toLowerCase().contains(finalSearchQuery)))
                        .collect(Collectors.toList());
            }

            request.setAttribute("cvApproved", cvApproved);
            request.getRequestDispatcher("/view/ListCVApproved.jsp").forward(request, response);
            return;
        }

        // lay ra list CV bi reject
        if ("rejected".equals(type)) {
            String searchQuery = request.getParameter("searchQuery");
            if (searchQuery != null) {
                searchQuery = searchQuery.trim().toLowerCase();
            }

            List<CV> cvRejected = dao1.getCVrejected();
            if (searchQuery != null && !searchQuery.isEmpty()) {
                final String finalSearchQuery = searchQuery;
                cvRejected = cvRejected.stream()
                        .filter(cv -> cv.getUsername().toLowerCase().contains(finalSearchQuery)
                        || (cv.getProfession() != null && cv.getProfession().toLowerCase().contains(finalSearchQuery)))
                        .collect(Collectors.toList());
            }

            request.setAttribute("cvRejected", cvRejected);
            request.getRequestDispatcher("/view/ListCVRejected.jsp").forward(request, response);
            return; 
        }


        List<CV> cv = dao.getCVtoAccept();
        request.setAttribute("acceptCV", cv);
        request.getRequestDispatcher("/view/AcceptCV.jsp").forward(request, response);

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
        DAOAcceptCV dao = new DAOAcceptCV();
        String action = request.getParameter("action");
        String username = request.getParameter("username");
        String status = request.getParameter("status");

        if ("approve".equals(action)) {
            dao.approveCV(username);
            dao.updateCVStatus(username, "approved");
//            String notificationMessage = "Your CV has been approved.";
//            dao.saveNotification(username, notificationMessage);
            response.sendRedirect("AcceptCV?status=approved");
            return;
        } else if ("reject".equals(action)) {
            String reason = request.getParameter("reason");
            dao.rejectCV(username, reason);
            dao.updateCVStatus(username, "rejected");
//            String notificationMessage = "Your CV has been rejected.";
//            dao.saveNotification(username, notificationMessage);
            response.sendRedirect("AcceptCV?status=rejected");
            return;
        }

        List<CV> lCV;
        if (status == null || status.isEmpty()) {
            lCV = dao.getAllCV();
        } else {
            lCV = dao.getCVByStatus(status);
        }
        request.setAttribute("listCV", lCV);
        request.getRequestDispatcher("/view/AcceptCV.jsp").forward(request, response);

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
