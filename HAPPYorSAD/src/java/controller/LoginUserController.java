/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import model.DAOuser;

/**
 *
 * @author admin
 */
@WebServlet(name = "ChangePassController", urlPatterns = {"/LoginUser"})
public class LoginUserController extends HttpServlet {

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
            doPost(request, response);
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
        doPost(request, response);
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
        HttpSession session = request.getSession();
        DAOuser userDAO = new DAOuser();

        String service = request.getParameter("service");

        if ("login".equals(service)) {
            String usernameLogin = request.getParameter("usernameLogin");
            String passwordLogin = request.getParameter("passwordLogin");
            String rememberMe = request.getParameter("rememberMe");

            if (userDAO.loginUser(usernameLogin, passwordLogin)) {
                if ("on".equals(rememberMe)) {
                    Cookie c = new Cookie("usernameUser_cookie", usernameLogin);
                    c.setMaxAge(3600);
                    response.addCookie(c);
                } else {
                    Cookie c = new Cookie("usernameUser_cookie", "");
                    c.setMaxAge(0);
                    response.addCookie(c);
                }
                session.setAttribute("usernameUser", usernameLogin);
                request.getRequestDispatcher("/sourcesHome/homeDetail.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Wrong username or password!!");
                request.getRequestDispatcher("/view/LoginUser.jsp").forward(request, response);
            }
            return;
        }

        if ("logout".equals(service)) {
            session.invalidate();
            response.sendRedirect("/view/LoginUser.jsp");
            return;
        }

        if ("register".equals(service)) {
            String usernameRegis = request.getParameter("usernameRegis");
            String passwordRegis = request.getParameter("passwordRegis");
            String emailRegis = request.getParameter("emailRegis");
            String phoneRegis = request.getParameter("phoneRegis");
            String genderRegis = request.getParameter("genderRegis");
            String addressRegis = request.getParameter("addressRegis");
            String fullnameRegis = request.getParameter("fullnameRegis");

            Date dateOfBirth = null;
            try {
                String dateString = request.getParameter("dobRegis");
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date utilDate = formatter.parse(dateString);
                dateOfBirth = new Date(utilDate.getTime());
            } catch (Exception e) {
                e.printStackTrace();
            }

            String avatar_path = null;

            if (!userDAO.checkUsernameExist(usernameRegis)) {
                User newUser = new User(avatar_path, usernameRegis, fullnameRegis, passwordRegis, "Active", emailRegis, phoneRegis, emailRegis, dateOfBirth, new Date(), genderRegis, "mentee", false);
                userDAO.addUser(newUser);
                request.setAttribute("msg", "Register Successfully!!");
                request.getRequestDispatcher("/view/LoginUser.jsp").forward(request, response);
            } else {
                request.setAttribute("msg", "Username Already Exist!!");
                request.getRequestDispatcher("/view/RegisterUser.jsp").forward(request, response);
            }
            return;
        }

        if ("changepass".equals(service)) {
            String username = request.getParameter("username");
            String oldPassword = request.getParameter("oldPassword");
            String newPassword = request.getParameter("newPassword");

            if (userDAO.loginUser(username, oldPassword)) {
                userDAO.UpdatePassword(username, newPassword);
                request.setAttribute("msg", "Password changed successfully!");
                request.getRequestDispatcher("/view/LoginUser.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Incorrect old password!");
                request.getRequestDispatcher("/view/changePassword.jsp").forward(request, response);
            }
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
