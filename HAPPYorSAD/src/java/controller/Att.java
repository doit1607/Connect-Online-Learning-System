package controller;

import entity.Attendance;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.DAOa;
import model.DAOslot;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import static model.DBConnection.conn;

public class Att extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(Att.class.getName());
    private DAOa attendanceDAO;
    private DAOslot slotDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        attendanceDAO = new DAOa();
        slotDAO = new DAOslot();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        // Basic request processing remains same if needed
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String requestIdParam = request.getParameter("requestId");
            int requestId = (requestIdParam != null && !requestIdParam.isEmpty())
                    ? Integer.parseInt(requestIdParam)
                    : 1756; // Default value only if parameter is missing

            request.setAttribute("slots", slotDAO.getSlotsByRequestId(requestId));
            request.setAttribute("requestId", requestId);
            request.getRequestDispatcher("view/att.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid requestId format", e);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request ID format");
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error fetching slots for request", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error in doGet", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected error occurred");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Validate parameters
            String slotIdParam = request.getParameter("slotId");
            String requestIdParam = request.getParameter("requestId");
            if (slotIdParam == null || requestIdParam == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required parameters");
                return;
            }

            int slotId = Integer.parseInt(slotIdParam);
            int requestId = Integer.parseInt(requestIdParam);

            // Get mentorId with null check
            Integer mentorId = (Integer) request.getSession().getAttribute("userId");
            if (mentorId == null) {
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not authenticated");
                return;
            }

            boolean isDone = "true".equals(request.getParameter("isDone"));

            // Mark attendance and update status
            attendanceDAO.markAttendance(slotId, mentorId, 1, isDone);
            System.out.println(1);
            if (isDone) {
                slotDAO.updateSlotStatus(slotId, "Complete");
            }

            LOGGER.log(Level.INFO, "Attendance marked for Slot ID {0} by Mentor ID {1}, isDone: {2}",
                    new Object[]{slotId, mentorId, isDone});

            // Forward to JSP with updated data
            request.setAttribute("slots", slotDAO.getSlotsByRequestId(requestId));
            request.setAttribute("requestId", requestId);
            request.getRequestDispatcher("view/att.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid parameter format", e);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid parameter format");
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error marking attendance", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error in doPost", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected error occurred");
        }
    }
    
    private int getMenteeIdFromSlot(int slotId) throws SQLException {
        String sql = "SELECT mentee_id FROM Slot WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, slotId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt("mentee_id");
        }
        throw new SQLException("Mentee ID not found for Slot ID: " + slotId);
    }

    @Override
    public String getServletInfo() {
        return "Attendance Management Servlet";
    }

    @Override
    public void destroy() {
        // Clean up resources if needed
        super.destroy();
    }
}
