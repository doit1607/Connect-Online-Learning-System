/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.PreparedStatement;
import java.util.Arrays;
import java.util.List;

/**
 *
 * @author admin
 */
public class DaoCV extends DBConnection{

    public void createCV(String profession, String professionIntro, String serviceDescription, String achievementDescription, List<String> courses) {
        String sql = "INSERT INTO [dbo].[CV]\n"
                + "           ([profession]\n"
                + "           ,[professionIntro]\n"
                + "           ,[serviceDescription]\n"
                + "           ,[achievementDescription]\n"
                + "           ,[courses])\n"
                + "     VALUES(?, ?, ?, ?, ?)";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, profession);
            pre.setString(2, professionIntro);
            pre.setString(3, serviceDescription);
            pre.setString(4, achievementDescription);
            pre.setString(5, String.join(", ", courses));
            pre.executeUpdate();
        } catch (Exception e) {
        }
    }
    
    public static void main(String[] args) {
        DaoCV dao = new DaoCV();
        dao.createCV("hello", "hello", "hello", "hello", Arrays.asList("hello, hello, hello"));
    }
}
