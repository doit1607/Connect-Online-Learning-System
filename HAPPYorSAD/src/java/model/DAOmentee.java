/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Mentee;
import entity.MenteeDTO;
import entity.Mentor;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import static model.DBConnection.conn;

/**
 *
 * @author Ann
 */
public class DAOmentee extends DBConnection {

    public static DAOuser userDao = new DAOuser();

    public static Integer getMenteeIdByUserId(int userId) {
        int menteeId = -1;
        String sql = "SELECT m.id \n"
                + "FROM Users u join Mentee m on m.user_id = u.id\n"
                + "WHERE u.id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql);) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                menteeId = rs.getInt("id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return menteeId;
    }

    public Mentee getMenteeById(int menteeId) {
        String query = "SELECT [id]\n"
                + "      ,[user_id]\n"
                + "      ,[name]\n"
                + "      ,[is_deleted]\n"
                + "      ,[email]\n"
                + "      ,[goals]\n"
                + "      ,[created_at]\n"
                + "      ,[image]\n"
                + "  FROM [SWP1].[dbo].[Mentee]\n"
                + "  where id = ?;";
        try {
            PreparedStatement stmt = conn.prepareStatement(query);

            stmt.setInt(1, menteeId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Mentee(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getString("name"),
                        rs.getInt("is_deleted"),
                        rs.getString("email"),
                        rs.getString("goals"),
                        rs.getTimestamp("created_at").toLocalDateTime(),
                        rs.getString("image")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
public List<Mentee> getAllMentee() {
        List<Mentee> mentors = new ArrayList<>();
        String sql = "SELECT id, name, image FROM Mentee"; // Điều chỉnh cột theo bảng của bạn

        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Mentee mentor = new Mentee();
                mentor.setId(rs.getInt("id"));
                mentor.setName(rs.getString("name"));
                mentor.setImage(rs.getString("image"));
                mentors.add(mentor);
            }
            System.out.println("Successfully retrieved " + mentors.size() + " mentors.");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mentors;
    }
    public int getMenteeUserid(int menteeId) {
        String sql = "SELECT user_id FROM Mentee WHERE id = ?";
        try (PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, menteeId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("user_id");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Mentee getMenteeBySlotId(String slotDate, int slotNumberId) {
        String sql = "SELECT m.name, m.image, m.email \n"
                + "FROM Slot sl \n"
                + "JOIN Mentee m ON m.id = sl.mentee_id \n"
                + "WHERE sl.slot_date = ? and sl.slot_number_id=?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, slotDate);
            stmt.setInt(2, slotNumberId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Mentee(
                            rs.getString("name"),
                            rs.getString("image"),
                            rs.getString("email")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý lỗi hoặc log lỗi
        }
        return null; // Trả về null nếu không tìm thấy
    }

    public String getMenteeUsername(int id) {
        String sql = "SELECT username FROM Users WHERE id = ?";
        try (PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("username");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public List<MenteeDTO> getTop10MenteesBySpending() {
    List<MenteeDTO> menteeList = new ArrayList<>();
    String sql = "SELECT top 10 m.id, m.name, m.email, COALESCE(SUM(r.totalPrice), 0) AS total_spent " +
                 "FROM Mentee m " +
                 "LEFT JOIN Request r ON m.id = r.mentee_id AND r.status = 'Closed' " +
                 "GROUP BY m.id, m.name,m.email " +
                 "ORDER BY total_spent DESC ";

    try (PreparedStatement st = conn.prepareStatement(sql);
         ResultSet rs = st.executeQuery()) {
        while (rs.next()) {
            MenteeDTO mentee = new MenteeDTO();
            mentee.setId(rs.getInt("id"));
            mentee.setName(rs.getString("name"));
            mentee.setEmail(rs.getString("email"));
            mentee.setTotalSpent(rs.getDouble("total_spent"));
            menteeList.add(mentee);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return menteeList;
}


    public static void main(String[] args) {
        DAOmentee dao = new DAOmentee();
        int userID = 5;
        Integer menteeId = getMenteeIdByUserId(userID);
        Mentee mentee = dao.getMenteeById(1);
        System.out.println(mentee);
    }
}
