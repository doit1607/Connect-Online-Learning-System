/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.CV;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author admin
 */
public class DaoCV extends DBConnection {

    public void createCV(String profession, String professionIntro, String serviceDescription, String achievementDescription, String username) {
        String sql = "INSERT INTO [dbo].[CV]\n"
                + "           ([profession]\n"
                + "           ,[professionIntro]\n"
                + "           ,[serviceDescription]\n"
                + "           ,[achievementDescription]\n"
                + "           ,[username]\n"
                + "           ,[status])\n"
                + "     VALUES(?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, profession);
            pre.setString(2, professionIntro);
            pre.setString(3, serviceDescription);
            pre.setString(4, achievementDescription);
            pre.setString(5, username);
            pre.setString(6, "draft");
            pre.executeUpdate();
        } catch (Exception e) {
        }
    }

    public String getCVStatusByUsername(String username) {
        String sql = "SELECT [status] FROM CV WHERE username = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, username);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return rs.getString("status");
            }
        } catch (Exception e) {
        }
        return null;
    }

    public CV getCVByUsername(String username) {
        String sql = "SELECT * FROM CV WHERE username = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, username);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return new CV(rs.getString("username"), rs.getString("profession"),
                        rs.getString("professionIntro"), rs.getString("serviceDescription"),
                        rs.getString("achievementDescription"), "Pending");
            }
        } catch (Exception e) {
        }
        return null;
    }

    public void updateCV(String profession, String professionIntro, String serviceDescription, String achievementDescription, String username) {
        String sql = "UPDATE [dbo].[CV]\n"
                + "   SET [profession] = ?\n"
                + "      ,[professionIntro] = ?\n"
                + "      ,[serviceDescription] = ?\n"
                + "      ,[achievementDescription] = ?\n"
                + " WHERE [username] = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, profession);
            pre.setString(2, professionIntro);
            pre.setString(3, serviceDescription);
            pre.setString(4, achievementDescription);
            pre.setString(5, username);

            pre.executeUpdate();
        } catch (Exception e) {
        }

    }

    public static void main(String[] args) {
        DaoCV dao = new DaoCV();
        dao.createCV("hello", "hello", "hello", "hello", "dungmtr");
        //dao.updateCV("vippro", "dang cap", "anh trai", "say hi", Arrays.asList("Business Administration"), "dungmtr");
//        String s = dao.getCVStatusByUsername("emily_white");
//        System.out.println(s);

    }
}
