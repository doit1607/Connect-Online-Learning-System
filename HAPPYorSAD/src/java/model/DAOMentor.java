/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import entity.Mentor;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
/**
 *
 * @author Dell
 */
public class DAOMentor {
     private Connection conn;

    public DAOMentor(Connection conn) {
        this.conn = conn;
    } 

    public List<Mentor> getMentors(String search) throws SQLException {
        List<Mentor> list = new ArrayList<>();
        String sql = "SELECT * FROM Mentor WHERE name LIKE ? OR email LIKE ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + search + "%");
            stmt.setString(2, "%" + search + "%");

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(new Mentor(
                        rs.getInt("id"),
                        rs.getInt("mentorId"),
                        rs.getInt("userId"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getDouble("rating"),
                        rs.getInt("reviews"),
                        rs.getDouble("pricePerSlot"),
                        rs.getString("expertise"),
                        rs.getString("bio"),
                        rs.getTimestamp("createdAt").toLocalDateTime(),
                        rs.getDouble("baseRate"),
                        rs.getDouble("multiplier")
                    ));
                }
            }
        }
        return list;
    }
}
