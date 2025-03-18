package controller;

import entity.Mentee;
import entity.Mentee_Slot;
import entity.Mentor_Slot;
import entity.Request;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.time.LocalDate;
import java.time.Month;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.time.temporal.ChronoUnit;
import model.DAOMentor;
import model.DAOmentee;
import model.DAOschedule;
import model.DAOslot;
import entity.Slot;
import model.DAORequest;
import model.DAOatt;
import model.DAOmentee_Slot;
import model.DAOmentor_Slot;

/**
 * @author Ann
 */
public class Attendance extends HttpServlet {

    private static final java.util.logging.Logger LOGGER = java.util.logging.Logger.getLogger(Attendance.class.getName());
    private final DAOslot daoSlot = new DAOslot();
    private final DAOmentor_Slot daoMSL = new DAOmentor_Slot();
    private final DAOmentee_Slot daoMeSL = new DAOmentee_Slot();
    private final DAOschedule daoSc = new DAOschedule();
    private final DAOmentee daoMentee = new DAOmentee();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (java.io.PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Attendance</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Attendance at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            LOGGER.info("No active session or userId not found, redirecting to login");
            response.sendRedirect("/HAPPYorSAD/view/LoginUser.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        LOGGER.info("Processing request for userId: " + userId);
        Integer mentorId = DAOMentor.getMentorIdByUserId(userId);
        LOGGER.info("Retrieved mentorId: " + mentorId);

        Integer selectedMonthAttr = (Integer) request.getAttribute("selectedMonth");
        Integer selectedYearAttr = (Integer) request.getAttribute("selectedYear");
        Integer weekOffsetAttr = (Integer) request.getAttribute("weekOffset");

        int selectedMonth = (selectedMonthAttr != null) ? selectedMonthAttr : LocalDate.now().getMonthValue();
        int selectedYear = (selectedYearAttr != null) ? selectedYearAttr : LocalDate.now().getYear();
        int weekOffset = (weekOffsetAttr != null) ? weekOffsetAttr : -1;

        String selectedMonthStr = request.getParameter("month");
        String selectedYearStr = request.getParameter("year");
        String weekOffsetStr = request.getParameter("weekOffset");

        LOGGER.info("Initial date parameters - Month: " + selectedMonth + ", Year: " + selectedYear + ", WeekOffset: " + weekOffset);

        if (selectedMonthStr != null && !selectedMonthStr.isEmpty()) {
            try {
                selectedMonth = Integer.parseInt(selectedMonthStr);
            } catch (NumberFormatException e) {
                LOGGER.warning("Invalid month format, using default or attribute: " + e.getMessage());
            }
        }
        if (selectedYearStr != null && !selectedYearStr.isEmpty()) {
            try {
                selectedYear = Integer.parseInt(selectedYearStr);
            } catch (NumberFormatException e) {
                LOGGER.warning("Invalid year format, using default or attribute: " + e.getMessage());
            }
        }
        if (weekOffsetStr != null && !weekOffsetStr.isEmpty()) {
            try {
                weekOffset = Integer.parseInt(weekOffsetStr);
            } catch (NumberFormatException e) {
                LOGGER.warning("Invalid weekOffset format, using default or attribute: " + e.getMessage());
            }
        }

        List<entity.Schedule> schedules = daoSc.getSchedulesByMonth(selectedYear, selectedMonth);
        String scheduleHeader = "Schedules for " + Month.of(selectedMonth) + " " + selectedYear;
        request.setAttribute("scheduleHeader", scheduleHeader);
        request.setAttribute("schedules", schedules);
        request.setAttribute("selectedMonth", selectedMonth);
        request.setAttribute("selectedYear", selectedYear);

        int scheduleId = -1;
        String scheduleIdStr = request.getParameter("scheduleId");
        if (scheduleIdStr != null && !scheduleIdStr.isEmpty()) {
            try {
                scheduleId = Integer.parseInt(scheduleIdStr);
            } catch (NumberFormatException e) {
                LOGGER.info("Invalid scheduleId, defaulting to -1: " + e.getMessage());
            }
        } else if (!schedules.isEmpty()) {
            scheduleId = schedules.get(0).getId();
        }
        LOGGER.info("Selected scheduleId: " + scheduleId);
        request.setAttribute("scheduleId", scheduleId);

        String[] weekDays = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
        request.setAttribute("weekDays", weekDays);

        java.sql.Date startDate = daoSc.getStartDateByScheduleId(scheduleId);
        LOGGER.info("Schedule start date: " + startDate);
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        List<String> weekDates = new ArrayList<>();

        if (startDate != null) {
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(startDate);
            calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);

            if (weekOffset == -1) {
                LocalDate startLocalDate = startDate.toLocalDate();
                LocalDate currentDate = LocalDate.now();
                long daysBetween = ChronoUnit.DAYS.between(startLocalDate, currentDate);
                weekOffset = (int) (daysBetween / 7);
                LOGGER.info("Calculated weekOffset for current week: " + weekOffset);
            }

            calendar.add(Calendar.WEEK_OF_YEAR, weekOffset);
            calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);

            for (int i = 0; i < 7; i++) {
                String formattedDate = new java.sql.Date(calendar.getTimeInMillis()).toLocalDate().format(dateFormatter);
                weekDates.add(formattedDate);
                calendar.add(Calendar.DATE, 1);
            }
        }
        LOGGER.info("Generated week dates: " + weekDates);
        request.setAttribute("weekDates", weekDates);

