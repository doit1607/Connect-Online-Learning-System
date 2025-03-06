/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Request;
import entity.Transaction;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.DAORequest;
import model.DAOa;
import model.DAOslot;
import model.DAOuser;
import model.TransactionDAO;

/**
 *
 * @author admin
 */
@WebServlet(name = "viewRequest", urlPatterns = {"/viewRequest"})
public class ViewRequest extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
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
        int limit = 4;
        int page = 1;

        String dateFilterString = request.getParameter("date");
        String title = request.getParameter("title");
        String status = request.getParameter("status");
        int dateFilter = 0;

        if (dateFilterString != null && !dateFilterString.isEmpty()) {
            dateFilter = Integer.parseInt(dateFilterString);
        }
        try {
            String pageParam = request.getParameter("page");
            String limitParam = request.getParameter("limit");

            if (limitParam != null && !limitParam.isEmpty()) {
                limit = Integer.parseInt(limitParam);
                if (limit <= 0) {
                    limit = 5; // Nếu limit <= 0, đặt lại giá trị mặc định
                }
            }

            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
                if (page < 1) {
                    page = 1;
                }
            }
        } catch (NumberFormatException e) {
            System.err.println("Lỗi khi chuyển đổi page/limit: " + e.getMessage());
        }

        DAORequest daoReq = new DAORequest();
        HttpSession session = request.getSession();
        String mentorUsername = (String) session.getAttribute("usernameUser");
        LocalDate date = null;
        switch (dateFilter) {
            case 1:
                date = LocalDate.now();
                break;
            case 2:
                date = LocalDate.now().minusDays(7);
                break;
            case 3:
                date = LocalDate.now()
                        .withDayOfMonth(1);
                break;
            default:
//                throw new AssertionError();
        }
        int totalRequests = daoReq.getRequestCount(mentorUsername, title, status, date);
        int totalPages = (int) Math.ceil((double) totalRequests / limit);

//        List<Mentor1> list = dao.getAllMentors(search, page, limit);
//        int totalMentors = dao.getTotalMentors(search); // Lấy tổng số mentor
//        int totalPages = (int) Math.ceil((double) totalMentors / limit); // Tính tổng số trang
//
//        HttpSession session = request.getSession();
//        session.setAttribute("listMentor", list);
//        session.setAttribute("currentPage", page);
//        session.setAttribute("limit", limit);
//        session.setAttribute("totalPages", totalPages); // Gửi tổng số trang đến session
        List<Request> requests = daoReq.getRequestByMentor(mentorUsername, title, status, date, page, limit);
        
        
        request.setAttribute("requests", requests);
        request.setAttribute("currentPage", page);
        request.setAttribute("limit", limit);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("view/viewRequest.jsp").forward(request, response);
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
        int requestId = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");
        TransactionDAO trandao = new TransactionDAO();

        DAORequest dao = new DAORequest();

        // *** Thêm xử lý điểm danh slot ***
        String action = request.getParameter("action");
        DAOslot slotDAO = new DAOslot();
        DAOa attendanceDAO = new DAOa();

//        if ("markDone".equals(action)) {
//            int slotId = Integer.parseInt(request.getParameter("slotId"));
//            int mentorId = Integer.parseInt(request.getParameter("mentorId"));
//            try {
//                attendanceDAO.markAttendance(slotId, mentorId, true);
//            } catch (SQLException ex) {
//                Logger.getLogger(ViewRequest.class.getName()).log(Level.SEVERE, null, ex);
//            }
//            try {
//                slotDAO.updateSlotStatus(slotId, "Complete");
//            } catch (SQLException ex) {
//                Logger.getLogger(ViewRequest.class.getName()).log(Level.SEVERE, null, ex);
//            }
//
//            try {
//                // Kiểm tra nếu tất cả slot đã hoàn thành
//                if (slotDAO.areAllSlotsComplete(requestId)) {
//                    dao.updateRequestStatus(requestId, "Complete");
//                }
//            } catch (SQLException ex) {
//                Logger.getLogger(ViewRequest.class.getName()).log(Level.SEVERE, null, ex);
//            }
//        } else if (status.equals("Processing")) {
//            dao.updateRequestStatus(requestId, status);
//        } else if (status.equals("Cancel")) {
//            dao.updateRequestStatus(requestId, status);
//            String reason = request.getParameter("reject_reason");
//            dao.addRejectReason(requestId, reason);
//        }

        response.sendRedirect("/HAPPYorSAD/viewRequest");

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
