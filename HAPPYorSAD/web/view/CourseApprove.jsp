<%-- 
    Document   : CourseApprove
    Created on : Mar 25, 2025, 1:03:26 AM
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

        <style>
            /* Style cho khu vực nội dung */
            .content-area {
                background-color: #ffffff;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
            }

            /* Style cho tiêu đề */
            .profile-heading {
                margin-bottom: 25px;
            }

            .heading-title {
                font-size: 26px;
                font-weight: 700;
                color: #2c3e50;
                position: relative;
                display: inline-block;
            }

            .heading-title::after {
                content: '';
                width: 60px;
                height: 4px;
                background-color: #28a745;
                position: absolute;
                bottom: -8px;
                left: 0;
                border-radius: 2px;
            }

            /* Style cho form tìm kiếm */
            .search-form {
                margin-bottom: 30px;
            }

            .search-group {
                display: flex;
                gap: 15px;
                align-items: center;
                max-width: 500px;
            }

            .search-input {
                flex: 1;
                padding: 12px 15px;
                font-size: 14px;
                border: 1px solid #ced4da;
                border-radius: 8px;
                transition: border-color 0.3s ease, box-shadow 0.3s ease;
            }

            .search-input:focus {
                border-color: #28a745;
                box-shadow: 0 0 8px rgba(40, 167, 69, 0.2);
                outline: none;
            }

            .search-btn {
                background-color: #28a745;
                color: white;
                padding: 12px 25px;
                border: none;
                border-radius: 8px;
                font-size: 14px;
                font-weight: 500;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }

            .search-btn:hover {
                background-color: #218838;
                transform: translateY(-2px);
            }

            /* Style cho bảng */
            .custom-table {
                overflow-x: auto;
            }

            .modern-table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
            }

            .table-header th {
                background-color: #f1f5f9;
                color: #2c3e50;
                font-weight: 600;
                font-size: 15px;
                padding: 15px;
                text-align: left;
                border-bottom: 2px solid #e2e8f0;
            }

            .table-row td {
                padding: 15px;
                font-size: 14px;
                color: #34495e;
                border-bottom: 1px solid #e2e8f0;
                transition: background-color 0.3s ease;
            }

            .table-row:hover {
                background-color: #f8fafc;
            }

            /* Style cho trạng thái */
            .status-badge {
                display: inline-block;
                padding: 8px 15px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 500;
                text-transform: capitalize;
                transition: transform 0.2s ease;
            }

            .status-badge.approved {
                background-color: #28a745;
                color: white;
            }

            .status-badge:hover {
                transform: scale(1.05);
            }

            /* Style cho nút Back */
            .action-section {
                margin-top: 25px;
                text-align: center;
            }

            .back-btn {
                display: inline-block;
                padding: 12px 25px;
                background-color: #28a745;
                color: white;
                font-size: 14px;
                font-weight: 500;
                border-radius: 8px;
                text-decoration: none;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }

            .back-btn:hover {
                background-color: #218838;
                transform: translateY(-2px);
            }

            /* Responsive design */
            @media (max-width: 768px) {
                .content-area {
                    padding: 20px;
                }

                .heading-title {
                    font-size: 22px;
                }

                .search-group {
                    flex-direction: column;
                    gap: 10px;
                }

                .search-input, .search-btn {
                    width: 100%;
                }

                .table-header th, .table-row td {
                    font-size: 13px;
                    padding: 10px;
                }

                .back-btn {
                    padding: 10px 20px;
                    font-size: 13px;
                }
            }
        </style>




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
                    <div class="col-xl-9 col-lg-9">
                        <div class="content-area" id="content-area">
                            <!-- Profile Heading -->
                            <div class="profile-heading">
                                <h3 class="heading-title">Manage Course - Approved</h3>
                            </div>

                            <!-- Search Form -->
                            <form action="ApproveCourse" method="get" class="search-form">
                                <input type="hidden" name="status" value="approved">
                                <div class="search-group">
                                    <input type="text" name="searchQuery" class="search-input" placeholder="Search by course name" value="${searchQuery}">
                                    <button type="submit" class="search-btn">Search</button>
                                </div>
                            </form>

                            <!-- Table Section -->
                            <div class="checkout-form">
                                <div class="table-responsive custom-table">
                                    <table class="table table-nowrap mb-0 modern-table">
                                        <thead class="table-header">
                                            <tr>
                                                <th>Mentor Name</th>
                                                <th>Title</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="course" items="${courseList}">
                                                <tr class="table-row">
                                                    <td>${course.name}</td>
                                                    <td>${course.title}</td>
                                                    <td>
                                                        <span class="status-badge approved">${course.status}</span>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <!-- Back Link -->
                            <div class="action-section">
                                <a href="ApproveCourse" class="back-btn badge-light-success">Back to Pending Courses</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
