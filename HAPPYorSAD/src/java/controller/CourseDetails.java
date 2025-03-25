/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Course;
import entity.Mentor;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.DAOCourse;
import model.DAOMentor;

/**
 *
 * @author Acer
 */
public class CourseDetails extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet responsee
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        int id = Integer.parseInt(request.getParameter("Cid"));
        DAOCourse dao = new DAOCourse();
        DAOMentor daom = new DAOMentor();
        Course course = dao.getCourseById(id);
        int countMenteeOfcourse = dao.countMenteeOfCourse(course.getId());
        course.setTotal_Mentee(countMenteeOfcourse);
        List<Mentor> list = dao.getMentorByCourseId(id);
        int countReview = 0;
        int countMentee = 0;
        for (Mentor mentor : list) {
            countReview = daom.countMentorsReviewed(mentor.getMentorId());
            countMentee = daom.countMenteesReviewed(mentor.getMentorId());
            mentor.setTotal_mentees(countReview);
            mentor.setTotal_reviews(countMentee);
        }
        int countMentorOfCourse = dao.getTotalMentorsByCourse(id);
        String majorName = dao.getCourseMajor(id);
        int majorId = course.getCourseMajorId();
        List<Course> listc = dao.getCoursesByMajor(majorId);
        ArrayList<Course> listCourseToPrint = new ArrayList<>();
        for (Course course1 : listc) {
            if (course1.getId() != course.getId()) {
                listCourseToPrint.add(course1);
            }
        }
        request.setAttribute("listAllMentorByCourse", list);
        request.setAttribute("detail", course);
//      session.setAttribute("countMenteOfCourse", countMenteOfCourse);
        request.setAttribute("countMentorOfCourse", countMentorOfCourse);
        request.setAttribute("majorName", majorName);
        request.setAttribute("listCourseToPrint", listCourseToPrint);
        request.getRequestDispatcher("view/CourseDetail.jsp").forward(request, response);

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
