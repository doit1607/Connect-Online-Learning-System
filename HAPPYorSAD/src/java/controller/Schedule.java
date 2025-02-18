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
import model.DAOschedule;

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

        if (session == null || session.getAttribute("userId") == null) {
            System.out.println("Session invalid");
            response.sendRedirect("/HAPPYorSAD/view/LoginUser.jsp");
            return;
        }
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("view/LoginUser.jsp");
            return;
        }
        System.out.println("Session ID: " + session.getId());
        System.out.println("User ID from session: " + session.getAttribute("userId"));

        Date scheduleDate = null;

        try {
            String schedule = request.getParameter("schedule");

            if (schedule == null || schedule.trim().isEmpty()) {
                response.sendRedirect("/HAPPYorSAD/view/SetSchedule.jsp?msg=invalid_date");
                return;
            }

            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            formatter.setLenient(false); // Ngăn chặn các giá trị ngày không hợp lệ
            scheduleDate = formatter.parse(schedule);

            DAOschedule daoS = new DAOschedule();
            boolean check = daoS.addSchedule(userId, scheduleDate);

            request.getRequestDispatcher("/HAPPYorSAD/view/SetSchedule.jsp?msg=" + (check ? "success" : "error")).forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error");
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
