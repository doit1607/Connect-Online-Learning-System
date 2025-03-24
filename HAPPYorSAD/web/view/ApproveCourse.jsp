<%-- 
    Document   : ApproveCourse
    Created on : Mar 25, 2025, 12:04:06 AM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.DAOCourse, entity.MentorCourse" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>Dreams LMS</title>

        <!-- Favicon -->
        <!-- Favicon -->
        <link rel="shortcut icon" type="image/x-icon" href="/HAPPYorSAD/assets/img/favicon.svg">


        <!-- Theme Settings Js -->
        <script src="/HAPPYorSAD/assets/js/theme-script.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap.min.css">

        <!-- Fontawesome CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/all.min.css">

        <!-- Feather CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/feather.css">

        <!-- Select2 CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/select2/css/select2.min.css">

        <!-- Dropzone -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/dropzone/dropzone.min.css">

        <!-- Boxioons CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/boxicons/css/boxicons.min.css">

        <!-- Main CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css">






        <script data-cfasync="false" src="/HAPPYorSAD/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script><script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

        <!-- Bootstrap Core JS -->
        <script src="/HAPPYorSAD/assets/js/bootstrap.bundle.min.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

        <!-- Select2 JS -->
        <script src="/HAPPYorSAD/assets/plugins/select2/js/select2.min.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

        <!-- Ckeditor JS -->
        <script src="/HAPPYorSAD/assets/js/ckeditor.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

        <!-- Dropzone JS -->
        <script src="/HAPPYorSAD/assets/plugins/dropzone/dropzone.min.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

        <!-- Sticky Sidebar JS -->
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/ResizeSensor.js" type="d693b69077856eb34d3f2643-text/javascript"></script>
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

        <!-- Custom JS -->
        <script src="/HAPPYorSAD/assets/js/script.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

        <script src="/HAPPYorSAD/cdn-cgi/scripts/7d0fa10a/cloudflare-static/rocket-loader.min.js" 
        data-cf-settings="d693b69077856eb34d3f2643-|49" defer></script>
        <script defer src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015" integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ==" data-cf-beacon='{"rayId":"91074a70ad7f06b9","version":"2025.1.0","serverTiming":{"name":{"cfExtPri":true,"cfL4":true,"cfSpeedBrain":true,"cfCacheStatus":true}},"token":"3ca157e612a14eccbb30cf6db6691c29","b":1}' crossorigin="anonymous"></script>

    </head>
    <!-- Main Wrapper -->
    <div class="main-wrapper">
        <!-- Header -->
        <%@include file="/../sourcesHome/headerManager.jsp" %>
        <!-- /Header -->
        <!-- Breadcrumb -->
        <div class="breadcrumb-bar breadcrumb-bar-info">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-12">
                        <div class="breadcrumb-list">
                            <h2 class="breadcrumb-title">Manager</h2>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /Breadcrumb -->	

        <!-- Page Content -->
        <div class="page-content">
            <div class="container">
                <div class="row">

                    <div class="col-xl-3 col-lg-3 theiaStickySidebar">
                        <div class="settings-widget account-settings">
                            <div class="settings-menu">
                                <h3>Dashboard</h3>
                                <ul>
                                    <li class="nav-item">
                                        <a href="/../HAPPYorSAD/AcceptCV" class="accept-cv">
                                            <i class="fas fa-user"></i>Manage CV
                                        </a>
                                    <li class="nav-item">
                                        <a href="CourseManager" class="nav-link">
                                            <i class="bx bxs-graduation"></i>Manage Courses
                                        </a>
                                    </li>
                                    <li class="nav-item active">
                                        <a href="ApproveCourse" class="nav-link">
                                            <i class="bx bxs-graduation"></i>Request Course
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="ConfirmSchedule" class="nav-link">
                                            <i class="bx bxs-graduation"></i>Manage Schedule
                                        </a>
                                    </li>

                                    <li class="nav-item">
                                        <a href="ShowAllRequest" class="nav-link">
                                            <i class="bx bxs-heart"></i>Manage Request Mentee
                                        </a>
                                    </li>

                                    <li class="nav-item">
                                        <a href="menteestatistic" class="nav-link">
                                            <i class="bx bxs-user-plus"></i>Manage Static Mentee
                                        </a>
                                    </li>
                                </ul>

                                <ul>
                                    <li class="nav-item">
                                        <a href="LoginUser?service=logout" class="nav-link">
                                            <i class="bx bxs-log-out"></i>Logout
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <%
                        DAOCourse dao = new DAOCourse();
                        int index = 1;
                        List<MentorCourse> pendingCourses = dao.getPendingCourses(index); 
                    %>

                    <div class="col-xl-9 col-lg-9">
                        <!-- Approve Mentor Course -->
                        <div class="content-area" id="content-area">
                            <div class="profile-heading">
                                <h3>Approve Mentor Courses</h3>
                            </div>

                            <!-- Bộ lọc trạng thái -->
                            <form action="ApproveCourse" method="get">
                                <select name="status" id="statusFilter" class="form-control">
                                    <option value="">-- Select status of Course --</option>
                                    <option value="approved" ${status == 'approved' ? 'selected' : ''}>Approved</option>
                                    <option value="rejected" ${status == 'rejected' ? 'selected' : ''}>Rejected</option>
                                </select>
                                <button type="submit" class="btn btn-primary">Filter</button>
                            </form>

                            <div class="checkout-form">
                                <div class="table-responsive custom-table">
                                    <table class="table table-nowrap mb-0">
                                        <thead>
                                            <tr>
                                                <th>Mentor Name</th>
                                                <th>Title</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="course" items="${courseList}">
                                                <tr>
                                                    <td>${course.name}</td>
                                                    <td>${course.title}</td>
                                                    <td>
                                                        <div style="background-color: ${course.status == 'pending' ? '#ffc107' : (course.status == 'approved' ? '#28a745' : '#dc3545')};
                                                             color: white; padding: 8px 12px; border-radius: 5px; display: inline-block;">
                                                            ${course.status}
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <form action="ApproveCourse" method="post">
                                                            <input type="hidden" name="mentorId" value="${course.mentorId}">
                                                            <input type="hidden" name="courseId" value="${course.courseId}">

                                                            <button type="submit" name="action" value="approve" class="btn btn-success">
                                                                Approve
                                                            </button>

                                                            <button type="submit" name="action" value="reject" class="btn btn-danger">
                                                                Reject
                                                            </button>
                                                        </form>

                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <div class="pagination">
                                        <c:if test="${tag > 1}">
                                            <li class="page-item">
                                                <a href="ApproveCourse?index=${tag-1}" class="page-link">Previous</a>
                                            </li>
                                        </c:if>

                                        <c:if test="${endPage > 0}">
                                            <c:forEach begin="1" end="${endPage - 1}" var="i">
                                                <a class="page-link ${tag == i ? 'active' : ''}" href="ApproveCourse?index=${i}">${i}</a>
                                            </c:forEach>
                                        </c:if>

                                        <c:if test="${tag < endPage - 1}">
                                            <li class="page-item">
                                                <a href="ApproveCourse?index=${tag+1}" class="page-link">Next</a>
                                            </li>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
