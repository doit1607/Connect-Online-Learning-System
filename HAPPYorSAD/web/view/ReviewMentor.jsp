<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.List, entity.Mentor" %>
<%@ page import="java.util.List, entity.MentorReview" %>
<%-- 
    Document   : ReviewMentor
    Created on : Feb 3, 2025, 11:38:35 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <!-- Mirrored from dreamslms.dreamstechnologies.com/html/course-list.html by HTTrack Website Copier/3.x [XR&CO'2014], Tue, 11 Feb 2025 21:04:25 GMT -->
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

        <link href="css/cssReview/ReviewMentor.css" rel="stylesheet" type="text/css"/>
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
                                <h2 class="breadcrumb-title">Rate & Comment Mentor</h2>
                                <nav aria-label="breadcrumb" class="page-breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="index-2.html">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Rate & Comment Mentor</li>
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
                                            <li class="nav-item active">
                                                <a href="/../HAPPYorSAD/reviewmentor" class="nav-link">
                                                    <i class="bx bxs-bell"></i> Review Mentor
                                                </a>
                                            </li>
                                        </c:if>
                                    </ul>
                                    <h3>Account Settings</h3>
                                    <ul>
                                        <li class="nav-item ">
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

                        <%
                            HttpSession userSession = request.getSession();
                            Integer menteeId = (Integer) userSession.getAttribute("menteeID");
                            List<Mentor> mentorList = (List<Mentor>) request.getAttribute("mentorList");
                            List<Integer> reviewedMentorIds = (List<Integer>) session.getAttribute("reviewedMentorIds");

                            // Lấy mentorId từ request nếu có
                            String selectedMentorIdParam = request.getParameter("mentorId");
                            Integer selectedMentorId = (selectedMentorIdParam != null) ? Integer.parseInt(selectedMentorIdParam) : null;
                            MentorReview review = (MentorReview) request.getAttribute("review"); // Lấy review từ request
                            String selectedMentorName = "Selected Mentor"; // Giá trị mặc định
                            
                            int rating = (review != null) ? review.getRating() : 0;
                            String comment = (review != null) ? review.getCommit() : "";
                        %>

                        <div class="col-xl-9 col-lg-9">
                            <div class="card">
                                <div class="card-body">
                                    <h1 class="mb-4">Select Mentor to Review</h1>

                                    <!-- Danh sách mentor -->
                                    <div class="mentor-list">
                                        <ul>
                                            <% if (mentorList != null) {
                                                for (Mentor mentor : mentorList) { 
                                                    boolean isReviewed = reviewedMentorIds != null && reviewedMentorIds.contains(mentor.getId());
                                                    boolean isSelected = selectedMentorId != null && selectedMentorId.equals(mentor.getId());
                                            %>
                                            <li>
                                                <a href="/HAPPYorSAD/reviewmentor?mentorId=<%= mentor.getId() %>" 
                                                   class="btn btn-link <%= isSelected ? "selected-mentor" : "" %>">
                                                    <%= mentor.getName() %>
                                                </a>
                                            </li>
                                            <% } } %>
                                        </ul>
                                    </div>

                                    <% if (selectedMentorId != null) { %>
                                    <div id="review-form">
                                        <h2 class="mb-3">Rate & Comment</h2>
                                        <form action="/HAPPYorSAD/reviewmentor" method="get">
                                            <input type="hidden" name="username" value="${sessionScope.usernameUser}">
                                            <input type="hidden" name="mentorId" value="<%= selectedMentorId %>">
                                            <input type="hidden" name="menteeID" value="${sessionScope.menteeID}">

                                            <!-- Rating -->
                                            <div class="rating mb-3">
                                                <% for (int i = 5; i >= 1; i--) { %>
                                                <input type="radio" id="star<%= i %>" name="rating" value="<%= i %>" <%= (i == rating) ? "checked" : "" %> required>
                                                <label for="star<%= i %>">★</label>
                                                <% } %>
                                            </div>

                                            <!-- Comment -->
                                            <div class="form-group">
                                                <label for="comment">Comment <span class="required">*</span></label>
                                                <textarea class="form-control" name="comment" required rows="5"><%= comment %></textarea>
                                            </div>

                                            <button type="submit" class="btn btn-primary">Submit Review</button>
                                        </form>
                                    </div>
                                    <% } %>
                                </div>
                            </div>
                        </div>

                        <!-- CSS để làm nổi bật mentor được chọn -->
                        <style>
                            .selected-mentor {
                                background-color: #007bff; /* Màu nền xanh */
                                color: white; /* Chữ trắng */
                                padding: 5px 10px; /* Khoảng đệm */
                                border-radius: 5px; /* Bo góc */
                                text-decoration: none; /* Bỏ gạch chân */
                            }
                            .selected-mentor:hover {
                                color: white; /* Giữ màu chữ trắng khi hover */
                            }
                        </style>
                        <!-- /Main Content -->
                    </div>
                </div>
            </div>
            <!-- /Page Content -->

            <!-- Footer Top -->
            <%@include file="/../sourcesHome/homeFooter.jsp" %>    
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
