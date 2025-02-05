/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Ann
 */
public class DAOuser extends DBConnection {

    public boolean loginUser(String username, String password) {
        try {
            String sql = "Select * from [User] where username = ? and password = ?";
            PreparedStatement state = conn.prepareStatement(sql);
            state.setString(1, username);
            state.setString(2, password);
            ResultSet rs = state.executeQuery();
            if (rs.next()) {
                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public void addUser(User u) {
        try {

            String sql = "INSERT INTO [dbo].[User] "
                    + "([username], [avatar_path], [password], [status], [email], [phone_number], "
                    + "[date_of_birth], [gender], [created_at], [role], [is_guest]) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, u.getUsername());
            stmt.setString(2, u.getAvatarPath());
            stmt.setString(3, u.getPassword());
            stmt.setString(4, u.getStatus());
            stmt.setString(5, u.getEmail());
            stmt.setString(6, u.getPhoneNumber());
            stmt.setDate(7, new java.sql.Date(u.getDateOfBirth().getTime()));
            stmt.setString(8, u.getGender());
            stmt.setDate(9, new java.sql.Date(u.getCreatedAt().getTime()));
            stmt.setString(10, u.getRole());
            stmt.setBoolean(11, u.getIsGuest());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();

        }
    }

    public boolean checkUsernameExist(String username) {
        try {
            String sql = "Select * from [User] where username = ? ";
            PreparedStatement state = conn.prepareStatement(sql);
            state.setString(1, username);
            ResultSet rs = state.executeQuery();
            if (rs.next()) {
                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public String getPasswordByUsername(String username) {
        String password;
        try {
            String sql = "SELECT password FROM User WHERE username = ?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                password = rs.getString("password");
                return password;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public void UpdatePassword(String username, String password) {
        try {
            String Sql = "UPDATE User SET password = ? WHERE username = ?";
            PreparedStatement st = conn.prepareStatement(Sql);
            st.setString(1, password);
            st.setString(2, username);
            int rowsUpdated = st.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // fetch Mentee by id
    public User getMenteeById(int id) {
        User mentee = null;
        String sql = "Select * from [User] where id = ? and role = 'mentee'";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, id);
            try (ResultSet rs = pre.executeQuery()) {
                if (rs.next()) {
                    mentee = new User();
                    mentee.setUsername(rs.getString("username"));
                    mentee.setAvatarPath(rs.getString("avatar_path"));
                    mentee.setFullname(rs.getString("fullname"));
                    mentee.setEmail(rs.getString("email"));
                    mentee.setPhoneNumber(rs.getString("phone_number"));
                    mentee.setAddress(rs.getString("address"));
                    mentee.setDateOfBirth(rs.getDate("date_of_birth"));
                    mentee.setGender(rs.getString("gender"));
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return mentee;
    }

    // Update Mentee profile
    public boolean updateMenteeProfile(User mentee) {
        boolean isUpdate = false;
        String sql = "Update [User] set avatar_path = ?, fullname = ?, phone_number = ?,"
                + "address = ?, date_of_birth = ?, gender = ? WHERE username = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, mentee.getAvatarPath());
            pre.setString(2, mentee.getFullname());
            pre.setString(3, mentee.getPhoneNumber());
            pre.setString(4, mentee.getAddress());
            pre.setDate(5, new java.sql.Date(mentee.getDateOfBirth().getTime()));
            pre.setString(6, mentee.getGender());
            pre.setString(7, mentee.getUsername());

            int rowsAffected = pre.executeUpdate();
            isUpdate = rowsAffected > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return isUpdate;
    }
    
    // fetch Mentor by id
    public User getMentorById(int id) {
        User mentor = null;
        String sql = "Select * from [User] where id = ? and role = 'mentor'";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, id);
            try (ResultSet rs = pre.executeQuery()) {
                if (rs.next()) {
                    mentor = new User();
                    mentor.setUsername(rs.getString("username"));
                    mentor.setAvatarPath(rs.getString("avatar_path"));
                    mentor.setFullname(rs.getString("fullname"));
                    mentor.setEmail(rs.getString("email"));
                    mentor.setPhoneNumber(rs.getString("phone_number"));
                    mentor.setAddress(rs.getString("address"));
                    mentor.setDateOfBirth(rs.getDate("date_of_birth"));
                    mentor.setGender(rs.getString("gender"));
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return mentor;
    }

    // Update Mentor profile
    public boolean updateMentorProfile(User mentor) {
        boolean isUpdate = false;
        String sql = "Update [User] set avatar_path = ?, fullname = ?, phone_number = ?,"
                + "address = ?, date_of_birth = ?, gender = ? WHERE username = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, mentor.getAvatarPath());
            pre.setString(2, mentor.getFullname());
            pre.setString(3, mentor.getPhoneNumber());
            pre.setString(4, mentor.getAddress());
            pre.setDate(5, new java.sql.Date(mentor.getDateOfBirth().getTime()));
            pre.setString(6, mentor.getGender());
            pre.setString(7, mentor.getUsername());

            int rowsAffected = pre.executeUpdate();
            isUpdate = rowsAffected > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return isUpdate;
    }
}
