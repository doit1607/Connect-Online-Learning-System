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

            /* Container form */
            .add-course-form {
                max-width: 600px;
                margin: 30px auto;
                padding: 30px;
                background: #ffffff;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
                transition: transform 0.3s ease;
            }

            .add-course-form:hover {
                transform: translateY(-5px);
            }

            /* Input block */
            .input-block {
                margin-bottom: 25px;
            }

            .add-course-label {
                display: block;
                font-size: 1rem;
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 8px;
                transition: color 0.3s ease;
            }

            .input-block:hover .add-course-label {
                color: #1a73e8;
            }

            /* File upload */
            .relative-form {
                display: flex;
                align-items: center;
                justify-content: space-between;
                background: #f9f9f9;
                padding: 10px 15px;
                border-radius: 8px;
                border: 1px solid #ddd;
                transition: border-color 0.3s ease;
            }

            .relative-form:hover {
                border-color: #1a73e8;
            }

            #file-name {
                color: #777;
                font-size: 0.9rem;
            }

            .relative-file-upload {
                position: relative;
                display: inline-block;
                cursor: pointer;
            }

            .relative-file-upload input[type="file"] {
                position: absolute;
                left: 0;
                top: 0;
                opacity: 0;
                width: 100%;
                height: 100%;
                cursor: pointer;
            }

            .relative-file-upload {
                background: #1a73e8;
                color: #fff;
                padding: 8px 15px;
                border-radius: 5px;
                font-weight: 500;
                transition: background 0.3s ease;
            }

            .relative-file-upload:hover {
                background: #1557b0;
            }

            /* Form control */
            .form-control {
                width: 100%;
                padding: 12px 15px;
                border: 1px solid #ddd;
                border-radius: 8px;
                font-size: 1rem;
                color: #333;
                background: #f9f9f9;
                transition: border-color 0.3s ease, box-shadow 0.3s ease;
            }

            .form-control:focus {
                outline: none;
                border-color: #1a73e8;
                box-shadow: 0 0 5px rgba(26, 115, 232, 0.3);
                background: #fff;
            }

            textarea.form-control {
                resize: vertical;
                min-height: 100px;
            }

            /* Select */
            select.form-control {
                appearance: none;
                background: #f9f9f9 url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="%23777" viewBox="0 0 24 24"><path d="M7 10l5 5 5-5z"/></svg>') no-repeat right 15px center;
                padding-right: 40px;
            }

            /* Button */
            .btn.btn-success-dark {
                background: linear-gradient(135deg, #28a745, #218838);
                color: #fff;
                padding: 12px 30px;
                border: none;
                border-radius: 25px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 1px;
                transition: all 0.3s ease;
                width: 100%;
                max-width: 200px;
                display: block;
                margin: 0 auto;
            }

            .btn.btn-success-dark:hover {
                background: linear-gradient(135deg, #218838, #1e7e34);
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            }

            /* Preview image */
            #image-preview {
                transition: opacity 0.3s ease;
            }

            #image-preview.visible {
                display: block;
                opacity: 1;
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
                                        <li class="nav-item">
                                            <a href="/../HAPPYorSAD/AcceptCV" class="accept-cv">
                                                <i class="fas fa-user"></i>Manage CV
                                            </a>
                                        <li class="nav-item active">
                                            <a href="CourseManager" class="nav-link">
                                                <i class="bx bxs-graduation"></i>Manage Courses
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
                                                <img id="image-preview" src="#" alt="Image Preview" class="img-fluid" style="display:none; margin-top: 10px; max-width: 10px; height: auto; border: 1px solid #ccc; padding: 5px; border-radius: 5px;">
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

                                            <div class="input-block">
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
