package controller;

import entity.Mentee;
import entity.Mentee_Slot;
import entity.Mentor;
import entity.Request;
import entity.Slot;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DAOslot;
import model.DAOmentee;
import model.DAOMentor;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.Month;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.DAORequest;
import model.DAOatt;
import model.DAOmentee_Slot;
import model.DAOmentor_Slot;
import model.DAOschedule;

public class AttendanceMentee extends HttpServlet {

    private final DAOslot daoSlot = new DAOslot();
    private final DAOmentee daoMentee = new DAOmentee();
    private final DAOMentor daoMentor = new DAOMentor();
    private static final java.util.logging.Logger LOGGER = java.util.logging.Logger.getLogger(AttendanceMentee.class.getName());
    private final DAOschedule daoSc = new DAOschedule();
    private final DAOmentee_Slot daoMSL = new DAOmentee_Slot();
    private final DAOmentor_Slot daoMeSL = new DAOmentor_Slot();
    private final DAOatt daoA = new DAOatt();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("/HAPPYorSAD/view/LoginUser.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        Integer menteeId = daoMentee.getMenteeIdByUserId(userId); // Assume this method exists

        int selectedMonth = LocalDate.now().getMonthValue();
        int selectedYear = LocalDate.now().getYear();
        String selectedMonthStr = request.getParameter("month");
        String selectedYearStr = request.getParameter("year");

        if (selectedMonthStr != null && selectedYearStr != null && !selectedMonthStr.isEmpty() && !selectedYearStr.isEmpty()) {
            try {
                selectedMonth = Integer.parseInt(selectedMonthStr);
                selectedYear = Integer.parseInt(selectedYearStr);
                LOGGER.info("User selected month: " + selectedMonth + ", year: " + selectedYear);
            } catch (NumberFormatException e) {
                LOGGER.warning("Invalid month/year format, defaulting to current: " + e.getMessage());
            }
        } else {
            LOGGER.info("No month/year selected, using default: " + selectedMonth + ", " + selectedYear);
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
        request.setAttribute("scheduleId", scheduleId);
        String[] weekDays = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
        request.setAttribute("weekDays", weekDays);
        int weekOffset = 0;
        String weekOffsetStr = request.getParameter("weekOffset");
        if (weekOffsetStr != null) {
            try {
                weekOffset = Integer.parseInt(weekOffsetStr);
            } catch (NumberFormatException e) {
                LOGGER.warning("Invalid weekOffset, defaulting to 0: " + e.getMessage());
            }
        }
        List<String> weekDates = new ArrayList<>();
        java.sql.Date startDate = daoSc.getStartDateByScheduleId(scheduleId);
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        if (startDate != null) {
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(startDate);
            calendar.add(Calendar.WEEK_OF_YEAR, weekOffset);
            calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);

            for (int i = 0; i < 7; i++) {
                weekDates.add(new java.sql.Date(calendar.getTimeInMillis()).toLocalDate().format(dateFormatter));
                calendar.add(Calendar.DATE, 1);
            }
        }
        request.setAttribute("weekDates", weekDates);

        String weekStartDate = weekDates.isEmpty() ? "" : weekDates.get(0);
        String weekEndDate = weekDates.isEmpty() ? "" : weekDates.get(6);
        request.setAttribute("weekOffset", weekOffset);
        request.setAttribute("weekStartDate", weekStartDate);
        request.setAttribute("weekEndDate", weekEndDate);

        Map<String, List<Mentee_Slot>> slotsByDay = new HashMap<>();
        // Fetch slots for the mentee using DAOslot
        if (startDate != null && menteeId != null) {
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(startDate);
            calendar.add(Calendar.WEEK_OF_YEAR, weekOffset);
            calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);

            for (int i = 0; i < 7; i++) {
                java.sql.Date date = new java.sql.Date(calendar.getTimeInMillis());
                String formattedDate = date.toLocalDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                slotsByDay.put(formattedDate, daoMSL.getSlotsByDateMenteeAttendance(date, menteeId));
                calendar.add(Calendar.DATE, 1);
            }

        }

        System.out.println(slotsByDay);
        request.setAttribute("weekDates", weekDates);
        request.setAttribute("slotsByDay", slotsByDay);
        request.setAttribute("weekStartDate", weekStartDate);
        request.setAttribute("weekEndDate", weekEndDate);
        request.setAttribute("selectedMonth", selectedMonth);
        request.setAttribute("selectedYear", selectedYear);
        request.setAttribute("weekOffset", weekOffset);

