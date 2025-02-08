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
        String sql = "Select u.avatar_path, m.name, u.username, "
                + "m.expertise, m.email, m.reviews, m.rating, "
                + "m.price_per_slot\n"
                + "from Mentor m \n"
                + "join Users u on u.id = m.user_id";
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

    public List<Mentor> getMentorsHome() {
        List<Mentor> list = new ArrayList<>();
        String sql = "SELECT "
                + "    m.image, "
                + "    m.name, "
                + "    m.expertise, "
                + "    m.rating, "
                + "    COUNT(DISTINCT r.mentee_id) AS total_mentees, "
                + "    COUNT(r.rating) AS rating_count "
                + "FROM Mentor m "
                + "LEFT JOIN Mentor_Reviews r ON m.id = r.mentor_id "
                + "LEFT JOIN Users u ON r.mentee_id = u.id AND u.role = 'mentee' "
                + "GROUP BY m.image, m.name, m.expertise, m.rating "
                + "ORDER BY total_mentees DESC, rating_count DESC, rating DESC";

        try (PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                list.add(new Mentor(rs.getString("name"),
                        rs.getDouble("rating"), rs.getString("expertise"),
                        rs.getString("image"), rs.getInt("total_mentees"),
                        rs.getInt("rating_count"))
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public static void main(String[] args) {
        DAOMentor dao = new DAOMentor();

        List<Mentor> list = dao.getMentorsHome();
        System.out.println(list);

    }

}
