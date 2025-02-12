<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : homeHeader
    Created on : Jan 19, 2025, 4:17:41 PM
    Author     : Ann
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dreams LMS</title>          

        <!-- Favicon -->         
        <link rel="shortcut icon" type="image/x-icon" href="/HAPPYorSAD/assets/img/favicon.svg">          

        <!-- Theme Settings Js -->         
        <script src="/HAPPYorSAD/assets/js/theme-script.js" type="text/javascript"></script>          

        <!-- Bootstrap CSS -->         
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap.min.css">          

        <!-- Fontawesome CSS -->         
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/fontawesome.min.css">         
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/all.min.css">          

        <!-- Owl Carousel CSS -->         
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/owl.carousel.min.css">         
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/owl.theme.default.min.css">          

        <!-- Feathericon CSS -->         
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/feather/feather.css">          

        <!-- Main CSS (?ã s?a ???ng d?n) -->         
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css">    
    </head>
    <body>
            <!-- Header -->
            <header class="header">
                <div class="header-fixed">
                    <nav class="navbar navbar-expand-lg header-nav scroll-sticky">
                        <div class="container">
                            <div class="navbar-header">
                                <a id="mobile_btn" href="javascript:void(0);">
                                    <span class="bar-icon">
                                        <span></span>
                                        <span></span>
                                        <span></span>
                                    </span>
                                </a>
                                <a href="Home" class="navbar-brand logo">
                                    <img src="/HAPPYorSAD/assets/img/logo.svg" class="img-fluid" alt="Logo">
                                </a>
                            </div>
                            <div class="main-menu-wrapper">
                                <div class="menu-header">
                                    <a href="index-2.html" class="menu-logo">
                                        <img src="/HAPPYorSAD/assets/img/logo.svg" class="img-fluid" alt="Logo">
                                    </a>
                                    <a id="menu_close" class="menu-close" href="javascript:void(0);">
                                        <i class="fas fa-times"></i>
                                    </a>
                                </div>
                                <ul class="main-nav">
                                    <li class="has-submenu ">
                                        <a class="" href="Home">Home <i class="fas fa-chevron-down"></i></a>

                                    </li>
                                    <li class="has-submenu">
                                        <a href="ViewMentor_Mentee">Instructor <i class="fas fa-chevron-down"></i></a>
                                        <ul class="submenu">
                                            <li class="has-submenu">
                                                <a href="ViewMentor_Mentee">Instructor</a>
                                                <ul class="submenu">
                                                    <li><a href="ViewMentor_Mentee">List</a></li>
                                                    <li><a href="ViewMentor_Mentee">Grid</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="instructor-dashboard.html">Dashboard</a></li>
                                            <li><a href="instructor-profile.html">My Profile</a></li>
                                            <li><a href="instructor-course.html">My Course</a></li>
                                            <li><a href="instructor-reviews.html">Reviews</a></li>
                                            <li><a href="instructor-referral.html">Wallet</a></li>
                                            <li><a href="instructor-notifications.html">Notifications</a></li>
                                            <li><a href="instructor-settings.html">Settings</a></li>
                                        </ul>
                                    </li>
                                    <li class="has-submenu">
                                        <a href="#">Student <i class="fas fa-chevron-down"></i></a>
                                        <ul class="submenu first-submenu">
                                            <li class="has-submenu">
                                                <a href="students-list.html">Mentees</a>
                                                <ul class="submenu">
                                                    <li><a href="students-list.html">List</a></li>
                                                    <li><a href="students-grid.html">Grid</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="student-dashboard.html">Dashboard</a></li>
                                            <li><a href="student-profile.html">My Profile</a></li>
                                            <li><a href="student-courses.html">Enrolled Courses</a></li>
                                            <li><a href="student-reviews.html">Reviews</a></li>
                                            <li><a href="student-order-history.html">Orders</a></li>
                                            <li><a href="student-referral.html">Wallet</a></li>
                                            <li><a href="student-settings.html">Settings</a></li>
                                        </ul>
                                    </li>
                                    <li class="has-submenu">
                                        <a href="#">Pages <i class="fas fa-chevron-down"></i></a>
                                        <ul class="submenu">
                                            <li><a href="notifications.html">Notification</a></li>
                                            <li><a href="wishlist.html">Wishlist</a></li>
                                            <li class="has-submenu">
                                                <a href="course-list.html">Course</a>
                                                <ul class="submenu">
                                                    <li><a href="CreateCourses">Add Course</a></li>
                                                    <li><a href="ShowAllCourse">Course List</a></li>
                                                    <li><a href="ShowAllCourse">Course Grid</a></li>
                                                    <!--                                                    <li><a href="course-details.html">Course Details</a></li>-->
                                                </ul>
                                            </li>
                                            <li class="has-submenu">
                                                <a href="come-soon.html">Error</a>
                                                <ul class="submenu">
                                                    <li><a href="come-soon.html">Coming Soon</a></li>
                                                    <li><a href="error-404.html">404</a></li>
                                                    <li><a href="error-500.html">500</a></li>
                                                    <li><a href="under-construction.html">Under Construction</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="faq.html">FAQ</a></li>
                                            <li><a href="support.html">Support</a></li>
                                            <li><a href="job-category.html">Major</a></li>
                                            <li><a href="checkout.html">Checkout</a></li>
                                            <li><a href="/HAPPYorSAD/view/LoginUser.jsp">Login</a></li>
                                            <li><a href="/HAPPYorSAD/view/RegisterUser.jsp">Register</a></li>
                                            <li><a href="#">Forgot Password</a></li>
                                        </ul>
                                    </li>
                                    <!--                                    <li class="has-submenu">
                                                                            <a href="#">Blog <i class="fas fa-chevron-down"></i></a>
                                                                            <ul class="submenu">
                                                                                <li><a href="blog-list.html">Blog List</a></li>
                                                                                <li><a href="blog-grid.html">Blog Grid</a></li>
                                                                                <li><a href="blog-masonry.html">Blog Masonry</a></li>
                                                                                <li><a href="blog-modern.html">Blog Modern</a></li>
                                                                                <li><a href="blog-details.html">Blog Details</a></li>
                                                                            </ul>
                                                                        </li>-->
                                    <li class="login-link">
                                        <a href="/HAPPYorSAD/view/LoginUser.jsp">Login / Signup</a>
                                    </li>
                                </ul>
                            </div>
                            <ul class="nav header-navbar-rht">
                                <li class="nav-item">
                                    <div>
                                        <a href="javascript:void(0);" id="dark-mode-toggle" class="dark-mode-toggle  ">
                                            <i class="fa-solid fa-moon"></i>
                                        </a>
                                        <a href="javascript:void(0);" id="light-mode-toggle" class="dark-mode-toggle ">
                                            <i class="fa-solid fa-sun"></i>
                                        </a>
                                    </div>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link header-sign" href="/HAPPYorSAD/view/LoginUser.jsp">Signin</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link header-login" href="/HAPPYorSAD/view/RegisterUser.jsp">Signup</a>
                                </li>
                            </ul>
                        </div>
                    </nav>
                </div>
            </header>
            <!-- /Header -->
    </body>
</html>
