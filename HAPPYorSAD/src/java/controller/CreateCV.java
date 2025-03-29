/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import model.DAOuser;
import model.DaoCV;

/**
 *
 * @author admin
 */
public class CreateCV extends HttpServlet {

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
        DAOuser mentor = new DAOuser();
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("usernameUser");
        User u = mentor.getMentorByUsername(username);

        request.setAttribute("mentor", u);

        request.getRequestDispatcher("/CRUD/CreateCV.jsp").forward(request, response);
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
        List<String> courses = (coursesArray != null) ? Arrays.asList(coursesArray) : null;

        if (profession != null && !profession.isEmpty()
                && professionIntro != null && !professionIntro.isEmpty()
                && serviceDescription != null && !serviceDescription.isEmpty()
                && achievementDescription != null && !achievementDescription.isEmpty()) {

            DaoCV dao = new DaoCV();
            dao.createCV(profession, professionIntro, courses, serviceDescription, achievementDescription, username);

            String cvSta = dao.getCVStatusByUsername(username);
            session.setAttribute("cvStatus", cvSta);

            session.setAttribute("successMessage", "CV created successfully!");
            request.getRequestDispatcher("/Dashboard/DashboardMentorProfile.jsp").forward(request, response);
            return;
        }

        //session.setAttribute("cvStatus", "rejected");
        request.setAttribute("errorMessage", "Please fill in all required fields.");
        request.setAttribute("profession", profession);
        request.setAttribute("professionIntro", professionIntro);
        request.setAttribute("serviceDescription", serviceDescription);
        request.setAttribute("achievementDescription", achievementDescription);

        request.getRequestDispatcher("/CRUD/CreateCV.jsp").forward(request, response);
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
