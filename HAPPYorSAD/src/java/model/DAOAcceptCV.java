/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.CV;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/**
 *
 * @author admin
 */
public class DAOAcceptCV extends DBConnection {

    // dem so luong CV
    public int getTotalRequest() {
        String sql = "select count(*) from CV";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public List<CV> getCVtoAccept(int index) {
        List<CV> cvList = new ArrayList<>();
        String sql = "SELECT * FROM CV WHERE status = 'Pending'\n"
                + "order by created_at\n"
                + "offset ? rows fetch next 3 rows only";

        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, (index - 1) * 3);
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

                cv.setStatus(rs.getString("status"));
                cvList.add(cv);

            }

        } catch (Exception e) {
            e.printStackTrace();
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

    // ham dung de insert them thong bao
    public void saveNotification(String username, String message) {
        String sql = "INSERT INTO NotificationForCV (username, message, created_at) VALUES (?, ?, GETDATE())";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, username);
            pre.setString(2, message);
            pre.executeUpdate();
        } catch (Exception e) {
        }
    }

    public List<String> getNotifications(String username) {
        List<String> notifications = new ArrayList<>();
        String sql = "SELECT message FROM NotificationForCV WHERE username = ? ORDER BY created_at";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, username);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                notifications.add(rs.getString("message"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return notifications;
    }

    // Ham dung de duyet CV
    public void approveCV(String username) {
        String sql = "UPDATE CV SET status = 'approved' WHERE username = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, username);
            pre.executeUpdate();
            saveNotification(username, "CV has been approved");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Ham dung de tu choi CV voi li do gi
    public void rejectCV(String username, String reason) {
        String sql = "UPDATE CV SET status = 'rejected' WHERE username = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, username);
            pre.executeUpdate();
            saveNotification(username, "CV has been rejected. Reason: " + reason);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteNotification(String username) {
        String sql = "DELETE FROM NotificationForCV WHERE username = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, username);
            pre.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteSingleNotification(String username, String message) {
        String sql = "DELETE FROM NotificationForCV WHERE username = ? AND message = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, username);
            pre.setString(2, message);
            pre.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<CV> getAllCV() {
        List<CV> cvList = new ArrayList<>();
        String sql = "SELECT * FROM CV";
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

                cv.setStatus(rs.getString("status"));
                cvList.add(cv);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return cvList;
    }

    public List<CV> getCVByStatus(String status) {
        List<CV> cvList = new ArrayList<>();
        String sql = "SELECT * FROM CV WHERE status = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, status);
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

                cv.setStatus(rs.getString("status"));
                cvList.add(cv);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return cvList;
    }

    public static void main(String[] args) {
        DAOAcceptCV dao = new DAOAcceptCV();
        List<CV> cvList = dao.getCVtoAccept(1);

        if (cvList.isEmpty()) {
            System.out.println("⚠️ No CVs found in database.");
        } else {
            for (CV cv : cvList) {
                System.out.println(cv);
            }
        }
    }
}
