package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.List;
import model.DAORequest;
import model.DAOslot;
import entity.Slot;

@WebServlet("/FetchSlotsForRequest") // Map the servlet to this URL
public class FetchSlotsForRequest extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String requestId = request.getParameter("requestId");
            if (requestId == null || requestId.isEmpty()) {
                out.println("<p>No request ID provided</p>");
                return;
            }

            int requestIdd = Integer.parseInt(requestId);
            DAOslot dao = new DAOslot();
            // Assuming you have a method to get schedule details
            // Replace this with your actual schedule retrieval logic
            List<entity.Slot> scheduleList = dao.getSlotsByRequestId1(2);
            
            System.out.println("HElllooo");
            if (scheduleList == null || scheduleList.isEmpty()) {
                out.println("<p>No schedule available for this request</p>");
            } else {
                // Build HTML table for schedule
                out.println("<table class='table table-bordered'>");
                out.println("<thead><tr><th>Date</th><th>Time</th><th>Slot</th></tr></thead>");
                out.println("<tbody>");

                for (Slot Slot : scheduleList) {
                    out.println("<tr>");
                    out.println("<td>" + Slot.getSlotDate()+ "</td>");
                    out.println("<td>" + Slot.getSlotNumber()+ "</td>");
                    out.println("<td>" + Slot.getStartTime()+ "</td>");
                     out.println("<td>" + Slot.getEndTime()+ "</td>");
                    out.println("<td>" + Slot.getStatus()+ "</td>");
                    out.println("</tr>");
                }

                out.println("</tbody>");
                out.println("</table>");
            }
        } catch (NumberFormatException e) {
            out.println("<p>Invalid request ID format</p>");
        } catch (Exception e) {
            out.println("<p>Error loading schedule: " + e.getMessage() + "</p>");
        } finally {
            out.close();
        }
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
        return "Fetches schedule slots for a specific request";
    }
}

