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

        <link rel="shortcut icon" type="image/x-icon" href="/HAPPYorSAD/assets/img/favicon.svg">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/owl.carousel.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/owl.theme.default.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/slick/slick.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/slick/slick-theme.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/select2/css/select2.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/aos/aos.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css">
        <link rel="stylesheet" href="assets/css/style.css">

    </head>

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
            <div class="inner-banner">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-8">                          
                            <h2>${detail.title}</h2>
                            <p>Learn Web Development by building 25 websites and mobile apps using HTML, CSS, Javascript, PHP, Python, MySQL & more!</p>
                            <div class="course-info d-flex align-items-center border-bottom-0 m-0 p-0">
                                <div class="cou-info">
                                    <img src="assets/img/icon/icon-01.svg" alt="Img">
                                    <p>12+ Lesson</p>
                                </div>
                                <div class="cou-info">
                                    <img src="assets/img/icon/timer-icon.svg" alt="Img">
                                    <p>9hr 30min</p>
                                </div>
                                <div class="cou-info">
                                    <img src="assets/img/icon/people.svg" alt="Img">
                                    <p> Total: ${countMentorOfCourse} Mentor </p>
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

                    <div class="row">
                        <div class="col-lg-8">

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
                                                <a href="MentorDetail?mentorId=${mentor.mentorId}&courseId=${detail.id}&price=${price}">
                                                    <img class="img-fluid" alt="Img" src="${mentor.image}">
                                                </a>
                                            </div>
                                            <div class="instructor-content">												
                                                <h5><a href="MentorDetail?mentorId=${mentor.mentorId}&courseId=${detail.id}&price=${price}">${mentor.name}</a></h5>
                                                <h6>@${mentor.username}</h6>
                                                <div class="instructor-info">
                                                    <div class="rating-img d-flex align-items-center justify-content-center">
                                                        <img src="assets/img/icon/icon-01.svg" class="me-1" alt="Img">
                                                        <p>12+ Lesson</p>
                                                    </div>
                                                    <div class="course-view d-flex align-items-center justify-content-center">
                                                        <img src="assets/img/icon/icon-02.svg" class="me-1" alt="Img">
                                                        <p>9hr 30min</p>
                                                    </div>
                                                    <div class="rating-img d-flex align-items-center">
                                                        <img src="assets/img/icon/user-icon.svg" class="me-1" alt="Img">
                                                        <p>${mentor.total_mentees} Mentees</p>
                                                    </div>
                                                    <div class="rating">
                                                        <c:set var="ratingValue" value="${mentor.rating}"/>
                                                        <c:set var="numReviews" value="${mentor.total_reviews}"/> 
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
                                                        <span class="d-inline-block average-rating"><span>${ratingValue}</span> (${numReviews})</span>
                                                    </div>
                                                    <a href="#rate" class="rating-count"><i class="fa-regular fa-heart"></i></a>
                                                </div>
                                                <div class="instructor-badge">
                                                    <span class="web-badge">${mentor.expertise}</span>

                                                </div>
                                            </div>
                                            <h2>CreateRequest
                                                <a href="test?mentorId=${mentor.mentorId}&courseId=${detail.id}&price=${price}" 
                                                   class="btn btn-enroll w-100">Invite</a>
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
                                                    <div class="price">
                                                        <h3> ${o.price} đ</h3>
                                                    </div>
                                                </div>
                                                <div class="product-content">
                                                    <div class="course-group d-flex">                                                 
                                                        <div
                                                            class="course-share d-flex align-items-center justify-content-center">
                                                            <a href="#rate"><i class="fa-regular fa-heart"></i></a>
                                                        </div>
                                                    </div>
                                                    <h3 class="title"><a href="course-details.html">${o.title}</a></h3>
                                                    <div class="course-info d-flex align-items-center">
                                                        <div class="rating-img d-flex align-items-center">
                                                            <img src="assets/img/icon/icon-01.svg" alt="Img">
                                                            <p>12+ Lesson</p>
                                                        </div>
                                                        <div class="course-view d-flex align-items-center">
                                                            <img src="assets/img/icon/icon-02.svg" alt="Img">
                                                            <p>9hr 30min</p>
                                                        </div>
                                                    </div>
                                                    <div class="rating">
                                                        <i class="fas fa-star filled"></i>
                                                        <i class="fas fa-star filled"></i>
                                                        <i class="fas fa-star filled"></i>
                                                        <i class="fas fa-star filled"></i>
                                                        <i class="fas fa-star"></i>
                                                        <span class="d-inline-block average-rating"><span>4.0</span> (15)</span>
                                                    </div>
                                                    <div class="all-btn all-category d-flex align-items-center">
                                                        <a href="checkout.html" class="btn btn-primary">MORE DETAIL</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>	

                        <div class="col-lg-4">
                            <div class="sidebar-sec">

                                <!-- Video -->
                                <div class="video-sec vid-bg">
                                    <div class="card">
                                        <div class="card-body">
                                            <a href="" class="video-thumbnail" data-fancybox="">
                                                <!--                                                <div class="play-icon">
                                                                                                    <i class="fa-solid fa-play"></i>
                                                                                                </div>-->
                                                <img class="img-fluid" src="${detail.image}" alt="Img">
                                            </a>
                                            <div class="video-details">                                              
                                                <div class="course-fee">
                                                    <h2 class="title"><a href="">Study with Instructor Trung An</a></h2>
                                                    <p><span>$99.00</span> 50% off</p>
                                                </div>
                                                <h2><a href="/../HAPPYorSAD/CreateRequest" class="btn btn-enroll w-100">Invite</a></h2>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /Video -->

                                <!-- Include -->
                                <div class="card include-sec">
                                    <div class="card-body">
                                        <div class="cat-title">
                                            <h4>Includes</h4>
                                        </div>
                                        <ul>
                                            <li><img src="assets/img/icon/import.svg" class="me-2" alt="Img"> 11 hours on-demand video</li>
                                            <li><img src="assets/img/icon/play.svg" class="me-2" alt="Img"> 69 downloadable resources</li>
                                            <li><img src="assets/img/icon/key.svg" class="me-2" alt="Img"> Full lifetime access</li>
                                            <li><img src="assets/img/icon/mobile.svg" class="me-2" alt="Img"> Access on mobile and TV</li>
                                            <li><img src="assets/img/icon/cloud.svg" class="me-2" alt="Img"> Assignments</li>
                                            <li><img src="assets/img/icon/teacher.svg" class="me-2" alt="Img"> Certificate of Completion</li>
                                        </ul>
                                    </div>
                                </div>
                                <!-- /Include -->

                                <!-- Features -->
                                <div class="card feature-sec">
                                    <div class="card-body">
                                        <div class="cat-title">
                                            <h4>Includes</h4>
                                        </div>
                                        <ul>
                                            <li><img src="assets/img/icon/users.svg" class="me-2" alt="Img"> Enrolled: <span>32 students</span></li>
                                            <li><img src="assets/img/icon/timer.svg" class="me-2" alt="Img"> Duration: <span>20 hours</span></li>
                                            <li><img src="assets/img/icon/chapter.svg" class="me-2" alt="Img"> Chapters: <span>15</span></li>
                                            <li><img src="assets/img/icon/video.svg" class="me-2" alt="Img"> Video:<span> 12 hours</span></li>
                                            <li><img src="assets/img/icon/chart.svg" class="me-2" alt="Img"> Level: <span>Beginner</span></li>
                                        </ul>
                                    </div>
                                </div>
                                <!-- /Features -->

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
        <script src="/HAPPYorSAD/assets/js/theme-script.js"></script>
        <script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="/HAPPYorSAD/assets/js/jquery.waypoints.js"></script>
        <script src="/HAPPYorSAD/assets/js/jquery.counterup.min.js"></script>
        <script src="/HAPPYorSAD/assets/plugins/select2/js/select2.min.js"></script>
        <script src="/HAPPYorSAD/assets/js/owl.carousel.min.js"></script>
        <script src="/HAPPYorSAD/assets/plugins/slick/slick.js"></script>
        <script src="/HAPPYorSAD/assets/plugins/aos/aos.js"></script>
        <script src="/HAPPYorSAD/assets/js/script.js"></script>
    </body>

    <!-- Mirrored from dreamslms.dreamstechnologies.com/html/course-details.html by HTTrack Website Copier/3.x [XR&CO'2014], Tue, 11 Feb 2025 21:04:46 GMT -->
</html>
