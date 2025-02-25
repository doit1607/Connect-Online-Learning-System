/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Request;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import model.DAORequest;

/**
 *
 * @author Acer
 */
public class UpdateRequest extends HttpServlet {

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
        DAORequest requestDAO = new DAORequest();
        try {
            // Lấy dữ liệu từ form JSP
            int requestId = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            int totalSlot = Integer.parseInt(request.getParameter("totalSlot"));
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String content = request.getParameter("content");
            String action = request.getParameter("action"); // "draft" hoặc "submit"

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
            LocalDate startDate = LocalDate.parse(startDateStr, formatter);
            LocalDate endDate = LocalDate.parse(endDateStr, formatter);

            Request existingRequest = requestDAO.getRequestById(requestId);
            if (existingRequest == null) {
                response.getWriter().println("⚠️ Lỗi: Không tìm thấy request với ID: " + requestId);
                return;
            }

            System.out.println("🔍 Trạng thái request: " + existingRequest.getStatus());

            if (!existingRequest.getStatus().equals("Draft")) {
                response.getWriter().println("⛔ Không thể cập nhật request vì trạng thái hiện tại là: " + existingRequest.getStatus());
                return;
            }

            if (existingRequest != null && existingRequest.getStatus().equals("Draft")) {
                String newStatus = action.equals("submit") ? "Open" : "Draft";

                // Tạo request mới với dữ liệu cập nhật
                Request updatedRequest = new Request(
                        requestId,
                        existingRequest.getMenteeId(),
                        existingRequest.getMentorId(),
                        title,
                        totalSlot,
                        startDate,
                        endDate,
                        content,
                        newStatus, // Trạng thái cập nhật
                        existingRequest.getCreatedAt(),
                        LocalDateTime.now(),
                        courseId
                );

                // Cập nhật request
                requestDAO.updateRequest(updatedRequest);

                // Chuyển hướng về danh sách request
                response.sendRedirect("ShowMenteeRequest");
            } else {
                response.getWriter().write("Không thể cập nhật request, chỉ request ở trạng thái Draft mới có thể sửa.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Lỗi khi cập nhật request.");
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
        String requestId = request.getParameter("id");
        System.out.println("Request ID nhận được: " + requestId);
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
