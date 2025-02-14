/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Ann
 */
public class RolePagePermission {

    private int roleId;
    private int pageId;
    // Optional: private int permissionId;

    // Constructors, getters, setters, (optional) toString, equals, hashCode
    private Role role;
    private Pages page;

    public RolePagePermission() {
    }
    
    

    public RolePagePermission(int roleId, int pageId) {
        this.roleId = roleId;
        this.pageId = pageId;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public int getPageId() {
        return pageId;
    }

    public void setPageId(int pageId) {
        this.pageId = pageId;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Pages getPage() {
        return page;
    }

    public void setPage(Pages page) {
        this.page = page;
    }
}
