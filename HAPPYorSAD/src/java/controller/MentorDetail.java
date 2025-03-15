package controller;

import entity.Course;
import entity.Mentor1;
import entity.Mentor_Slot;
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
import model.DAOmentee_Slot;
import model.DAOmentor_Slot;
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
    private static final DAOmentor_Slot daoMentorSL = new DAOmentor_Slot();
    private static final DAOmentee_Slot daoMenteeSL = new DAOmentee_Slot();

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
        Double priceperslot = Double.parseDouble(request.getParameter("price"));
        ArrayList<Course> list = daoC.getCourseByMentorId(mentorIdDetail);
        HttpSession session = request.getSession();
        int mentorId = Integer.parseInt(request.getParameter("mentorId"));
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        session.setAttribute("mentor", mentor);
        session.setAttribute("list", list);
        request.setAttribute("mentorId", mentorId);
        request.setAttribute("price", priceperslot);
        request.setAttribute("courseId", courseId);
        request.setAttribute("mentorname", mentor.getName());

        // Default to current month/year and first week if not provided
        LocalDate now = LocalDate.now();
        int selectedMonth = now.getMonthValue();
        int selectedYear = now.getYear();
        LocalDate weekStartDate = now.withDayOfMonth(1); // Start from the 1st of the month initially

        setScheduleData(request, mentorId, selectedMonth, selectedYear, weekStartDate);

        request.getRequestDispatcher("view/MentorDetail.jsp").forward(request, response);
    }

    private void handleScheduleRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int mentorId = Integer.parseInt(request.getParameter("mentorId"));
        int month = Integer.parseInt(request.getParameter("month"));
        int year = Integer.parseInt(request.getParameter("year"));
        String direction = request.getParameter("direction");

        // Determine the current week's starting date
        LocalDate weekStartDate;
        if (request.getAttribute("weekStartDate") != null) {
            weekStartDate = (LocalDate) request.getAttribute("weekStartDate");
        } else {
            weekStartDate = LocalDate.of(year, month, 1); // Default to start of the month
        }

        // Adjust month or week based on direction
        if ("prev".equals(direction)) {
            month--;
            if (month < 1) {
                month = 12;
                year--;
            }
            weekStartDate = LocalDate.of(year, month, 1); // Reset to start of previous month
        } else if ("next".equals(direction)) {
            month++;
            if (month > 12) {
                month = 1;
                year++;
            }
            weekStartDate = LocalDate.of(year, month, 1); // Reset to start of next month
        } else if ("prevWeek".equals(direction)) {
            weekStartDate = weekStartDate.minusWeeks(1);
            if (weekStartDate.getMonthValue() != month) {
                month = weekStartDate.getMonthValue();
                year = weekStartDate.getYear();
            }
        } else if ("nextWeek".equals(direction)) {
            weekStartDate = weekStartDate.plusWeeks(1);
            if (weekStartDate.getMonthValue() != month) {
                month = weekStartDate.getMonthValue();
                year = weekStartDate.getYear();
            }
        }

        // Update request attributes
        request.setAttribute("mentorId", mentorId);
        request.setAttribute("selectedMonth", month);
        request.setAttribute("selectedYear", year);
        request.setAttribute("weekStartDate", weekStartDate);

        setScheduleData(request, mentorId, month, year, weekStartDate);

        request.getRequestDispatcher("view/MentorDetail.jsp").forward(request, response);
    }

    private void setScheduleData(HttpServletRequest request, int mentorId, int month, int year, LocalDate weekStartDate)
            throws ServletException, IOException {
        // Fetch schedule for the selected month/year
        List<Schedule> schedules = daoSc.getSchedulesByMonth(year, month);
        if (schedules.isEmpty()) {
            LOGGER.info("No schedules found for mentorId: " + mentorId + " in " + Month.of(month) + " " + year);
            request.setAttribute("noSchedule", true);
        } else {
            int scheduleId = schedules.get(0).getId();
            request.setAttribute("scheduleId", scheduleId);

            // Generate week dates starting from weekStartDate
            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            String[] weekDays = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
            List<String> weekDates = new ArrayList<>();
            LocalDate currentDate = weekStartDate;
            for (int i = 0; i < 7; i++) {
                weekDates.add(currentDate.format(dateFormatter));
                currentDate = currentDate.plusDays(1);
            }

            // Fetch slots for each day in the week
            Map<String, List<Mentor_Slot>> slotsByDay = new HashMap<>();
            List<Mentor_Slot> allSlots = new ArrayList<>();
            List<Mentor_Slot> bookedSlots = new ArrayList<>();

            for (String date : weekDates) {
                java.sql.Date sqlDate = java.sql.Date.valueOf(date);
                List<Mentor_Slot> slots = daoMentorSL.getSlotsByDateMentorDetai(sqlDate, mentorId);
                slotsByDay.put(date, slots);
                for (Mentor_Slot slot : slots) {
                    allSlots.add(slot);
                    if ("Studying".equals(slot.getStatus())) {
                        bookedSlots.add(slot);
                    }
                }
            }

            // Set attributes for JSP
            request.setAttribute("weekDays", weekDays);
            request.setAttribute("weekDates", weekDates);
            request.setAttribute("slotsByDay", slotsByDay);
            request.setAttribute("allSlots", allSlots);
            request.setAttribute("bookedSlots", bookedSlots);
        }

        // Format the month/year display
        LocalDate date = LocalDate.of(year, month, 1);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM yyyy", new java.util.Locale("en", "US"));
        String formattedMonthYear = date.format(formatter);
        request.setAttribute("formattedMonthYear", formattedMonthYear);
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
        return "Servlet to display mentor details and schedule for viewing";
    }
}
