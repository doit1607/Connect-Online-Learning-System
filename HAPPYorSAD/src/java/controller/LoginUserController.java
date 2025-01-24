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
        HttpSession s = request.getSession();
        DAOuser u = new DAOuser();
        String login = request.getParameter("login");
        String rememberMe = request.getParameter("rememberMe");
        String logout = request.getParameter("logout");
        String register = request.getParameter("register");
        String usernameLogin = request.getParameter("usernameLogin");
        String passwordLogin = request.getParameter("passwordLogin");
        if (login != null) {
            boolean checkLogin = u.loginUser(usernameLogin, passwordLogin);
            if (checkLogin == true) {
                if (rememberMe != null) {
                    Cookie c = new Cookie("usernameUser_cookie", usernameLogin);
                    c.setMaxAge(3600);
                    response.addCookie(c);
                } else {
                    Cookie c = new Cookie("usernameUser_cookie", "");
                    c.setMaxAge(0);
                    response.addCookie(c);
                }
                s.setAttribute("usernameUser", usernameLogin);
                request.getRequestDispatcher("sourcesHome/homeDetail.jsp").forward(request, response);
            } else {
                String error = "Wrong username or password!!";
                request.setAttribute("error", error);
                request.getRequestDispatcher("LoginUser.jsp").forward(request, response);
            }
            return;
        }
        if ("out".equals(logout)) {
            s.invalidate();
            request.getRequestDispatcher("LoginUser.jsp").forward(request, response);
            return;
        }
        if ("out".equals(register)) {
            String usernameRegis = request.getParameter("usernameRegis");
            String passwordRegis = request.getParameter("passwordRegis");
            String emailRegis = request.getParameter("emailRegis");
            String phoneRegis = request.getParameter("phoneRegis");

            Date dateOfBirth = null;
            Date createAt = new Date(System.currentTimeMillis());

            try {
                String dateString = request.getParameter("dateofbirthRegis");
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
                java.util.Date utilDate = formatter.parse(dateString);
                dateOfBirth = new Date(utilDate.getTime());
            } catch (Exception e) {
                e.printStackTrace();
            }

            String status = "Active";
            String avatar_path = request.getParameter("avatarRegis");
            String genderRegis = request.getParameter("genderRegis");
            String role = "User";
            Boolean is_guest = false;
            Boolean userExist = u.checkUsernameExist(usernameRegis);
            if (!userExist) {
                User user = new User(usernameRegis, avatar_path, passwordRegis, status, emailRegis, phoneRegis, dateOfBirth, role, createAt, role, is_guest);
                u.addUser(user);
                String msg = "Register Successfully!!";
                request.setAttribute("msg", msg);
                request.getRequestDispatcher("LoginUser.jsp").forward(request, response);
            } else {
                String msg = "Username Already Exist!!";
                request.setAttribute("msg", msg);
                request.getRequestDispatcher("registerUser.jsp").forward(request, response);
            }
        }
        return;
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
    
