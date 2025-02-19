/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.CV;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 *
 * @author admin
 */
public class DAOAcceptCV extends DBConnection {

    public List<CV> getCVtoAccept() {
        List<CV> cvList = new ArrayList<>();
        String sql = "SELECT * FROM CV WHERE status = 'pending'";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                CV cv = new CV();
                cv.setUsername(rs.getString("username"));
                cv.setProfession(rs.getString("profession"));
                cv.setProfessionIntro(rs.getString("professionIntro"));
                cv.setServiceDescription(rs.getString("serviceDescription"));
                cv.setAchievementDescription(rs.getString("achievementDescription"));
                cv.setStatus(rs.getString("status"));
                cvList.add(cv);
            }
        } catch (Exception e) {
        }
        return cvList;
    }

    public void updateCVStatus(String username, String status) {
        String sql = "UPDATE CV SET status = ? WHERE username = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, status);
            pre.setString(2, username);
            pre.executeUpdate();
        } catch (Exception e) {
        }
    }

    public static void main(String[] args) {
        DAOAcceptCV dao = new DAOAcceptCV();
        List<CV> cv = dao.getCVtoAccept();
        for (CV cv1 : cv) {
            System.out.println(cv1);
        }
    }
}
