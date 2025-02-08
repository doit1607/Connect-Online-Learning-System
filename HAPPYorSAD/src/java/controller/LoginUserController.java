package controller;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;
import entity.User;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DAOuser;

import utils.EmailUtil;

@WebServlet(name = "LoginUserController", urlPatterns = {"/LoginUser"})
public class LoginUserController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        DAOuser userDAO = new DAOuser();
        String service = request.getParameter("service");

        if ("login".equals(service)) {
            String username = request.getParameter("usernameLogin");
            String password = request.getParameter("passwordLogin");
            String rememberMe = request.getParameter("rememberMe");

            if (userDAO.loginUser(username, password)) {
                if (userDAO.checkUserActive(username)) {
                    if ("on".equals(rememberMe)) {
                        Cookie c = new Cookie("usernameUser_cookie", username);
                        c.setMaxAge(3600);
                        response.addCookie(c);
                    } else {
                        Cookie c = new Cookie("usernameUser_cookie", "");
                        c.setMaxAge(0);
                        response.addCookie(c);
                    }
                    session.setAttribute("usernameUser", username);
                    response.sendRedirect("ShowAllCourse");
                }
                else{
                    request.setAttribute("error", "Your account hasn't been activated yet. Please check your email!");
                    request.getRequestDispatcher("/view/LoginUser.jsp").forward(request, response);
                }

            } else {
                request.setAttribute("error", "Wrong username or password!!");
                request.getRequestDispatcher("/view/LoginUser.jsp").forward(request, response);
            }
            return;
        }

        if ("logout".equals(service)) {
            session.invalidate();
            response.sendRedirect("view/LoginUser.jsp");
            return;
        }

        if ("register".equals(service)) {
            EmailUtil em = new EmailUtil();
            String username = request.getParameter("usernameRegis");
            String password = request.getParameter("passwordRegis");
            String email = request.getParameter("emailRegis");
            String phone = request.getParameter("phoneRegis");
            String gender = request.getParameter("genderRegis");
            String address = request.getParameter("addressRegis");
            String fullname = request.getParameter("fullnameRegis");

            Date dateOfBirth = null;
            try {
                String dob = request.getParameter("dobRegis");
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                dateOfBirth = formatter.parse(dob);
            } catch (Exception e) {
                e.printStackTrace();
            }

            if (!userDAO.checkUsernameExist(username)) {
                if (!userDAO.checkEmailExist(email)) {

                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    String formattedDate = sdf.format(new Date());
                    java.sql.Timestamp createdAt = java.sql.Timestamp.valueOf(formattedDate);
                    User newUser = new User(null, username, fullname, password, "Inactive", email, phone, address, dateOfBirth, createdAt, gender, "mentee", false);
                    userDAO.addUser(newUser);

                    String verificationLink = "http://localhost:9999/HAPPYorSAD/LoginUser?service=activate&email=" + email;
                    em.sendVerificationEmail(email, username, verificationLink);
                    request.setAttribute("msg", "Registration successful! Check your email to activate your account.");
                    request.getRequestDispatcher("/view/LoginUser.jsp").forward(request, response);
                } else {
                    String verificationLink = "http://localhost:9999/HAPPYorSAD/LoginUser?service=activate&email=" + email;
                    em.sendVerificationEmail(email, username, verificationLink);
                    request.setAttribute("msgemail", "The email already exists but has not been activated. Please check your email to activate your account!");
                    request.getRequestDispatcher("/view/RegisterUser.jsp").forward(request, response);

                }

            } else {
                request.setAttribute("msgusername", "Username already exists!");
                request.getRequestDispatcher("/view/RegisterUser.jsp").forward(request, response);
            }
            return;
        }

        if ("activate".equals(service)) {
            String email = request.getParameter("email");
            if (!userDAO.isActivationExpired(email)) {
                if (userDAO.activateUser(email)) {
                    request.setAttribute("msg", "Account verified successfully! You can now log in.");
                } else {
                    request.setAttribute("error", "Invalid or expired verification link!");
                }
                request.getRequestDispatcher("/view/LoginUser.jsp").forward(request, response);
                return;
            } else {
                userDAO.deleteUserByEmail(email);
                request.setAttribute("error", "Invalid or expired verification link!");
                request.getRequestDispatcher("/view/LoginUser.jsp").forward(request, response);
            }

        }

        if ("changepass".equals(service)) {
            String username = (String)session.getAttribute("usernameUser");
            String oldPassword = request.getParameter("oldPassword");
            String newPassword = request.getParameter("newPassword");

            if (userDAO.loginUser(username, oldPassword)) {
                userDAO.updatePassword(username, newPassword);
                request.setAttribute("msg", "Password changed successfully!");
                request.getRequestDispatcher("/view/LoginUser.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Incorrect old password!");
                request.getRequestDispatcher("/view/changePassword.jsp").forward(request, response);
            }
        }
    }

}
