/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Enum.java to edit this template
 */
package entity;

/**
 *
 * @author Ann
 */
public enum UserRole {
    GUEST,
    MENTEE,
    MENTOR,
    MANAGER;

    public static UserRole fromString(String roleStr) {
        if (roleStr == null || roleStr.isEmpty()) {
            return GUEST; // Mặc định là GUEST nếu role rỗng hoặc null
        }
        try {
            return UserRole.valueOf(roleStr.toUpperCase());
        } catch (IllegalArgumentException e) {
            return GUEST; // Mặc định là GUEST nếu role không hợp lệ
        }
    }
}
