/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Mentee;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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

    public static void main(String[] args) {
        DAOmentee dao = new DAOmentee();
        int userID = 5;
        Integer menteeId = getMenteeIdByUserId(userID);
        Mentee mentee = dao.getMenteeById(1);
        System.out.println(mentee);
    }
}
