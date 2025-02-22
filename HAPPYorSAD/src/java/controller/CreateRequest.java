/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Course;
import entity.Request;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import model.DAOCourse;
import model.DAORequest;


/**
 *
 * @author Acer
 */
public class CreateRequest extends HttpServlet {

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
              DAORequest dao = new DAORequest();
        DAOCourse daoCourse = new DAOCourse();
        HttpSession session = request.getSession();

        // Lấy mentorId từ request, nếu null thì mặc định -1
       String mentorIdParam = request.getParameter("mentorId");
        Integer mentorId = (Integer) session.getAttribute("mentorId");
        if (mentorIdParam != null) {
            try {
                mentorId = Integer.parseInt(mentorIdParam);
                session.setAttribute("mentorId", mentorId); // Lưu vào session
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        if (mentorId == null) {
            response.sendRedirect("view/CourseDetail.jsp");
            return;
        }
        if (mentorId != null) {
            ArrayList<Course> listCourse = daoCourse.getCourseByMentorId(mentorId);
            session.setAttribute("listAllCourse", listCourse);
        }

        // Lấy menteeId từ userId (fix cứng userId = 5, sau này lấy từ session)
        Integer menteeId = (Integer) session.getAttribute("menteeId");
        if (menteeId == null) {
            response.sendRedirect("view/LoginUser.jsp"); // Chuyển hướng đến trang đăng nhập nếu chưa có menteeId
            return;
        }

        // Lấy dữ liệu từ request
        String title = request.getParameter("title");
        String dateStr = request.getParameter("deadline_date");
        String timeStr = request.getParameter("deadline_hour");
        String content = request.getParameter("content");
        String[] courseIdsArray = request.getParameterValues("courseIds");

        // Kiểm tra null hoặc rỗng để tránh lỗi parse
        if (title == null || dateStr == null || timeStr == null || content == null) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin.");
            request.getRequestDispatcher("CRUD/CreateRequest.jsp").forward(request, response);
            return;
        }
        title = title.trim();
        content = content.trim();

        // Xử lý danh sách courseIds (có thể null)
        if (courseIdsArray == null || courseIdsArray.length == 0) {
            request.setAttribute("error", "You must select at least one course.");
            request.getRequestDispatcher("CRUD/CreateRequest.jsp").forward(request, response);
            return;
        }

        String courseIds = String.join(",", courseIdsArray);

        try {
            LocalDate deadlineDate = LocalDate.parse(dateStr.trim());
            LocalTime deadlineHour = LocalTime.parse(timeStr.trim());

            Request newRequest = new Request(menteeId, mentorId, title, deadlineDate, deadlineHour, content, courseIds);
            boolean success = dao.createRequest(newRequest);

            if (success) {
                response.sendRedirect("CreateRequest?success=true");
            } else {
                request.setAttribute("error", "Tạo request thất bại.");
                request.getRequestDispatcher("CRUD/CreateRequest.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getRequestDispatcher("CRUD/CreateRequest.jsp").forward(request, response);
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
