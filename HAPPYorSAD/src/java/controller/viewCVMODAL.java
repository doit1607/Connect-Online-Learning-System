/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.CV;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.logging.Logger;
import java.util.logging.Level;
import model.DAOuser;
import model.DaoCV;

/**
 *
 * @author Ann
 */
public class viewCVMODAL extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(viewCVMODAL.class.getName());

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        LOGGER.log(Level.INFO, "Processing request in viewCVMODAL servlet");

        // Lấy mentorId từ request parameter
        String mentorIdStr = request.getParameter("mentorId");
        if (mentorIdStr == null || mentorIdStr.isEmpty()) {
            LOGGER.log(Level.WARNING, "No mentorId provided in request");
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Mentor ID is required");
            return;
        }

        int mentorId;
        try {
            mentorId = Integer.parseInt(mentorIdStr);
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid mentorId format: {0}", mentorIdStr);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Mentor ID format");
            return;
        }
        LOGGER.log(Level.INFO, "Mentor ID retrieved from request: {0}", mentorId);

        // Lấy thông tin mentor để lấy username
        DAOuser mentorDao = new DAOuser();
        User u = mentorDao.getMentorById2(mentorId); // Giả sử có phương thức getMentorById
        if (u == null) {
            LOGGER.log(Level.SEVERE, "Mentor not found for ID: {0}", mentorId);
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Mentor not found");
            return;
        }
        LOGGER.log(Level.INFO, "Mentor retrieved: {0}", u.getUsername());
        request.setAttribute("mentor", u);

        // Sử dụng username để lấy CV
        DaoCV dao = new DaoCV();
        String username = u.getUsername();
        CV cv = dao.getCVByUsername(username); // Thay đổi từ getCVByMentorId sang getCVByUsername
        if (cv == null) {
            LOGGER.log(Level.INFO, "No CV found for username: {0}, creating empty CV", username);
            cv = new CV();
        } else {
            LOGGER.log(Level.INFO, "CV retrieved for username: {0}", username);
        }
        request.setAttribute("cv", cv);

        // Log danh sách courses
        request.setAttribute("selectedCourses", cv.getCourses() != null ? cv.getCourses() : new ArrayList<>());

        LOGGER.log(Level.INFO, "Forwarding to /view/cvMODAL.jsp");
        request.getRequestDispatcher("/view/cvMODAL.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet to view mentor CV in modal";
    }
}
