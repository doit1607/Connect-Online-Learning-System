/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;
import entity.Schedule;
import entity.Attendance;
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

    public static void main(String[] args) {
        DAOatt dao = new DAOatt();
        
        try {
            dao.markAttendance(2189, 1, 1, true);
        } catch (SQLException ex) {
            Logger.getLogger(DAOatt.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    
}
