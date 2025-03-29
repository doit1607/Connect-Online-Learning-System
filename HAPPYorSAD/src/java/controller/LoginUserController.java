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
import java.security.SecureRandom;
import model.DAORateMentor;
import model.DAORequest;
import model.DAOuser;
import model.DaoCV;
import model.TransactionDAO;

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
        DaoCV userCV = new DaoCV();
        DAORateMentor dao = new DAORateMentor();
        DAORequest daoRequest = new DAORequest();
        TransactionDAO userwallet = new TransactionDAO();
        String service = request.getParameter("service");

        if ("login".equals(service)) {

            String username = request.getParameter("usernameLogin");
            String password = request.getParameter("passwordLogin");
            String rememberMe = request.getParameter("rememberMe");
            String requestStatus = dao.getRequestStatusByMentee(username);
            String avatar = userDAO.getAvatarPath(username);
            int userId = userDAO.getUserIdByUsername(username);
            session.setAttribute("userId", userId);
            int menteeId = daoRequest.getMenteeIdByUserId(userId);
            session.setAttribute("menteeId", menteeId);
            int mentorId = daoRequest.getMentorIdByUserId(userId);
            session.setAttribute("mentorId", mentorId);
            session.setAttribute("userAvatar", avatar);
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
                    String role = userDAO.getRole(username);
                    if (role.equalsIgnoreCase("Mentor")) {
                        session.setAttribute("usernameUser", username);
                        session.setAttribute("usernameRole", role);
                        session.setAttribute("cvStatus", userCV.getCVStatusByUsername(username));
                        session.setAttribute("walletBalance", userwallet.getBalance(username));
                        session.setAttribute("walletTotalbalance", userwallet.getTotalBalance(username));
                        session.setAttribute("userEmail", userDAO.getEmail(username));
                        response.sendRedirect("ProfileServlet");
                    }
                    if (role.equalsIgnoreCase("Mentee")) {
                        session.setAttribute("usernameUser", username);
                        session.setAttribute("usernameRole", role);
                        session.setAttribute("menteeRequestStatus", requestStatus);
                        session.setAttribute("cvStatus", userCV.getCVStatusByUsername(username));
                        session.setAttribute("walletBalance", userwallet.getBalance(username));
                        session.setAttribute("walletTotalbalance", userwallet.getTotalBalance(username));
                        session.setAttribute("userEmail", userDAO.getEmail(username));

                        response.sendRedirect("Home");
                    }
                    if (role.equalsIgnoreCase("Manager")) {
                        session.setAttribute("usernameUser", username);
                        session.setAttribute("usernameRole", role);
                        session.setAttribute("walletBalance", userwallet.getBalance(username));
                        session.setAttribute("walletTotalbalance", userwallet.getTotalBalance(username));
                        session.setAttribute("userEmail", userDAO.getEmail(username));

                        response.sendRedirect("Manager");
                    }
                } else {
                    request.setAttribute("error", "Your account hasn't activated yet. Please check your email!");
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
            String role = request.getParameter("roleRegis");
            String dobString = request.getParameter("dobRegis");

            String specialCharPattern = "^[a-zA-Z0-9]*$";
            String emailPattern = "^[A-Za-z0-9+_.-]+@(.+)$";
            String phonePattern = "^0[0-9]{9}$";
            String passwordPattern = "^(?=.*[A-Z]).{8,}$";
            Date dateOfBirth = null;
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            try {
                if (dobString != null && !dobString.isEmpty()) {
                    dateOfBirth = formatter.parse(dobString);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            request.setAttribute("usernameRegis", username);
            request.setAttribute("passwordRegis", password);
            request.setAttribute("emailRegis", email);
            request.setAttribute("phoneRegis", phone);
            request.setAttribute("genderRegis", gender);
            request.setAttribute("addressRegis", address);
            request.setAttribute("fullnameRegis", fullname);
            request.setAttribute("roleRegis", role);
            if (dateOfBirth != null) {
                request.setAttribute("dobRegis", formatter.format(dateOfBirth));
            } else {
                request.setAttribute("dobRegis", dobString);
            }

            if (!username.matches(specialCharPattern)) {
                request.setAttribute("msgusername", "Username must not contain special characters!");
                request.getRequestDispatcher("/view/RegisterUser.jsp").forward(request, response);
                return;
            }
            if (!password.matches(passwordPattern)) {
                request.setAttribute("msgpassword", "Password must have at least 1 uppercase letter and be at least 8 characters long!");
                request.getRequestDispatcher("/view/RegisterUser.jsp").forward(request, response);
                return;
            }
            if (!fullname.matches("^[a-zA-Z\\s]*$")) {
                request.setAttribute("msgfullname", "Full name must not contain special characters!");
                request.getRequestDispatcher("/view/RegisterUser.jsp").forward(request, response);
                return;
            }
            if (address != null && !address.matches("^[a-zA-Z0-9\\s]*$")) {
                request.setAttribute("msgaddress", "Address must not contain special characters!");
                request.getRequestDispatcher("/view/RegisterUser.jsp").forward(request, response);
                return;
            }

            if (username.equals(email)) {
                request.setAttribute("msgusername", "Username cannot be the same as email!");
                request.getRequestDispatcher("/view/RegisterUser.jsp").forward(request, response);
                return;
            }

            if (!email.matches(emailPattern)) {
                request.setAttribute("msgemail", "Invalid email format!");
                request.getRequestDispatcher("/view/RegisterUser.jsp").forward(request, response);
                return;

            }

            if (!phone.matches(phonePattern)) {
                request.setAttribute("msgphone", "Phone number must be 10 digits starting with 0!");
                request.getRequestDispatcher("/view/RegisterUser.jsp").forward(request, response);
                return;
            }
            if (userDAO.checkPhoneExist(phone)) {
                request.setAttribute("msgphone", "Phone number already exists!");
                request.getRequestDispatcher("/view/RegisterUser.jsp").forward(request, response);
                return;
            }

            if (!userDAO.checkUsernameExist(username)) {
                if (!userDAO.checkEmailExist(email)) {

                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    String formattedDate = sdf.format(new Date());
                    java.sql.Timestamp createdAt = java.sql.Timestamp.valueOf(formattedDate);
                    User newUser = new User(null, username, fullname, password, "Inactive", email, phone, address, dateOfBirth, createdAt, gender, role, false);
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
            String username = request.getParameter("currentusername");
            String currentpassword = request.getParameter("currentpassword");
            String newPassword = request.getParameter("newpassword");

            if (userDAO.loginUser(username, currentpassword)) {
                if (!currentpassword.equals(newPassword)) {
                    userDAO.updatePassword(username, newPassword);
                    request.setAttribute("msg", "Password changed successfully!");
                    request.getRequestDispatcher("/view/LoginUser.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Old password same with new password.Please input again!");
                    request.getRequestDispatcher("/view/ChangePassword.jsp").forward(request, response);
                }

            } else {
                request.setAttribute("error", "Incorrect old password!");
                request.getRequestDispatcher("/view/ChangePassword.jsp").forward(request, response);
            }
        }

        if ("resetpassword".equals(service)) {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            if (userDAO.checkUsernameandEmail(username, email)) {
                String newPassword = generateRandomPassword();
                userDAO.updatePassword(username, newPassword);
                EmailUtil em = new EmailUtil();
                em.sendResetPassword(email, username, newPassword);
                request.setAttribute("msg", "A new password has been sent to your email.");
                request.getRequestDispatcher("/view/LoginUser.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Invalid username or email!");
                request.getRequestDispatcher("/view/ResetPassword.jsp").forward(request, response);
            }
        }
    }

    public String generateRandomPassword() {
        String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@#$%";
        int PASSWORD_LENGTH = 10;
        SecureRandom random = new SecureRandom();
        StringBuilder password = new StringBuilder(PASSWORD_LENGTH);

        for (int i = 0; i < PASSWORD_LENGTH; i++) {
            int index = random.nextInt(CHARACTERS.length());
            password.append(CHARACTERS.charAt(index));
        }
        return password.toString();
    }

}
