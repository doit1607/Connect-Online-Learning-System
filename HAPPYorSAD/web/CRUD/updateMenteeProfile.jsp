<!DOCTYPE html> 
<html lang="en">

    <!-- Mirrored from dreamslms.dreamstechnologies.com/html/mentee-settings.html by HTTrack Website Copier/3.x [XR&CO'2014], Tue, 11 Feb 2025 21:04:22 GMT -->
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

    <a href="../Home/CSS_Setting.jsp"></a>
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
                                    <li class="breadcrumb-item">Home</li>
                                    <li class="breadcrumb-item active" href="updatementeeprofile?username=${sessionScope.usernameUser}" aria-current="page">Edit Profile</li>
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
                                        <li class="nav-item ">
                                            <a href="/../HAPPYorSAD/ProfileServlet" class="nav-link">
                                                <i class="bx bxs-user"></i>My Profile
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="/../HAPPYorSAD/ShowMenteeRequest" class="nav-link">
                                                <i class="bx bxs-graduation"></i>Request
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="/HAPPYorSAD/AttendanceMentee" class="nav-link">
                                                <i class="bx bxs-check-circle"></i>Attendance
                                            </a>
                                        </li>
                                        <c:if test="${sessionScope.menteeRequestStatus eq 'Completed'}">
                                            <li class="nav-item">
                                                <a href="/../HAPPYorSAD/reviewmentor" class="nav-link">
                                                    <i class="bx bxs-bell"></i> Review Mentor
                                                </a>
                                            </li>
                                        </c:if>
                                    </ul>
                                    <h3>Account Settings</h3>
                                    <ul>
                                        <li class="nav-item active">
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
                    </c:if>
                    <c:if test="${sessionScope.usernameRole eq 'mentor'}">
                        <div class="col-xl-3 col-lg-3 theiaStickySidebar">

                            <div class="settings-widget account-settings">
                                <div class="settings-menu">
                                    <h3>Dashboard</h3>
                                    <ul>
                                        <li class="nav-item">
                                            <a href="/../HAPPYorSAD/ProfileServlet" class="nav-link">
                                                <i class="bx bxs-tachometer"></i>My Profile
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="instructor-reviews.html" class="nav-link">
                                                <i class="bx bxs-star"></i>Reviews
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="/../HAPPYorSAD/Slot" class="nav-link">
                                                <i class="bx bxs-tachometer"></i>Schedule
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="Notifications" class="nav-link">
                                                <i class="bx bxs-bell"></i>Notifications
                                            </a>
                                        </li>

                                    </ul>
                                    <h3>Instructor</h3>
                                    <ul>
                                        <li class="nav-item">
                                            <a href="/../HAPPYorSAD/ViewCV" class="nav-link ">
                                                <i class="bx bxs-rocket"></i>My Curriculum Vitae
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="/../HAPPYorSAD/viewRequest" class="nav-link">
                                                <i class="bx bxs-graduation"></i>Inviting Request
                                            </a>
                                        </li>
                                    </ul>
                                    <h3>Account Settings</h3>
                                    <ul>
                                        <li class="nav-item active">
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
                    </c:if> 

                    <!-- Mentee Settings -->
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
                                        <li><a href="/HAPPYorSAD/view/ChangePassword.jsp"><i class="bx bx-lock"></i>Change Password</a></li>
                                    </ul>
                                </div>
                                <form action="updatementeeprofile" method="post" class="checkout-form settings-wrap" enctype="multipart/form-data">

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
                                                <label>Avatar:</label>
                                                <img id="avatarPreview" src="${pageContext.request.contextPath}/uploads/${sessionScope.userAvatar}" alt="Avatar Preview" style="display: none;">
                                                <input type="file" id="avatarUpload" name="avatarFile">
                                            </div>
                                            <div class="col-md-6">
                                                <div class="input-block">
                                                    <label class="form-label">Account Name</label>
                                                    <input type="text" class="form-control" id="username" name="username" value="${mentee.username}" readonly>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="input-block">
                                                    <label class="form-label">Full Name <span class="required">*</span></label>
                                                    <input type="text" class="form-control" id="fullname" name="fullname" value="${mentee.fullname}" required>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="input-block">
                                                    <label class="form-label">Date of Birth <span class="required">*</span></label>
                                                    <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" value="${mentee.dateOfBirth}" required>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="input-block">
                                                    <label class="form-label">Email (Read-Only)</label>
                                                    <input type="email" class="form-control" id="email" name="email" value="${mentee.email}" readonly>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="input-block">
                                                    <label class="form-label">Gender <span class="required">*</span></label>
                                                    <select class="form-control" id="gender" name="gender" value="${mentee.gender}">
                                                        <option value="male" ${mentee.gender == 'male' ? 'selected' : ''}>male</option>
                                                        <option value="female" ${mentee.gender == 'female' ? 'selected' : ''}>female</option>
                                                        <option value="other" ${mentee.gender == 'other' ? 'selected' : ''}>other</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="input-block">
                                                    <label class="form-label">Address <span class="required">*</span></label>
                                                    <input type="text" class="form-control" id="address" name="address" value="${mentee.address}" required>
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
                    <!-- /Mentee Settings -->

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
        <!-- /Footer Top -->

        <!-- Footer Bottom -->
        <div class="footer-bottom">
            <div class="container">



            </div>
        </div>
        <!-- /Footer Bottom -->

    </footer>
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

<script src="/HAPPYorSAD/cdn-cgi/scripts/7d0fa10a/cloudflare-static/rocket-loader.min.js" 
data-cf-settings="d693b69077856eb34d3f2643-|49" defer></script>
<script defer src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015" integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ==" data-cf-beacon='{"rayId":"91074a70ad7f06b9","version":"2025.1.0","serverTiming":{"name":{"cfExtPri":true,"cfL4":true,"cfSpeedBrain":true,"cfCacheStatus":true}},"token":"3ca157e612a14eccbb30cf6db6691c29","b":1}' crossorigin="anonymous"></script>
</body>

<!-- Mirrored from dreamslms.dreamstechnologies.com/html/mentee-settings.html by HTTrack Website Copier/3.x [XR&CO'2014], Tue, 11 Feb 2025 21:04:23 GMT -->
</html>