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
                                        <li class="nav-item active">
                                            <a href="/../HAPPYorSAD/AcceptCV" class="accept-cv">
                                                <i class="fas fa-user"></i>Manage CV
                                            </a>
                                        <li class="nav-item">
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
                        <div class="col-xl-9 col-lg-9">
                            <div class="content-area" id="content-area">
                                <!-- Profile Heading -->
                                <div class="profile-heading">
                                    <h2 class="heading-title">CV Details</h2>
                                </div>

                                <!-- Personal Information -->
                                <div class="info-section">
                                    <h3 class="section-title">Personal Information</h3>
                                    <ul class="info-list">
                                        <li>
                                            <span class="icon-label"><strong>Full name 👤:</strong></span>
                                            <span class="text-value">${mentor.fullname}</span>
                                        </li>
                                        <li>
                                            <span class="icon-label"><strong>Phone 📱:</strong></span>
                                            <span class="text-value">${mentor.phoneNumber}</span>
                                        </li>
                                        <li>
                                            <span class="icon-label"><strong>Date of Birth 🎂:</strong></span>
                                            <span class="text-value">${mentor.dateOfBirth}</span>
                                        </li>
                                        <li>
                                            <span class="icon-label"><strong>Gmail 📧:</strong></span>
                                            <span class="text-value">${mentor.email}</span>
                                        </li>
                                        <li>
                                            <span class="icon-label"><strong>Gender ⚧:</strong></span>
                                            <span class="text-value">${mentor.gender}</span>
                                        </li>
                                        <li>
                                            <span class="icon-label"><strong>Address 📍:</strong></span>
                                            <span class="text-value">${mentor.address}</span>
                                        </li>
                                    </ul>
                                </div>

                                <!-- CV Details -->
                                <c:if test="${cvDetail != null}">
                                    <div class="cv-section">
                                        <h3 class="section-title">Professional Details</h3>
                                        <div class="cv-content">
                                            <p><span class="detail-label">Profession:</span> ${cvDetail.profession}</p>
                                            <p><span class="detail-label">Introduction:</span> ${cvDetail.professionIntro}</p>
                                            <p><span class="detail-label">Service Description:</span> ${cvDetail.serviceDescription}</p>
                                            <p><span class="detail-label">Achievements:</span> ${cvDetail.achievementDescription}</p>
                                            <p><span class="detail-label">Major:</span> ${cvDetail.courses}</p>
                                            <p><span class="detail-label">Created At:</span>
                                                <fmt:formatDate value="${cvDetail.createdAtAsDate}" pattern="dd-MM-yyyy HH:mm:ss" />
                                            </p>
                                        </div>
                                    </div>
                                </c:if>

                                <c:if test="${cvDetail == null}">
                                    <div class="no-data">
                                        <p>No CV details available.</p>
                                    </div>
                                </c:if>

                                <!-- Back Button -->
                                <div class="action-section">
                                    <a href="AcceptCV" class="btn btn-secondary back-btn">Back</a>
                                </div>
                            </div>
                        </div>

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

                            /* Content Area */
                            .content-area {
                                max-width: 900px;
                                margin: 30px auto;
                                padding: 20px;
                                background: #fff;
                                border-radius: 15px;
                                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
                                transition: transform 0.3s ease;
                            }

                            .content-area:hover {
                                transform: translateY(-5px);
                            }

                            /* Profile Heading */
                            .profile-heading {
                                text-align: center;
                                margin-bottom: 30px;
                            }

                            .heading-title {
                                font-size: 2.2rem;
                                font-weight: 600;
                                color: #2c3e50;
                                position: relative;
                                display: inline-block;
                            }

                            .heading-title::after {
                                content: '';
                                position: absolute;
                                width: 60%;
                                height: 4px;
                                background: linear-gradient(90deg, #1a73e8, #34c759);
                                bottom: -10px;
                                left: 20%;
                                border-radius: 2px;
                                transition: width 0.3s ease;
                            }

                            .heading-title:hover::after {
                                width: 100%;
                                left: 0;
                            }

                            /* Info Section */
                            .info-section,
                            .cv-section {
                                margin-bottom: 40px;
                                padding: 20px;
                                background: #fafafa;
                                border-radius: 10px;
                                transition: all 0.3s ease;
                            }

                            .info-section:hover,
                            .cv-section:hover {
                                background: #f0f4ff;
                                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
                            }

                            .section-title {
                                font-size: 1.5rem;
                                font-weight: 600;
                                color: #1a73e8;
                                margin-bottom: 20px;
                                position: relative;
                            }

                            .section-title::before {
                                content: '';
                                position: absolute;
                                width: 30px;
                                height: 3px;
                                background: #1a73e8;
                                bottom: -5px;
                                left: 0;
                            }

                            /* Info List */
                            .info-list {
                                list-style: none;
                            }

                            .info-list li {
                                display: flex;
                                align-items: center;
                                padding: 12px 0;
                                border-bottom: 1px solid #eee;
                                transition: all 0.3s ease;
                            }

                            .info-list li:last-child {
                                border-bottom: none;
                            }

                            .info-list li:hover {
                                padding-left: 10px;
                            }

                            .icon-label {
                                min-width: 180px;
                                font-weight: 600;
                                color: #2c3e50;
                            }

                            .icon-label strong {
                                margin-right: 5px;
                            }

                            .text-value {
                                color: #555;
                                font-weight: 400;
                                flex: 1;
                                transition: color 0.3s ease;
                            }

                            .info-list li:hover .text-value {
                                color: #1a73e8;
                            }

                            /* CV Content */
                            .cv-content p {
                                margin: 15px 0;
                                padding: 10px;
                                background: #fff;
                                border-radius: 8px;
                                transition: all 0.3s ease;
                            }

                            .cv-content p:hover {
                                background: #e9f1ff;
                                transform: translateX(5px);
                            }

                            .detail-label {
                                font-weight: 600;
                                color: #2c3e50;
                                margin-right: 10px;
                            }

                            /* No Data */
                            .no-data {
                                text-align: center;
                                padding: 30px;
                                background: #fff5f5;
                                border-radius: 10px;
                                margin: 20px 0;
                            }

                            .no-data p {
                                color: #e63946;
                                font-size: 1.2rem;
                                font-weight: 500;
                            }

                            /* Action Section */
                            .action-section {
                                text-align: center;
                                margin-top: 30px;
                            }

                            .btn.btn-secondary.back-btn {
                                background: linear-gradient(135deg, #6c757d, #495057);
                                color: #fff;
                                padding: 12px 30px;
                                border: none;
                                border-radius: 25px;
                                font-weight: 600;
                                text-transform: uppercase;
                                letter-spacing: 1px;
                                transition: all 0.3s ease;
                                display: inline-block;
                            }

                            .btn.btn-secondary.back-btn:hover {
                                background: linear-gradient(135deg, #495057, #343a40);
                                transform: translateY(-3px);
                                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
                            }

                            /* Responsive */
                            @media (max-width: 768px) {
                                .content-area {
                                    padding: 15px;
                                    margin: 15px;
                                }

                                .heading-title {
                                    font-size: 1.8rem;
                                }

                                .section-title {
                                    font-size: 1.3rem;
                                }

                                .info-list li {
                                    flex-direction: column;
                                    align-items: flex-start;
                                    padding: 10px 0;
                                }

                                .icon-label {
                                    min-width: unset;
                                    margin-bottom: 5px;
                                }

                                .text-value {
                                    padding-left: 20px;
                                }

                                .cv-content p {
                                    font-size: 0.9rem;
                                }
                            }
                        </style>
                    </div>
                </div>
            </div>
        </div>	
    </div>
    <!-- /Page Content -->

</body>

<!-- Mirrored from dreamslms.dreamstechnologies.com/html/mentee-settings.html by HTTrack Website Copier/3.x [XR&CO'2014], Tue, 11 Feb 2025 21:04:23 GMT -->
</html>

