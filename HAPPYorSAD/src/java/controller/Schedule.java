package controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import model.DAOMentor;
import model.DAOschedule;
import model.DAOslot;

/**
 *
 * @author Ann
 */
public class Schedule extends HttpServlet {

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
        HttpSession session = request.getSession();

        // Lấy userId từ session
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("/HAPPYorSAD/view/login.jsp");
            return;
        }

        // Lấy mentorId từ userId
        DAOMentor daoMentor = new DAOMentor();
        Integer mentorId = daoMentor.getMentorIdByUserId(userId);

        if (mentorId == null) {
            response.sendRedirect("/HAPPYorSAD/view/SetSchedule.jsp?msg=no_mentor");
            return;
        }
        session.setAttribute("mentorId", mentorId);
        System.out.println("Mentor ID: " + mentorId);

        String dayOfWeek = request.getParameter("day");

        try {
            String scheduleStr = request.getParameter("schedule");
            if (scheduleStr == null || scheduleStr.trim().isEmpty()) {
                response.sendRedirect("/HAPPYorSAD/view/SetSchedule.jsp?msg=invalid_date");
                return;
            }
            // Chuyển đổi ngày từ String sang java.sql.Date
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            formatter.setLenient(false); // Ngăn chặn ngày không hợp lệ
            java.util.Date scheduleDateUtil = formatter.parse(scheduleStr);
            Date scheduleDate = new Date(scheduleDateUtil.getTime());

            DAOschedule daoSchedule = new DAOschedule();

            // Lấy hoặc tạo scheduleId
            int scheduleId = daoSchedule.getOrCreateScheduleId(mentorId, dayOfWeek);
            if (scheduleId == -1) {
                response.sendRedirect("/HAPPYorSAD/view/SetSchedule.jsp?msg=error");
                return;
            }

            // Lấy danh sách slot theo scheduleId
            DAOslot daoSL = new DAOslot();
            

            // Đặt danh sách slot vào request và chuyển hướng đến JSP
            request.setAttribute("slots", slots);
            request.setAttribute("dayOfWeek", dayOfWeek);
            request.getRequestDispatcher("/HAPPYorSAD/view/SetSchedule.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("/HAPPYorSAD/view/error.jsp");
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
