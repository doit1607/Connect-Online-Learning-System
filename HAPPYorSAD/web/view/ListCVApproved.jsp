<%-- 
    Document   : AcceptCV
    Created on : Feb 16, 2025, 11:52:34 PM
    Author     : admin
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <!-- Mirrored from dreamslms.dreamstechnologies.com/html/mentee-settings.html by HTTrack Website Copier/3.x [XR&CO'2014], Tue, 11 Feb 2025 21:04:22 GMT -->
    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>Dreams LMS</title>

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
    <body>
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

                        <!-- sidebar -->
                        <div class="col-xl-3 col-lg-3 theiaStickySidebar">
                            <div class="settings-widget account-settings">
                                <div class="settings-menu">
                                    <h3>Dashboard</h3>
                                    <ul>
                                        <li class="nav-item active">
                                            <a href="/../HAPPYorSAD/AcceptCV" class="accept-cv">
                                                <i class="fas fa-user"></i>Manage CV
                                            </a>
                                        <li class="nav-item">
                                            <a href="CourseManager" class="nav-link">
                                                <i class="bx bxs-graduation"></i>Manage Courses
                                            </a>
                                        </li>
                                        
                                        <li class="nav-item">
                                            <a href="ConfirmSchedule" class="nav-link">
                                                <i class="bx bxs-graduation"></i>Manage Scheudle
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
                                    <h3 class="heading-title">Manage CV - Approved</h3>
                                </div>

                                <!-- Search Form -->
                                <form action="AcceptCV" method="get" class="search-form">
                                    <input type="hidden" name="status" value="approved">
                                    <div class="search-group">
                                        <input type="text" name="searchQuery" class="search-input" placeholder="Search by name" value="${searchQuery}">
                                        <button type="submit" class="search-btn">Search</button>
                                    </div>
                                </form>

                                <!-- Table Section -->
                                <div class="checkout-form">
                                    <div class="table-responsive custom-table">
                                        <table class="table table-nowrap mb-0 modern-table">
                                            <thead class="table-header">
                                                <tr>
                                                    <th>Username</th>
                                                    <th>Profession</th>
                                                    <th>Introduction</th>
                                                    <th>Major</th>
                                                    <th>Service Description</th>
                                                    <th>Achievements</th>
                                                    <th>Created At</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="cv" items="${cvApproved}">
                                                    <tr class="table-row">
                                                        <td>${cv.username}</td>
                                                        <td>${cv.profession}</td>
                                                        <td>${cv.professionIntro}</td>
                                                        <td>
                                                            <ul class="course-list">
                                                                <c:forEach var="course" items="${cv.courses}">
                                                                    <li>${course}</li>
                                                                    </c:forEach>
                                                            </ul>
                                                        </td>
                                                        <td>${cv.serviceDescription}</td>
                                                        <td>${cv.achievementDescription}</td>
                                                        <td>
                                                            <fmt:formatDate value="${cv.createdAtAsDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                                        </td>
                                                        <td>
                                                            <a href="AcceptCV?action=detail&username=${cv.username}" class="btn btn-info detail-btn">Detail</a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                                <!-- Back Link -->
                                <div class="action-section">
                                    <a href="AcceptCV" class="back-btn badge-light-success">Back to Request CV</a>
                                </div>
                            </div>
                        </div>

                        <style>
                            /* Container Styling */
                            .content-area {
                                background: #ffffff;
                                border-radius: 12px;
                                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                                padding: 25px;
                                margin: 20px 0;
                                transition: transform 0.3s ease;
                            }

                            .content-area:hover {
                                transform: translateY(-5px);
                            }

                            /* Heading Styling */
                            .heading-title {
                                color: #2c3e50;
                                border-bottom: 3px solid #27ae60;
                                padding-bottom: 10px;
                                margin-bottom: 25px;
                                font-weight: 700;
                            }

                            /* Search Form Styling */
                            .search-form {
                                margin-bottom: 30px;
                            }

                            .search-group {
                                display: flex;
                                align-items: center;
                                gap: 15px;
                                max-width: 400px;
                            }

                            .search-input {
                                padding: 10px 15px;
                                border: 1px solid #ddd;
                                border-radius: 5px;
                                flex: 1;
                                transition: border-color 0.3s ease, box-shadow 0.3s ease;
                            }

                            .search-input:focus {
                                border-color: #27ae60;
                                box-shadow: 0 0 5px rgba(39, 174, 96, 0.3);
                                outline: none;
                            }

                            .search-btn {
                                padding: 10px 20px;
                                background: #27ae60;
                                color: white;
                                border: none;
                                border-radius: 5px;
                                cursor: pointer;
                                transition: all 0.3s ease;
                            }

                            .search-btn:hover {
                                background: #219653;
                                transform: translateY(-2px);
                            }

                            /* Table Styling */
                            .modern-table {
                                border-collapse: separate;
                                border-spacing: 0;
                                width: 100%;
                            }

                            .table-header th {
                                background: #27ae60;
                                color: white;
                                padding: 12px 15px;
                                font-weight: 600;
                                text-transform: uppercase;
                                letter-spacing: 0.5px;
                            }

                            .table-row {
                                transition: background-color 0.3s ease;
                            }

                            .table-row:hover {
                                background-color: #f8f9fa;
                            }

                            .table-row td {
                                padding: 15px;
                                vertical-align: middle;
                                border-bottom: 1px solid #eee;
                            }

                            .course-list {
                                padding-left: 20px;
                                margin: 0;
                            }

                            .course-list li {
                                margin: 5px 0;
                            }

                            /* Detail Button */
                            .detail-btn {
                                padding: 8px 15px;
                                border-radius: 5px;
                                background: #3498db;
                                color: white;
                                text-decoration: none;
                                transition: all 0.3s ease;
                            }

                            .detail-btn:hover {
                                background: #2980b9;
                                transform: translateY(-2px);
                                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                            }

                            /* Back Link Styling */
                            .action-section {
                                text-align: right;
                                margin-top: 20px;
                            }

                            .back-btn {
                                display: inline-block;
                                padding: 10px 20px;
                                background: #ecf0f1;
                                color: #27ae60;
                                text-decoration: none;
                                border-radius: 5px;
                                font-weight: 500;
                                transition: all 0.3s ease;
                            }

                            .back-btn:hover {
                                background: #27ae60;
                                color: white;
                                transform: translateY(-2px);
                            }
                        </style>
                    </div>
                </div>
            </div>	
        </div>
        <!-- /Page Content -->

    </body>

    <!-- Mirrored from dreamslms.dreamstechnologies.com/html/mentee-settings.html by HTTrack Website Copier/3.x [XR&CO'2014], Tue, 11 Feb 2025 21:04:23 GMT -->
</html>

