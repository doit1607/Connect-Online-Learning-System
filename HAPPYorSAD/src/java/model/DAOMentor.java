package model;

import entity.Mentor;
import entity.User;
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

    public static DAOuser userDao = new DAOuser();

    public List<Mentor> getAllMentors(String search, int pageNumber, int pageSize) {
        List<Mentor> list = new ArrayList<>();

        if (pageSize <= 0) {
            pageSize = 10;
        }

        int offset = (pageNumber - 1) * pageSize; // Tính toán offset

        String sql = "SELECT m.id, m.name, m.email, m.rating, m.is_deleted, "
                + "m.reviews, m.price_per_slot, m.expertise, m.bio, m.created_at, m.base_rate, m.multiplier, m.user_id "
                + "FROM Mentor m "
                + "JOIN Users u ON m.user_id = u.id "
                + "WHERE (LOWER(m.name) LIKE LOWER(?) OR LOWER(m.email) LIKE LOWER(?) OR LOWER(m.expertise) LIKE LOWER(?)) "
                + "ORDER BY m.id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            String searchParam = "%" + search.toLowerCase() + "%";
            stmt.setString(1, searchParam);
            stmt.setString(2, searchParam);
            stmt.setString(3, searchParam);
            stmt.setInt(4, offset);
            stmt.setInt(5, pageSize);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Mentor mentor = new Mentor();
                    mentor.setId(rs.getInt("id"));
                    mentor.setName(rs.getString("name"));
                    mentor.setEmail(rs.getString("email"));
                    mentor.setRating(rs.getDouble("rating"));
                    mentor.setIsDeleted(rs.getBoolean("is_deleted"));
                    mentor.setReviews(rs.getString("reviews"));
                    mentor.setPricePerSlot(rs.getDouble("price_per_slot"));
                    mentor.setExpertise(rs.getString("expertise"));
                    mentor.setBio(rs.getString("bio"));
                    mentor.setCreatedAt(rs.getDate("created_at"));
                    mentor.setBaseRate(rs.getDouble("base_rate"));
                    mentor.setMultiplier(rs.getDouble("multiplier"));

                    User user = userDao.getMentorById(rs.getInt("user_id"));
                    mentor.setUser(user);

                    list.add(mentor);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public int getTotalMentors(String search) {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM Mentor WHERE LOWER(name) LIKE LOWER(?) OR LOWER(email) LIKE LOWER(?) OR LOWER(expertise) LIKE LOWER(?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            String searchParam = "%" + search.toLowerCase() + "%";
            stmt.setString(1, searchParam);
            stmt.setString(2, searchParam);
            stmt.setString(3, searchParam);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return total;
    }

    public List<Mentor> getMentorsSuggestion() {
        List<Mentor> list = new ArrayList<>();
        String sql = "SELECT * "
                + "FROM Mentor m "
                + "JOIN Users u ON m.user_id = u.id";

        try (PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Mentor mentor = new Mentor();
                mentor.setName(rs.getString("name"));
                mentor.setExpertise(rs.getString("expertise"));
                mentor.setPricePerSlot(rs.getDouble("price_per_slot"));
                mentor.setRating(rs.getDouble("rating"));
                User user = userDao.getMentorById(rs.getInt("user_id"));
                mentor.setUser(user);

                list.add(mentor);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void toggleMentorStatus(String userName, String newStatus) {
        String sql = "UPDATE Users SET status = ? WHERE username = ?";
        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setString(2, userName);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Mentor> getMentorsHome() {
        List<Mentor> list = new ArrayList<>();
        String sql = "SELECT m.id, m.name, m.expertise, m.rating, "
                + "COUNT(DISTINCT r.mentee_id) AS total_mentees, "
                + "COUNT(r.rating) AS rating_count "
                + "FROM Mentor m "
                + "LEFT JOIN Mentor_Reviews r ON m.id = r.mentor_id "
                + "GROUP BY m.id, m.name, m.expertise, m.rating "
                + "ORDER BY total_mentees DESC, rating_count DESC, m.rating DESC";

        try (PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {

                Mentor mentor = new Mentor();

                mentor.setId(rs.getInt("id"));
                mentor.setName(rs.getString("name"));
                mentor.setExpertise(rs.getString("expertise"));
                mentor.setRating(rs.getDouble("rating"));
                mentor.setTotalMentees(rs.getInt("total_mentees"));
                mentor.setRatingCount(rs.getInt("rating_count"));

                list.add(mentor);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list; // Return the list of mentors
    }

    public static void main(String[] args) {
        DAOMentor dao = new DAOMentor();

        String searchQuery = ""; //
        int pageNumber = 1;
        int pageSize = 5;

        if (pageSize <= 0) {
            System.out.println("Page size must be greater than zero.");
            return;
        }

        List<Mentor> mentors = dao.getAllMentors(searchQuery, pageNumber, pageSize);

        if (mentors.isEmpty()) {
            System.out.println("No mentors found.");
        } else {
            System.out.println("Mentors found on page " + pageNumber + ":");
            for (Mentor mentor : mentors) {
                System.out.println(mentor);
            }
        }
    }
}