        request.getRequestDispatcher("/view/AttendanceMentee.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("getMentorInfo".equals(action)) {
            String date = request.getParameter("date");
            String dateString = request.getParameter("date");
            int slotNumber = Integer.parseInt(request.getParameter("slot"));
            Slot slot = daoSlot.getSlotByDateAndNumberr(date, slotNumber);

            Mentor mentor = daoMeSL.getMentorBySlotId(date, slotNumber); // Assume this method exists
            request.setAttribute("mentor", mentor);
            request.setAttribute("slot", slot); // Thêm slot để hiển thị trạng thái
            request.setAttribute("selectedDate", date);
            request.setAttribute("selectedSlot", slotNumber);
            request.setAttribute("showModal", true);
            doGet(request, response);
        } else if ("confirmAttendance".equals(action)) {
            String date = request.getParameter("date");
            int slotNumber = Integer.parseInt(request.getParameter("slot"));
            String menteeConfirmation = request.getParameter("confirmation"); // "confirm" hoặc "reject"

            Slot slot = daoSlot.getSlotByDateAndNumberr(date, slotNumber);
            if (slot != null) {
                String currentStatus = slot.getStatus();
                System.out.println("Current Status: " +currentStatus);
                try {
                    if (currentStatus.equals("confirm_present") || currentStatus.equals("confirm_absent")) {
                        if ("confirm".equals(menteeConfirmation)) {

                            // Xác nhận: Chuyển trạng thái từ pending_present/absent sang present/absent
                            String finalStatus = currentStatus.equals("confirm_present") ? "present" : "absent";
                            daoMSL.updateMenteeSlotStatusCF(slot.getId(), finalStatus);

                            if ("absent".equals(finalStatus)) {
                                daoMeSL.updateSlotStatus(slot.getId(), "Cancle");
                            } else if ("present".equals(finalStatus)) {
                                daoMeSL.updateSlotStatus(slot.getId(), "Done");
                            }
                            LOGGER.info("Attendance confirmed as: " + finalStatus + " for Slot " + slotNumber + " on " + date);
                            request.setAttribute("message", "Attendance confirmed successfully as " + finalStatus + "!");

//                             Kiểm tra xem tất cả slot của requestId có "present" không
                            int requestId = slot.getRequest_id();

                            DAORequest daoR = new DAORequest();
                            boolean allPresent = daoA.checkAllSlotsPresent(requestId);
                            System.out.println(requestId);

                            if (allPresent) {
                                Request requestDetails = daoR.getRequestById(requestId);
                                System.out.println(requestDetails);
                                System.out.println("Đã hoàn thành khóa tất cả Slot trong request");
                                if (requestDetails != null) {
                                    Mentee mentee = daoMentee.getMenteeById(requestDetails.getMenteeId());
                                    if (mentee != null) {
                                        String notification = "Đã hoàn thành " + requestDetails.getTitle() + " của " + mentee.getName() + ". Nhấn để xác nhận.";
                                        request.setAttribute("notification", notification);
                                        request.setAttribute("requestId", requestId);
                                        request.setAttribute("showCompletionModal", true); // Add this flag
                                    } else {
                                        System.out.println("Mentee not found for requestId: " + requestId);
                                    }
                                } else {
                                    System.out.println("Request details not found for requestId: " + requestId);
                                }
                            }
                            

                        } else if ("reject".equals(menteeConfirmation)) {
                            // Từ chối: Giữ trạng thái pending để mentor chỉnh sửa lại
                            LOGGER.info("Mentee rejected confirmation for Slot " + slotNumber + " on " + date + ", status remains " + currentStatus);
                            request.setAttribute("message", "Attendance rejected. Please wait for mentor to update.");
                        }
                    } else {
                        LOGGER.warning("Slot status is not pending: " + currentStatus);
                        request.setAttribute("error", "Cannot confirm attendance: Status is already " + currentStatus);
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(AttendanceMentee.class.getName()).log(Level.SEVERE, "Error updating slot status", ex);
                    request.setAttribute("error", "An error occurred while confirming attendance.");
                }
            } else {
                LOGGER.warning("Slot not found for Date: " + date + ", Slot: " + slotNumber);
                request.setAttribute("error", "Slot not found.");
            }

            doGet(request, response);
        } else {
            LOGGER.warning("Unknown action: " + action);
            request.setAttribute("error", "Invalid action.");
            doGet(request, response);
        }
    }
}
