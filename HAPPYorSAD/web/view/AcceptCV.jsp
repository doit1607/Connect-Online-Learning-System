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
                margin-bottom: 30px;
                text-align: center;
            }

            .profile-heading h3 {
                font-size: 2rem;
                font-weight: 600;
                color: #2c3e50;
                position: relative;
                display: inline-block;
            }

            .profile-heading h3::after {
                content: '';
                position: absolute;
                width: 50%;
                height: 3px;
                background: linear-gradient(90deg, #1a73e8, #34c759);
                bottom: -10px;
                left: 25%;
                border-radius: 2px;
                transition: width 0.3s ease;
            }

            .profile-heading h3:hover::after {
                width: 100%;
                left: 0;
            }

            /* Filter Form */
            form[action="AcceptCV"][method="get"] {
                display: flex;
                align-items: center;
                gap: 15px;
                margin-bottom: 25px;
                max-width: 400px;
            }

            form[action="AcceptCV"][method="get"] label {
                font-weight: 500;
                color: #2c3e50;
            }

            .form-control {
                padding: 10px 15px;
                border: 1px solid #ddd;
                border-radius: 8px;
                background: #fff;
                font-size: 0.95rem;
                color: #333;
                transition: border-color 0.3s ease, box-shadow 0.3s ease;
            }

            .form-control:focus {
                outline: none;
                border-color: #1a73e8;
                box-shadow: 0 0 5px rgba(26, 115, 232, 0.3);
            }

            select.form-control {
                appearance: none;
                background: #fff url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="%23777" viewBox="0 0 24 24"><path d="M7 10l5 5 5-5z"/></svg>') no-repeat right 15px center;
                padding-right: 40px;
            }

            .btn.btn-primary {
                background: #1a73e8;
                color: #fff;
                padding: 10px 20px;
                border: none;
                border-radius: 8px;
                font-weight: 500;
                text-transform: uppercase;
                transition: background 0.3s ease, transform 0.3s ease;
            }

            .btn.btn-primary:hover {
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

            .table {
                width: 100%;
                border-collapse: collapse;
                font-size: 0.95rem;
            }

            .table th {
                background: #2c3e50;
                color: #fff;
                padding: 15px;
                text-align: left;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .table tr {
                transition: background 0.3s ease;
            }

            .table tr:nth-child(even) {
                background: #f9f9f9;
            }

            .table tr:hover {
                background: #e9f1ff;
            }

            .table td {
                padding: 15px;
                vertical-align: middle;
                border-bottom: 1px solid #eee;
            }

            .table td ul {
                margin: 0;
                padding-left: 20px;
            }

            .table td ul li {
                margin: 5px 0;
            }

            /* Action Buttons */
            .btn.btn-success,
            .btn.btn-danger {
                padding: 8px 15px;
                border: none;
                border-radius: 5px;
                font-weight: 500;
                color: #fff;
                transition: all 0.3s ease;
                margin: 5px 0;
                display: inline-block;
            }

            .btn.btn-success {
                background: #28a745;
            }

            .btn.btn-success:hover {
                background: #218838;
                transform: translateY(-2px);
            }

            .btn.btn-danger {
                background: #dc3545;
            }

            .btn.btn-danger:hover {
                background: #c82333;
                transform: translateY(-2px);
            }

            input[name="reason"] {
                padding: 8px 10px;
                border: 1px solid #ddd;
                border-radius: 5px;
                width: 100%;
                margin: 5px 0;
                font-size: 0.9rem;
                transition: border-color 0.3s ease;
            }

            input[name="reason"]:focus {
                outline: none;
                border-color: #dc3545;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .content-area {
                    padding: 15px;
                }

                form[action="AcceptCV"][method="get"] {
                    flex-direction: column;
                    align-items: stretch;
                }

                .btn.btn-primary {
                    width: 100%;
                }

                .table th, .table td {
                    padding: 10px;
                    font-size: 0.85rem;
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
                            <!-- Mentee Settings -->
                            <div class="content-area" id="content-area">
                                <div class="profile-heading">
                                    <h3>Request CV</h3>
                                </div>
                                <form action="AcceptCV" method="get">

                                    <select name="status" id="statusFilter" class="form-control">
                                        <option value="">--Select status of CV--</option>
                                        <option value="approved">Approved</option>
                                        <option value="rejected">Rejected</option>
                                    </select>
                                    <button type="submit" class="btn btn-primary">Filter</button>
                                </form>
                                <div class="checkout-form">
                                    <div class="table-responsive custom-table">

                                        <table class="table table-nowrap mb-0">
                                            <tr>
                                                <th>Username</th>
                                                <th>Profession</th>
                                                <th>Introduction</th>
                                                <th>Major</th>
                                                <th>Service Description</th>
                                                <th>Achievements</th>
                                                <th>Created at</th>
                                                <th>Actions</th>
                                            </tr>
                                            <c:forEach var="cv" items="${acceptCV}">
                                                <tr>
                                                    <td>${cv.username}</td>
                                                    <td>${cv.profession}</td>
                                                    <td>${cv.professionIntro}</td>
                                                    <td>
                                                        <ul>
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
                                                        <form action="AcceptCV" method="post">
                                                            <input type="hidden" name="username" value="${cv.username}">

                                                            <button type="submit" name="action" value="approve" class="btn btn-success">
                                                                Approve CV
                                                            </button>

                                                            <input type="text" name="reason" placeholder="Enter reason if rejected">
                                                            <button type="submit" name="action" value="reject" class="btn btn-danger">
                                                                Reject CV
                                                            </button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </table>
                                    </div>
                                </div>
                                <div class="pagination">
                                    <c:if test="${tag > 1}">
                                        <li class="page-item">
                                            <a href="AcceptCV?index=${tag-1}" class="page-link">Previous</a>
                                        </li>
                                    </c:if>

                                    <c:if test="${endPage > 0}">
                                        <c:forEach begin="1" end="${endPage - 1}" var="i">
                                            <a class="page-link ${tag == i ? 'active' : ''}" href="AcceptCV?index=${i}">${i}</a>
                                        </c:forEach>
                                    </c:if>

                                    <c:if test="${tag < endPage - 1}">
                                        <li class="page-item">
                                            <a href="AcceptCV?index=${tag+1}" class="page-link">Next</a>
                                        </li>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>	
        </div>
        <!-- /Page Content -->

    </body>

    <!-- Mirrored from dreamslms.dreamstechnologies.com/html/mentee-settings.html by HTTrack Website Copier/3.x [XR&CO'2014], Tue, 11 Feb 2025 21:04:23 GMT -->
</html>

