/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package controller;

import entity.RolePermissions;
import entity.User;
import entity.UserRole;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DAOpermission;

/**
 *
 * @author Ann
 */
public class AuthorizationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        UserRole userRole = UserRole.GUEST; // Mặc định là GUEST
        if (session != null) {
            User loggedInUser = (User) session.getAttribute("loggedInUser");
            if (loggedInUser != null && loggedInUser.getRole() != null) {
                userRole = UserRole.fromString(loggedInUser.getRole());
            }
        }

        String requestedPath = httpRequest.getRequestURI();
        if (requestedPath == null) {
            chain.doFilter(request, response);
            return;
        }

        // Lấy quyền yêu cầu từ database
        String requiredPermission = DAOpermission.getRequiredPermission(requestedPath);

        // Kiểm tra quyền
        if (requiredPermission != null && !RolePermissions.hasPermission(userRole, requiredPermission)) {
            log("Unauthorized access: " + userRole + " tried to access " + requestedPath);

            // Chuyển hướng đến trang lỗi thay vì trả về 403
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/error.jsp?message=forbidden");
            return;
        }

        chain.doFilter(request, response); // Tiếp tục request nếu có quyền hoặc không cần phân quyền
    }

    private void log(String msg) {
        System.out.println("[AuthorizationFilter] " + msg);
    }
}
