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
public class DAOMentor extends DBConnection {

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
                            rs.getString("reviews"),
                            rs.getDouble("pricePerSlot"),
                            rs.getString("expertise"),
                            rs.getString("bio"),
                            rs.getTimestamp("createdAt").toLocalDateTime(),
                            rs.getDouble("baseRate"),
                            rs.getDouble("multiplier"),
                            rs.getBoolean("is_deleted")
                    ));
                }
            }
        }
        return list;
    }

    public List<Mentor> getMentorsSuggestion() {
        List<Mentor> list = new ArrayList<>();
        String sql = "SELECT id, name, email, rating, reviews FROM Mentor ";

        try (PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                list.add(new Mentor(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getDouble("rating"),
                        rs.getString("reviews")
                ));
            }

        } catch (SQLException e) {
            e.printStackTrace(); 
        }

        return list;
    }
    
     public static void main(String[] args) {
        DAOMentor dao = new DAOMentor();

        List<Mentor> list = dao.getMentorsSuggestion();
        System.out.println(list);

    }

}
