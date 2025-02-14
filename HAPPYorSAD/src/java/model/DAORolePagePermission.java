/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Ann
 */
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import entity.RolePagePermission;
import entity.Test;
import java.util.ArrayList;
import java.util.List;

public class DAORolePagePermission extends DBConnection {

    public boolean isAuthorized(int roleId, String url) throws SQLException {
        String sql = "SELECT \n"
                + "    r.id, \n"
                + "    r.name, \n"
                + "    p.page_id, \n"
                + "    p.page_url, \n"
                + "    p.page_name\n"
                + "FROM Role_Page_Permissions rpp\n"
                + "JOIN Roles r ON rpp.role_id = r.id\n"
                + "JOIN Pages p ON rpp.page_id = p.page_id"
                + "WHERE rpp.role_id = ? AND p.page_url = ?";

        try (PreparedStatement preparedStatement = conn.prepareStatement(sql)) {
            preparedStatement.setInt(1, roleId);
            preparedStatement.setString(2, url);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return true;

                }
            }
        }
        return false;
    }

    public List<Test> getAllowedURLs(int roleId) {
        List<Test> allowedURLs = new ArrayList<>();
        String sql = "SELECT r.name, p.page_url, p.page_name "
                + "FROM Role_Page_Permissions rpp "
                + "JOIN Roles r ON rpp.role_id = r.id "
                + "JOIN Pages p ON rpp.page_id = p.page_id "
                + "WHERE rpp.role_id = ?";

        try (PreparedStatement preparedStatement = conn.prepareStatement(sql)) {
            preparedStatement.setInt(1, roleId);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    allowedURLs.add(new Test(rs.getString("name"),
                            rs.getString("page_url"),
                            rs.getString("page_name")));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return allowedURLs;
    }

    public static void main(String[] args) {
        DAORolePagePermission dao = new DAORolePagePermission();
        List<Test> urls = dao.getAllowedURLs(1);

        System.out.println("Danh sách URL cho role_id = 1:");
        for (Test t : urls) {
            System.out.println("Tên Role: " + t.getName() + ", URL: " + t.getPage_url()+ ", Tên Trang: " + t.getPage_name());
        }
    }
}
