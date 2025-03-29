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
import model.DAOmentee;
import model.DAOslot;
import model.DAOmentee_Slot;
import model.TransactionDAO;

/**
 *
 * @author admin
 */
@WebServlet(name = "viewRequest", urlPatterns = {"/viewRequest"})
public class ViewRequest extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int limit = 4;
        int page = 1;

        String dateFilterString = request.getParameter("date");
        String title = request.getParameter("title");
        if (title != null) {
            title = title.trim();
        }
        String[] status = request.getParameterValues("status");
        request.setAttribute("status", status);
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
                    limit = 5;
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
                date = LocalDate.now().withDayOfMonth(1);
                break;
            default:
            // Không cần throw AssertionError
        }
        int totalRequests = daoReq.getRequestCount(mentorUsername, title, status, date);
        int totalPages = (int) Math.ceil((double) totalRequests / limit);

        List<Request> requests = daoReq.getRequestByMentor(mentorUsername, title, status, date, page, limit);

        request.setAttribute("requests", requests);
        request.setAttribute("currentPage", page);
        request.setAttribute("limit", limit);
        request.setAttribute("totalPages", totalPages);

        String requestIdStr = request.getParameter("requestId");
        if (requestIdStr != null && !requestIdStr.isEmpty()) {
            int requestId = Integer.parseInt(requestIdStr);
            Request selectedRequest = daoReq.getRequestById(requestId);
            if (selectedRequest != null) {
                request.setAttribute("selectedRequest", selectedRequest);
            }
        }

        request.getRequestDispatcher("view/viewRequest.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int requestId = Integer.parseInt(request.getParameter("id"));
        HttpSession session = request.getSession();
        System.out.println("Request ID: " + requestId);

        TransactionDAO daotran = new TransactionDAO();
        DAORequest dao = new DAORequest();
        DAOmentee daomentee = new DAOmentee();
        DAOslot daoSl = new DAOslot();
        DAOmentee_Slot daoMs = new DAOmentee_Slot();

        Request newrequest = dao.getRequestById(requestId);
        dao.updateStatusRequesIsOverEndDate();
        if (newrequest == null) {
            System.out.println("Error: Request not found with ID " + requestId);
            session.setAttribute("error", "Request not exist.!");
            response.sendRedirect("/HAPPYorSAD/errorPage");
            return;
        }

        int menteeid = newrequest.getMenteeId();
        int menteeuser_id = daomentee.getMenteeUserid(menteeid);
        String usernamementee = daomentee.getMenteeUsername(menteeuser_id);
        double totalprice = newrequest.gettotalprice();
        String status = request.getParameter("status");
        int mentorId = dao.getMentorIdByRequestId(requestId);

        if (status.equals("Pending")) {
            System.out.println("Updating request status to Pending");
            try {
                dao.updateRequestStatus(requestId, "Pending");
                List<entity.Mentee_Slot> slots = daoMs.getSlotsByRequestId(requestId);
                for (entity.Mentee_Slot slot : slots) {
                    int slotId = slot.getSlot_id();
                    daoSl.updateSlotStatusss(slotId, mentorId, "Pending");
                    System.out.println("Updated slot ID: " + slotId);
                }
                daotran.updateHoldAfterReject(usernamementee, totalprice);
                daotran.withdrawToWallet(usernamementee, totalprice);
                daotran.depositToWallet("robert_jones", totalprice);
                daotran.createTransaction("robert_jones", totalprice, "DEPOSIT", "Course fee of Mentee " + usernamementee);
                session.setAttribute("msg", "Request " + requestId + " is accepted!");
            } catch (SQLException ex) {
                Logger.getLogger(ViewRequest.class.getName()).log(Level.SEVERE, null, ex);
                session.setAttribute("error", "Error for accecpt request!");
            }
        } else if (status.equals("Cancel")) {
            System.out.println("Updating request status to Cancel");
            try {
                daotran.updateHoldAfterReject(usernamementee, totalprice);
                double hold = daotran.getHold(usernamementee);
                daotran.createTransaction(usernamementee, totalprice, "DEPOSIT", "Mentor reject the request!");
                dao.updateRequestStatus(requestId, "Cancel");
                session.setAttribute("msg", "Request " + requestId + " is cancled.");
                session.setAttribute("walletHold", hold);
            } catch (SQLException ex) {
                Logger.getLogger(ViewRequest.class.getName()).log(Level.SEVERE, null, ex);
                session.setAttribute("error", "Error for accecpt request!");
            }
        } else if ("Completed".equals(status) && "PendingCompleted".equals(newrequest.getStatus())) {
            try {
                dao.updateRequestStatus(requestId, "Completed");
                session.setAttribute("msg", "Request " + requestId + " is completed!.");
            } catch (SQLException ex) {
                Logger.getLogger(ViewRequest.class.getName()).log(Level.SEVERE, null, ex);
                session.setAttribute("error", "Error when accepted request.");
            }
        } else {
            System.out.println("Error: Invalid status received - " + status);
            session.setAttribute("error", "Status is invalid: " + status);
        }

        // Giữ lại các tham số lọc khi redirect
        String page = request.getParameter("page") != null ? request.getParameter("page") : "1";
        String date = request.getParameter("date") != null ? request.getParameter("date") : "0";
        String redirectUrl = "/HAPPYorSAD/viewRequest?page=" + page + "&date=" + date;
        response.sendRedirect(redirectUrl);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
