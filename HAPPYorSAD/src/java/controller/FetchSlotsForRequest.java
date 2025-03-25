package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.DAOslot;
import java.time.LocalDate;
import java.time.DayOfWeek;
import java.sql.Date;
import model.DAOmentee_Slot;
import entity.Mentee_Slot;

public class FetchSlotsForRequest extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String method = request.getMethod();

        try {
            if ("DELETE".equalsIgnoreCase(method)) {
                handleDelete(request, response, out);
            } else {
                handleGet(request, response, out);
            }
        } finally {
            out.close();
        }
    }

    private void handleGet(HttpServletRequest request, HttpServletResponse response, PrintWriter out)
            throws ServletException, IOException {
        try {
            String requestId = request.getParameter("requestId");
            String currentMenteeIdd = request.getParameter("menteeId"); // Lấy từ request hoặc session

            int currentMenteeId = Integer.parseInt(currentMenteeIdd);
            if (requestId == null || requestId.isEmpty()) {
                out.println("<p>No request ID provided</p>");
                return;
            }

            int requestIdd = Integer.parseInt(requestId);
            DAOslot dao = new DAOslot();
            DAOmentee_Slot daoMs = new DAOmentee_Slot();
            List<Mentee_Slot> scheduleList = daoMs.getSlotsByRequestId1(requestIdd);
            for (Mentee_Slot slot : scheduleList) {
                System.out.println("Hello1: " + slot);
            }

            out.println("<!-- Debug: Fetching slots for requestId = " + requestIdd + " -->");

            if (scheduleList == null || scheduleList.isEmpty()) {
                out.println("<p>No schedule available for this request</p>");
            } else {
                // Build HTML table with "Note" column
                out.println("<table class='table table-bordered'>");
                out.println("<thead>"
                        + "<tr>"
                        + "<th>Day</th>"
                        + "<th>Date</th>"
                        + "<th>Month</th>"
                        + "<th>Year</th>"
                        + "<th>Slot</th>"
                        + "<th>Start Time</th>"
                        + "<th>End Time</th>"
                        + "<th>Status</th>"
                        + "<th>Note</th>"
                        + "</tr></thead>");
                out.println("<tbody>");

                for (Mentee_Slot slot : scheduleList) {
                    Date sqlDate = (Date) slot.getSlot_date();
                    LocalDate slotDate = sqlDate.toLocalDate();

                    DayOfWeek dayOfWeek = slotDate.getDayOfWeek();
                    String dayOfWeekStr = dayOfWeek.toString().substring(0, 1).toUpperCase()
                            + dayOfWeek.toString().substring(1).toLowerCase();

                    int day = slotDate.getDayOfMonth();
                    String month = slotDate.getMonth().toString().substring(0, 1).toUpperCase()
                            + slotDate.getMonth().toString().substring(1).toLowerCase();
                    int year = slotDate.getYear();
                    out.println("<tr>");
                    out.println("<td>" + dayOfWeekStr + "</td>"); 
                    out.println("<td>" + day + "</td>");          
                    out.println("<td>" + month + "</td>");       
                    out.println("<td>" + year + "</td>");         

                    out.println("<td>" + slot.getSlot_number() + "</td>");
                    out.println("<td>" + slot.getStart_time() + "</td>");
                    out.println("<td>" + slot.getEnd_time() + "</td>");
                    out.println("<td>" + slot.getStatus() + "</td>");

                    // Kiểm tra xem slot này có được mentee khác book không
                    boolean isBookedByOther = false;
                    List<Mentee_Slot> relatedSlots = daoMs.getSlotsBySlotId(slot.getSlot_id()); // Truyền slot_id
                    System.out.println("Slot ID being checked: " + slot.getSlot_id());
                    System.out.println("Number of related slots found: " + relatedSlots.size());

                    for (Mentee_Slot otherSlot : relatedSlots) {
                        System.out.println("Checking slot - Slot ID: " + otherSlot.getSlot_id()
                                + ", Mentee ID: " + otherSlot.getMentee_id()
                                + ", Status: " + otherSlot.getStatus());

                        if (otherSlot.getSlot_id() == slot.getSlot_id()
                                && // So sánh slot_id
                                otherSlot.getMentee_id() != currentMenteeId
                                && // Mentee khác
                                "Studying".equals(otherSlot.getStatus())) { // Chỉ kiểm tra trạng thái Studying
                            isBookedByOther = true;
                            System.out.println("Slot is booked by other mentee! Condition met.");
                            break;
                        }
                    }

                    System.out.println("Final result - isBookedByOther: " + isBookedByOther);

                    if (isBookedByOther) {
                        out.println("<td><button class='delete-btn' onclick=\"deleteSlot('" + slot.getSlot_id() + "')\">Slot has been Booked by another Mentee - Click to delete</button></td>");
                    } else {
                        out.println("<td></td>");
                    }
                    out.println("</tr>");
                }

                out.println("</tbody>");
                out.println("</table>");
            }
        } catch (NumberFormatException e) {
            out.println("<p>Invalid request ID format: " + e.getMessage() + "</p>");
        } catch (Exception e) {
            out.println("<p>Error loading schedule: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response, PrintWriter out)
            throws ServletException, IOException {
        try {
            String slotId = request.getParameter("slotId");
            if (slotId == null || slotId.isEmpty()) {
                out.println("<p>No slot ID provided</p>");
                return;
            }

            int slotIdd = Integer.parseInt(slotId);
            DAOmentee_Slot daoMs = new DAOmentee_Slot();
            boolean deleted = daoMs.deleteSlot(slotIdd); // Giả sử có method này trong DAO

            if (deleted) {
                out.println("<p>Slot deleted successfully</p>");
            } else {
                out.println("<p>Slot not found or could not be deleted</p>");
            }
        } catch (NumberFormatException e) {
            out.println("<p>Invalid slot ID format: " + e.getMessage() + "</p>");
        } catch (Exception e) {
            out.println("<p>Error deleting slot: " + e.getMessage() + "</p>");
            e.printStackTrace();
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
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Fetches and manages schedule slots for a specific request";
    }
}
