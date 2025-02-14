/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;


import model.DAOMentor;
import entity.Mentor1;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 *
 * @author Dell
 */
@WebServlet(name = "ViewMentors", urlPatterns = {"/viewMentor"})
public class ViewMentors extends HttpServlet {

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
     String search = request.getParameter("search");
        if (search == null) {
            search = "";
        }

        int limit = 4; // Số mentor hiển thị trên mỗi trang
        int page = 1;  // Trang mặc định là 1

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
                    page = 1; // Nếu page < 1, đặt lại giá trị mặc định
                }
            }
        } catch (NumberFormatException e) {
            System.err.println("Lỗi khi chuyển đổi page/limit: " + e.getMessage());
        }

        DAOMentor dao = new DAOMentor();
        List<Mentor1> list = dao.getAllMentors(search, page, limit);
        int totalMentors = dao.getTotalMentors(search); // Lấy tổng số mentor
        int totalPages = (int) Math.ceil((double) totalMentors / limit); // Tính tổng số trang

        HttpSession session = request.getSession();
        session.setAttribute("listMentor", list);
        session.setAttribute("currentPage", page);
        session.setAttribute("limit", limit);
        session.setAttribute("totalPages", totalPages); // Gửi tổng số trang đến session

        request.getRequestDispatcher("view/ViewMentor.jsp").forward(request, response);

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
       String mentorUserName = request.getParameter("username");
        String newStatus = request.getParameter("status");

        if (mentorUserName != null && !mentorUserName.isEmpty() && newStatus != null) {
            try {
               
                DAOMentor dao = new DAOMentor();

                dao.toggleMentorStatus(mentorUserName, newStatus);

                request.getSession().setAttribute("message", "Cập nhật trạng thái mentor thành công.");
                response.sendRedirect("viewMentor");
            } catch (NumberFormatException e) {
                e.printStackTrace();
                request.getSession().setAttribute("error", "ID mentor không hợp lệ.");
                response.sendRedirect("mentorList.jsp");
            }
        } else {
            request.getSession().setAttribute("error", "Thiếu ID mentor hoặc trạng thái.");
            response.sendRedirect("mentorList.jsp");
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
