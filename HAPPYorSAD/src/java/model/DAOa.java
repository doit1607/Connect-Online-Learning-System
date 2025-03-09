/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Attendance;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import static model.DBConnection.conn;

/**
 *
 * @author Ann
 */
public class DAOa extends DBConnection {

    public void markAttendance(int slotId, int mentorId, int menteeId, boolean isDone) throws SQLException {
        String sql = "INSERT INTO Attendance (slot_id, mentor_id, mentee_id, is_done, marked_at) VALUES (?, ?, ?, ?, GETDATE())";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, slotId);
        ps.setInt(2, mentorId);
        ps.setInt(3, menteeId);
        ps.setBoolean(4, isDone);
        ps.executeUpdate();
        System.out.println("Attendance marked successfully!");
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
      System.out.println("Hello from DAOMentor!");
    }
}
