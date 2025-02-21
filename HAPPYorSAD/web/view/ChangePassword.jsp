<!DOCTYPE html> 
<html lang="en">

    <!-- Mirrored from dreamslms.dreamstechnologies.com/html/student-change-password.html by HTTrack Website Copier/3.x [XR&CO'2014], Tue, 11 Feb 2025 21:05:44 GMT -->
    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>Dreams LMS</title>

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

    </head>
    <body>

        <!-- Main Wrapper -->
        <div class="main-wrapper">

            <!-- Header -->
            <%@include file="../sourcesHome/homeHeader.jsp" %>
            <!-- /Header -->

            <!-- Breadcrumb -->
            <div class="breadcrumb-bar breadcrumb-bar-info">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 col-12">
                            <div class="breadcrumb-list">
                                <h2 class="breadcrumb-title">Settings</h2>
                                <nav aria-label="breadcrumb" class="page-breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="index-2.html">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Change Password</li>
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
                        <c:if test="${sessionScope.usernameRole eq 'mentee'}">
                            <!-- sidebar -->
                                <div class="col-xl-3 col-lg-3 theiaStickySidebar">
                                    <div class="settings-widget account-settings">
                                        <div class="settings-menu">
                                            <h3>Dashboard</h3>
                                            <ul>
                                                <li class="nav-item active">
                                                    <a href="instructor-dashboard.html" class="nav-link">
                                                        <i class="bx bxs-tachometer"></i>Dashboard
                                                    </a>
                                                </li>
                                                <li class="nav-item ">
                                                    <a href="instructor-profile.html" class="nav-link">
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
                                                    <a href="instructor-settings.html" class="nav-link ">
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
                            </c:if>
                            <c:if test="${sessionScope.usernameRole eq 'mentor'}">
                                <div class="col-xl-3 col-lg-3 theiaStickySidebar">
                                    <div class="settings-widget account-settings">
                                        <div class="settings-menu">
                                            <h3>Dashboard</h3>
                                            <ul>
                                                <li class="nav-item active">
                                                    <a href="instructor-dashboard.html" class="nav-link">
                                                        <i class="bx bxs-tachometer"></i>Dashboard
                                                    </a>
                                                </li>
                                                <li class="nav-item ">
                                                    <a href="instructor-profile.html" class="nav-link">
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
                                                    <a href="instructor-settings.html" class="nav-link ">
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
                            </c:if>    
                            <!-- Student Settings -->
                            <div class="col-xl-9 col-lg-9">	
                                <div class="settings-widget card-details">
                                    <div class="settings-menu p-0">
                                        <div class="profile-heading">
                                            <h3>Settings</h3>
                                            <p>You have full control to manage your own account settings</p>
                                        </div>
                                        <div class="settings-page-head">
                                            <ul class="settings-pg-links">
                                                <c:if test="${sessionScope.usernameRole eq 'mentor'}">
                                                <li><a href="/../HAPPYorSAD/updatementorprofile?username=${sessionScope.usernameUser}" ><i class="bx bx-edit"></i>Edit Profile</a></li>
                                                </c:if>
                                                <c:if test="${sessionScope.usernameRole eq 'mentee'}">
                                                <li><a href="/../HAPPYorSAD/updatementeeprofile?username=${sessionScope.usernameUser}" ><i class="bx bx-edit"></i>Edit Profile</a></li>
                                                </c:if>
                                                <li><a href="/HAPPYorSAD/view/ChangePassword.jsp" class="active" ><i class="bx bx-lock"></i>Change Password</a></li>
                                                <li><a href="mentor-notifications.html"><i class="bx bx-bell"></i>Notifications</a></li>
                                            </ul>
                                        </div>
                                        <form id="changePasswordForm" action="/../HAPPYorSAD/LoginUser" method="POST">
                                            <div class="checkout-form settings-wrap">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="input-block">
                                                            <label class="form-label">Username</label>
                                                            <input type="text" name="currentusername" value="${sessionScope.usernameUser}" class="form-control">
                                                        </div>
                                                        <div class="input-block">
                                                            <input type="hidden" name="service" value="changepass">
                                                            <label class="form-label">Current Password</label>
                                                            <input type="password" name="currentpassword" class="form-control">
                                                            <c:if test="${requestScope.error != null}">
                                                                ${requestScope.error}
                                                            </c:if>
                                                        </div>
                                                        <div class="input-block">
                                                            <label class="form-label">New Password</label>
                                                            <input type="password" name="newpassword" id="newpassword" class="form-control">
                                                        </div>
                                                        <div class="input-block">
                                                            <label class="form-label">Re-type New Password</label>
                                                            <input type="password" id="retypepassword" class="form-control">
                                                            <small id="passwordError" style="color: red; display: none;">Passwords do not match!</small>
                                                        </div>
                                                        <button type="submit" class="btn btn-primary" id="submitButton" disabled>Change Password</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>							
                                    </div>
                                </div>
                            </div>	
                            <!-- /Student Settings -->

                        </div>
                    </div>
                </div>	
                

                <script>
                    document.getElementById("newpassword").addEventListener("input", validatePassword);
                    document.getElementById("retypepassword").addEventListener("input", validatePassword);

                    function validatePassword() {
                        var newPassword = document.getElementById("newpassword").value;
                        var retypePassword = document.getElementById("retypepassword").value;
                        var passwordError = document.getElementById("passwordError");
                        var submitButton = document.getElementById("submitButton");

                        if (newPassword === retypePassword && newPassword.length > 0) {
                            passwordError.style.display = "none";
                            submitButton.disabled = false;
                        } else {
                            passwordError.style.display = "block";
                            submitButton.disabled = true;
                        }
                    }
                </script>

                <!-- /Page Content -->

                <!-- Footer -->
                <%@include file="../sourcesHome/homeFooter.jsp" %>
                <!-- /Footer -->

            </div>
            <!-- /Main Wrapper -->

            <!-- jQuery -->
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

            <script src="/HAPPYorSAD/cdn-cgi/scripts/7d0fa10a/cloudflare-static/rocket-loader.min.js" data-cf-settings="d693b69077856eb34d3f2643-|49" defer></script><script defer src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015" integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ==" data-cf-beacon='{"rayId":"91074a70ad7f06b9","version":"2025.1.0","serverTiming":{"name":{"cfExtPri":true,"cfL4":true,"cfSpeedBrain":true,"cfCacheStatus":true}},"token":"3ca157e612a14eccbb30cf6db6691c29","b":1}' crossorigin="anonymous"></script>
    </body>

    <!-- Mirrored from dreamslms.dreamstechnologies.com/html/student-change-password.html by HTTrack Website Copier/3.x [XR&CO'2014], Tue, 11 Feb 2025 21:05:44 GMT -->
</html>