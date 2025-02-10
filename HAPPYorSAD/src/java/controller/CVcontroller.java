/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.CV;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.util.Vector;
import model.DAOCV;

/**
 *
 * @author admin
 */
@WebServlet(name = "CVcontroller", urlPatterns = {"/CVURL"})
public class CVcontroller extends HttpServlet {

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
        DAOCV dao = new DAOCV();
        try (PrintWriter out = response.getWriter()) {
            String service = request.getParameter("service");

            if (service.equals("updateCV")) {
                String submit = request.getParameter("submit");
                if (submit == null) { // show insert form
                    int id = Integer.parseInt(request.getParameter("id"));
                    String sql = "SELECT * FROM CV where id = " + id;
                    Vector<CV> vector = dao.getCV(sql);
                    request.setAttribute("vector", vector);
                    request.getRequestDispatcher("/CRUD/updateCV.jsp").forward(request, response);
                } else {
                    // if (submit != null) { // insert data into Database
                    //getdata
                    String id = request.getParameter("id");
                    String userId = request.getParameter("userId");
                    String filePath = request.getParameter("filePath");
                    String status = request.getParameter("status");
                    String validFrom = request.getParameter("validFrom");
                    String validUntil = request.getParameter("validUntil");
                    String createdAt = request.getParameter("createdAt");
                    String updatedAt = request.getParameter("updatedAt");
                    //check data
                    if (id.equals("")) {
                        out.println("CV_ID is empty");
                    }
                    Vector<CV> vector = dao.getCV("select * from CV where id =" + id);
                    if (vector.size() > 0) {
                        out.print("CV_ID is duplicate");
                    }
                    //convert
                    int iD = Integer.parseInt(id);
                    int userID = Integer.parseInt(userId);
                    LocalDate validF = LocalDate.parse(request.getParameter("validFrom"));
                    LocalDate validU = LocalDate.parse(request.getParameter("validUntil"));
                    LocalDate createA = LocalDate.parse(request.getParameter("createdAt"));
                    LocalDate updateA = LocalDate.parse(request.getParameter("updatedAt"));
                    CV cv = new CV(iD, userID, filePath, status, validF, validU, createA, updateA);
                    int n = dao.updateCV(cv);
                    response.sendRedirect("CVURL?service=listAllCV");
                }
            }

            if (service.equals("addCV")) {
                String submit = request.getParameter("submit");
                if (submit == null) { // show insert form
                    request.getRequestDispatcher("/CRUD/addCV.jsp").forward(request, response);
                } else {
                    // if (submit != null) { // insert data into Database
                    //getdata
                    String id = request.getParameter("id");
                    String userId = request.getParameter("userId");
                    String filePath = request.getParameter("filePath");
                    String status = request.getParameter("status");
                    String validFrom = request.getParameter("validFrom");
                    String validUntil = request.getParameter("validUntil");
                    String createdAt = request.getParameter("createdAt");
                    String updatedAt = request.getParameter("updatedAt");
                    //check data
                    if (id.equals("")) {
                        out.println("CV_ID is empty");
                    }
                    Vector<CV> vector = dao.getCV("select * from CV where id=" + id);
                    if (vector.size() > 0) {
                        out.print("CV_ID is duplicate");
                    }
                    //convert
                    int iD = Integer.parseInt(id);
                    int userID = Integer.parseInt(userId);
                    LocalDate validF = LocalDate.parse(request.getParameter("validFrom"));
                    LocalDate validU = LocalDate.parse(request.getParameter("validUntil"));
                    LocalDate createA = LocalDate.parse(request.getParameter("createdAt"));
                    LocalDate updateA = LocalDate.parse(request.getParameter("updatedAt"));
                    CV cv = new CV(iD, userID, filePath, status, validF, validU, createA, updateA);
                    int n = dao.addCV(cv);
                    response.sendRedirect("CVURL?service=listAllCV");
                }
            }

            if (service.equals("listAllCV")) { // request from view
                // call model
                String sql = "SELECT * FROM CV";
                String submit = request.getParameter("submit");
                Vector<CV> vector = dao.getCV(sql);
                // select view: jsp
                RequestDispatcher dispath
                        = request.getRequestDispatcher("view/listCV.jsp");
                request.setAttribute("listCV", vector);
                request.setAttribute("titlePage", "CVManage");
                // run
                dispath.forward(request, response);
            }
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
