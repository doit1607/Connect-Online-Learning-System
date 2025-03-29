/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;
import model.DAOuser;

/**
 *
 * @author admin
 */
@WebServlet(name = "UpdateMenteeProfile", urlPatterns = {"/updatementeeprofile"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
                 maxFileSize = 1024 * 1024 * 10,       // 10MB
                 maxRequestSize = 1024 * 1024 * 50)    // 50MB
public class UpdateMenteeProfile extends HttpServlet {

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
        DAOuser mente = new DAOuser();
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("usernameUser");

        User u = mente.getMenteeByUsername(username);

        request.setAttribute("mentee", u);
        request.getRequestDispatcher("/CRUD/updateMenteeProfile.jsp").forward(request, response);
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
            // Lấy dữ liệu từ form
            String username = request.getParameter("username");
            
            String fullname = request.getParameter("fullname");
            String address = request.getParameter("address");
            String gender = request.getParameter("gender");
            
            String regexName = "^[a-zA-Z]+(\\s[a-zA-Z]+)*$";

            if (!fullname.matches(regexName)) {
                request.getSession().setAttribute("errorMessage", "Wrong input update! Please input again.");
                response.sendRedirect("updatementeeprofile");
                return;
            }

            String regexAddress = "^[a-zA-Z0-9,\\.]+(\\s[a-zA-Z0-9,\\.]+)*$";
            if (!address.matches(regexAddress)) {
                request.getSession().setAttribute("errorMessage", "Wrong input update! Please input again.");
                response.sendRedirect("updatementeeprofile");
                return;
            }

            // Xử lý ngày sinh
            Date dateOfBirth = null;
            String dob = request.getParameter("dateOfBirth");
            if (dob != null && !dob.isEmpty()) {
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                dateOfBirth = formatter.parse(dob);
                Date currentDate = new Date();
                if (dateOfBirth.after(currentDate)) {
                    request.getSession().setAttribute("errorMessage", "Date of birth cannot be greater than current date.");
                    response.sendRedirect("updatementeeprofile");
                    return;
                }
            }

            // Xử lý upload avatar
            Part filePart = request.getPart("avatarFile");
            String fileUrl = (String) request.getSession().getAttribute("userAvatar");

            if (filePart != null && filePart.getSize() > 0) {
                String fileName = UUID.randomUUID().toString() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String uploadPath = getServletContext().getRealPath("/uploads");

                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();

                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);

                fileUrl = "/HAPPYorSAD/uploads/" + fileName;
                request.getSession().setAttribute("userAvatar", fileUrl);
            }
            
            // Cập nhật thông tin vào database
            DAOuser mente = new DAOuser();
            mente.updateMenteeProfile(username, fileUrl, fullname, address, dateOfBirth, gender);

            request.getSession().setAttribute("successMessage", "Profile updated successfully!");
            response.sendRedirect("updatementeeprofile");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("updatementeeprofile?error=Error updating profile");
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
