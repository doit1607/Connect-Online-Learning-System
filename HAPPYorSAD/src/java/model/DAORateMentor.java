/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.MentorReview;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class DAORateMentor extends DBConnection {

    public boolean submitReview(int mentorId, int menteeId, int rating, String comment) {
        boolean isUpdated = false;

        String sql = "INSERT INTO mentor_reviews (mentor_Id, mentee_Id, rating, comment) VALUES (?, ?, ?, ?)";

        try (PreparedStatement insertStmt = conn.prepareStatement(sql)) {
            insertStmt.setInt(1, mentorId);
            insertStmt.setInt(2, menteeId);
            insertStmt.setInt(3, rating);
            insertStmt.setString(4, comment);
            isUpdated = insertStmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isUpdated;
    }
    public List<MentorReview> getReviewsByMentor(String username) {
        List<MentorReview> reviews = new ArrayList<>();
        String sql = "SELECT mr.* FROM mentor_reviews mr "
                   + "JOIN Mentor m ON mr.mentor_id = m.id "
                   + "JOIN Users u ON m.user_id = u.id "
                   + "WHERE u.username = ? "
                   + "ORDER BY mr.created_at DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    MentorReview review = new MentorReview(
                        rs.getInt("id"),
                        rs.getInt("mentor_id"),

                        rs.getInt("mentee_id"),
                        rs.getInt("rating"),
                        rs.getString("comment"),
                        rs.getTimestamp("created_at").toLocalDateTime()
                    );
                    reviews.add(review);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviews;
    }
    public List<MentorReview> getReviewsByMentorAndStar(String username, int star) {
        List<MentorReview> reviews = new ArrayList<>();
        String sql = "SELECT mr.* FROM mentor_reviews mr "
                   + "JOIN Mentor m ON mr.mentor_id = m.id "
                   + "JOIN Users u ON m.user_id = u.id "
                   + "WHERE u.username = ? AND mr.rating = ?"
                   + "ORDER BY mr.created_at DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setInt(2, star);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    MentorReview review = new MentorReview(
                            rs.getInt("id"),
                                                    rs.getInt("mentor_id"),

                        rs.getInt("mentee_id"),
                        rs.getInt("star"),
                        rs.getString("comment"),
                        rs.getTimestamp("created_at").toLocalDateTime()
                    );
                    reviews.add(review);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviews;
    }
    
    

    public static void main(String[] args) {
        DAORateMentor dao = new DAORateMentor();
        boolean result = dao.submitReview(2, 3, 5, "very good");

        if (result) {
            System.out.println("Review submitted successfully!");
        } else {
            System.out.println("Failed to submit review.");
        }
    }
}
