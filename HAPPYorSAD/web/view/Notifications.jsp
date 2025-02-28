<!DOCTYPE html> 
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.DAOAcceptCV" %>
<html lang="en">
    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>Course List</title>

        <!-- Favicon -->
        <link rel="shortcut icon" type="image/x-icon" href="/HAPPYorSAD/assets/img/favicon.svg">

        <!-- Theme Settings Js -->
        <script src="/HAPPYorSAD/assets/js/theme-script.js" type="ed8c0f9a7decd809791bf17a-text/javascript"></script>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap.min.css">

        <!-- Fontawesome CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/all.min.css">

        <!-- Select2 CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/select2/css/select2.min.css">

        <!-- Feathericon CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/feather/feather.css">

        <!-- Main CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css">

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
                                <h2 class="breadcrumb-title">Notifications</h2>
                                <nav aria-label="breadcrumb" class="page-breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="index-2.html">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Notifications</li>
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
                                                <i class="bx bxs-tachometer"></i>My Profile
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="instructor-enrolled-course.html" class="nav-link">
                                                <i class="bx bxs-graduation"></i>Enrolled Courses
                                            </a>
                                        </li>
                                        <li class="nav-item ">
                                            <a href="/../HAPPYorSAD/Slot" class="nav-link">
                                                <i class="bx bxs-graduation"></i>Available Timings

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

                                        <li class="nav-item active">
                                            <a href="Notifications" class="nav-link">
                                                <i class="bx bxs-bell"></i>Notifications
                                            </a>
                                        </li>

                                    </ul>
                                    <h3>Instructor</h3>
                                    <ul>
                                        <li class="nav-item">
                                            <a href="instructor-course.html" class="nav-link ">
                                                <i class="bx bxs-rocket"></i>My Courses
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="instructor-course.html" class="nav-link ">
                                                <i class="bx bxs-rocket"></i>My Curriculum Vitae
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="instructor-enrolled-course.html" class="nav-link">
                                                <i class="bx bxs-graduation"></i>Inviting Request
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="instructor-referral.html" class="nav-link">
                                                <i class="bx bxs-user-plus"></i>Statistic Request
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="instructor-announcements.html" class="nav-link">
                                                <i class="bx bxs-volume-full"></i>Announcements
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="instructor-withdraw.html" class="nav-link ">
                                                <i class="bx bxs-wallet"></i>Withdrawls
                                            </a>
                                        </li>

                                        <li class="nav-item">
                                            <a href="instructor-earnings.html" class="nav-link">
                                                <i class="bx bxs-badge-dollar"></i>Earnings
                                            </a>
                                        </li>
                                    </ul>
                                    <h3>Account Settings</h3>
                                    <ul>
                                        <li class="nav-item">
                                            <a href="updatementorprofile?username=${sessionScope.usernameUser}" class="nav-link ">
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

                        <!-- Instructor profile -->
                        <div class="col-xl-9 col-lg-9">	

                            <div class="settings-widget card-details mb-0">
                                <div class="settings-menu p-0">
                                    <div class="profile-heading">
                                        <h3>Notifications</h3>
                                    </div>
                                    <div class="checkout-form personal-address">
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <!--                                                <div class="d-flex instructor-noti-head align-items-center">
                                                                                                    <div class="noti-mark-btns">
                                                                                                        <ul>
                                                                                                            <li>
                                                                                                                <a href="#" class="btn"><i class="feather-check me-2"></i> Mark all as read</a>
                                                                                                            </li>
                                                                                                            <li>
                                                                                                                <form action="Notifications" method="get">
                                                                                                                    <input type="hidden" name="action" value="deleteNotification">
                                                                                                                    <button type="submit" class="btn btn-delete">
                                                                                                                        <i class="feather-trash-2 me-2"></i> Delete all
                                                                                                                    </button>
                                                                                                                </form>
                                                                                                            </li>
                                                                                                        </ul>
                                                                                                    </div>
                                                                                                </div>-->

                                                <form action="Notifications" method="post">
                                                    <input type="hidden" name="action" value="viewNotifications">
                                                    <input type="hidden" name="username" value="${sessionScope.usernameUser}">
                                                    <button type="submit" class="btn btn-primary mb-3">View Notifications</button>
                                                </form>

                                                <div class="notification-list">

                                                    <c:forEach var="notification" items="${sessionScope.cvNotifications}">
                                                        <div class="notification-item p-3 border rounded mb-2">
                                                            <div class="row">
                                                                <div class="col-md-9">
                                                                    <div class="notification-content">
                                                                        <div class="notification-info">
                                                                            <p><c:out value="${notification}" /></p>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 text-end">
                                                                    <form action="Notifications" method="post">
                                                                        <input type="hidden" name="username" value="${sessionScope.usernameUser}">
                                                                        <input type="hidden" name="notificationMessage" value="<c:out value='${notification}'/>">
                                                                        <button type="submit" name="action" value="deleteSingleNotification" class="btn btn-danger btn-sm">
                                                                            <i class="feather-trash-2"></i> Delete
                                                                        </button>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>	
                        <!-- /Instructor profile -->

                    </div>
                </div>
            </div>	
            <!-- /Page Content -->

            <!-- Footer -->
            <%@include file="/../sourcesHome/homeFooter.jsp" %>  
            <!-- /Footer -->

        </div>
        <!-- /Main Wrapper -->

        <!-- jQuery -->
        <script data-cfasync="false" src="/HAPPYorSAD/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script><script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js" type="ed8c0f9a7decd809791bf17a-text/javascript"></script>

        <!-- Bootstrap Core JS -->
        <script src="/HAPPYorSAD/assets/js/bootstrap.bundle.min.js" type="ed8c0f9a7decd809791bf17a-text/javascript"></script>

        <!-- Select2 JS -->
        <script src="/HAPPYorSAD/assets/plugins/select2/js/select2.min.js" type="ed8c0f9a7decd809791bf17a-text/javascript"></script>

        <!-- Sticky Sidebar JS -->
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/ResizeSensor.js" type="ed8c0f9a7decd809791bf17a-text/javascript"></script>
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js" type="ed8c0f9a7decd809791bf17a-text/javascript"></script>

        <!-- Custom JS -->
        <script src="/HAPPYorSAD/assets/js/script.js" type="ed8c0f9a7decd809791bf17a-text/javascript"></script>

        <script src="/HAPPYorSAD/cdn-cgi/scripts/7d0fa10a/cloudflare-static/rocket-loader.min.js" data-cf-settings="ed8c0f9a7decd809791bf17a-|49" defer></script><script defer src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015" integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ==" data-cf-beacon='{"rayId":"91074462f90fe2ec","version":"2025.1.0","serverTiming":{"name":{"cfExtPri":true,"cfL4":true,"cfSpeedBrain":true,"cfCacheStatus":true}},"token":"3ca157e612a14eccbb30cf6db6691c29","b":1}' crossorigin="anonymous"></script>
    </body>

    <!-- Mirrored from dreamslms.dreamstechnologies.com/html/instructor-notifications.html by HTTrack Website Copier/3.x [XR&CO'2014], Tue, 11 Feb 2025 21:04:07 GMT -->
</html>