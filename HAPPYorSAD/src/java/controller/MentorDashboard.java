/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import entity.Course;
import entity.MentorReview;
import entity.Request;
import entity.Transaction;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import model.DAOCourse;
import model.DAORateMentor;
import model.DAORequest;
import model.TransactionDAO;

/**
 *
 * @author admin
 */
@WebServlet(name="MentorDashboard", urlPatterns={"/MentorDashboard"})
public class MentorDashboard extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        DAOCourse dAOCourse = new DAOCourse();
        DAORequest dAORequest = new DAORequest();
        DAORateMentor dAORateMentor =  new DAORateMentor();
        TransactionDAO dAOTransaction = new TransactionDAO();
        
        
        HttpSession session = request.getSession();
        String mentorUsername = (String)session.getAttribute("usernameUser");
        List<Course> myCourses = dAOCourse.getCourseByMentor(mentorUsername);
                int courseOpen = dAORequest.getRequestCount(mentorUsername, null, "Open", null);
                int courseClosed = dAORequest.getRequestCount(mentorUsername, null, "Closed", null);
                int courseProcessing = dAORequest.getRequestCount(mentorUsername, null, "Processing", null);
                int courseCanceled = dAORequest.getRequestCount(mentorUsername, null, "Canceled", null);


        Double balance = dAOTransaction.getBalance(mentorUsername);
        Double earning = dAORequest.getTotalReceivedAmountByMentor(mentorUsername)*0.8;
        int requestCompleted = dAORequest.getRequestCount(mentorUsername, "", "Closed", null);
        List<MentorReview> reviews = dAORateMentor.getReviewsByMentor(mentorUsername);
//                request.setAttribute("username", mentorUsername);
double totalRating = reviews.stream().mapToInt(MentorReview::getRating).sum();
double averageRating = reviews.isEmpty() ? 0 : totalRating / reviews.size();

String formattedRating = String.format("%.1f", averageRating);

        Map<Integer, Integer> starCount = new HashMap<>();
for (int i = 1; i <= 5; i++) {
    starCount.put(i, 0); // Khởi tạo với 0
}

// Đếm số lượng đánh giá theo số sao
for (MentorReview review : reviews) {
    starCount.put(review.getRating(), starCount.get(review.getRating()) + 1);
}

// Tính phần trăm
int totalReviews = reviews.size();
Map<Integer, Double> starPercentage = new HashMap<>();
for (int i = 1; i <= 5; i++) {
    double percentage = (totalReviews > 0) ? (starCount.get(i) * 100.0 / totalReviews) : 0;
    starPercentage.put(i, percentage);
}

request.setAttribute("starPercentage", starPercentage);
request.setAttribute("averageRating", formattedRating);
                request.setAttribute("reviews", reviews);

        request.setAttribute("balance", balance);
        request.setAttribute("earning", earning);
                request.setAttribute("requestCompleted", requestCompleted);

        request.setAttribute("myCourses", myCourses);
        
        
        // Dữ liệu cho biểu đồ cột (Bar Chart)
        List<String> barLabels = Arrays.asList("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");
        List<Integer> barDataLastYear = dAORequest.getRequestByYear(mentorUsername, 2024);
        List<Integer> barDataThisYear = dAORequest.getRequestByYear(mentorUsername, 2025);

        // Dữ liệu cho biểu đồ tròn (Pie Chart)
        List<String> pieLabels = Arrays.asList("Completed", "In Progress", "Opening", "Rejected");
        List<Integer> pieData = Arrays.asList(courseClosed, courseProcessing, courseOpen, courseCanceled);

        String pieLabelsJson = "[" + String.join(",", pieLabels.stream().map(s -> "\"" + s + "\"").toList()) + "]";
        String pieDataJson = "[" + pieData.stream().map(String::valueOf).collect(Collectors.joining(",")) + "]";
        String barLabelsJson = "[" + String.join(",", barLabels.stream().map(s -> "\"" + s + "\"").toList()) + "]";
        String barDataLastYearJson = "[" + barDataLastYear.stream().map(String::valueOf).collect(Collectors.joining(",")) + "]";
        String barDataThisYearJson = "[" + barDataThisYear.stream().map(String::valueOf).collect(Collectors.joining(",")) + "]";

        // Set dữ liệu vào request
        request.setAttribute("barLabels", barLabelsJson);
        request.setAttribute("barDataLastYear", barDataLastYearJson);
        request.setAttribute("barDataThisYear", barDataThisYearJson);
        request.setAttribute("pieLabels", pieLabelsJson);
        request.setAttribute("pieData", pieDataJson);


        
        
        
        request.getRequestDispatcher("view/mentorDashboard.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
