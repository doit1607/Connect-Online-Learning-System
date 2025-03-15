/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;
import entity.Schedule;
import entity.Attendance;
import entity.Mentee;
import entity.Request;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.logging.Level;
import java.time.LocalDate;
import java.util.logging.Logger;

/**
 *
 * @author Ann
 */
public class DAOatt extends DBConnection {

    public void markAttendance(int slotId, int mentorId, int menteeId, boolean isDone) throws SQLException {
        String sql = "INSERT INTO Attendance (slot_id, mentor_id, mentee_id, is_done, marked_at) VALUES (?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, slotId);
        ps.setInt(2, mentorId);
        ps.setInt(3, menteeId);
        ps.setBoolean(4, isDone);
        ps.executeUpdate();
        System.out.println("Attendance marked successfully!"); // Xác nhận

    }

    public Attendance getAttendance(int slotId, int mentorId) throws SQLException {
        String sql = "SELECT * FROM Attendance WHERE slot_id = ? AND mentor_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, slotId);
        ps.setInt(2, mentorId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return new Attendance(
                    rs.getInt("id"),
                    rs.getInt("slot_id"),
                    rs.getInt("mentor_id"),
                    rs.getInt("mentee_id"),
                    rs.getBoolean("is_done"),
                    rs.getDate("marked_at")
            );
        }
        return null;
    }

    // Kiểm tra xem tất cả slot của requestId có trạng thái "present" không
    public boolean checkAllSlotsPresent(int requestId) {
        String sql = "SELECT \n"
                + "    COUNT(*) AS total, \n"
                + "    SUM(CASE WHEN status = 'present' THEN 1 ELSE 0 END) AS presentCount,\n"
                + "    SUM(CASE WHEN status = 'absent' THEN 1 ELSE 0 END) AS absentCount\n"
                + "FROM Mentee_Slot \n"
                + "WHERE request_id = ?;";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, requestId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int total = rs.getInt("total");
                int presentCount = rs.getInt("presentCount");
                int absentCount = rs.getInt("absentCount");

                return total > 0 && total == (presentCount + absentCount); // True nếu tất cả slot đều "present"
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy thông tin chi tiết của request
//    public Request getRequestDetails(int requestId) {
//        String sql = "SELECT title, menteeId, startDate, endDate, content, status " +
//                     "FROM Request WHERE requestId = ?";
//        try (Connection conn = DBConnection.getConnection();
//             PreparedStatement stmt = conn.prepareStatement(sql)) {
//            stmt.setInt(1, requestId);
//            ResultSet rs = stmt.executeQuery();
//            if (rs.next()) {
//                Request request = new Request();
//                request.setRequestId(requestId);
//                request.setTitle(rs.getString("title"));
//                request.setMenteeId(rs.getInt("menteeId"));
//                request.setStartDate(rs.getDate("startDate"));
//                request.setEndDate(rs.getDate("endDate"));
//                request.setContent(rs.getString("content"));
//                request.setStatus(rs.getString("status"));
//                return request;
//            }
//        } catch (SQLException e) {
//            LOGGER.log(Level.SEVERE, "Error getting request details for requestId: " + requestId, e);
//        }
//        return null;
//    }
    // Lấy thông tin mentee dựa trên requestId
//    public Mentee getMenteeByRequestId(int requestId) {
//        String sql = "SELECT m.menteeId, m.name, m.email, m.avatarPath " +
//                     "FROM Mentee m " +
//                     "JOIN Request r ON m.menteeId = r.menteeId " +
//                     "WHERE r.requestId = ?";
//        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
//            stmt.setInt(1, requestId);
//            ResultSet rs = stmt.executeQuery();
//            if (rs.next()) {
//                Mentee mentee = new Mentee();
//                mentee.setMenteeId(rs.getInt("menteeId"));
//                mentee.setName(rs.getString("name"));
//                mentee.setEmail(rs.getString("email"));
//                mentee.setAvatarPath(rs.getString("avatarPath"));
//                return mentee;
//            }
//        } catch (SQLException e) {
//            LOGGER.log(Level.SEVERE, "Error getting mentee for requestId: " + requestId, e);
//        }
//        return null;
//    }
    public static void main(String[] args) {
        DAOatt dao = new DAOatt();

        try {
            dao.markAttendance(2189, 1, 1, true);
        } catch (SQLException ex) {
            Logger.getLogger(DAOatt.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
