<%-- 
    Document   : CourseDetail
    Created on : 13 Feb 2025, 12:42:23 am
    Author     : Acer
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html lang="en">

    <!-- Mirrored from dreamslms.dreamstechnologies.com/html/course-details.html by HTTrack Website Copier/3.x [XR&CO'2014], Tue, 11 Feb 2025 21:04:36 GMT -->
    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>Course Detail</title>

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
    <style>
        .video-sec .card {
            position: relative;
            overflow: hidden;
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .video-sec .card:hover {
            transform: translateY(-5px);
        }

        .video-sec .card img {
            width: 100%;
            height: auto;
            object-fit: cover;
            border-radius: 10px;
        }

        .video-sec .video-details {
            position: absolute;
            bottom: 20px; /* Đặt giá cao hơn một chút để giống hình */
            left: 0;
            right: 0;
            text-align: center;
            padding: 0;
        }

        .video-sec .price-tag {
            display: inline-block;
            padding: 8px 16px; /* Padding vừa phải */
            background-color: #fff; /* Nền trắng như trong hình */
            color: #ff0000; /* Chữ đỏ như trong hình */
            font-size: 24px; /* Kích thước chữ vừa phải, giống hình */
            font-weight: 700; /* Đậm để nổi bật */
            border: 2px solid #000; /* Viền đen xung quanh */
            border-radius: 15px; /* Bo tròn như nhãn dán trong hình */
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2); /* Bóng nhẹ để nổi */
            text-shadow: none; /* Bỏ bóng chữ để giống hình */
            transition: all 0.3s ease;
        }

        .video-sec .card:hover .price-tag {
            transform: scale(1.05); /* Phóng to nhẹ khi hover */
            background-color: #f8f9fa; /* Nền trắng nhạt hơn khi hover */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3); /* Bóng đậm hơn khi hover */
        }
        .product-img img {
            width: 100%; /* ??t chi?u r?ng c? ??nh cho ?nh */
            height: 200px; /* ??t chi?u cao c? ??nh cho ?nh */
            object-fit: cover; /* C?t và ?i?u ch?nh ?nh ?? v?a v?i khung mà không b? méo */
            border-radius: 8px; /* Bo tròn góc ?nh (tu? ch?nh n?u mu?n) */
        }
    </style>
    <body>
        <%@include file="../sourcesHome/homeHeader.jsp" %>
        <!-- Main Wrapper -->
        <div class="main-wrapper">


            <!-- Breadcrumb -->
            <div class="breadcrumb-bar">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 col-12">
                            <div class="breadcrumb-list">
                                <nav aria-label="breadcrumb" class="page-breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="Home">Home</a></li>
                                        <li class="breadcrumb-item" aria-current="page"><a href="ShowAllCourse">Courses</a></li>

                                        <li class="breadcrumb-item" aria-current="page">${detail.title}</li>
                                    </ol>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /Breadcrumb -->

            <!-- Inner Banner -->
            <div class="inner-banner" style="background-image: url('${detail.image}');background-size: cover; background-position: center;">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-8 " >                          
                            <h2>${detail.title}</h2>

                            <div class="course-info d-flex align-items-center border-bottom-0 m-0 p-0">                              
                                <div class="cou-info">
                                    <img src="assets/img/icon/people.svg" alt="Img">
                                    <p> Total: ${countMentorOfCourse} Mentor </p>
                                </div>
                                <div class="rating-img d-flex align-items-center">
                                    <img src="assets/img/icon/user-icon.svg" class="me-1" alt="Img">
                                    <p>${detail.total_Mentee} Mentees</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /Inner Banner -->

            <!-- Course Content -->
            <section class="page-content course-sec">
                <div class="container">

                    <div class="row d-flex">
                        <div class="col-md-8">

                            <!-- Overview -->
                            <div class="card overview-sec">
                                <div class="card-body">
                                    <h2 class="subs-title">Overview</h2>
                                    <h5>Course Title</h5>
                                    <h5><p>${detail.title}</p> </h5>
                                    <h5>Course Major</h5>
                                    <h5><p>${majorName}</p>  </h5>  
                                    <h5>Course Description</h5>
                                    <h5><p>${detail.description}</p>  </h5>                                                            
                                </div>
                            </div>
                            <!-- /Overview -->

                            <!-- Instructor List -->
                            <div class="row">
                                <h2 class="subs-title">List of suggested course mentors</h2>
                                <!-- Instructor List -->
                                <c:forEach var="mentor" items="${sessionScope.listAllMentorByCourse}"> 
                                    <div class="col-lg-12 d-flex">
                                        <div class="instructor-list flex-fill">
                                            <div class="instructor-img">
                                                <a href="MentorDetail?mentorId=${mentor.mentorId}&courseId=${detail.id}&price=${mentor.pricePerSlot}">
                                                    <img class="img-fluid" alt="Img" src="${mentor.image}">
                                                </a>
                                                <div class="price">
                                                    <h3> ${mentor.pricePerSlot}đ</h3>
                                                </div>
                                            </div>
                                            <div class="instructor-content">												
                                                <h5><a href="MentorDetail?mentorId=${mentor.mentorId}&courseId=${detail.id}&price=${mentor.pricePerSlot}">${mentor.name}</a></h5>
                                                <h6>${mentor.username}</h6>
                                                <div class="instructor-info">
                                                    <div class="rating-img d-flex align-items-center">
                                                        <img src="assets/img/icon/user-icon.svg" class="me-1" alt="Img">

                                                        <p>${mentor.total_mentees} Mentees</p>
                                                    </div>
                                                    <div class="rating">
                                                        <c:set var="ratingValue" value="${mentor.rating}"/>

                                                        <c:set var="fullStars" value="${Math.floor(ratingValue)}"/>
                                                        <c:forEach begin="1" end="5" varStatus="loop">
                                                            <c:choose>
                                                                <c:when test="${loop.index <= fullStars}">
                                                                    <i class="fas fa-star filled"></i>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <i class="fas fa-star"></i>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                        <span class="d-inline-block average-rating"><span>${ratingValue}</span> (${mentor.total_reviews})</span>
                                                    </div>                                                  
                                                </div>
                                                <div class="instructor-badge">
                                                    <span class="web-badge">${mentor.expertise}</span>

                                                </div>
                                            </div>
                                            <h2>
                                                <a href="MentorDetail?mentorId=${mentor.mentorId}&courseId=${detail.id}&price=${mentor.pricePerSlot}" 
                                                   class="btn btn-enroll w-100">View</a>
                                            </h2>
                                        </div>
                                    </div>
                                </c:forEach>
                                <!-- /Instructor List -->                             
                            </div>

                            <div class="row">
                                <h2 class="subs-title">List of suggested course have same major</h2>
                                <c:forEach var="o" items="${sessionScope.listCourseToPrint}"> 
                                    <div class="col-lg-4 col-md-6 d-flex">
                                        <div class="course-box course-design d-flex ">
                                            <div class="product">
                                                <div class="product-img">
                                                    <a href="course-details.html">
                                                        <img class="img-fluid" alt="Img" src="${o.image}">
                                                    </a>
                                                </div>
                                                <div class="product-content">
                                                    <h3 class="title"><a href="course-details.html">${o.title}</a></h3>                                                  
                                                    <div class="all-btn all-category d-flex align-items-center">
                                                        <a href="CourseDetails?Cid=${o.id}" class="btn btn-primary">MORE DETAIL</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>	   
                        <div class="col-md-4">
                            <div >

                                <div class="video-sec vid-bg">
                                    <div class="card">
                                        <div class="card-body">
                                            <img src="${detail.image}" alt="Img">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>	
                </div>
            </section>
            <!-- /Pricing Plan -->

        </div>
        <!-- /Main Wrapper -->
        <%@include file="../sourcesHome/homeFooter.jsp" %>            
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
        <script defer src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015" integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ==" data-cf-beacon='{"rayId":"91074a70ad7f06b9","version":"2025.1.0","serverTiming":{"name":{"cfExtPri":true,"cfL4":true,"cfSpeedBrain":true,"cfCacheStatus":true}},"token":"3ca157e612a14eccbb30cf6db6691c29","b":1}' 
        crossorigin="anonymous"></script>
    </body>

    <!-- Mirrored from dreamslms.dreamstechnologies.com/html/course-details.html by HTTrack Website Copier/3.x [XR&CO'2014], Tue, 11 Feb 2025 21:04:46 GMT -->
</html>
