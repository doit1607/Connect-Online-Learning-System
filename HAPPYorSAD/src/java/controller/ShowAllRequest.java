/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Mentee_Slot;
import entity.Request;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
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
import model.DAOmentee;
import model.DAOslot;
import model.TransactionDAO;
import entity.Slot;
import model.DAOMentor;
import model.DAOmentee_Slot;

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
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        DAORequest dao = new DAORequest();
        DAOslot daoSl = new DAOslot();
        DAOMentor daomentor = new DAOMentor();
        DAOmentee_Slot daoMs = new DAOmentee_Slot();

        TransactionDAO daotran = new TransactionDAO();
        DAOmentee daomentee = new DAOmentee();

        String action = request.getParameter("action");
        String search = request.getParameter("search");
        String status = request.getParameter("status");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        String service = request.getParameter("service");
        dao.updateStatusRequesIsOverEndDate();


//        int requestId = Integer.parseInt(request.getParameter("requestid"));
//            Request newrequest = dao.getRequestById(requestId);
//            int menteeid = newrequest.getMenteeId();
//            int menteeuser_id = daomentee.getMenteeUserid(menteeid);
//            String usernamementee = daomentee.getMenteeUsername(menteeuser_id);
//            double totalprice = newrequest.gettotalprice();
//            dao.updateRequestStatus(requestId, "Processing");
//            daotran.updateHoldAfterReject(usernamementee, totalprice);
//            daotran.withdrawToWallet(usernamementee, totalprice);
//            daotran.depositToWallet((String)session.getAttribute("usernameUser"), totalprice);
//            daotran.createTransaction((String)session.getAttribute("usernameUser"), totalprice, "DEPOSIT");
//            double balance = daotran.getBalance((String)session.getAttribute("usernameUser"));
//            session.setAttribute("walletBalance", balance);
//            
        if ("confirm".equals(service)) {
            int requestId = Integer.parseInt(request.getParameter("requestid"));
            Request newrequest = dao.getRequestById(requestId);
            int menteeid = newrequest.getMenteeId();
            int menteeuser_id = daomentee.getMenteeUserid(menteeid);
            int mentorId = dao.getMentorIdByRequestId(requestId);
            String usernamementee = daomentee.getMenteeUsername(menteeuser_id);
            System.out.println("MentorId" + mentorId);
            try {
                List<entity.Mentee_Slot> slots = daoMs.getSlotsByRequestIdd(requestId);
                for (entity.Mentee_Slot slot : slots) {
                    System.out.println(slot);
                    int slotId = slot.getSlot_id();
                    System.out.println("slot ID: " + slotId + "mentee ID: " + menteeid + "Mentor ID: " + mentorId + "Request ID: " + requestId);
                    daoMs.updateMenteeSlotStatus(slotId, menteeid, requestId, "Studying");
                    daoMs.updateMentorSlotStatus(slotId, mentorId, "Studying");
                }
            } catch (SQLException ex) {
                Logger.getLogger(ShowAllRequest.class.getName()).log(Level.SEVERE, null, ex);
            }

            double totalprice = newrequest.gettotalprice();
            daotran.createTransaction((String) session.getAttribute("usernameUser"), totalprice, "DEPOSIT", "Course fee of Mentee " + usernamementee);
            double balance = daotran.getBalance((String) session.getAttribute("usernameUser"));
            dao.updateRequestStatus(requestId, "Processing");
        }
        if ("closed".equals(service)) {
            DAOmentee_Slot daoMSL = new DAOmentee_Slot();
            DAOMentor daoMentor = new DAOMentor();

            int requestId = Integer.parseInt(request.getParameter("requestid"));
            Request newrequest = dao.getRequestById(requestId);

            List<Mentee_Slot> slots = daoMSL.getSlotsByRequestId(requestId);
            int presentCount = 0;
            int absentCount = 0;

            for (Mentee_Slot slot : slots) {
                if ("present".equals(slot.getStatus())) {
                    presentCount++;
                } else if ("absent".equals(slot.getStatus())) {
                    absentCount++;
                }
            }
            double pricePerSlot = daoMentor.getMentorPrice(newrequest.getCourseId());
            double totalPrice = newrequest.getTotalSlot() * pricePerSlot;

            double refundAmount = absentCount * pricePerSlot * 0.7; 
            double mentorAmount = presentCount * pricePerSlot * 0.8;

            int mentorid = newrequest.getMentorId();
            int mentoruser_id = daomentor.getMentorUserid(mentorid);
            int menteeid = newrequest.getMenteeId();
            int menteeuser_id = daomentee.getMenteeUserid(menteeid);
            String usernamementee = daomentee.getMenteeUsername(menteeuser_id);
            String usernamementor = daomentor.getMentorUsername(mentoruser_id);
            double finalprice = refundAmount + mentorAmount; 

       
            
            if (refundAmount > 0) {
                daotran.processRefund(usernamementee, refundAmount);
                daotran.withdrawToWallet((String) session.getAttribute("usernameUser"), refundAmount);
                daotran.createTransaction((String) session.getAttribute("usernameUser"), refundAmount, "WITHDRAW",
                        "Refund " + refundAmount + " for Mentee " + usernamementee + " with " + absentCount + " slot absent");
            }

           
            if (mentorAmount > 0) {
                daotran.withdrawToWallet((String) session.getAttribute("usernameUser"), mentorAmount);
                daotran.createTransaction((String) session.getAttribute("usernameUser"), mentorAmount, "WITHDRAW",
                        "Refund " + mentorAmount + " for Mentor " + usernamementor + " with " + presentCount + " slot present");

                daotran.depositToWallet(usernamementor, mentorAmount);
                daotran.createTransaction(usernamementor, mentorAmount, "DEPOSIT",
                        "Course fees of Mentee " + usernamementee + " with " + presentCount + " slot");
            }

            if (refundAmount > 0) {
                daotran.createTransaction(usernamementee, refundAmount, "DEPOSIT",
                        "Refund money for " + absentCount + " slot absent with Mentor " + usernamementor);
            }

            dao.updateRequestStatus(requestId, "Closed");

            double balance = daotran.getBalance((String) session.getAttribute("usernameUser"));
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

        String indexPage = request.getParameter("index");
        if (indexPage == null) {
            indexPage = "1";
        }
        int index = Integer.parseInt(indexPage);

        int count = dao.getTotalRequest();
        int endPage = count / 10;
        if (count % 10 != 0) {
            endPage++;
        }

        List<Request> requestList;
        if (search == null && status == null && startDate == null && endDate == null) {
            requestList = dao.showAllRequest(index); 
        } else {
            requestList = dao.getAllRequests(search, status, startDate, endDate);
        }

        request.setAttribute("tag", index);
        request.setAttribute("endPage", endPage);
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ShowAllRequest.class.getName()).log(Level.SEVERE, null, ex);
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ShowAllRequest.class.getName()).log(Level.SEVERE, null, ex);
        }
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
