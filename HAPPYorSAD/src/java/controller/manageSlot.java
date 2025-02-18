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
import java.time.LocalTime;
import java.sql.Time;
import model.DAOMentor;
import model.DAOschedule;
import model.DAOslot;

/**
 *
 * @author Ann
 */
public class manageSlot extends HttpServlet {

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
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        DAOslot dao = new DAOslot();
        DAOschedule daoS = new DAOschedule();

        Integer userId = (Integer) session.getAttribute("userId");
        System.out.println("User ID from session: " + session.getAttribute("userId"));
        if (userId == null) {
            response.sendRedirect("view/LoginUser.jsp");
            return;
        }
        Integer mentorId = (Integer) DAOMentor.getMentorIdByUserId(userId);
        if (mentorId != null) {
            session.setAttribute("mentorId", mentorId);
            System.out.println("Mentor ID: " + mentorId);
        } else {
            System.out.println("User is not a mentor.");
            response.getWriter().write("error: User is not a mentor.");
            return;
        }
        
        

        String dayOfWeek = request.getParameter("day");

        if ("add".equals(action)) {

            String startTimeStr = request.getParameter("startTime");
            String endTimeStr = request.getParameter("endTime");

            LocalTime startLocalTime = LocalTime.parse(startTimeStr);
            LocalTime endLocalTime = LocalTime.parse(endTimeStr);

            Time startTime = Time.valueOf(startLocalTime);
            Time endTime = Time.valueOf(endLocalTime);
            int duration = Integer.parseInt(request.getParameter("duration"));
            Integer scheduleId = daoS.getOrCreateScheduleId(mentorId, dayOfWeek);
            boolean success = dao.addSlot(scheduleId, startTime, endTime);
            response.sendRedirect("slots.jsp?mentorId=" + mentorId + "&day=" + dayOfWeek + "&status=" + (success ? "success" : "failed"));

        } else if ("delete".equals(action)) {
            int slotId = Integer.parseInt(request.getParameter("slotId"));
            boolean success = dao.deleteSlot(slotId);
            response.sendRedirect("/view/slots.jsp?mentorId=" + mentorId + "&status=" + (success ? "deleted" : "failed"));
        }

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
