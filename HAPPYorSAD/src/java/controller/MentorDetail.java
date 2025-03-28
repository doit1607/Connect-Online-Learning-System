package controller;

import entity.Course;
import entity.Mentor1;
import entity.MentorReview;
import entity.Mentor_Slot;
import entity.Schedule;
import entity.Slot;
import entity.CV;

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
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;
import model.DAOCourse;
import model.DAOMentor;
import model.DAORateMentor;
import model.DAORequest;
import model.DAOmentee_Slot;
import model.DAOmentor_Slot;
import model.DAOschedule;
import model.DAOslot;
import model.DAOuser;
import model.DaoCV;

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

        HttpSession session = request.getSession();
        String mentorId = request.getParameter("mentorId");
        String courseId = request.getParameter("courseId");
        String price = request.getParameter("price");
        String month = request.getParameter("month");
        String year = request.getParameter("year");
        String direction = request.getParameter("direction");
        String username = (String) session.getAttribute("usernameUser");
        int id = Integer.parseInt(request.getParameter("mentorId"));
        int mentorIdDetail = id;
        DAOMentor dao = new DAOMentor();
        DaoCV daoCV = new DaoCV();

        DAOCourse daoC = new DAOCourse();
        Mentor1 mentor = dao.getMentorById(mentorIdDetail);
        Double priceperslot = Double.parseDouble(request.getParameter("price"));
        ArrayList<Course> list = daoC.getCourseByMentorId(mentorIdDetail);
        DAOuser userDAO = new DAOuser();
        int userId = userDAO.getUserIdByUsername(username);

        String usermentor = dao.getMentorUsername(mentorIdDetail);
        CV cv = daoCV.getCVByUsername(usermentor);

        DAORateMentor daoR = new DAORateMentor();

        List<MentorReview> listReview = daoR.getMentorRate(mentorIdDetail);
        System.out.println("Helloo " + listReview);
        request.setAttribute("listReview", listReview);
        request.setAttribute("cv", cv);
        request.setAttribute("mentorname", mentor.getName());
        request.setAttribute("mentorId", mentorId);
        request.setAttribute("courseId", courseId);
        request.setAttribute("price", price);
        request.setAttribute("professionIntro", cv.professionIntro);
        request.setAttribute("achievementDescription", cv.achievementDescription);

        request.setAttribute("selectedMonth", month);
        request.setAttribute("selectedYear", year);
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
        DaoCV daoCV = new DaoCV();
        DAOCourse daoC = new DAOCourse();
        Mentor1 mentor = dao.getMentorById(mentorIdDetail);
        Double priceperslot = Double.parseDouble(request.getParameter("price"));
        ArrayList<Course> list = daoC.getCourseByMentorId(mentorIdDetail);

        HttpSession session = request.getSession();
        int mentorId = Integer.parseInt(request.getParameter("mentorId"));
        String username = dao.getMentorUsername(mentorId);
        String professionIntro = request.getParameter("professionIntro");
        String achievementDescription = request.getParameter("achievementDescription");

        CV cv = daoCV.getCVByUsername(username);
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        session.setAttribute("mentor", mentor);
        session.setAttribute("list", list);
        request.setAttribute("mentorId", mentorId);
        request.setAttribute("cv", cv);
        request.setAttribute("professionIntro", cv.professionIntro);
        request.setAttribute("achievementDescription", cv.achievementDescription);

        request.setAttribute("price", priceperslot);
        request.setAttribute("courseId", courseId);
        request.setAttribute("mentorname", mentor.getName());

        LocalDate now = LocalDate.now();
        int selectedMonth = now.getMonthValue();
        int selectedYear = now.getYear();
        LocalDate weekStartDate = now.minusDays(now.getDayOfWeek().getValue() - 1); // Thứ Hai của tuần hiện tại

        setScheduleData(request, mentorId, selectedMonth, selectedYear, weekStartDate);
        request.getRequestDispatcher("view/MentorDetail.jsp").forward(request, response);
    }

    private void handleScheduleRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int mentorId = Integer.parseInt(request.getParameter("mentorId"));
        String monthStr = request.getParameter("month");
        String yearStr = request.getParameter("year");
        String direction = request.getParameter("direction");
        String weekOffsetStr = request.getParameter("weekOffset");

        LOGGER.info("Received parameters: mentorId=" + mentorId + ", monthStr=" + monthStr
                + ", yearStr=" + yearStr + ", direction=" + direction + ", weekOffset=" + weekOffsetStr);

        LocalDate now = LocalDate.now();
        int month;
        int year;
        LocalDate weekStartDate;

        // Khởi tạo lần đầu hoặc khi không có tham số
        if (monthStr == null || monthStr.trim().isEmpty() || yearStr == null || yearStr.trim().isEmpty()) {
            // Lần đầu vào: Hiển thị tuần hiện tại
            weekStartDate = now.minusDays(now.getDayOfWeek().getValue() - 1); // Thứ Hai của tuần hiện tại
            month = weekStartDate.getMonthValue();
            year = weekStartDate.getYear();
        } else {
            month = Integer.parseInt(monthStr);
            year = Integer.parseInt(yearStr);
            int weekOffset = (weekOffsetStr == null || weekOffsetStr.trim().isEmpty()) ? 0 : Integer.parseInt(weekOffsetStr);
            weekStartDate = LocalDate.of(year, month, 1)
                    .minusDays(LocalDate.of(year, month, 1).getDayOfWeek().getValue() - 1) // Thứ Hai đầu tháng
                    .plusWeeks(weekOffset); // Điều chỉnh theo weekOffset
        }

        LOGGER.info("Initial date setup: month=" + month + ", year=" + year + ", weekStartDate=" + weekStartDate);

        if ("prev".equals(direction)) {
            LOGGER.info("Moving to previous month...");
            month--;
            if (month < 1) {
                month = 12;
                year--;
            }
            weekStartDate = LocalDate.of(year, month, 1)
                    .minusDays(LocalDate.of(year, month, 1).getDayOfWeek().getValue() - 1); // Thứ Hai đầu tháng mới
        } else if ("next".equals(direction)) {
            LOGGER.info("Moving to next month...");
            month++;
            if (month > 12) {
                month = 1;
                year++;
            }
            weekStartDate = LocalDate.of(year, month, 1)
                    .minusDays(LocalDate.of(year, month, 1).getDayOfWeek().getValue() - 1); // Thứ Hai đầu tháng mới
        } else if ("prevWeek".equals(direction)) {
            LOGGER.info("Moving to previous week...");
            weekStartDate = weekStartDate.minusWeeks(1); // Lùi lại 1 tuần
            month = weekStartDate.getMonthValue();
            year = weekStartDate.getYear();
        } else if ("nextWeek".equals(direction)) {
            LOGGER.info("Moving to next week...");
            weekStartDate = weekStartDate.plusWeeks(1); // Tiến lên 1 tuần
            month = weekStartDate.getMonthValue();
            year = weekStartDate.getYear();
        }

        // Tính lại weekOffset dựa trên weekStartDate so với đầu tháng
        LocalDate firstMondayOfMonth = LocalDate.of(year, month, 1)
                .minusDays(LocalDate.of(year, month, 1).getDayOfWeek().getValue() - 1);
        int weekOffset = (int) ChronoUnit.WEEKS.between(firstMondayOfMonth, weekStartDate);

        LOGGER.info("Setting request attributes: mentorId=" + mentorId + ", selectedMonth=" + month
                + ", selectedYear=" + year + ", weekOffset=" + weekOffset + ", weekStartDate=" + weekStartDate);
        // Update request attributes
        request.setAttribute("mentorId", mentorId);
        request.setAttribute("selectedMonth", month);
        request.setAttribute("selectedYear", year);
        request.setAttribute("weekOffset", weekOffset);
        request.setAttribute("weekStartDate", weekStartDate);

        setScheduleData(request, mentorId, month, year, weekStartDate);

        LOGGER.info("Forwarding to MentorDetail.jsp with weekStartDate=" + weekStartDate);
        request.getRequestDispatcher("view/MentorDetail.jsp").forward(request, response);
    }

    private void setScheduleData(HttpServletRequest request, int mentorId, int month, int year, LocalDate weekStartDate)
            throws ServletException, IOException {
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
