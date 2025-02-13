<%-- 
    Document   : templaye
    Created on : Feb 13, 2025, 12:26:24 AM
    Author     : Ann
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">         
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">         
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

        <!-- Main CSS  -->         
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css"> 
    </head>
    <body>
        <div class="main-wrapper">
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


            <!-- Content -->

            
            



            <!-- /Content -->

            <!-- Footer -->
            <footer class="footer">

                <!-- Footer Top -->
                <div class="footer-top aos" data-aos="fade-up">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-4 col-md-6">

                                <!-- Footer Widget -->
                                <div class="footer-widget footer-about">
                                    <div class="footer-logo">
                                        <img src="/HAPPYorSAD/assets/img/logo.svg" alt="logo">
                                    </div>
                                    <div class="footer-about-content">
                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut consequat mauris
                                            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut consequat mauris</p>
                                    </div>
                                </div>
                                <!-- /Footer Widget -->

                            </div>

                            <div class="col-lg-2 col-md-6">

                                <!-- Footer Widget -->
                                <div class="footer-widget footer-menu">
                                    <h2 class="footer-title">For Instructor</h2>
                                    <ul>
                                        <li><a href="instructor-profile.html">Profile</a></li>
                                        <li><a href="/HAPPYorSAD/view/LoginUser.jsp">Login</a></li>
                                        <li><a href="/HAPPYorSAD/view/RegisterUser.jsp">Register</a></li>
                                        <li><a href="ViewMentor_Mentee">Mentor</a></li>
                                        <li><a href="instructor-dashboard.html"> Dashboard</a></li>
                                    </ul>
                                </div>
                                <!-- /Footer Widget -->

                            </div>

                            <div class="col-lg-2 col-md-6">

                                <!-- Footer Widget -->
                                <div class="footer-widget footer-menu">
                                    <h2 class="footer-title">For Student</h2>
                                    <ul>
                                        <li><a href="instructor-profile.html">Profile</a></li>
                                        <li><a href="/HAPPYorSAD/view/LoginUser.jsp">Login</a></li>
                                        <li><a href="/HAPPYorSAD/view/RegisterUser.jsp">Register</a></li>
                                        <li><a href="#">Mentee</a></li>
                                        <li><a href="instructor-dashboard.html"> Dashboard</a></li>
                                    </ul>
                                </div>
                                <!-- /Footer Widget -->

                            </div>

                            <div class="col-lg-4 col-md-6">

                                <!-- Footer Widget -->
                                <div class="footer-widget footer-contact">
                                    <h2 class="footer-title">News letter</h2>
                                    <div class="news-letter">
                                        <form>
                                            <input type="text" class="form-control" placeholder="Enter your email address"
                                                   name="email">
                                        </form>
                                    </div>
                                    <div class="footer-contact-info">
                                        <div class="footer-address">
                                            <img src="assets/img/icon/icon-20.svg" alt="Img" class="img-fluid">
                                            <p> 3556 Beech Street, San Francisco,<br> California, CA 94108 </p>
                                        </div>
                                        <p>
                                            <img src="assets/img/icon/icon-19.svg" alt="Img" class="img-fluid">
                                            <a href="https://dreamslms.dreamstechnologies.com/cdn-cgi/l/email-protection" class="__cf_email__" data-cfemail="41253324202c322d2c32012439202c312d246f222e2c">[email&#160;protected]</a>
                                        </p>
                                        <p class="mb-0">
                                            <img src="assets/img/icon/icon-21.svg" alt="Img" class="img-fluid">
                                            +19 123-456-7890
                                        </p>
                                    </div>
                                </div>
                                <!-- /Footer Widget -->

                            </div>

                        </div>
                    </div>
                </div>
                <!-- /Footer Top -->

                <!-- Footer Bottom -->
                <div class="footer-bottom">
                    <div class="container">

                        <!-- Copyright -->
                        <div class="copyright">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="privacy-policy">
                                        <ul>
                                            <li><a href="term-condition.html">Terms</a></li>
                                            <li><a href="privacy-policy.html">Privacy</a></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="copyright-text">
                                        <p class="mb-0">&copy; 2024 DreamsLMS. All rights reserved.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /Copyright -->

                    </div>
                </div>
                <!-- /Footer Bottom -->

            </footer>
            <!-- /Footer -->
        </div>
        <!-- jQuery -->
        <script data-cfasync="false" src="/HAPPYorSAD/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script><script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js" type="1d433aff6b2b8dd82abe2a72-text/javascript"></script>

        <!-- Bootstrap Core JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <!-- counterup JS -->
        <script src="/HAPPYorSAD/assets/js/jquery.waypoints.js" type="1d433aff6b2b8dd82abe2a72-text/javascript"></script>
        <script src="/HAPPYorSAD/assets/js/jquery.counterup.min.js" type="1d433aff6b2b8dd82abe2a72-text/javascript"></script>

        <!-- Select2 JS -->
        <script src="/HAPPYorSAD/assets/plugins/select2/js/select2.min.js" type="1d433aff6b2b8dd82abe2a72-text/javascript"></script>

        <!-- Owl Carousel -->
        <script src="/HAPPYorSAD/assets/js/owl.carousel.min.js" type="1d433aff6b2b8dd82abe2a72-text/javascript"></script>

        <!-- Slick Slider -->
        <script src="/HAPPYorSAD/assets/plugins/slick/slick.js" type="1d433aff6b2b8dd82abe2a72-text/javascript"></script>

        <!-- Aos -->
        <script src="/HAPPYorSAD/assets/plugins/aos/aos.js" type="1d433aff6b2b8dd82abe2a72-text/javascript"></script>

        <!-- Custom JS -->
        <script src="/HAPPYorSAD/assets/js/script.js" type="1d433aff6b2b8dd82abe2a72-text/javascript"></script>


        <script src="/HAPPYorSAD/cdn-cgi/scripts/7d0fa10a/cloudflare-static/rocket-loader.min.js" data-cf-settings="1d433aff6b2b8dd82abe2a72-|49" defer></script><script defer src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015" integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ==" data-cf-beacon='{"rayId":"910743f1baeee2ec","version":"2025.1.0","serverTiming":{"name":{"cfExtPri":true,"cfL4":true,"cfSpeedBrain":true,"cfCacheStatus":true}},"token":"3ca157e612a14eccbb30cf6db6691c29","b":1}' crossorigin="anonymous"></script>
    </body>

</html>




