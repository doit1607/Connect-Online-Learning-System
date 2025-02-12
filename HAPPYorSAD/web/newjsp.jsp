<%-- 
    Document   : newjsp
    Created on : Feb 12, 2025, 4:46:23 AM
    Author     : Ann
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <title>JSP Page</title>
        <!-- Favicon -->
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.svg">

        <!-- Theme Settings Js -->
        <script src="assets/js/theme-script.js" type="1d433aff6b2b8dd82abe2a72-text/javascript"></script>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">

        <!-- Fontawesome CSS -->
        <link rel="stylesheet" href="assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="assets/plugins/fontawesome/css/all.min.css">

        <!-- Owl Carousel CSS -->
        <link rel="stylesheet" href="assets/css/owl.carousel.min.css">
        <link rel="stylesheet" href="assets/css/owl.theme.default.min.css">

        <!-- Slick CSS -->
        <link rel="stylesheet" href="assets/plugins/slick/slick.css">
        <link rel="stylesheet" href="assets/plugins/slick/slick-theme.css">

        <!-- Select2 CSS -->
        <link rel="stylesheet" href="assets/plugins/select2/css/select2.min.css">

        <!-- Aos CSS -->
        <link rel="stylesheet" href="../assets/plugins/aos/aos.css">

        <!-- Main CSS -->
        <link rel="stylesheet" href="assets/css/style.css">
    </head>
    <body>
        <div class="main-wrapper">
            <section class="home-slide d-flex align-items-center">
                <div class="container">
                    <div class="row ">
                        <div class="col-md-7">
                            <div class="home-slide-face aos" data-aos="fade-up">
                                <div class="home-slide-text ">
                                    <h5>The Leader in Online Learning</h5>
                                    <h1>Engaging & Accessible Online Courses For All</h1>
                                    <p>Own your future learning new skills online</p>
                                </div>
                                <div class="banner-content">
                                    <form class="form" action="https://dreamslms.dreamstechnologies.com/html/course-list.html">
                                        <div class="form-inner">
                                            <div class="input-group">
                                                <i class="fa-solid fa-magnifying-glass search-icon"></i>
                                                <input type="email" class="form-control"
                                                       placeholder="Search School, Online eductional centers, etc">
                                                <span class="drop-detail"> 
                                                    <select class="form-select select">
                                                        <option>Category</option>
                                                        <c:forEach var="category" items="${sessionScope.listMajor}">
                                                            <option value="${category.id}">${category.name}</option>
                                                        </c:forEach>
                                                    </select>
                                                </span>
                                                <button class="btn btn-primary sub-btn" type="submit"><i
                                                        class="fas fa-arrow-right"></i></button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="trust-user">
                                    <p>Trusted by over 15K Users <br>worldwide since 2024</p>
                                    <div class="trust-rating d-flex align-items-center">
                                        <div class="rate-head">
                                            <h2><span>1000</span>+</h2>
                                        </div>
                                        <div class="rating d-flex align-items-center">
                                            <h2 class="d-inline-block average-rating">4.4</h2>
                                            <i class="fas fa-star filled"></i>
                                            <i class="fas fa-star filled"></i>
                                            <i class="fas fa-star filled"></i>
                                            <i class="fas fa-star filled"></i>
                                            <i class="fas fa-star filled"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5 d-flex align-items-center">
                            <div class="girl-slide-img aos" data-aos="fade-up">
                                <img src="assets/img/object.png" alt="Img">
                            </div>
                        </div>
                    </div>
                </div>
            </section>


            <!-- Top Categories -->
            <section class="section how-it-works">
                <div class="container">
                    <div class="section-header aos" data-aos="fade-up">
                        <div class="section-sub-head">
                            <span>Favourite Course</span>
                            <h2>Top Category</h2>
                        </div>
                        <div class="all-btn all-category d-flex align-items-center">
                            <a href="job-category.html" class="btn btn-primary">All Categories</a>
                        </div>
                    </div>
                    <div class="section-text aos" data-aos="fade-up">
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget aenean accumsan bibendum gravida
                            maecenas augue elementum et neque. Suspendisse imperdiet.</p>
                    </div>
                    <div class="owl-carousel mentoring-course owl-theme aos" data-aos="fade-up">
                        <c:forEach var="category" items="${sessionScope.listMajor}" >
                            <div class="feature-box text-center ">
                                <div class="feature-bg">
                                    <div class="feature-header">
                                        <div class="feature-icon">
                                            <img src="${category.image}" alt="${category.name}">
                                        </div>
                                        <div class="feature-cont">
                                            <div class="feature-text">${category.name}</div>
                                        </div>
                                    </div>
                                    <p>${category.total_courses} Courses</p>
                                </div>
                            </div>                     
                        </c:forEach>


                    </div>
                </div>
            </section>
            <!-- /Top Categories -->



            <!-- Feature Course -->
            <section class="section new-course">
                <div class="container">
                    <div class="section-header aos" data-aos="fade-up">
                        <div class="section-sub-head">
                            <span>What’s New</span>
                            <h2>Featured Courses</h2>
                        </div>
                        <div class="all-btn all-category d-flex align-items-center">
                            <a href="course-list.html" class="btn btn-primary">All Courses</a>
                        </div>
                    </div>
                    <div class="section-text aos" data-aos="fade-up">
                        <p class="mb-0">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget aenean accumsan
                            bibendum gravida maecenas augue elementum et neque. Suspendisse imperdiet.</p>
                    </div>
                    <div class="course-feature">
                        <div class="row">
                            <c:forEach var="course" items="${sessionScope.listTCourse}" varStatus="loop">
                                <c:if test="${loop.index < 6}">
                                    <div class="col-lg-4 col-md-6 d-flex">
                                        <div class="course-box d-flex aos" data-aos="fade-up">
                                            <div class="product">
                                                <div class="product-img">
                                                    <a href="course-details.html">
                                                        <img class="img-fluid" src="${course.image}" alt="${course.title}">
                                                    </a>
                                                    <!--                                                <div class="price">
                                                                                                        <h3>$300 <span>$99.00</span></h3>
                                                                                                    </div>-->
                                                </div>
                                                <div class="product-content">
                                                    <div class="course-group d-flex">
                                                        <!--                                                    <div class="course-group-img d-flex">
                                                                                                                <a href="instructor-profile.html"><img src="assets/img/user/user1.jpg"
                                                                                                                                                       alt="Img" class="img-fluid"></a>
                                                                                                                <div class="course-name">
                                                                                                                    <h4><a href="instructor-profile.html">Nicole Brown</a></h4>
                                                                                                                    <p>Instructor</p>
                                                                                                                </div>
                                                                                                            </div>-->
                                                        <div class="course-share d-flex align-items-center justify-content-center">
                                                            <a href="#"><i class="fa-regular fa-heart"></i></a>
                                                        </div>
                                                    </div>
                                                    <h3 class="title instructor-text"><a href="course-details.html">${course.title}</a></h3>
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
                                                    <div class="d-flex align-items-center justify-content-between">

                                                        <div class="all-btn all-category d-flex align-items-center">
                                                            <a href="checkout.html" class="btn btn-primary">Request</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </div>

            </section>
            <!-- /Feature Course -->


            <!-- /Trending Course -->

            <!-- Trending Course -->
            <section class="section trend-course">
                <div class="container">
                    <div class="section-header aos" data-aos="fade-up">
                        <div class="section-sub-head">
                            <span>What’s New</span>
                            <h2>TRENDING COURSES</h2>
                        </div>
                        <div class="all-btn all-category d-flex align-items-center">
                            <a href="course-list.html" class="btn btn-primary">All Courses</a>
                        </div>
                    </div>
                    <div class="section-text aos" data-aos="fade-up">
                        <p class="mb-0">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget aenean accumsan
                            bibendum gravida maecenas augue elementum et neque. Suspendisse imperdiet.</p>
                    </div>
                    <div class="owl-carousel trending-course owl-theme aos" data-aos="fade-up">

                        <c:forEach var="course" items="${sessionScope.listTCourse}">
                            <div class="course-box trend-box">
                                <div class="product trend-product">
                                    <div class="product-img">
                                        <a href="course-details.html">
                                            <img class="img-fluid" alt="Img" src="${course.image}">
                                        </a>
                                        <!--                                        <div class="price">
                                                                                    <h3>$300 <span>$99.00</span></h3>
                                                                                </div>-->
                                    </div>
                                    <div class="product-content">

                                        <h3 class="title"><a href="course-details.html">${course.title}</a></h3>
                                        <div class="course-info d-flex align-items-center">
                                            <div class="rating-img d-flex align-items-center">
                                                <img src="assets/img/icon/icon-01.svg" alt="Img" class="img-fluid">
                                                <p>10+ Lesson</p>
                                            </div>
                                            <div class="course-view d-flex align-items-center">
                                                <img src="assets/img/icon/icon-02.svg" alt="Img" class="img-fluid">
                                                <p>11hr 30min</p>
                                            </div>
                                        </div>
                                        <div class="d-flex align-items-center justify-content-between">
                                            <!--                                            <div class="rating m-0">
                                                                                            <i class="fas fa-star filled"></i>
                                                                                            <i class="fas fa-star filled"></i>
                                                                                            <i class="fas fa-star filled"></i>
                                                                                            <i class="fas fa-star filled"></i>
                                                                                            <i class="fas fa-star"></i>
                                                                                            <span class="d-inline-block average-rating"><span>4.0</span> (15)</span>
                                                                                        </div>-->
                                            <div class="all-btn all-category d-flex align-items-center">
                                                <a href="checkout.html" class="btn btn-primary">Request</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>


                    <div class="feature-instructors">
                        <div class="section-header aos" data-aos="fade-up">
                            <div class="section-sub-head feature-head text-center">
                                <h2>Featured Instructor</h2>
                                <div class="section-text aos" data-aos="fade-up">
                                    <p class="mb-0">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget aenean
                                        accumsan bibendum gravida maecenas augue elementum et neque. Suspendisse imperdiet.
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="owl-carousel instructors-course owl-theme aos" data-aos="fade-up">
                            
                         <c:forEach var="mentor" items="${sessionScope.listMentor}" varStatus="loop">
                            <c:if test="${loop.index > 1}">
                            <div class="instructors-widget">
                                <div class="instructors-img ">
                                    <a href="instructor-list.html">
                                        <img class="img-fluid" alt="Img" src="${mentor.image}">
                                    </a>
                                </div>
                                <div class="instructors-content text-center">
                                    <h5><a href="instructor-profile.html">${mentor.name}</a></h5>
                                    <p>${mentor.expertise}</p>
                                    <div class="student-count d-flex justify-content-center">
                                        <i class="fa-solid fa-user-group"></i>
                                        <span>${mentor.total_mentees} Mentees</span>
                                    </div>
                                </div>
                            </div></c:if>
                            </c:forEach>
                            
                            <c:forEach var="mentor" items="${sessionScope.listMentor}" varStatus="loop">
                                <c:if test="${loop.index %2==0}">
                            <div class="instructors-widget">
                                <div class="instructors-img">
                                    <a href="instructor-list.html">
                                        <img class="img-fluid" alt="Img" src="${mentor.image}">
                                    </a>
                                </div>
                                <div class="instructors-content text-center">
                                    <h5><a href="instructor-profile.html">${mentor.name}</a></h5>
                                    <p>${mentor.expertise}</p>
                                    <div class="student-count d-flex justify-content-center">
                                        <i class="fa-solid fa-user-group yellow"></i>
                                        <span>${mentor.total_mentees} Mentees</span>
                                    </div>
                                </div>
                            </div></c:if>
                            </c:forEach>
                            
                            <c:forEach var="mentor" items="${sessionScope.listMentor}" varStatus="loop">
                                <c:if test="${loop.index % 3 ==0}">
                            <div class="instructors-widget">
                                <div class="instructors-img">
                                    <a href="instructor-list.html">
                                        <img class="img-fluid" alt="Img" src="${mentor.image}">
                                    </a>
                                </div>
                                <div class="instructors-content text-center">
                                    <h5><a href="instructor-profile.html">${mentor.name}</a></h5>
                                    <p>${mentor.expertise}</p>
                                    <div class="student-count d-flex justify-content-center">
                                        <i class="fa-solid fa-user-group violet"></i>
                                        <span>${mentor.total_mentees} Mentees</span>
                                    </div>
                                </div>
                            </div></c:if>
                            </c:forEach>
                            
                            
                            <div class="instructors-widget">
                                <c:forEach var="mentor" items="${sessionScope.listMentor}" varStatus="loop">
                                    <c:if test="${loop.index % 5 ==0}">
                                <div class="instructors-img">
                                    <a href="instructor-list.html">
                                        <img class="img-fluid" alt="Img" src="${mentor.image}">
                                    </a>
                                </div>
                                <div class="instructors-content text-center">
                                    <h5><a href="instructor-profile.html">${mentor.name}</a></h5>
                                    <p>${mentor.expertise}</p>
                                    <div class="student-count d-flex justify-content-center">
                                        <i class="fa-solid fa-user-group orange"></i>
                                        <span>${mentor.total_mentees} Mentees</span>
                                    </div>
                                </div></c:if>
                                 </c:forEach>
                                
                            </div>
                           
                        
                   
                        </div>
                    </div>
                </div>
            </section>
            <!-- /Trending Course -->






        </div>
        <!-- jQuery -->
        <script data-cfasync="false" src="../cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script><script src="assets/js/jquery-3.7.1.min.js" type="1d433aff6b2b8dd82abe2a72-text/javascript"></script>

        <!-- Bootstrap Core JS -->
        <script src="assets/js/bootstrap.bundle.min.js" type="1d433aff6b2b8dd82abe2a72-text/javascript"></script>

        <!-- counterup JS -->
        <script src="assets/js/jquery.waypoints.js" type="1d433aff6b2b8dd82abe2a72-text/javascript"></script>
        <script src="assets/js/jquery.counterup.min.js" type="1d433aff6b2b8dd82abe2a72-text/javascript"></script>

        <!-- Select2 JS -->
        <script src="assets/plugins/select2/js/select2.min.js" type="1d433aff6b2b8dd82abe2a72-text/javascript"></script>

        <!-- Owl Carousel -->
        <script src="assets/js/owl.carousel.min.js" type="1d433aff6b2b8dd82abe2a72-text/javascript"></script>

        <!-- Slick Slider -->
        <script src="assets/plugins/slick/slick.js" type="1d433aff6b2b8dd82abe2a72-text/javascript"></script>

        <!-- Aos -->
        <script src="assets/plugins/aos/aos.js" type="1d433aff6b2b8dd82abe2a72-text/javascript"></script>

        <!-- Custom JS -->
        <script src="assets/js/script.js" type="1d433aff6b2b8dd82abe2a72-text/javascript"></script>

        <script src="cdn-cgi/scripts/7d0fa10a/cloudflare-static/rocket-loader.min.js" data-cf-settings="1d433aff6b2b8dd82abe2a72-|49" defer></script><script defer src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015" integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ==" data-cf-beacon='{"rayId":"910743f1baeee2ec","version":"2025.1.0","serverTiming":{"name":{"cfExtPri":true,"cfL4":true,"cfSpeedBrain":true,"cfCacheStatus":true}},"token":"3ca157e612a14eccbb30cf6db6691c29","b":1}' crossorigin="anonymous"></script>
    </body>
</html>
