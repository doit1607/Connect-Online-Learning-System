<%-- 
    Document   : DashboardManager
    Created on : Mar 17, 2025, 3:58:18 PM
    Author     : dungb
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <!-- /Sidebar -->
        <div class="col-xl-3 col-lg-3 theiaStickySidebar">
            <div class="settings-widget account-settings">
                <div class="settings-menu">
                    <h3>Dashboard</h3>
                    <ul>
                        <li class="nav-item active ">
                            <a href="/../HAPPYorSAD/ProfileServlet" class="nav-link">
                                <i class="bx bxs-user"></i>Profile
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="/../HAPPYorSAD/ShowMenteeRequest" class="nav-link">
                                <i class="bx bxs-graduation"></i>Request
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="/../HAPPYorSAD/AttendanceMentee" class="nav-link">
                                <i class="bx bxs-check-circle"></i>Attendance
                            </a>
                        </li>
                        <c:if test="${sessionScope.menteeRequestStatus eq 'Completed'}">
                            <li class="nav-item">
                                <a href="reviewmentor" class="nav-link">
                                    <i class="bx bxs-bell"></i> Review Mentor
                                </a>
                            </li>
                        </c:if>
                    </ul>
                    <h3>Account Settings</h3>
                    <ul>
                        <li class="nav-item">
                            <a href="updatementeeprofile?username=${sessionScope.usernameUser}" class="nav-link ">
                                <i class="bx bxs-cog"></i>Settings
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="LoginUser?service=logout" class="nav-link">
                                <i class="bx bxs-log-out"></i>Logout
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <!-- /Sidebar -->

    </body>
</html>
