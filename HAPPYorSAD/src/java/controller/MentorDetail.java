package controller;

import entity.Course;
import entity.Mentor1;
import entity.Schedule;
import entity.Slot;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.time.Month;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import model.DAOCourse;
import model.DAOMentor;
import model.DAOschedule;
import model.DAOslot;

/**
 *
 * @author Acer
 */
public class MentorDetail extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(MentorDetail.class.getName());
    private final DAOslot daoSlot = new DAOslot();
    private final DAOschedule daoSc = new DAOschedule();

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
        String action = request.getParameter("action");

        if ("getMentorSlots".equals(action)) {
            handleScheduleRequest(request, response);
        } else {
            handleInitialRequest(request, response);
        }
    }

    private void handleInitialRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("mentorId"));
        int mentorIdDetail = id;
        DAOMentor dao = new DAOMentor();
        DAOCourse daoC = new DAOCourse();
        Mentor1 mentor = dao.getMentorById(mentorIdDetail);
        ArrayList<Course> list = daoC.getCourseByMentorId(mentorIdDetail);
        HttpSession session = request.getSession();
        int mentorId = Integer.parseInt(request.getParameter("mentorId"));
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        session.setAttribute("mentor", mentor);
        session.setAttribute("list", list);
        request.setAttribute("mentorId", mentorId);
        request.setAttribute("courseId", courseId);

        // Default to current month/year if not provided
        int selectedMonth = LocalDate.now().getMonthValue();
        int selectedYear = LocalDate.now().getYear();

        // Lấy danh sách lịch trình của mentor theo tháng/năm
        List<Schedule> schedules = daoSc.getSchedulesByMonth(selectedYear, selectedMonth);
        if (schedules.isEmpty()) {
            LOGGER.info("No schedules found for mentorId: " + mentorId + " in " + Month.of(selectedMonth) + " " + selectedYear);
            request.setAttribute("noSchedule", true);
        } else {
            int scheduleId = schedules.get(0).getId();
            request.setAttribute("scheduleId", scheduleId);

            // Lấy ngày bắt đầu của lịch trình
            java.sql.Date startDate = daoSc.getStartDateByScheduleId(scheduleId);
            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

            // Tạo danh sách ngày trong tuần
            String[] weekDays = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
            java.util.Calendar calendar = java.util.Calendar.getInstance();
            calendar.setTime(startDate);
            List<String> weekDates = new ArrayList<>();
            for (int i = 0; i < 7; i++) {
                java.sql.Date sqlDate = new java.sql.Date(calendar.getTimeInMillis());
                weekDates.add(sqlDate.toLocalDate().format(dateFormatter));
                calendar.add(java.util.Calendar.DATE, 1);
            }

            // Lấy danh sách slot theo ngày
            List<Slot> allSlots = new ArrayList<>();
            List<Slot> bookedSlots = new ArrayList<>();
            Map<String, List<Slot>> slotsByDay = new HashMap<>();

            for (String date : weekDates) {
                java.sql.Date sqlDate = java.sql.Date.valueOf(date);
                List<Slot> slots = daoSlot.getSlotsByDate1(sqlDate, mentorId);
                slotsByDay.put(date, slots);

                for (Slot slot : slots) {
                    allSlots.add(slot);
                    if (slot.isBooked()) {
                        bookedSlots.add(slot);
                    }
                }
            }

            // Truyền dữ liệu lịch vào request
            request.setAttribute("weekDays", weekDays);
            request.setAttribute("weekDates", weekDates);
            request.setAttribute("slotsByDay", slotsByDay);
            request.setAttribute("allSlots", allSlots);
            request.setAttribute("bookedSlots", bookedSlots);
            request.setAttribute("selectedMonth", selectedMonth);
            request.setAttribute("selectedYear", selectedYear);
        }

        // Format the initial month/year display using java.time API
        LocalDate date = LocalDate.of(selectedYear, selectedMonth, 1);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM yyyy", new java.util.Locale("en", "US"));
        String formattedMonthYear = date.format(formatter);
        request.setAttribute("formattedMonthYear", formattedMonthYear);

        request.getRequestDispatcher("view/MentorDetail.jsp").forward(request, response);
    }

    private void handleScheduleRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int mentorId = Integer.parseInt(request.getParameter("mentorId"));
        int month = Integer.parseInt(request.getParameter("month"));
        int year = Integer.parseInt(request.getParameter("year"));
        String direction = request.getParameter("direction");

        // Adjust month based on direction
        if ("prev".equals(direction)) {
            month--;
            if (month < 1) {
                month = 12;
                year--;
            }
        } else if ("next".equals(direction)) {
            month++;
            if (month > 12) {
                month = 1;
                year++;
            }
        }

        // Update request parameters
        request.setAttribute("mentorId", mentorId);
        request.setAttribute("selectedMonth", month);
        request.setAttribute("selectedYear", year);

        // Fetch updated schedule
        List<Schedule> schedules = daoSc.getSchedulesByMonth(year, month);
        if (schedules.isEmpty()) {
            LOGGER.info("No schedules found for mentorId: " + mentorId + " in " + Month.of(month) + " " + year);
            request.setAttribute("noSchedule", true);
        } else {
            int scheduleId = schedules.get(0).getId();
            request.setAttribute("scheduleId", scheduleId);

            java.sql.Date startDate = daoSc.getStartDateByScheduleId(scheduleId);
            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

            String[] weekDays = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
            java.util.Calendar calendar = java.util.Calendar.getInstance();
            calendar.setTime(startDate);
            List<String> weekDates = new ArrayList<>();
            for (int i = 0; i < 7; i++) {
                java.sql.Date sqlDate = new java.sql.Date(calendar.getTimeInMillis());
                weekDates.add(sqlDate.toLocalDate().format(dateFormatter));
                calendar.add(java.util.Calendar.DATE, 1);
            }

            Map<String, List<Slot>> slotsByDay = new HashMap<>();
            for (String date : weekDates) {
                java.sql.Date sqlDate = java.sql.Date.valueOf(date);
                List<Slot> slots = daoSlot.getSlotsByDate1(sqlDate, mentorId);
                slotsByDay.put(date, slots);
            }

            request.setAttribute("weekDays", weekDays);
            request.setAttribute("weekDates", weekDates);
            request.setAttribute("slotsByDay", slotsByDay);
        }

        // Format the updated month/year display using java.time API
        LocalDate date = LocalDate.of(year, month, 1);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM yyyy", new java.util.Locale("en", "US"));
        String formattedMonthYear = date.format(formatter);
        request.setAttribute("formattedMonthYear", formattedMonthYear);

        request.getRequestDispatcher("view/MentorDetail.jsp").forward(request, response);
    }

    private String generateSlotsHTML(int mentorId, int month, int year) {
        // This method is no longer needed for form submission, but kept for reference
        return "";
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
        return "Servlet to display mentor details and schedule for viewing";
    }
    // </editor-fold>
}
