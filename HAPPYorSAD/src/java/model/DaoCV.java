/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.CV;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 *
 * @author admin
 */
public class DaoCV extends DBConnection {

    public void createCV(String profession, String professionIntro, String serviceDescription, String achievementDescription, List<String> courses, String username) {
        String sql = "INSERT INTO [dbo].[CV]\n"
                + "           ([profession]\n"
                + "           ,[professionIntro]\n"
                + "           ,[serviceDescription]\n"
                + "           ,[achievementDescription]\n"
                + "           ,[courses]\n"
                + "           ,[username]\n"
                + "           ,[status])\n"
                + "     VALUES(?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, profession);
            pre.setString(2, professionIntro);
            pre.setString(3, serviceDescription);
            pre.setString(4, achievementDescription);
            pre.setString(5, String.join(", ", courses));
            pre.setString(6, username);
            pre.setString(7, "pending");
            pre.executeUpdate();
        } catch (Exception e) {
        }
    }

    public String getCVStatusByUsername(String username) {
        String sql = "SELECT status FROM CV WHERE username = ?";
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
                String coursesStr = rs.getString("courses");
                List<String> coursesList = new ArrayList<>();
                if (coursesStr != null && !coursesStr.isEmpty()) {
                    coursesList = Arrays.asList(coursesStr.split(","));
                }
                return new CV(rs.getString("username"), rs.getString("profession"),
                        rs.getString("professionIntro"), rs.getString("serviceDescription"),
                        rs.getString("achievementDescription"), coursesList, "pending");
            }
        } catch (Exception e) {
        }
        return null;
    }

    public void updateCV(String profession, String professionIntro, String serviceDescription, String achievementDescription, List<String> courses, String username) {
        String sql = "UPDATE [dbo].[CV]\n"
                + "   SET [profession] = ?\n"
                + "      ,[professionIntro] = ?\n"
                + "      ,[serviceDescription] = ?\n"
                + "      ,[achievementDescription] = ?\n"
                + "      ,[courses] = ?\n"
                + " WHERE [username] = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, profession);
            pre.setString(2, professionIntro);
            pre.setString(3, serviceDescription);
            pre.setString(4, achievementDescription);
            pre.setString(5, String.join(", ", courses));
            pre.setString(6, username);

            pre.executeUpdate();
        } catch (Exception e) {
        }
    }

    public static void main(String[] args) {
        DaoCV dao = new DaoCV();
        //dao.createCV("hello", "hello", "hello", "hello", Arrays.asList("hello, hello, hello"), "pending");
        dao.updateCV("vippro", "dang cap", "anh trai", "say hi", Arrays.asList("Business Administration"), "dungmtr");
    }
}
