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
                                <div class="pagination">
                                    <c:if test="${tag > 1}">
                                        <li class="page-item">
                                            <a href="AcceptCV?status=approved&index=${tag-1}" class="page-link">Previous</a>
                                        </li>
                                    </c:if>

                                    <c:if test="${endPage > 0}">
                                        <c:forEach begin="1" end="${endPage - 1}" var="i">
                                            <a class="page-link ${tag == i ? 'active' : ''}" href="AcceptCV?status=approved&index=${i}">${i}</a>
                                        </c:forEach>
                                    </c:if>

                                    <c:if test="${tag < endPage - 1}">
                                        <li class="page-item">
                                            <a href="AcceptCV?status=approved&index=${tag+1}" class="page-link">Next</a>
                                        </li>
                                    </c:if>
                                </div>
                            </div>
                        </div>

                        <style>
                            /* Reset và font */
                            * {
                                margin: 0;
                                padding: 0;
                                box-sizing: border-box;
                            }

                            body {
                                font-family: 'Poppins', sans-serif;
                                background: #f5f7fa;
                                color: #333;
                            }

                            /* Content Area */
                            .content-area {
                                max-width: 1200px;
                                margin: 30px auto;
                                padding: 20px;
                            }

                            /* Profile Heading */
                            .profile-heading {
                                text-align: center;
                                margin-bottom: 30px;
                            }

                            .heading-title {
                                font-size: 2rem;
                                font-weight: 600;
                                color: #2c3e50;
                                position: relative;
                                display: inline-block;
                            }

                            .heading-title::after {
                                content: '';
                                position: absolute;
                                width: 50%;
                                height: 3px;
                                background: linear-gradient(90deg, #28a745, #1a73e8);
                                bottom: -10px;
                                left: 25%;
                                border-radius: 2px;
                                transition: width 0.3s ease;
                            }

                            .heading-title:hover::after {
                                width: 100%;
                                left: 0;
                            }

                            /* Search Form */
                            .search-form {
                                max-width: 500px;
                                margin: 0 auto 30px;
                            }

                            .search-group {
                                display: flex;
                                gap: 10px;
                                align-items: center;
                            }

                            .search-input {
                                flex: 1;
                                padding: 12px 15px;
                                border: 1px solid #ddd;
                                border-radius: 8px;
                                font-size: 1rem;
                                background: #fff;
                                transition: border-color 0.3s ease, box-shadow 0.3s ease;
                            }

                            .search-input:focus {
                                outline: none;
                                border-color: #1a73e8;
                                box-shadow: 0 0 5px rgba(26, 115, 232, 0.3);
                            }

                            .search-btn {
                                padding: 12px 25px;
                                background: #1a73e8;
                                color: #fff;
                                border: none;
                                border-radius: 8px;
                                font-weight: 500;
                                text-transform: uppercase;
                                transition: background 0.3s ease, transform 0.3s ease;
                            }

                            .search-btn:hover {
                                background: #1557b0;
                                transform: translateY(-2px);
                            }

                            /* Checkout Form */
                            .checkout-form {
                                background: #fff;
                                border-radius: 15px;
                                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
                                padding: 20px;
                                transition: transform 0.3s ease;
                            }

                            .checkout-form:hover {
                                transform: translateY(-5px);
                            }

                            /* Table */
                            .custom-table {
                                overflow-x: auto;
                            }

                            .modern-table {
                                width: 100%;
                                border-collapse: collapse;
                                font-size: 0.95rem;
                            }

                            .table-header th {
                                background: #2c3e50;
                                color: #fff;
                                padding: 15px;
                                text-align: left;
                                font-weight: 600;
                                text-transform: uppercase;
                                letter-spacing: 0.5px;
                            }

                            .table-row {
                                transition: background 0.3s ease;
                            }

                            .table-row:nth-child(even) {
                                background: #f9f9f9;
                            }

                            .table-row:hover {
                                background: #e9f1ff;
                            }

                            .table-row td {
                                padding: 15px;
                                vertical-align: middle;
                                border-bottom: 1px solid #eee;
                            }

                            .course-list {
                                margin: 0;
                                padding-left: 20px;
                            }

                            .course-list li {
                                margin: 5px 0;
                            }

                            /* Action Buttons */
                            .btn.btn-info.detail-btn {
                                padding: 8px 15px;
                                background: #17a2b8;
                                color: #fff;
                                border: none;
                                border-radius: 5px;
                                font-weight: 500;
                                text-decoration: none;
                                transition: all 0.3s ease;
                                display: inline-block;
                            }

                            .btn.btn-info.detail-btn:hover {
                                background: #138496;
                                transform: translateY(-2px);
                                box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
                            }

                            /* Action Section */
                            .action-section {
                                text-align: center;
                                margin-top: 30px;
                            }

                            .back-btn.badge-light-success {
                                display: inline-block;
                                padding: 12px 25px;
                                background: linear-gradient(135deg, #28a745, #218838);
                                color: #fff;
                                text-decoration: none;
                                border-radius: 25px;
                                font-weight: 600;
                                text-transform: uppercase;
                                letter-spacing: 1px;
                                transition: all 0.3s ease;
                            }

                            .back-btn.badge-light-success:hover {
                                background: linear-gradient(135deg, #218838, #1e7e34);
                                transform: translateY(-3px);
                                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
                            }

                            /* Responsive */
                            @media (max-width: 768px) {
                                .content-area {
                                    padding: 15px;
                                }

                                .heading-title {
                                    font-size: 1.8rem;
                                }

                                .search-group {
                                    flex-direction: column;
                                }

                                .search-input,
                                .search-btn {
                                    width: 100%;
                                }

                                .modern-table th,
                                .modern-table td {
                                    padding: 10px;
                                    font-size: 0.85rem;
                                }

                                .btn.btn-info.detail-btn {
                                    width: 100%;
                                    text-align: center;
                                }
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

