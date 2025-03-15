package controller;

import entity.Mentor;
import entity.Mentor_Slot;
import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.logging.Level;
import model.DAOMentor;
import model.DAOmentor_Slot;
import model.DAOmentee_Slot;

public class ConfirmSchedule extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ConfirmSchedule.class.getName());
    private final DAOMentor daoMentor = new DAOMentor();
    private final DAOmentor_Slot daoMs = new DAOmentor_Slot();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("/HAPPYorSAD/view/LoginUser.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("viewSlots".equals(action)) {
            handleViewMentorSlots(request, response);
        } else if ("acceptSlot".equals(action)) {
            handleAcceptSlot(request, response);
        } else if ("rejectSlot".equals(action)) {
            handleRejectSlot(request, response);
        } else if ("acceptAllSlots".equals(action)) { // Thêm xử lý cho Accept All
            handleAcceptAllSlots(request, response);
        } else {
            // Hiển thị danh sách mentor mặc định
            List<Mentor> mentors = daoMentor.getAllMentor();
            request.setAttribute("mentors", mentors);
            request.getRequestDispatcher("view/ScheduleManager.jsp").forward(request, response);
        }
    }

    private void handleViewMentorSlots(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String mentorIdStr = request.getParameter("mentorId");
        if (mentorIdStr != null && !mentorIdStr.isEmpty()) {
            try {
                int mentorId = Integer.parseInt(mentorIdStr);
                List<Mentor_Slot> slots = daoMs.getNonAvailableSlots(mentorId);
                System.out.println(slots);
                String mentorName = daoMentor.getMentorNameById(mentorId);
                request.setAttribute("selectedMentorSlots", slots);
                request.setAttribute("selectedMentorId", mentorId);
                request.setAttribute("selectedMentorName", mentorName);
            } catch (NumberFormatException e) {
                LOGGER.warning("Invalid mentorId format: " + e.getMessage());
                request.setAttribute("message", "Invalid mentor ID.");
            }
        }
        List<Mentor> mentors = daoMentor.getAllMentor();
        request.setAttribute("mentors", mentors);
        request.getRequestDispatcher("view/ScheduleManager.jsp").forward(request, response);
    }

    private void handleAcceptSlot(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String slotIdStr = request.getParameter("slotId");
        String mentorIdStr = request.getParameter("mentorId");
        DAOmentee_Slot daomenS = new DAOmentee_Slot();

        if (slotIdStr == null || slotIdStr.isEmpty() || mentorIdStr == null || mentorIdStr.isEmpty()) {
            LOGGER.warning("Missing slotId or mentorId in request parameters");
            request.setAttribute("message", "Missing slot or mentor ID.");
            handleViewMentorSlots(request, response);
            return;
        }

        try {
            int slotId = Integer.parseInt(slotIdStr);
            int mentorId = Integer.parseInt(mentorIdStr);

            if (slotId <= 0) {
                LOGGER.warning("Invalid slotId value: " + slotId);
                request.setAttribute("message", "Invalid slot ID.");
                handleViewMentorSlots(request, response);
                return;
            }

            try {
                daomenS.updateMentorSlotStatus(slotId, mentorId, "Available");
                LOGGER.info("Slot ID " + slotId + " accepted for mentorId: " + mentorId);
                request.setAttribute("message", "Slot accepted successfully!");
            } catch (SQLException ex) {
                LOGGER.log(Level.SEVERE, "SQL Error while accepting slot: " + slotId, ex);
                request.setAttribute("message", "Failed to accept slot due to database error.");
            }
        } catch (NumberFormatException e) {
            LOGGER.warning("Invalid slotId or mentorId format: " + e.getMessage());
            request.setAttribute("message", "Invalid slot or mentor ID format.");
        }
        handleViewMentorSlots(request, response);
    }

    private void handleRejectSlot(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String slotIdStr = request.getParameter("slotId");
        String mentorIdStr = request.getParameter("mentorId");

        if (slotIdStr == null || mentorIdStr == null) {
            LOGGER.warning("Missing slotId or mentorId in request parameters");
            request.setAttribute("message", "Missing slot or mentor ID.");
            handleViewMentorSlots(request, response);
            return;
        }

        try {
            int slotId = Integer.parseInt(slotIdStr);
            int mentorId = Integer.parseInt(mentorIdStr);
            boolean success = daoMs.deleteSlot(mentorId, slotId);
            if (success) {
                LOGGER.info("Slot " + slotId + " rejected and deleted for mentorId: " + mentorId);
                request.setAttribute("message", "Slot rejected successfully!");
            } else {
                LOGGER.warning("Failed to reject slot " + slotId);
                request.setAttribute("message", "Failed to reject slot.");
            }
        } catch (NumberFormatException e) {
            LOGGER.warning("Invalid slotId or mentorId format: " + e.getMessage());
            request.setAttribute("message", "Invalid slot or mentor ID.");
        }
        handleViewMentorSlots(request, response);
    }

    // Thêm xử lý Accept All Slots
    private void handleAcceptAllSlots(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String mentorIdStr = request.getParameter("mentorId");
        String[] slotIds = request.getParameterValues("slotIds");
        DAOmentee_Slot daomenS = new DAOmentee_Slot();

        if (mentorIdStr == null || slotIds == null || slotIds.length == 0) {
            LOGGER.warning("Missing mentorId or slotIds in request parameters");
            request.setAttribute("message", "Missing mentor ID or slots to accept.");
            handleViewMentorSlots(request, response);
            return;
        }

        try {
            int mentorId = Integer.parseInt(mentorIdStr);
            int acceptedCount = 0;

            for (String slotIdStr : slotIds) {
                try {
                    int slotId = Integer.parseInt(slotIdStr);
                    if (slotId > 0) {
                        daomenS.updateMentorSlotStatus(slotId, mentorId, "Available");
                        LOGGER.info("Slot ID " + slotId + " accepted for mentorId: " + mentorId);
                        acceptedCount++;
                    }
                } catch (SQLException ex) {
                    LOGGER.log(Level.SEVERE, "SQL Error while accepting slot: " + slotIdStr, ex);
                } catch (NumberFormatException e) {
                    LOGGER.warning("Invalid slotId format: " + slotIdStr);
                }
            }

            request.setAttribute("message", "Accepted " + acceptedCount + " slots successfully!");
        } catch (NumberFormatException e) {
            LOGGER.warning("Invalid mentorId format: " + mentorIdStr);
            request.setAttribute("message", "Invalid mentor ID.");
        }
        handleViewMentorSlots(request, response);
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
        return "Servlet for Manager to Confirm Mentor Schedules";
    }
}
