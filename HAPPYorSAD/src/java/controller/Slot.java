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
import java.util.Arrays;
import java.util.List;
import model.DAOMentor;
import model.DAOschedule;
import static model.DAOschedule.getScheduleIdsByMentorId;
import model.DAOslot;

/**
 *
 * @author Ann
 */
public class Slot extends HttpServlet {

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
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("/HAPPYorSAD/view/LoginUser.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        Integer mentorId = (Integer) DAOMentor.getMentorIdByUserId(userId);
        List<Integer> scheduleIds = getScheduleIdsByMentorId(mentorId);
        
        if (scheduleIds ==null){
            System.out.println("error");
        }else{
            for (Integer scheduleId : scheduleIds) {
                System.out.println(scheduleId);
        }

        if (mentorId != null) {
            session.setAttribute("mentorId", mentorId);
            System.out.println("Mentor ID: " + mentorId);
        } else {
            System.out.println("User is not a mentor.");
            response.getWriter().write("error: User is not a mentor.");
            return;
        }
             
        DAOslot dao = new DAOslot();
//        List<Schedule> dayOrweek = dao.getDaysBySchedule(scheduleIds), )
        List<String> days = Arrays.asList("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday");
        request.setAttribute("days", days);
        String selectedDay = request.getParameter("day");
        if (selectedDay == null || selectedDay.trim().isEmpty()) {
            selectedDay = "Monday";
            System.out.println("Hello monday");
        }
        request.setAttribute("selectedDay", selectedDay);
        System.out.println(selectedDay);


        List<entity.Slot> slots = dao.getSlotsBySchedule(scheduleIds);
        
              if(slots != null){
                  System.out.println(mentorId);
                  System.out.println(selectedDay);
              }else{
                  for (entity.Slot slot : slots) {
                      System.out.println(slot);
                  }
              }
        request.setAttribute("slots", slots);   
        request.setAttribute("mentorId", mentorId);

        System.out.println(mentorId);
        request.getRequestDispatcher("/view/Slot.jsp").forward(request, response);
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
