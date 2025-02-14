<!DOCTYPE html> 
<html lang="en">

    <!-- Mirrored from dreamslms.dreamstechnologies.com/html/mentor-settings.html by HTTrack Website Copier/3.x [XR&CO'2014], Tue, 11 Feb 2025 21:04:22 GMT -->
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
                                    <li class="breadcrumb-item active" href="updatementorprofile?username=${sessionScope.usernameUser}" aria-current="page">Edit Profile</li>
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
                                        <a href="mentor-dashboard.html" class="nav-link">
                                            <i class="bx bxs-tachometer"></i>Dashboard
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="mentor-profile.html" class="nav-link">
                                            <i class="bx bxs-user"></i>My Profile
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="mentor-courses.html" class="nav-link">
                                            <i class="bx bxs-graduation"></i>Enrolled Courses
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="mentor-wishlist.html" class="nav-link">
                                            <i class="bx bxs-heart"></i>Wishlist
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="mentor-reviews.html" class="nav-link">
                                            <i class="bx bxs-star"></i>Reviews
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="mentor-quiz.html" class="nav-link">
                                            <i class="bx bxs-shapes"></i>My Quiz Attempts
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="mentor-order-history.html" class="nav-link">
                                            <i class="bx bxs-cart"></i>Order History
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="mentor-qa.html" class="nav-link">
                                            <i class="bx bxs-bookmark-alt"></i>Question & Answer
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="mentor-referral.html" class="nav-link">
                                            <i class="bx bxs-user-plus"></i>Referrals
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="mentor-messages.html" class="nav-link">
                                            <i class="bx bxs-chat"></i>Messages
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="mentor-tickets.html" class="nav-link">
                                            <i class="bx bxs-coupon"></i>Support Tickets
                                        </a>
                                    </li>
                                </ul>
                                <h3>Account Settings</h3>
                                <ul>
                                    <li class="nav-item active">
                                        <a href="mentor-settings.html" class="nav-link ">
                                            <i class="bx bxs-cog"></i>Settings
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="index-2.html" class="nav-link">
                                            <i class="bx bxs-log-out"></i>Logout
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>			
                    </div>
                    <!-- /Sidebar -->

                    <!-- Mentor Settings -->
                    <div class="col-xl-9 col-lg-9">	

                        <div class="settings-widget card-details">
                            <div class="settings-menu p-0">
                                <div class="profile-heading">
                                    <h3>Settings</h3>
                                    <p>You have full control to manage your own account settings</p>
                                </div>
                                <div class="settings-page-head">
                                    <ul class="settings-pg-links">
                                        <li><a href="updatementorprofile?username=${mentor.username}" class="active"><i class="bx bx-edit"></i>Edit Profile</a></li>
                                        <li><a href="mentor-change-password.html"><i class="bx bx-lock"></i>Change Password</a></li>
                                        <li><a href="mentor-social-profile.html"><i class="bx bx-user-circle"></i>Social Profiles</a></li>
                                        <li><a href="mentor-linked-accounts.html"><i class="bx bx-link"></i>Linked Accounts</a></li>
                                        <li><a href="mentor-notifications.html"><i class="bx bx-bell"></i>Notifications</a></li>
                                    </ul>
                                </div>
                                <form action="updatementorprofile" method="post" class="checkout-form settings-wrap">

                                    <div class="checkout-form settings-wrap">
                                        <div class="edit-profile-info">
                                            <h2>Update Your Profile</h2>
                                            <p>Edit your personal information</p>

                                        </div>

                                        <% 
                                            String successMessage = (String) session.getAttribute("successMessage");
                                            if (successMessage != null) {
                                        %>
                                        <div class="alert alert-success">
                                            <%= successMessage %>
                                        </div>
                                        <%
                                                session.removeAttribute("successMessage");
                                            }
                                        %>

                                        <input type="hidden" name="username" value="${sessionScope.usernameUser}">

                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="input-block">
                                                    <label class="form-label">Avatar <span class="required">*</span></label>
                                                    <input type="file" id="avatarUpload" accept="image/*">
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="input-block">
                                                    <label class="form-label">Account Name</label>
                                                    <input type="text" class="form-control" id="username" name="username" value="${mentor.username}" readonly>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="input-block">
                                                    <label class="form-label">Full Name <span class="required">*</span></label>
                                                    <input type="text" class="form-control" id="fullname" name="fullname" value="${mentor.fullname}" required>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="input-block">
                                                    <label class="form-label">Date of Birth <span class="required">*</span></label>
                                                    <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" value="${mentor.dateOfBirth}" required>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="input-block">
                                                    <label class="form-label">Email (Read-Only)</label>
                                                    <input type="email" class="form-control" id="email" name="email" value="${mentor.email}" readonly>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="input-block">
                                                    <label class="form-label">Gender <span class="required">*</span></label>
                                                    <select class="form-control" id="gender" name="gender" value="${mentor.gender}">
                                                        <option value="male" ${mentor.gender == 'male' ? 'selected' : ''}>male</option>
                                                        <option value="female" ${mentor.gender == 'female' ? 'selected' : ''}>female</option>
                                                        <option value="other" ${mentor.gender == 'other' ? 'selected' : ''}>other</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="input-block">
                                                    <label class="form-label">Address <span class="required">*</span></label>
                                                    <input type="text" class="form-control" id="address" name="address" value="${mentor.address}" required>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <button class="btn btn-primary" type="submit">Update Profile</button>
                                            </div>
                                        </div>

                                    </div>
                                </form>								
                            </div>
                        </div>
                    </div>	
                    <!-- /Mentor Settings -->

                </div>
            </div>
        </div>	
        <!-- /Page Content -->

        <script>
            document.getElementById('avatarUpload').addEventListener('change', function (event) {
                const file = event.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        document.getElementById('avatarPreview').src = e.target.result;
                    }
                    reader.readAsDataURL(file);
                }
            });
        </script>

        <!-- Footer -->

        <%@include file="../sourcesHome/homeFooter.jsp" %>
        <!-- /Footer -->

    </div>
    <!-- /Main Wrapper -->

    <!-- jQuery -->
    <script data-cfasync="false" src="../cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script><script src="assets/js/jquery-3.7.1.min.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

    <!-- Bootstrap Core JS -->
    <script src="assets/js/bootstrap.bundle.min.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

    <!-- Select2 JS -->
    <script src="assets/plugins/select2/js/select2.min.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

    <!-- Ckeditor JS -->
    <script src="assets/js/ckeditor.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

    <!-- Dropzone JS -->
    <script src="assets/plugins/dropzone/dropzone.min.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

    <!-- Sticky Sidebar JS -->
    <script src="assets/plugins/theia-sticky-sidebar/ResizeSensor.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>
    <script src="assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

    <!-- Custom JS -->
    <script src="assets/js/script.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

    <script src="../cdn-cgi/scripts/7d0fa10a/cloudflare-static/rocket-loader.min.js" data-cf-settings="27bb6e11b88bb1c6a1b7b5ff-|49" defer></script><script defer src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015" integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ==" data-cf-beacon='{"rayId":"9107445c681fe2ec","version":"2025.1.0","serverTiming":{"name":{"cfExtPri":true,"cfL4":true,"cfSpeedBrain":true,"cfCacheStatus":true}},"token":"3ca157e612a14eccbb30cf6db6691c29","b":1}' crossorigin="anonymous"></script>
</body>

<!-- Mirrored from dreamslms.dreamstechnologies.com/html/mentor-settings.html by HTTrack Website Copier/3.x [XR&CO'2014], Tue, 11 Feb 2025 21:04:23 GMT -->
</html>