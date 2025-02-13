/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

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
