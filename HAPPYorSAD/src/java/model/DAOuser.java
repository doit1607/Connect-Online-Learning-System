/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.Scanner;
import static model.DBConnection.conn;

/**
 *
 * @author Ann
 */
public class DAOuser extends DBConnection {
     public User getMentorById(int id) {
        User mentor = null;
        String sql = "Select * from Users where id = ? and role = 'mentor'";
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
                     mentor.setStatus(rs.getString("status"));
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return mentor;
    }


    public boolean loginUser(String username, String password) {
        try {
            String sql = "Select * from Users where username = ? and password = ?";
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
     public boolean checkUsernameandEmail(String username, String email) {
        try {
            String sql = "Select * from Users where username = ? and email = ?";
            PreparedStatement state = conn.prepareStatement(sql);
            state.setString(1, username);
            state.setString(2, email);
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
            String sql = "INSERT INTO [dbo].Users "
                    + "([username], [fullname], [avatar_path], [password], [status], [email], "
                    + "[address], [phone_number], [date_of_birth], [gender], [created_at], [role], [is_guest]) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, u.getUsername());
            stmt.setString(2, u.getFullname());

            if (u.getAvatarPath() != null) {
                stmt.setString(3, u.getAvatarPath());
            } else {
                stmt.setNull(3, java.sql.Types.VARCHAR);
            }

            stmt.setString(4, u.getPassword());
            stmt.setString(5, u.getStatus());
            stmt.setString(6, u.getEmail());
            stmt.setString(7, u.getAddress());
            stmt.setString(8, u.getPhoneNumber());

            if (u.getDateOfBirth() != null) {
                stmt.setDate(9, new java.sql.Date(u.getDateOfBirth().getTime()));
            } else {
                stmt.setNull(9, java.sql.Types.DATE);
            }

            stmt.setString(10, u.getGender());
            if (u.getCreatedAt() != null) {
                stmt.setTimestamp(11, new java.sql.Timestamp(u.getCreatedAt().getTime()));
            } else {
                stmt.setNull(11, java.sql.Types.TIMESTAMP);
            }

            stmt.setString(12, u.getRole());
            stmt.setBoolean(13, false);

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public String getRole(String username) {
        String sql = "Select role from Users where username = ?";
        String role = null;
        try {

            PreparedStatement state = conn.prepareStatement(sql);
            state.setString(1, username);
            ResultSet rs = state.executeQuery();
            if (rs.next()) {
                role = rs.getString("role");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return role;
    }

    public boolean checkUsernameExist(String username) {
        try {
            String sql = "Select * from Users where username = ? ";
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

    public boolean checkUserActive(String username) {
        try {
            String sql = "Select * from Users where username = ? and status = 'active'";
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

    public void deleteUserByEmail(String email) {
        String sql = "DELETE FROM Users WHERE email = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean isActivationExpired(String email) {
        String sql = "SELECT created_at FROM Users WHERE email = ? AND status = 'Inactive'";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                java.sql.Timestamp createdAt = rs.getTimestamp("created_at");
                java.sql.Timestamp now = new java.sql.Timestamp(System.currentTimeMillis());

                long diffInMinutes = (now.getTime() - createdAt.getTime()) / (60 * 1000);
                return diffInMinutes > 15;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return true;
    }

    public boolean checkEmailExist(String email) {
        try {
            String sql = "Select * from Users where email = ? ";
            PreparedStatement state = conn.prepareStatement(sql);
            state.setString(1, email);
            ResultSet rs = state.executeQuery();
            if (rs.next()) {
                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkEmailActive(String email) {
        try {
            String sql = "Select * from Users where email = ? and status = 'Inactive";
            PreparedStatement state = conn.prepareStatement(sql);
            state.setString(1, email);
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
            String sql = "SELECT password FROM Users WHERE username = ?";
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

    public void updatePassword(String username, String password) {
        try {
            String Sql = "UPDATE Users SET password = ? WHERE username = ?";
            PreparedStatement st = conn.prepareStatement(Sql);
            st.setString(1, password);
            st.setString(2, username);
            int rowsUpdated = st.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean checkActiveExpire(String email) {
        try {
            String sql = "UPDATE Users SET status = 'Active' WHERE email = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean activateUser(String email) {
        try {
            String sql = "UPDATE Users SET status = 'active' WHERE email = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update Mentee profile
    public void updateMenteeProfile(String username, String avatar, String fullname, String address,
            Date dob, String gender) {
        String sql = "Update Users set avatar_path = ?, fullname = ?,"
                + "address = ?, date_of_birth = ?, gender = ? WHERE username = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, avatar);
            pre.setString(2, fullname);
            pre.setString(3, address);
            pre.setDate(4, new java.sql.Date(dob.getTime()));
            pre.setString(5, gender);
            pre.setString(6, username);

            pre.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public User getMenteeByUsername(String username) {

        String sql = "Select * from Users where username = ? and role = 'mentee'";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, username);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                return new User(rs.getString(4), rs.getString(2), rs.getString(3),
                        rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(9),
                        rs.getString(8), rs.getDate(10), rs.getDate(12), rs.getString(11),
                        rs.getString(13), true);
            }
//            try {
//                if (rs.next()) {
//                    mentor = new User();
//                    mentor.setUsername(rs.getString("username"));
//                    mentor.setAvatarPath(rs.getString("avatar_path"));
//                    mentor.setFullname(rs.getString("fullname"));
//                    mentor.setEmail(rs.getString("email"));
//                    mentor.setPhoneNumber(rs.getString("phone_number"));
//                    mentor.setAddress(rs.getString("address"));
//                    mentor.setDateOfBirth(rs.getDate("date_of_birth"));
//                    mentor.setGender(rs.getString("gender"));
//                }
//            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public User getMentorByUsername(String username) {
        String sql = "Select * from Users where username = ? and role = 'mentor'";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, username);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                return new User(rs.getString("avatar_path"), rs.getString("username"), rs.getString("fullname"),
                        rs.getString("password"), rs.getString("status"), rs.getString("email"),
                        rs.getString("phone_number"),
                        rs.getString("address"), rs.getDate("date_of_birth"), rs.getDate("created_at"),
                        rs.getString("gender"),
                        rs.getString("role"), true);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    // Update Mentor profile
    public void updateMentorProfile(String username, String avatar, String fullname, String address,
            Date dob, String gender) {
        String sql = "Update Users set avatar_path = ?, fullname = ?,"
                + "address = ?, date_of_birth = ?, gender = ? WHERE username = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, avatar);
            pre.setString(2, fullname);
            pre.setString(3, address);
            pre.setDate(4, new java.sql.Date(dob.getTime()));
            pre.setString(5, gender);
            pre.setString(6, username);

            pre.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public User getMentorProfile(int userId) {
        String sql = "SELECT u.fullname, u.username, m.created_at, "
                + "u.email, u.phone_number, m.bio "
                + "FROM Users u "
                + "JOIN Mentor m ON m.user_id = u.id "
                + "WHERE u.id = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, userId);  // Truyền tham số userId
            ResultSet rs = pre.executeQuery();

            if (rs.next()) {  // Nếu có dữ liệu thì lấy
                User user = new User(rs.getString("username"),
                        rs.getString("fullname"),
                        rs.getString("email"),
                        rs.getString("phone_number"),
                        rs.getTimestamp("created_at"), // Sử dụng getTimestamp()
                        rs.getString("bio"));
                rs.close();
                pre.close();
                return user;
            }
            rs.close();
            pre.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }
     public User getMenteeProfile(int userId) {
        String sql = "SELECT u.fullname, u.username, m.created_at, "
                + "u.email, u.phone_number "
                + "FROM Users u "
                + "JOIN Mentee m ON m.user_id = u.id "
                + "WHERE u.id = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, userId);  // Truyền tham số userId
            ResultSet rs = pre.executeQuery();

            if (rs.next()) {  // Nếu có dữ liệu thì lấy
                User user = new User(rs.getString("username"),
                        rs.getString("fullname"),
                        rs.getString("email"),
                        rs.getString("phone_number"),
                        rs.getTimestamp("created_at")// Sử dụng getTimestamp()
                );
                rs.close();
                pre.close();
                return user;
            }
            rs.close();
            pre.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public int getUserIdByUsername(String username) {
        int userId = -1;
        String sql = "SELECT id FROM Users WHERE username = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, username);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                userId = rs.getInt("id");
            }
            rs.close();
            pre.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userId;
    }
    
    public User getMenteeById(int id) {

        String sql = "SELECT u.* " +
             "FROM Users u " +
             "JOIN Mentee m ON u.id = m.user_id " +
             "WHERE m.id = ? ";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, id);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                return new User(rs.getString(4), rs.getString(2), rs.getString(3),
                        rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(9),
                        rs.getString(8), rs.getDate(10), rs.getDate(12), rs.getString(11),
                        rs.getString(13), true);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }
    public String getAvatarPath(String username){
        String sql = "Select avatar_path from Users where username = ?";
        String avatar = null;
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            if(rs.next()){
                avatar = rs.getString("avatar_path");
                return avatar;
            }
        } catch (Exception e) {
        }
        return null;
        
    }
    
    
}
