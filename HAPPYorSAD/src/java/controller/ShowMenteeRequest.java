/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Mentee;
import entity.Mentee_Slot;
import entity.Request;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.DAOCourse;
import model.DAOMentor;
import model.DAORequest;
import model.DAOmentee;
import model.DAOmentee_Slot;

/**
 *
 * @author Acer
 */
public class ShowMenteeRequest extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ShowMenteeRequest.class.getName());

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        DAORequest dao = new DAORequest();
        DAOmentee daom = new DAOmentee();
        DAOMentor daomentor = new DAOMentor();
        DAOCourse daoc = new DAOCourse();
        DAOmentee_Slot daoMSL = new DAOmentee_Slot();
        HttpSession session = request.getSession();
        Integer menteeId = (Integer) session.getAttribute("menteeId");

        LOGGER.log(Level.INFO, "Processing request for menteeId: {0}", menteeId);

        Mentee mentee = daom.getMenteeById(menteeId);
        if (mentee == null) {
            LOGGER.log(Level.WARNING, "Mentee not found for menteeId: {0}", menteeId);
            request.setAttribute("error", "Không tìm thấy thông tin mentee.");
            request.getRequestDispatcher("view/MenteeRequest.jsp").forward(request, response);
            return;
        }

        session.setAttribute("mentee", mentee);

        String indexPage = request.getParameter("index");
        if (indexPage == null) {
            indexPage = "1";
        }
        int index = Integer.parseInt(indexPage);

        int count = dao.getTotalRequest();
        int endPage = count / 10;
        if (count % 2 != 0) {
            endPage++;
        }
        request.setAttribute("endPage", endPage);
        request.setAttribute("tag", index);
        String status = request.getParameter("status");
        List<Request> listAllRequest;

        if (status != null && !status.isEmpty()) {
            listAllRequest = dao.getRequestByStatus(menteeId, status, index);
            LOGGER.log(Level.INFO, "Filtered {0} requests with status {1} for menteeId: {2}",
                    new Object[]{listAllRequest.size(), status, menteeId});
        } else {
            listAllRequest = dao.getAllRequest(menteeId, index);
            LOGGER.log(Level.INFO, "Retrieved {0} requests for menteeId: {1}",
                    new Object[]{listAllRequest.size(), menteeId});
        }
        session.setAttribute("listAllRequest", listAllRequest);

        // Tính toán thông tin chi tiết cho từng request
        Map<Integer, Map<String, Object>> requestData = new HashMap<>();

        for (Request req : listAllRequest) {
            List<Mentee_Slot> slots = null;
            try {
                slots = daoMSL.getSlotsByRequestId(req.getId());
            } catch (SQLException ex) {
                LOGGER.log(Level.SEVERE, "Error fetching slots for requestId: {0}", req.getId());
                LOGGER.log(Level.SEVERE, "SQLException: ", ex);
            }
            int presentCount = 0;
            int absentCount = 0;

            for (Mentee_Slot slot : slots) {
                if ("present".equals(slot.getStatus())) {
                    presentCount++;
                } else if ("absent".equals(slot.getStatus())) {
                    absentCount++;
                }
            }

            double pricePerSlot = daomentor.getMentorPrice(req.getCourseId());
            double totalPrice = req.getTotalSlot() * pricePerSlot; // Tổng tiền ban đầu
            double refundAmount = absentCount * pricePerSlot * 0.7; // Tiền hoàn lại (70%)
            double finalPrice = totalPrice - refundAmount; // Tiền cuối cùng

            // Lưu vào Map
            Map<String, Object> data = new HashMap<>();
            data.put("presentCount", presentCount);
            data.put("absentCount", absentCount);
            data.put("totalPrice", totalPrice);
            data.put("refundAmount", refundAmount);
            data.put("finalPrice", finalPrice);

            requestData.put(req.getId(), data);
        }

        request.setAttribute("requestData", requestData);

        String requestIdStr = request.getParameter("requestId");
        if (requestIdStr != null && !requestIdStr.isEmpty()) {
            try {
                int requestId = Integer.parseInt(requestIdStr);
                LOGGER.log(Level.INFO, "Processing specific requestId: {0}", requestId);
                Request specificRequest = dao.getRequestById(requestId);
                if (specificRequest != null && specificRequest.getMenteeId() == menteeId) {
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

                    double pricePerSlot = daomentor.getMentorPrice(specificRequest.getCourseId());
                    double totalPrice = specificRequest.getTotalSlot() * pricePerSlot;
                    double refundAmount = absentCount * pricePerSlot * 0.7; // Tiền hoàn lại (70%)
                    double finalPrice = totalPrice - refundAmount;

                    LOGGER.log(Level.INFO, "RequestId: {0}, Present: {1}, Absent: {2}, TotalPrice: {3}, Refund: {4}, FinalPrice: {5}",
                            new Object[]{requestId, presentCount, absentCount, totalPrice, refundAmount, finalPrice});

                    request.setAttribute("specificRequestId", requestId);
                    request.setAttribute("specificRequest", specificRequest);
                    request.setAttribute("presentCount", presentCount);
                    request.setAttribute("absentCount", absentCount);
                    request.setAttribute("refundAmount", refundAmount);
                    request.setAttribute("finalPrice", finalPrice);
                    request.setAttribute("totalPrice", totalPrice);
                    request.setAttribute("showRequestModal", true);
                } else {
                    LOGGER.log(Level.WARNING, "RequestId: {0} not found or does not belong to menteeId: {1}", new Object[]{requestId, menteeId});
                }
            } catch (NumberFormatException e) {
                LOGGER.log(Level.WARNING, "Invalid requestId format: {0}", requestIdStr);
            } catch (SQLException ex) {
                LOGGER.log(Level.SEVERE, "SQLException while fetching slots for requestId: {0}", requestIdStr);
                LOGGER.log(Level.SEVERE, "SQLException: ", ex);
            }
        }

        session.setAttribute("mentee", mentee);
        session.setAttribute("listAllRequest", listAllRequest);
        request.getRequestDispatcher("view/MenteeRequest.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LOGGER.log(Level.INFO, "Received GET request");
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        LOGGER.log(Level.INFO, "Received POST request with action: {0}", action);

        DAORequest daoR = new DAORequest();
        if ("CompleteRequest".equals(action)) {
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            String refundAmountStr = request.getParameter("refundAmount");
            String finalPriceStr = request.getParameter("finalPrice");
            String totalPriceStr = request.getParameter("totalPrice");
            LOGGER.log(Level.INFO, "Request parameters - requestId: {0}, refundAmount: {1}, finalPrice: {2}, totalPrice: {3}",
                    new Object[]{requestId, refundAmountStr, finalPriceStr, totalPriceStr});

            double totalPrice = Double.parseDouble(totalPriceStr);

            if (refundAmountStr == null || finalPriceStr == null) {
                LOGGER.log(Level.WARNING, "Invalid input data for requestId: {0}", requestId);
                request.setAttribute("error", "Dữ liệu đầu vào không hợp lệ.");
                processRequest(request, response);
                return;
            }

            try {
                double refundAmount = Double.parseDouble(refundAmountStr);
                double finalPrice = Double.parseDouble(finalPriceStr);
                daoR.updateRequestStatus(requestId, "PendingCompleted");

                LOGGER.log(Level.INFO, "Request {0} completed. Refund: {1}, FinalPrice: {2}", new Object[]{requestId, refundAmount, finalPrice});
                request.getSession().setAttribute("msg", "Yêu cầu " + requestId + " đã hoàn thành. Đã hoàn tiền: " + refundAmount + "₫. Tổng tiền cuối: " + finalPrice + "₫");
                response.sendRedirect("/HAPPYorSAD/ShowMenteeRequest");
            } catch (NumberFormatException e) {
                LOGGER.log(Level.WARNING, "Invalid number format for requestId: {0}", requestId);
                request.setAttribute("error", "Dữ liệu số không hợp lệ.");
                processRequest(request, response);
            } catch (SQLException ex) {
                LOGGER.log(Level.SEVERE, "SQLException while completing requestId: {0}", requestId);
                LOGGER.log(Level.SEVERE, "SQLException: ", ex);
            }
        } else {
            // Nếu action không hợp lệ, quay lại trang chính
            response.sendRedirect("/HAPPYorSAD/ShowMenteeRequest");
        }
    }

    @Override
    public String getServletInfo() {
        return "ShowMenteeRequest Servlet";
    }
}