        String weekStartDate = weekDates.isEmpty() ? "" : weekDates.get(0);
        String weekEndDate = weekDates.isEmpty() ? "" : weekDates.get(6);
        request.setAttribute("weekOffset", weekOffset);
        request.setAttribute("weekStartDate", weekStartDate);
        request.setAttribute("weekEndDate", weekEndDate);

        Map<String, List<entity.Mentor_Slot>> slotsByDay = new HashMap<>();
        List<String> rejectionNotices = new ArrayList<>();
        if (startDate != null && mentorId != null) {
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(startDate);
            calendar.add(Calendar.WEEK_OF_YEAR, weekOffset);
            calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);

            for (int i = 0; i < 7; i++) {
                java.sql.Date date = new java.sql.Date(calendar.getTimeInMillis());
                String formattedDate = date.toLocalDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

                List<Mentor_Slot> mentorSlots = daoMSL.getSlotsByDateMentorAttendance(date, mentorId);
                List<Mentor_Slot> filteredSlots = new ArrayList<>();

                for (Mentor_Slot slot : mentorSlots) {
                    String status = slot.getStatus();
                    if (status != null && (status.equals("Studying") || status.equals("pending_present")
                            || status.equals("pending_absent") || status.equals("present")
                            || status.equals("absent") || status.equals("Done") || status.equals("cancel")
                            || status.equals("att_again"))) {
                        Slot slotDetails = daoSlot.getSlotById(slot.getSlot_id());
                        if (slotDetails != null) {
                            slot.setStart_time(slotDetails.getStartTime());
                            slot.setEnd_time(slotDetails.getEndTime());
                            LOGGER.info("Slot Details - ID: " + slot.getSlot_id()
                                    + ", Date: " + formattedDate
                                    + ", Start: " + slot.getStart_time()
                                    + ", End: " + slot.getEnd_time()
                                    + ", Status: " + slot.getStatus());
                        }
                        filteredSlots.add(slot);
                    }
                }
                slotsByDay.put(formattedDate, filteredSlots);
                
                calendar.add(Calendar.DATE, 1);
            }
        }
     
        request.setAttribute("slotsByDay", slotsByDay);

        request.getRequestDispatcher("view/Attendance.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            LOGGER.info("No active session or userId not found in POST, redirecting to login");
            response.sendRedirect("/HAPPYorSAD/view/LoginUser.jsp");
            return;
        }

        String action = request.getParameter("action");
        LOGGER.info("Received POST action: " + action);

        String selectedMonthStr = request.getParameter("month");
        String selectedYearStr = request.getParameter("year");
        String weekOffsetStr = request.getParameter("weekOffset");

        int selectedMonth = LocalDate.now().getMonthValue();
        int selectedYear = LocalDate.now().getYear();
        int weekOffset = 0;

        if (selectedMonthStr != null && !selectedMonthStr.isEmpty()) {
            selectedMonth = Integer.parseInt(selectedMonthStr);
        }
        if (selectedYearStr != null && !selectedYearStr.isEmpty()) {
            selectedYear = Integer.parseInt(selectedYearStr);
        }
        if (weekOffsetStr != null && !weekOffsetStr.isEmpty()) {
            weekOffset = Integer.parseInt(weekOffsetStr);
        }

        DAOmentee daoM = new DAOmentee();
        DAOatt daoA = new DAOatt();
        DAORequest daoR = new DAORequest();

        String redirectUrl = String.format("/Attendance?month=%d&year=%d&weekOffset=%d", selectedMonth, selectedYear, weekOffset);

        try {
            if ("getMentees".equals(action)) {
                String date = request.getParameter("date");
                String slotNumberStr = request.getParameter("slot");
                int slotNumber = Integer.parseInt(slotNumberStr);

                LOGGER.info("Fetching mentees for Date: " + date + ", Slot: " + slotNumber);

                Mentee m = daoMeSL.getMenteeBySlotId(date, slotNumber);
                Mentor_Slot slot = daoMSL.getSlotsByDateMentorAtt(date, slotNumber);
                LOGGER.info("Retrieved Mentee: " + (m != null ? m.getName() : "null")
                        + ", Slot Details - ID: " + (slot != null ? slot.getSlot_id() : "null")
                        + ", Start: " + (slot != null ? slot.getStart_time() : "null")
                        + ", End: " + (slot != null ? slot.getEnd_time() : "null")
                        + ", Status: " + (slot != null ? slot.getStatus() : "null"));

                session.setAttribute("mentee", m);
                session.setAttribute("slot", slot);
                session.setAttribute("selectedDate", date);
                session.setAttribute("selectedSlot", slotNumber);
                session.setAttribute("showModal", true);

            } else if ("saveAttendance".equals(action)) {
                String date = request.getParameter("date");
                String slotNumberStr = request.getParameter("slot");
                String status = request.getParameter("status");

                int slotNumber = Integer.parseInt(slotNumberStr);
                LOGGER.info("Updating attendance for Date: " + date + ", Slot: " + slotNumber + " to " + status);

                Mentor_Slot slot = daoMSL.getSlotsByDateMentorAtt(date, slotNumber);
                LOGGER.info("Retrieved Slot for update - ID: " + (slot != null ? slot.getSlot_id() : "null")
                        + ", Start: " + (slot != null ? slot.getStart_time() : "null")
                        + ", End: " + (slot != null ? slot.getEnd_time() : "null")
                        + ", Current Status: " + (slot != null ? slot.getStatus() : "null"));

                String menteeStatus = status.equals("pending_present") ? "confirm_present" : "confirm_absent";
                Mentee_Slot menteeSlot = daoMeSL.getMenteeSlotsByMentorSlotId(slot.getSlot_id());
                if (menteeSlot != null) {
                    daoMeSL.updateSlotStatus(menteeSlot.getSlot_id(), menteeStatus);
                    LOGGER.info("Mentee slot updated - ID: " + menteeSlot.getSlot_id()
                            + ", New Status: " + menteeStatus);
                }
                if (slot != null) {
                    daoMSL.updateSlotStatus(slot.getSlot_id(), status.equals("pending_present") ? "pending_present" : "pending_absent");
                    LOGGER.info("Mentor slot updated - ID: " + slot.getSlot_id()
                            + ", New Status: " + (status.equals("pending_present") ? "pending_present" : "pending_absent"));
                }

                session.setAttribute("message", "Attendance saved successfully!");
                // Xóa các thuộc tính modal sau khi lưu thành công
                session.removeAttribute("mentee");
                session.removeAttribute("slot");
                session.removeAttribute("selectedDate");
                session.removeAttribute("selectedSlot");
                session.removeAttribute("showModal");

            } else if ("viewAttendance".equals(action)) {
                String date = request.getParameter("date");
                String slotNumberStr = request.getParameter("slot");
                int slotNumber = Integer.parseInt(slotNumberStr);

                LOGGER.info("Viewing attendance for Date: " + date + ", Slot: " + slotNumber);

                Mentee m = daoM.getMenteeBySlotId(date, slotNumber);
                Slot slot = daoSlot.getSlotByDateAndNumber(date, slotNumber);
                LOGGER.info("Retrieved Mentee: " + (m != null ? m.getName() : "null")
                        + ", Slot Details - ID: " + (slot != null ? slot.getId() : "null")
                        + ", Start: " + (slot != null ? slot.getStartTime() : "null")
                        + ", End: " + (slot != null ? slot.getEndTime() : "null"));

                session.setAttribute("mentee", m);
                session.setAttribute("slot", slot);
                session.setAttribute("selectedDate", date);
                session.setAttribute("selectedSlot", slotNumber);
                session.setAttribute("showModal", true);

            } else if ("clearModal".equals(action)) {
                LOGGER.info("Clearing modal attributes");
                session.removeAttribute("mentee");
                session.removeAttribute("slot");
                session.removeAttribute("selectedDate");
                session.removeAttribute("selectedSlot");
                session.removeAttribute("showModal");

            } else {
                LOGGER.warning("Unknown action received: " + action);
                session.setAttribute("error", "Invalid action.");
            }
        } catch (Exception e) {
            LOGGER.severe("Error processing action " + action + ": " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("error", "An error occurred. Please try again.");
        }

        LOGGER.info("Redirecting to: " + redirectUrl);
        response.sendRedirect(request.getContextPath() + redirectUrl);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for managing attendance ";
    }
}
