/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.CV;
import entity.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import model.DAOAcceptCV;
import model.DAOuser;
import model.DaoCV;

/**
 *
 * @author admin
 */
public class UpdateCV extends HttpServlet {

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
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("usernameUser");

        DAOuser mentor = new DAOuser();
        User u = mentor.getMentorByUsername(username);
        request.setAttribute("mentor", u);

        DaoCV dao = new DaoCV();
        CV cv = dao.getCVByUsername(username);
        request.setAttribute("cv", cv);
        request.setAttribute("selectedCourses", cv.getCourses() != null ? cv.getCourses() : new ArrayList<>());

        request.getRequestDispatcher("/CRUD/UpdateCV.jsp").forward(request, response);
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
        String username = (String) session.getAttribute("usernameUser");

        String profession = request.getParameter("profession");
        String professionIntro = request.getParameter("professionIntro");
        String serviceDescription = request.getParameter("serviceDescription");
        String achievementDescription = request.getParameter("achievementDescription");

        String[] coursesArray = request.getParameterValues("courses");
        List<String> courses = (coursesArray != null) ? Arrays.asList(coursesArray) : new ArrayList<>();

        String coursesString = String.join(", ", courses);

         if (!profession.isEmpty() && !professionIntro.isEmpty()
                && !serviceDescription.isEmpty() && !achievementDescription.isEmpty()) {

            DaoCV dao = new DaoCV();
            dao.updateCV(profession, professionIntro, courses, serviceDescription, achievementDescription, username);

            DAOAcceptCV dao1 = new DAOAcceptCV();
            String submitApproval = request.getParameter("submitApproval");
            if ("true".equalsIgnoreCase(submitApproval)) {
                dao1.updateCVStatus(username, "Pending");
                session.setAttribute("successMessage", "CV submitted for approval successfully!");
                response.sendRedirect("UpdateCV");
                return;
            }

            String cvStatus = dao.getCVStatusByUsername(username);
            session.setAttribute("cvStatus", cvStatus);
            session.setAttribute("successMessage", "Update CV successfully!");
            response.sendRedirect("UpdateCV");
        } else {
            request.setAttribute("errorMessage", "Please fill in all required fields.");
            doGet(request, response);
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
