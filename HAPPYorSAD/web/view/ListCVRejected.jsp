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
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.svg">

        <!-- Theme Settings Js -->
        <script src="assets/js/theme-script.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">

        <!-- Fontawesome CSS -->
        <link rel="stylesheet" href="assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="assets/plugins/fontawesome/css/all.min.css">

        <!-- Feather CSS -->
        <link rel="stylesheet" href="assets/css/feather.css">

        <!-- Select2 CSS -->
        <link rel="stylesheet" href="assets/plugins/select2/css/select2.min.css">

        <!-- Dropzone -->
        <link rel="stylesheet" href="assets/plugins/dropzone/dropzone.min.css">

        <!-- Boxioons CSS -->
        <link rel="stylesheet" href="assets/plugins/boxicons/css/boxicons.min.css">

        <!-- Main CSS -->
        <link rel="stylesheet" href="assets/css/style.css">
    </head>
    <body>
        <!-- Main Wrapper -->
        <div class="main-wrapper">
            <!-- Header -->
            <%@include file="/../sourcesHome/homeHeader.jsp" %>
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
                                                <i class="bx bxs-graduation"></i>Manage Course
                                            </a>
                                        </li>

                                        <li class="nav-item">
                                            <a href="instructor-wishlist.html" class="nav-link">
                                                <i class="bx bxs-heart"></i>Wishlist
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="instructor-reviews.html" class="nav-link">
                                                <i class="bx bxs-star"></i>Reviews
                                            </a>
                                        </li>

                                        <li class="nav-item">
                                            <a href="instructor-referral.html" class="nav-link">
                                                <i class="bx bxs-user-plus"></i>Referrals
                                            </a>
                                        </li>

                                        <li class="nav-item">
                                            <a href="instructor-notifications.html" class="nav-link">
                                                <i class="bx bxs-bell"></i>Notifications
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
                                    <h3>Manage CV - Rejected</h3>
                                </div>

                                <form action="AcceptCV" method="get">
                                    <input type="hidden" name="type" value="rejected">
                                    <input type="text" name="searchQuery" placeholder="Search by name" value="${searchQuery}">
                                    <button type="submit">Search</button>
                                </form>

                                <div class="checkout-form">
                                    <div class="table-responsive custom-table">

                                        <table class="table table-nowrap mb-0">
                                            <tr>
                                                <th>Username</th>
                                                <th>Profession</th>
                                                <th>Introduction</th>
                                                <th>Courses</th>
                                                <th>Service Description</th>
                                                <th>Achievements</th>
                                                <th>Created at</th>
                                                <th>Reason</th>
                                            </tr>
                                            <c:forEach var="cv" items="${cvRejected}">
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
                                                    <td>${cv.message}</td>
                                                    <td>
                                                        <a href="AcceptCV?action=detail&username=${cv.username}" class="btn btn-info">Detail</a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </table>

                                    </div>
                                </div>
                                <a href="AcceptCV" class="resut-badge badge-light-success">Back to RequestCV</a>
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

