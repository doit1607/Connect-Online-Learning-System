/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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

        // Thêm code để lấy lịch của mentor (chỉ view)
        String selectedMonthStr = request.getParameter("month");
        String selectedYearStr = request.getParameter("year");
        int selectedMonth, selectedYear;

        // Xử lý tháng và năm từ request hoặc mặc định là tháng/năm hiện tại
        if (selectedMonthStr != null && selectedYearStr != null && !selectedMonthStr.isEmpty() && !selectedYearStr.isEmpty()) {
            try {
                selectedMonth = Integer.parseInt(selectedMonthStr);
                selectedYear = Integer.parseInt(selectedYearStr);
            } catch (NumberFormatException e) {
                selectedMonth = LocalDate.now().getMonthValue();
                selectedYear = LocalDate.now().getYear();
                LOGGER.info("Invalid month/year parameters. Defaulting to current: " + selectedMonth + "/" + selectedYear);
            }
        } else {
            selectedMonth = LocalDate.now().getMonthValue();
            selectedYear = LocalDate.now().getYear();
            LOGGER.info("No month/year provided. Defaulting to current: " + selectedMonth + "/" + selectedYear);
        }

        // Lấy danh sách lịch trình của mentor theo tháng/năm
        List<Schedule> schedules = daoSc.getSchedulesByMonth(selectedYear, selectedMonth);
        if (schedules.isEmpty()) {
            LOGGER.info("No schedules found for mentorId: " + mentorId + " in " + Month.of(selectedMonth) + " " + selectedYear);
            request.setAttribute("noSchedule", true);
        } else {
            int scheduleId = schedules.get(0).getId(); // Lấy scheduleId đầu tiên
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

            // Lấy danh sách slot theo ngày và chia thành allSlots và bookedSlots
            List<Slot> allSlots = new ArrayList<>(); // Tất cả slot
            List<Slot> bookedSlots = new ArrayList<>(); // Slot có is_booked = 1
            Map<String, List<Slot>> slotsByDay = new HashMap<>();

            for (String date : weekDates) {
                java.sql.Date sqlDate = java.sql.Date.valueOf(date);
                List<Slot> slots = daoSlot.getSlotsByDate1(sqlDate, mentorId); // Lấy slot từ DAO
                slotsByDay.put(date, slots);

                // Thêm vào allSlots và bookedSlots
                for (Slot slot : slots) {
                    allSlots.add(slot);
                    if (slot.isBooked() == true) {
                        bookedSlots.add(slot);
                    }
                }
                LOGGER.info("Slots for " + date + ": " + slots);
            }

            // Truyền dữ liệu lịch vào request
            request.setAttribute("weekDays", weekDays);
            request.setAttribute("weekDates", weekDates);
            request.setAttribute("slotsByDay", slotsByDay);
            request.setAttribute("allSlots", allSlots); // Thêm tất cả slot
            request.setAttribute("bookedSlots", bookedSlots); // Thêm slot booked
            LOGGER.info("Slots for 1 :" + allSlots);
            LOGGER.info("Slots for 2:" + bookedSlots);
            request.setAttribute("selectedMonth", selectedMonth);
            request.setAttribute("selectedYear", selectedYear);
        }

        // Chuyển hướng đến MentorDetail.jsp
        request.getRequestDispatcher("view/MentorDetail.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet to display mentor details and schedule for viewing";
    }// </editor-fold>
}
