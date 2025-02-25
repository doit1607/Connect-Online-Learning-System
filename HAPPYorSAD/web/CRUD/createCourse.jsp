<%-- 
    Document   : createCourse
    Created on : Jan 24, 2025, 5:08:45 PM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
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
                                        <li class="nav-item ">
                                            <a href="/../HAPPYorSAD/AcceptCV" class="accept-cv">
                                                <i class="fas fa-user"></i>Manage CV
                                            </a>
                                        <li class="nav-item active">
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
                        <!-- Main Wrapper -->
                        <div class="col-xl-9 col-lg-9">
                            <!-- New Course -->
                            <% ResultSet rsMajor = (ResultSet) request.getAttribute("rsMajor");%>

                            <div class="profile-heading">
                                <h3>Create Course</h3>
                            </div>
                            <div class="card">
                                <!-- Course Wizard -->

                                <c:if test="${param.success == 'true'}">
                                    <div class="alert alert-success">Course created successfully!</div>
                                </c:if>

                                <div class="content-area" id="content-area">

                                    <div class="add-course-form">
                                        <form action="CreateCourses" method="post" id="createCourseForm" enctype="multipart/form-data">
                                            <div class="input-block">
                                                <label class="add-course-label">Course image</label>
                                                <div class="relative-form">
                                                    <span id="file-name">No File Selected</span>
                                                    <label class="relative-file-upload">
                                                        Upload File <input type="file" name="imageFile" accept="image/*" id="image-upload" onchange="previewImage(event)">
                                                    </label>
                                                </div>
                                                <img id="image-preview" src="#" alt="Image Preview" class="img-fluid" style="display:none; margin-top: 10px; max-width: 150px; height: auto; border: 1px solid #ccc; padding: 5px; border-radius: 5px;">
                                            </div>
                                            <div class="input-block">
                                                <label class="add-course-label">Course Name</label>
                                                <input type="text" name="title" id="title" class="form-control" placeholder="Course Title" required>
                                            </div>
                                            <div class="input-block">
                                                <label class="add-course-label">Major Name</label>                                                                                                                        
                                                <select class="form-control" name="majorID" id="majorID">
                                                    <option value="">-- Select Major --</option>
                                                    <c:forEach var="major" items="${listMajor}">
                                                        <option value="${major.id}">${major.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>

                                            <div class="input-block mb-0">
                                                <label class="add-course-label">Course Description</label>
                                                <textarea name="description" id="description" class="form-control" placeholder="Course Description" rows="3" required></textarea>
                                            </div>
                                            <div class="add-course-btns">
                                                <ul class="nav">

                                                    <li>
                                                        <button type="submit" form="createCourseForm" class="btn btn-success-dark">Save</button>
                                                    </li>
                                                </ul>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /Course Wizard -->
            </div>

            <!-- /New Course -->

            <script>
                function previewImage(event) {
                    var input = event.target;
                    var reader = new FileReader();

                    reader.onload = function () {
                        var imagePreview = document.getElementById('image-preview');
                        imagePreview.src = reader.result;
                        imagePreview.style.display = 'block';
                    };

                    reader.readAsDataURL(input.files[0]);

                    // Display the file name
                    document.getElementById('file-name').textContent = input.files[0].name;
                }
            </script>
        </div>
    </body>

</html>
