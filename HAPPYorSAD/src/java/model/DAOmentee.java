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
    
    public static void main(String[] args) {
        DAOmentee dao = new DAOmentee();
        int userID=5;
        Integer menteeId = getMenteeIdByUserId(userID);
        System.out.println(menteeId);
    }
}
