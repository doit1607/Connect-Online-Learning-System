/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.CV;
import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/**
 *
 * @author admin
 */
public class DaoCV extends DBConnection {

    public void createCV(String profession, String professionIntro, List<String> courses, String serviceDescription, String achievementDescription, String username) {
        String sql = "INSERT INTO [dbo].[CV]\n"
                + "           ([profession]\n"
                + "           ,[professionIntro]\n"
                + "           ,[courses]\n"
                + "           ,[serviceDescription]\n"
                + "           ,[achievementDescription]\n"
                + "           ,[created_at]\n"
                + "           ,[username]\n"
                + "           ,[status])\n"
                + "     VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, profession);
            pre.setString(2, professionIntro);
            pre.setString(3, String.join(", ", courses));
            pre.setString(4, serviceDescription);
            pre.setString(5, achievementDescription);
            pre.setTimestamp(6, Timestamp.valueOf(LocalDateTime.now()));
            pre.setString(7, username);
            pre.setString(8, "draft");
            pre.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getCVStatusByUsername(String username) {
        String sql = "SELECT [status] FROM CV WHERE username = ?";
        try (PreparedStatement pre = conn.prepareStatement(sql)) {
            pre.setString(1, username);
            try (ResultSet rs = pre.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("status");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
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
                String courseData = rs.getString("courses");
                List<String> courses = (courseData != null && !courseData.isEmpty())
                        ? Arrays.asList(courseData.split(", "))
                        : new ArrayList<>();

                LocalDateTime createdAt = rs.getTimestamp("created_at") != null
                        ? rs.getTimestamp("created_at").toLocalDateTime()
                        : LocalDateTime.now();

                return new CV(
                        rs.getString("username"), rs.getString("profession"),
                        rs.getString("professionIntro"), courses, rs.getString("serviceDescription"),
                        rs.getString("achievementDescription"), createdAt, "Pending"
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new CV();
    }

    public List<CV> getCVApproved() {
        List<CV> listApproved = new ArrayList<>();
        String sql = "SELECT * FROM CV WHERE status = 'approved'";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                String courseData = rs.getString("courses");
                List<String> courses = (courseData != null && !courseData.isEmpty())
                        ? Arrays.asList(courseData.split(","))
                        : new ArrayList<>();

                LocalDateTime createdAt = rs.getTimestamp("created_at") != null
                        ? rs.getTimestamp("created_at").toLocalDateTime()
                        : LocalDateTime.now();

                CV cv = new CV(
                        rs.getString("username"),
                        rs.getString("profession"),
                        rs.getString("professionIntro"),
                        courses,
                        rs.getString("serviceDescription"),
                        rs.getString("achievementDescription"),
                        createdAt,
                        "Approved"
                );

                listApproved.add(cv);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listApproved;
    }

    public void updateCV(String profession, String professionIntro, List<String> courses, String serviceDescription, String achievementDescription, String username) {
        String sql = "UPDATE [dbo].[CV]\n"
                + "   SET [profession] = ?\n"
                + "      ,[professionIntro] = ?\n"
                + "      ,[courses] = ?\n"
                + "      ,[serviceDescription] = ?\n"
                + "      ,[achievementDescription] = ?\n"
                + " WHERE [username] = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, profession);
            pre.setString(2, professionIntro);
            String coursesStr = String.join(", ", courses);
            pre.setString(3, coursesStr);
            pre.setString(4, serviceDescription);
            pre.setString(5, achievementDescription);
            pre.setString(6, username);

            pre.executeUpdate();
        } catch (Exception e) {
        }

    }

    public List<CV> getCVrejected() {
        List<CV> listCV = new ArrayList<>();
        String sql = "select c.username, c.profession, c.professionIntro, c.courses\n"
                + ", c.achievementDescription, c.serviceDescription, c.created_at, n.message from CV c\n"
                + "join Users u on c.username = u.username\n"
                + "join NotificationForCV n on u.username = n.username where n.message like '%CV has been rejected.%'";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                CV cv = new CV();
                cv.setUsername(rs.getString("username"));
                cv.setProfession(rs.getString("profession"));
                cv.setProfessionIntro(rs.getString("professionIntro"));

                String courseStr = rs.getString("courses");
                if (courseStr != null && !courseStr.trim().isEmpty()) {
                    cv.setCourses(Arrays.asList(courseStr.trim().split("\\s*,\\s*")));
                } else {
                    cv.setCourses(Collections.emptyList());
                }

                cv.setServiceDescription(rs.getString("serviceDescription"));
                cv.setAchievementDescription(rs.getString("achievementDescription"));

                Timestamp timestamp = rs.getTimestamp("created_at");
                cv.setCreatedAt(timestamp != null ? timestamp.toLocalDateTime() : null);

                cv.setMessage(rs.getString("message"));

                listCV.add(cv);
            }
        } catch (Exception e) {
        }
        return listCV;
    }

    public static void main(String[] args) {
        DaoCV dao = new DaoCV();
        dao.updateCV("Software Engineering", "Experienced in Java and SQL",
                Arrays.asList("Business Administration", "Graphic Design"),
                "Freelance software development",
                "Built multiple web applications",
                "olivia_wright");

    }
}
