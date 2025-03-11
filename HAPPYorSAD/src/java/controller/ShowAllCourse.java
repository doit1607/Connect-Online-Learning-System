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
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

import java.util.List;
import model.DAOCourse;
import model.DAOmajor;

/**
 *
 * @author Acer
 */
public class ShowAllCourse extends HttpServlet {

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
        DAOCourse dao = new DAOCourse();
        DAOmajor daoM = new DAOmajor();
//        List<Course> listAllCousre = dao.getAllCourseOrderByName();
        String searchKeyword = request.getParameter("txt");

        if (searchKeyword != null && !searchKeyword.isEmpty()) {
 
            List<Course> searchResults = dao.searchCourseByTitle(searchKeyword);
            request.setAttribute("listAllCousre", searchResults);
        } else {
            String indexPage = request.getParameter("index");
            if (indexPage == null) {
                indexPage = "1";
            }
            int index = Integer.parseInt(indexPage);

            int count = dao.getTotalCourse();
            int endPage = count / 2;
            if (count % 2 != 0) {
                endPage++;
            }

            List<Course> listAllCousre = dao.pagingCourse(index);
            int id = 0;
            for (Course course : listAllCousre) {
                id = course.getId();
            }
            int countMentorOfCourse = dao.getTotalMentorsByCourse(id);

            request.setAttribute("endPage", endPage);
            request.setAttribute("tag", index);
            request.setAttribute("countMentorOfCourse", countMentorOfCourse);
            request.setAttribute("listAllCousre", listAllCousre);
        }

        List<Major> listAllMajor = daoM.getListAllMajor();
        request.setAttribute("listAllMaojor", listAllMajor);

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
        //        int majorId = Integer.parseInt(request.getParameter("Mid"));
        //        List<Course> listCourseByMajorId = daoM.getListAllCourseByMajorId(majorId);
        //        request.setAttribute("listCourseByMajorId", listCourseByMajorId);

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
