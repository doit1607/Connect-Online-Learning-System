/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Course;
import entity.Major;
import entity.Mentee;
import entity.Mentor;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.DAOCourse;
import model.DAOMenteeStatistic;
import model.DAOMentor;
import model.DAOmajor;
import model.DAOMentor;

/**
 *
 * @author Ann
 */
public class Home extends HttpServlet {

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
        // Category course
        DAOmajor daoM = new DAOmajor();
        DAOMentor daoMe = new DAOMentor();
        DAOMenteeStatistic daoMentee = new DAOMenteeStatistic();
        List<Major> listM = daoM.getMajorHome();
        HttpSession session = request.getSession();
        session.setAttribute("listMajor", listM);

        // Feature course
        DAOCourse daoC = new DAOCourse();
        List<Course> listC = daoC.getAllCourseHome();
        List<Course> listT = daoC.getAllCourseHome2();
        List<Mentor> listMe = daoMe.getMentorsHome();
        List<Course> listCountC = daoC.getCountCourseHome();
        List<Mentor> listCountMentor = daoMe.getCount();
        List<Mentee> listCountMentee = daoMentee.getCount();
        //Count course and menteees
        System.out.println("Hello");

        session.setAttribute("listFCourse", listC);
        session.setAttribute("listTCourse", listT);
        System.out.println("Check1");
        session.setAttribute("listMentor", listMe);
        session.setAttribute("listCountC", listCountC);
        session.setAttribute("listCountMentor", listCountMentor);
        session.setAttribute("listCountMentee", listCountMentee);
        request.getRequestDispatcher("Home/HomePage.jsp").forward(request, response);

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
