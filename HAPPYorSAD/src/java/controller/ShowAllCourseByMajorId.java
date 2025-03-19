/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Course;
import entity.Major;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.DAOCourse;
import model.DAOmajor;

/**
 *
 * @author Acer
 */
public class ShowAllCourseByMajorId extends HttpServlet {

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
        DAOCourse dao = new DAOCourse();
        DAOmajor daoM = new DAOmajor();
        int majorId = Integer.parseInt(request.getParameter("Mid"));
        List<Major> listAllMaojor = daoM.getListAllMajor();
        request.setAttribute("listAllMaojor", listAllMaojor);
        List<Course> listCourseByMajorId = daoM.getListAllCourseByMajorId(majorId);
        int countMentee = 0;
        int getTotalMentorsByCourse = 0;
        for (Course course : listCourseByMajorId) {
            countMentee = dao.countMenteeOfCourse(course.getId());
            getTotalMentorsByCourse = dao.getTotalMentorsByCourse(course.getId());
            course.setTotal_Mentee(countMentee);
            course.setTotal_Mentor(getTotalMentorsByCourse);
        }
        request.setAttribute("listAllCousre", listCourseByMajorId);
        request.setAttribute("tagg", majorId);
        request.getRequestDispatcher("view/Course.jsp").forward(request, response);
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
