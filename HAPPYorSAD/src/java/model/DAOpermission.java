/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.security.Permission;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Ann
 */
public class DAOpermission extends DBConnection {

    public static String getRequiredPermission(String requestedPath) {
        String sql = "SELECT required_permission FROM permissions WHERE ? LIKE path";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, requestedPath);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getString("required_permission");
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Nên ghi log thay vì in lỗi ra console
        }

        return null; // Không yêu cầu quyền nếu không có trong database
    }
}
