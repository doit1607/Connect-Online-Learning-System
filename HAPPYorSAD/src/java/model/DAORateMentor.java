/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Mentor;
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

        // insert gia tri cho bang mentor_review
        String sql = "INSERT INTO mentor_reviews (mentor_id, mentee_id, rating, comment, created_at) VALUES (?, ?, ?, ?, GETDATE())";

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

    // lay user_mentee_id de rating cho mentor
    public int getMenteeIdByUsername(String username) {
        int userID = -1;
        String sql = "SELECT me.id FROM Mentee me \n"
                + "JOIN Users u ON me.user_id = u.id \n"
                + "WHERE u.username = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, username);
            try (ResultSet rs = pre.executeQuery()) {
                if (rs.next()) {
                    userID = rs.getInt("id");
                }
            }
        } catch (Exception e) {
        }
        return userID;
    }

    // lay ra nhung mentee tu Request co trang thai la Completed de review
    public String getRequestStatusByMentee(String username) {
        String status = "";
        String sql = "SELECT  r.status FROM Request r join Mentee m on r.mentee_id = m.id\n"
                + "WHERE m.id = (SELECT m.id FROM Users u join Mentee m on u.id = m.user_id WHERE u.username = ?) and r.status = 'Completed'\n"
                + "ORDER BY m.id DESC";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, username);
            try (ResultSet rs = pre.executeQuery()) {
                if (rs.next()) {
                    status = rs.getString("status");
                }
            }
        } catch (SQLException e) {
        }
        return status;
    }

    // lay Mentor de danh gia
    public List<Mentor> getAllMentors(int menteeId) {
        List<Mentor> mentors = new ArrayList<>();
        String sql = "SELECT DISTINCT mo.id, mo.name FROM Mentor mo \n"
                + "               JOIN mentor_reviews mr ON mo.id = mr.mentor_id \n"
                + "               WHERE mr.mentee_id = ?";

        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, menteeId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Mentor mentor = new Mentor();
                mentor.setId(rs.getInt("id"));
                mentor.setName(rs.getString("name"));
                mentors.add(mentor);
            }
        } catch (Exception e) {
        }
        return mentors;
    }

    // Lay danh gia Mentor de hien thi
    public MentorReview getReviewByMenteeAndMentor(int mentorId) {
        MentorReview review = null;
        String sql = "select TOP 1 rating, comment from mentor_reviews \n"
                + "WHERE mentor_id = ?\n"
                + "order by created_at desc";

        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, mentorId);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                review = new MentorReview();
                review.setRating(rs.getInt("rating"));
                review.setCommit(rs.getString("comment"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return review;
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

    public List<Integer> getReviewedMentorsByMentee(String username) {
        List<Integer> reviewedMentors = new ArrayList<>();
        String sql = "SELECT DISTINCT mentor_id FROM mentor_reviews \n"
                + "WHERE mentee_id = (SELECT id FROM Mentee WHERE name = ?)";

        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, username);
            ResultSet rs = pre.executeQuery();

            while (rs.next()) {
                reviewedMentors.add(rs.getInt("mentor_id"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reviewedMentors;
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

    // Lay ra list Mentor duoc rate cho vao Detail
    public List<MentorReview> getMentorRate(int mentorId) {
        List<MentorReview> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "    mr.*, \n"
                + "    m.name AS mentee_name, \n"
                + "    m.image AS mentee_image\n"
                + "FROM \n"
                + "    mentor_reviews mr\n"
                + "JOIN \n"
                + "    mentee m ON mr.mentee_id = m.id\n"
                + "WHERE \n"
                + "    mr.mentor_id = ?;";

        try (PreparedStatement pre = conn.prepareStatement(sql)) {
            pre.setInt(1, mentorId);

            try (ResultSet rs = pre.executeQuery()) {
                while (rs.next()) {
                    list.add(new MentorReview(
                            rs.getInt("rating"),
                            rs.getString("comment"),
                            rs.getString("mentee_name"),
                            rs.getString("mentee_image"))
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Hiển thị lỗi để debug
        }
        return list;
    }

    public static void main(String[] args) {
        DAORateMentor dao = new DAORateMentor();
//        boolean result = dao.submitReview(10, 7, 5, "very good");
//
//        if (result) {
//            System.out.println("Review submitted successfully!");
//        } else {
//            System.out.println("Failed to submit review.");
//        }
//        int test = dao.getMenteeIdByUsername("jane_smith");
//        System.out.println(test);
//        MentorReview mr = dao.getReviewByMenteeAndMentor(1);
//        System.out.println(mr);
        List<MentorReview> list = dao.getMentorRate(2);
        for (MentorReview mentorReview : list) {
            System.out.println(mentorReview);
        }
    }
}
