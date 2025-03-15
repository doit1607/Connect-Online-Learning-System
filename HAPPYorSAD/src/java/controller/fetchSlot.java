package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.DAOslot;
import java.time.LocalDate; // For working with dates
import java.time.DayOfWeek;
import java.sql.Date; // For handling java.sql.Date
import model.DAOmentee_Slot;
import entity.Mentee_Slot;

public class fetchSlot extends HttpServlet {

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
            DAOmentee_Slot daoMs = new DAOmentee_Slot();
            List<Mentee_Slot> scheduleList = daoMs.getSlotsByRequestId1(requestIdd);
            for (Mentee_Slot slot : scheduleList) {
                System.out.println(slot);
            }

            out.println("<!-- Debug: Fetching slots for requestId = " + requestIdd + " -->");

            if (scheduleList == null || scheduleList.isEmpty()) {
                out.println("<p>No schedule available for this request</p>");
            } else {
                // Build HTML table with "Day of Week" column
                out.println("<table class='table table-bordered'>");
                out.println("<thead><tr><th>Date</th><th>Day of Week</th><th>Slot Number</th><th>Start Time</th><th>End Time</th><th>Status</th></tr></thead>");
                out.println("<tbody>");

                for (Mentee_Slot slot : scheduleList) {
                    // Convert java.sql.Date to LocalDate
                    Date sqlDate = (Date) slot.getSlot_date(); // Cast to java.sql.Date
                    LocalDate slotDate = sqlDate.toLocalDate(); // Convert to LocalDate
                    // Get the day of the week
                    DayOfWeek dayOfWeek = slotDate.getDayOfWeek();
                    // Format as "Monday", "Tuesday", etc.
                    String dayOfWeekStr = dayOfWeek.toString().substring(0, 1).toUpperCase()
                            + dayOfWeek.toString().substring(1).toLowerCase();

                    out.println("<tr>");
                    out.println("<td>" + slotDate + "</td>"); // Use LocalDate directly (yyyy-MM-dd format)
                    out.println("<td>" + dayOfWeekStr + "</td>"); // Day of Week
                    out.println("<td>" + slot.getSlot_number() + "</td>");
                    out.println("<td>" + slot.getStart_time() + "</td>");
                    out.println("<td>" + slot.getEnd_time() + "</td>");
                    out.println("<td>" + slot.getStatus() + "</td>");
                    out.println("</tr>");
                }

                out.println("</tbody>");
                out.println("</table>");
            }
        } catch (NumberFormatException e) {
            out.println("<p>Invalid request ID format: " + e.getMessage() + "</p>");
        } catch (Exception e) {
            out.println("<p>Error loading schedule: " + e.getMessage() + "</p>");
            e.printStackTrace(); // Log full stack trace to server logs
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
