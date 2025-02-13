/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Set;

/**
 *
 * @author Ann
 */
public class RolePermissions {

    private static final Set<String> guestPermissions = Set.of(
            "view_homepage",
            "view_public_courses",
            "register",
            "login"
    );

    private static final Set<String> menteePermissions = Set.of(
            "view_homepage",
            "view_courses",
            "access_mentee_dashboard",
            "view_mentors",
            "interact_with_mentors",
            "join_mentee_community"
    );

    private static final Set<String> mentorPermissions = Set.of(
            "view_homepage",
            "view_courses",
            "access_mentor_dashboard",
            "manage_mentees",
            "create_mentoring_content",
            "access_mentor_community"
    );

    private static final Set<String> managerPermissions = Set.of(
            "view_homepage",
            "access_manager_dashboard",
            "manage_users",
            "manage_mentors",
            "manage_mentees",
            "manage_roles_permissions",
            "manage_system_settings"
    );

    public static boolean hasPermission(UserRole role, String permission) {
        switch (role) {
            case GUEST:
                return guestPermissions.contains(permission);
            case MENTEE:
                return menteePermissions.contains(permission) || guestPermissions.contains(permission); // Mentee có quyền của Guest
            case MENTOR:
                return mentorPermissions.contains(permission) || menteePermissions.contains(permission) || guestPermissions.contains(permission); // Mentor có quyền của Mentee và Guest
            case MANAGER:
                return managerPermissions.contains(permission) || mentorPermissions.contains(permission) || menteePermissions.contains(permission) || guestPermissions.contains(permission); // Manager có tất cả quyền
            default:
                return false;
        }
    }

}
