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
    
    //insert a new rating and commit
    public boolean submitReview(int mentor_id, int mentee_id, int rating, String commit) {
        String sql = "INSERT INTO mentor_reviews (mentor_id, mentee_id, rating, comment) "
                + "VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, mentor_id);
            pre.setInt(2, mentee_id);
            pre.setInt(3, rating);
            pre.setString(4, commit);
            
            return pre.executeUpdate() > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }
    
    //fetch all reviews for a mentor
    public List<MentorReview> getReviewByMentorId(int mentorId) {
        List<MentorReview> reviews = new ArrayList<>();
        String sql = "Select * from mentor_reviews where mentor_id = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, mentorId);
            try(ResultSet rs = pre.executeQuery()) {
                while (rs.next()) {
                    MentorReview review = new MentorReview();
                    review.setId(rs.getInt("id"));
                    review.setMentorID(rs.getInt("mentor_id"));
                    review.setMenteeID(rs.getInt("mentee_id"));
                    review.setRating(rs.getInt("rating"));
                    review.setCommit(rs.getString("commit"));
                    review.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    reviews.add(review);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return reviews;
    }
}
