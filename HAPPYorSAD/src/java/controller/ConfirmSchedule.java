package controller;

import entity.Mentor;
import entity.Mentor_Slot;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
        } else if ("acceptAllSlots".equals(action)) {
            handleAcceptAllSlots(request, response);
        } else if ("rejectAllSlots".equals(action)) { // Thêm xử lý cho Reject All
            handleRejectAllSlots(request, response);
        } else {
            // Xử lý yêu cầu GET với các bộ lọc
            handleFilterMentors(request, response);
        }
    }

    // Xử lý bộ lọc mentor
    private void handleFilterMentors(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String monthStr = request.getParameter("month");
        String status = request.getParameter("status");
        String mentorSearch = request.getParameter("mentorSearch");
        String requestTimeStr = request.getParameter("requestTime");

        List<Mentor> mentors;
        try {
            // Nếu không có bộ lọc, lấy toàn bộ danh sách mentor
            if ((monthStr == null || monthStr.isEmpty())
                    && (status == null || status.isEmpty())
                    && (mentorSearch == null || mentorSearch.isEmpty())
                    && (requestTimeStr == null || requestTimeStr.isEmpty())) {
                mentors = daoMentor.getAllMentor();
            } else {
                // Xử lý các tham số lọc
                Integer month = monthStr != null && !monthStr.isEmpty() ? Integer.parseInt(monthStr) : null;
                String searchQuery = mentorSearch != null && !mentorSearch.isEmpty() ? mentorSearch : null;
                Date requestTime = requestTimeStr != null && !requestTimeStr.isEmpty()
                        ? new SimpleDateFormat("yyyy-MM-dd").parse(requestTimeStr) : null;

                // Gọi hàm lọc mentor từ DAO (cần cập nhật DAO nếu chưa có)
                mentors = daoMentor.filterMentors(month, status, searchQuery, requestTime);
            }
            request.setAttribute("mentors", mentors);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error filtering mentors: " + e.getMessage(), e);
            request.setAttribute("message", "Error occurred while filtering mentors.");
            mentors = daoMentor.getAllMentor(); // Fallback to all mentors
            request.setAttribute("mentors", mentors);
        }

        request.getRequestDispatcher("view/ScheduleManager.jsp").forward(request, response);
    }

    private void handleViewMentorSlots(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String mentorIdStr = request.getParameter("mentorId");
        String monthStr = request.getParameter("month");
        String status = request.getParameter("status");
        String requestTimeStr = request.getParameter("requestTime");

        if (mentorIdStr != null && !mentorIdStr.isEmpty()) {
            try {
                int mentorId = Integer.parseInt(mentorIdStr);
                Integer month = monthStr != null && !monthStr.isEmpty() ? Integer.parseInt(monthStr) : null;
                Date requestTime = requestTimeStr != null && !requestTimeStr.isEmpty()
                        ? new SimpleDateFormat("yyyy-MM-dd").parse(requestTimeStr) : null;

                // Lọc slot theo các tiêu chí
                List<Mentor_Slot> slots = daoMs.getFilteredSlots(mentorId, month, status, (java.sql.Date) requestTime);
                String mentorName = daoMentor.getMentorNameById(mentorId);
                request.setAttribute("selectedMentorSlots", slots);
                request.setAttribute("selectedMentorId", mentorId);
                request.setAttribute("selectedMentorName", mentorName);
            } catch (Exception e) {
                LOGGER.log(Level.SEVERE, "Error viewing mentor slots: " + e.getMessage(), e);
                request.setAttribute("message", "Invalid mentor ID or error fetching slots.");
            }
        }
        handleFilterMentors(request, response); // Gọi lại để hiển thị danh sách mentor
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

            daomenS.updateMentorSlotStatus(slotId, mentorId, "Accepted"); // Cập nhật trạng thái thành "Accepted"
            LOGGER.info("Slot ID " + slotId + " accepted for mentorId: " + mentorId);
            request.setAttribute("message", "Slot accepted successfully!");
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "SQL Error while accepting slot: " + slotIdStr, ex);
            request.setAttribute("message", "Failed to accept slot due to database error.");
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
            daoMs.updateSlotStatus2(mentorId, slotId, "Rejected"); // Cập nhật trạng thái thay vì xóa
            LOGGER.info("Slot " + slotId + " rejected for mentorId: " + mentorId);
            request.setAttribute("message", "Slot rejected successfully!");
        } catch (NumberFormatException e) {
            LOGGER.warning("Invalid slotId or mentorId format: " + e.getMessage());
            request.setAttribute("message", "Invalid slot or mentor ID.");
        }
        handleViewMentorSlots(request, response);
    }

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
                        daomenS.updateMentorSlotStatus(slotId, mentorId, "Accepted");
                        LOGGER.info("Slot ID " + slotId + " accepted for mentorId: " + mentorId);
                        acceptedCount++;
                    }
                } catch (SQLException ex) {
                    LOGGER.log(Level.SEVERE, "SQL Error while accepting slot: " + slotIdStr, ex);
                }
            }
            request.setAttribute("message", "Accepted " + acceptedCount + " slots successfully!");
        } catch (NumberFormatException e) {
            LOGGER.warning("Invalid mentorId format: " + mentorIdStr);
            request.setAttribute("message", "Invalid mentor ID.");
        }
        handleViewMentorSlots(request, response);
    }

    private void handleRejectAllSlots(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String mentorIdStr = request.getParameter("mentorId");
        String[] slotIds = request.getParameterValues("slotIds");

        if (mentorIdStr == null || slotIds == null || slotIds.length == 0) {
            LOGGER.warning("Missing mentorId or slotIds in request parameters");
            request.setAttribute("message", "Missing mentor ID or slots to reject.");
            handleViewMentorSlots(request, response);
            return;
        }

        try {
            int mentorId = Integer.parseInt(mentorIdStr);
            int rejectedCount = 0;

            for (String slotIdStr : slotIds) {
                try {
                    int slotId = Integer.parseInt(slotIdStr);
                    if (slotId > 0) {
                        daoMs.updateSlotStatus2(mentorId, slotId, "Rejected");
                        LOGGER.info("Slot ID " + slotId + " rejected for mentorId: " + mentorId);
                        rejectedCount++;
                    }
                } catch (Exception ex) {
                    LOGGER.log(Level.SEVERE, "Error while rejecting slot: " + slotIdStr, ex);
                }
            }
            request.setAttribute("message", "Rejected " + rejectedCount + " slots successfully!");
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
