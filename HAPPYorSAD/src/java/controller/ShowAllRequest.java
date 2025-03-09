/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Request;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.List;
import model.DAORequest;
import model.DAOmentee;
import model.TransactionDAO;

/**
 *
 * @author admin
 */
public class ShowAllRequest extends HttpServlet {

    private static final long serialVersionUID = 1L;

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
        DAORequest dao = new DAORequest();

        TransactionDAO daotran = new TransactionDAO();
        DAOmentee daomentee = new DAOmentee();

        String action = request.getParameter("action");
        String search = request.getParameter("search");
        String status = request.getParameter("status");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        String service = request.getParameter("service");
        if ("confirm".equals(service)) {
            int requestId = Integer.parseInt(request.getParameter("requestid"));
            Request newrequest = dao.getRequestById(requestId);
            int menteeid = newrequest.getMenteeId();
            int menteeuser_id = daomentee.getMenteeUserid(menteeid);
            String usernamementee = daomentee.getMenteeUsername(menteeuser_id);
            double totalprice = newrequest.gettotalprice();
            dao.updateRequestStatus(requestId, "Processing");
            daotran.updateHoldAfterReject(usernamementee, totalprice);
            daotran.withdrawToWallet(usernamementee, totalprice);
            daotran.depositToWallet((String)session.getAttribute("usernameUser"), totalprice);
            daotran.createTransaction((String)session.getAttribute("usernameUser"), totalprice, "DEPOSIT");
            double balance = daotran.getBalance((String)session.getAttribute("usernameUser"));
            session.setAttribute("walletBalance", balance);
        }

        LocalDate startDate = (startDateStr != null && !startDateStr.isEmpty()) ? LocalDate.parse(startDateStr) : null;
        LocalDate endDate = (endDateStr != null && !endDateStr.isEmpty()) ? LocalDate.parse(endDateStr) : null;

        if ("detail".equals(action)) {
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                try {
                    int id = Integer.parseInt(idStr);
                    Request requestD = dao.requestById(id);
                    if (requestD != null) {
                        request.setAttribute("requestDetail", requestD);
                        request.getRequestDispatcher("/view/requestDetail.jsp").forward(request, response);
                        return;
                    } else {
                        request.setAttribute("error", "Không tìm thấy yêu cầu có ID: " + id);
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "ID không hợp lệ!");
                }
            } else {
                request.setAttribute("error", "ID không được để trống!");
            }
            return;
        }
        // Lấy danh sách yêu cầu từ DAO
        List<Request> requestList;
        if (search == null && status == null && startDate == null && endDate == null) {
            requestList = dao.showAllRequest(); // Gọi hàm mới
        } else {
            requestList = dao.getAllRequests(search, status, startDate, endDate);
        }
        //List<Request> requestList = dao.getAllRequests(search, status, startDate, endDate);

        // Gửi danh sách đến JSP
        request.setAttribute("requestList", requestList);
        request.getRequestDispatcher("/view/viewAllRequests.jsp").forward(request, response);
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
