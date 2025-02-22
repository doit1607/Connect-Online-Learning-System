<%-- 
    Document   : DashboardMenteeProfile
    Created on : Feb 15, 2025, 1:25:01 PM
    Author     : Ann
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>Dreams LMS</title>

        <!-- Favicon -->
        <link rel="shortcut icon" type="image/x-icon" href="/HAPPYorSAD/assets/img/favicon.svg">

        <!-- Theme Settings Js -->
        <script src="/HAPPYorSAD/assets/js/theme-script.js" type="a09f0192fbc68959c45d1d3e-text/javascript"></script>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap.min.css">

        <!-- Fontawesome CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/all.min.css">

        <!-- Feather CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/feather.css">

        <!-- Boxioons CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/boxicons/css/boxicons.min.css">

        <!-- Main CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css">

    </head>

    <body>
        <%@include file="../sourcesHome/homeHeader.jsp" %>
        <!-- Main Wrapper -->
        <div class="main-wrapper">

            <!-- Breadcrumb -->
            <div class="breadcrumb-bar breadcrumb-bar-info">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 col-12">
                            <div class="breadcrumb-list">
                                <h2 class="breadcrumb-title">Dashboard</h2>
                                <nav aria-label="breadcrumb" class="page-breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="/../HAPPYorSAD/Home">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Dashboard</li>
                                    </ol>
                                </nav>
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
                                        <li class="nav-item ">
                                            <a href="/../HAPPYorSAD/ProfileServlet" class="nav-link">
                                                <i class="bx bxs-user"></i>My Profile
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="instructor-enrolled-course.html" class="nav-link">
                                                <i class="bx bxs-graduation"></i>Enrolled Courses
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

                        <!-- Content dashboard -->


                        <!-- Instructor profile -->
                        <div class="col-xl-9 col-lg-9">	

                            <div class="settings-widget card-details mb-0">
                                <div class="settings-menu p-0">
                                    <div class="profile-heading">
                                        <h3>My Profile</h3>
                                    </div>

                                    <div class="checkout-form personal-address">
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="contact-info"> 
                                                    <h6>Full Name</h6>
                                                    <p>${sessionScope.profile.fullname}</p>

                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="contact-info">
                                                    <h6>Last Name</h6>
                                                    <p>${sessionScope.profile.fullname}</p>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="contact-info">
                                                    <h6>Registerion Date</h6>
                                                    <p>January 16, 2024, 11:15 AM</p>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="contact-info">
                                                    <h6>User Name</h6>
                                                    <p>${sessionScope.profile.username}</p>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="contact-info">
                                                    <h6>Email</h6>
                                                    <p>${sessionScope.profile.email}</p>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="contact-info">
                                                    <h6>Phone Number</h6>
                                                    <p>${sessionScope.profile.phoneNumber}</p>
                                                </div>
                                            </div>
                                            <div class="col-sm-12">
                                                <div class="contact-info mb-0">
                                                    <h6>Bio</h6>
                                                    <p>${sessionScope.profile.bio}</p>
                                                </div>
                                            </div>
                                        </div>  

                                    </div>
                                </div>
                            </div>

                        </div>	
                        <!-- /Instructor profile -->

                        <!-- /Content dashboard -->


                    </div>
                    <div class="dash-pagination">
                        <div class="row align-items-center">
                            <div class="col-6">
                                <p>Page 1 of 2</p>
                            </div>
                            <div class="col-6">
                                <ul class="pagination">
                                    <li class="active">
                                        <a href="#">1</a>
                                    </li>
                                    <li>
                                        <a href="#">2</a>
                                    </li>
                                    <li>
                                        <a href="#"><i class="bx bx-chevron-right"></i></a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Student Dashboard -->

            </div>
        </div>
        <%@include file="../sourcesHome/homeFooter.jsp" %>
        <!-- /Page Content -->


        <!-- /Main Wrapper -->

        <!-- jQuery -->
        <script data-cfasync="false" src="/HAPPYorSAD/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script>
        <script src="assets/js/jquery-3.7.1.min.js" type="a09f0192fbc68959c45d1d3e-text/javascript"></script>

        <!-- Bootstrap Core JS -->
        <script src="/HAPPYorSAD/assets/js/bootstrap.bundle.min.js" type="a09f0192fbc68959c45d1d3e-text/javascript"></script>

        <!-- Sticky Sidebar JS -->
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/ResizeSensor.js"
        type="a09f0192fbc68959c45d1d3e-text/javascript"></script>
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js"
        type="a09f0192fbc68959c45d1d3e-text/javascript"></script>

        <!-- Custom JS -->
        <script src="/HAPPYorSAD/assets/js/script.js" type="a09f0192fbc68959c45d1d3e-text/javascript"></script>

        <script src="/HAPPYorSAD/cdn-cgi/scripts/7d0fa10a/cloudflare-static/rocket-loader.min.js"
        data-cf-settings="a09f0192fbc68959c45d1d3e-|49" defer></script>
        <script defer
                src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015"
                integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ=="
                data-cf-beacon='{"rayId":"9107442eff24e2ec","version":"2025.1.0","serverTiming":{"name":{"cfExtPri":true,"cfL4":true,"cfSpeedBrain":true,"cfCacheStatus":true}},"token":"3ca157e612a14eccbb30cf6db6691c29","b":1}'
        crossorigin="anonymous"></script>
    </body>
</html>



