<%-- 
    Document   : homeBody
    Created on : Jan 19, 2025, 4:17:49 PM
    Author     : Ann
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">         
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">         
        <title>Dreams LMS</title>          
        <link rel="shortcut icon" type="image/x-icon" href="/HAPPYorSAD/assets/img/favicon.svg">          
        <script src="/HAPPYorSAD/assets/js/theme-script.js" type="text/javascript"></script>          
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap.min.css">          
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/fontawesome.min.css">         
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/all.min.css">      

        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/owl.carousel.min.css">         
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/owl.theme.default.min.css">          
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/feather/feather.css">          
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css"> 
    </head>
    <body>
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
                            <img src="/HAPPYorSAD/assets/img/object.png" alt="Img">
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <section class="section student-course">
            <div class="container">
                <div class="course-widget">
                    <div class="row">
                        <div class="col-lg-3 col-md-6">
                            <div class="course-full-width">
                                <div class="blur-border course-radius align-items-center aos" data-aos="fade-up">
                                    <div class="online-course d-flex align-items-center">
                                        <div class="course-img">
                                            <img src="/HAPPYorSAD/assets/img/pencil-icon.svg" alt="Img">
                                        </div>
                                        <div class="course-inner-content">
                                            <c:forEach var="count" items="${sessionScope.listCountC}">
                                                <h4>${count.total_Courses}</h4>
                                            </c:forEach>

                                            <p>Online Courses</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6 d-flex">
                            <div class="course-full-width">
                                <div class="blur-border course-radius aos" data-aos="fade-up">
                                    <div class="online-course d-flex align-items-center">
                                        <div class="course-img">
                                            <img src="/HAPPYorSAD/assets/img/cources-icon.svg" alt="Img">
                                        </div>
                                        <div class="course-inner-content">
                                            <c:forEach var="count" items="${sessionScope.listCountMentor}">
                                                <h4>${count.total_Mentor}</h4>
                                            </c:forEach>
                                            <p>Expert Tutors</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--                        <div class="col-lg-3 col-md-6 d-flex">
                                                    <div class="course-full-width">
                                                                                        <div class="blur-border course-radius aos" data-aos="fade-up">
                                                                                            <div class="online-course d-flex align-items-center">
                                                                                                <div class="course-img">
                                                                                                    <img src="/HAPPYorSAD/assets/img/certificate-icon.svg" alt="Img">
                                                                                                </div>
                                                                                                <div class="course-inner-content">
                                                                                                    <h4><span>6</span>K+</h4>
                                                                                                    <p>Ceritified Courses</p>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                    </div>
                                                </div>-->
                        <div class="col-lg-3 col-md-6 d-flex">
                            <div class="course-full-width">
                                <div class="blur-border course-radius aos" data-aos="fade-up">
                                    <div class="online-course d-flex align-items-center">
                                        <div class="course-img">
                                            <img src="/HAPPYorSAD/assets/img/gratuate-icon.svg" alt="Img">
                                        </div>
                                        <div class="course-inner-content">
                                            <c:forEach var="count" items="${sessionScope.listCountMentee}">
                                                <h4>${count.total_Mentee}</h4>
                                            </c:forEach>
                                            <p>Online Mentees</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>



        <!-- Danh mục khóa học -->
        <!-- Top Categories -->
        <section class="section how-it-works">
            <div class="container">
                <div class="section-header aos" data-aos="fade-up">
                    <div class="section-sub-head">
                        <span>Feature Course Major</span>
                        <h2>Course Major</h2>
                    </div>
                </div>
                <div class="owl-carousel mentoring-course owl-theme aos" data-aos="fade-up">
                    <c:forEach var="category" items="${sessionScope.listMajor}" >
                        <div class="feature-box text-center ">
                            <div class="feature-bg">
                                <div class="feature-header">
                                    <div class=" product-img">
                                        <img src="${category.image}" alt="${category.name}">
                                    </div>
                                    <div class="feature-cont">
                                        <a href="/HAPPYorSAD/ShowAllCourseByMajorId?Mid=${category.id}">
                                            <div class="feature-text">${category.name}</div>
                                        </a>
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
                        <a href="ShowAllCourse" class="btn btn-primary">All Courses</a>
                    </div>
                </div>
                <div class="course-feature">
                    <div class="row">
                        <c:forEach var="course" items="${sessionScope.listFCourse}" varStatus="loop">
                            <c:if test="${loop.index < 4}">
                                <div class="col-lg-3 col-md-6 d-flex">
                                    <div class="course-box d-flex aos" data-aos="fade-up">
                                        <div class="product">
                                            <div class="product-img">
                                                <a href="CourseDetails?Cid=${course.id}">
                                                    <img class="img-fluid" src="${course.image}" alt="${course.title}">
                                                </a>
                                            </div>
                                            <div class="product-content">
                                                <div class="course-group d-flex">

                                                    <div class="course-share d-flex align-items-center justify-content-center">
                                                        <a href="#"><i class="fa-regular fa-heart"></i></a>
                                                    </div>
                                                </div>
                                                <h3 class="title instructor-text"><a href="course-details.html">${course.title}</a></h3>

                                                <div class="d-flex align-items-center justify-content-between">

                                                    <c:choose>
                                                        <c:when test="${sessionScope.usernameRole eq 'mentee'}">
                                                            <div class="all-btn all-category d-flex align-items-center">
                                                                <a href="/HAPPYorSAD/CourseDetails?Cid=${course.id}" class="btn btn-primary">Request</a>
                                                            </div>
                                                        </c:when>
                                                        <c:when test="${sessionScope.usernameRole eq 'mentor'}">
                                                            <div class="all-btn all-category d-flex align-items-center">
                                                                <!--                                                    <a href="/HAPPYorSAD/login" class="btn btn-primary">Request</a>-->
                                                            </div>
                                                        </c:when>
                                                        <c:when test="${sessionScope.usernameRole eq 'manager'}">
                                                            <div class="all-btn all-category d-flex align-items-center">
                                                                <!--                                                    <a href="/HAPPYorSAD/login" class="btn btn-primary">Request</a>-->
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="all-btn all-category d-flex align-items-center">
                                                                <a href="/HAPPYorSAD/view/LoginUser.jsp" class="btn btn-primary">Request</a>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>

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


        <!-- Master Skill -->
        <section class="section master-skill">
            <div class="container">
                <div class="row">
                    <div class="col-lg-7 col-md-12">
                        <div class="section-header aos" data-aos="fade-up">
                            <div class="section-sub-head">
                                <span>What’s New</span>
                                <h2>Master the skills to drive your career</h2>
                            </div>
                        </div>
                        <div class="career-group aos" data-aos="fade-up">
                            <div class="row">
                                <div class="col-lg-6 col-md-6 d-flex">
                                    <div class="certified-group blur-border d-flex">
                                        <div class="get-certified d-flex align-items-center">
                                            <div class="blur-box">
                                                <div class="certified-img ">
                                                    <img src="/HAPPYorSAD/assets/img/icon/icon-1.svg" alt="Img" class="img-fluid">
                                                </div>
                                            </div>
                                            <p>Stay motivated with engaging instructors</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 d-flex">
                                    <div class="certified-group blur-border d-flex">
                                        <div class="get-certified d-flex align-items-center">
                                            <div class="blur-box">
                                                <div class="certified-img ">
                                                    <img src="/HAPPYorSAD/assets/img/icon/icon-2.svg" alt="Img" class="img-fluid">
                                                </div>
                                            </div>
                                            <p>Keep up with in the latest in cloud</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 d-flex">
                                    <div class="certified-group blur-border d-flex">
                                        <div class="get-certified d-flex align-items-center">
                                            <div class="blur-box">
                                                <div class="certified-img ">
                                                    <img src="/HAPPYorSAD/assets/img/icon/icon-3.svg" alt="Img" class="img-fluid">
                                                </div>
                                            </div>
                                            <p>Get certified with 100+ certification courses</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 d-flex">
                                    <div class="certified-group blur-border d-flex">
                                        <div class="get-certified d-flex align-items-center">
                                            <div class="blur-box">
                                                <div class="certified-img ">
                                                    <img src="/HAPPYorSAD/assets/img/icon/icon-4.svg" alt="Img" class="img-fluid">
                                                </div>
                                            </div>
                                            <p>Build skills your way, from labs to courses</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-5 col-md-12 d-flex align-items-end">
                        <div class="career-img aos" data-aos="fade-up">
                            <img src="/HAPPYorSAD/assets/img/join.png" alt="Img" class="img-fluid">
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- /Master Skill -->

        <!-- Trending Course -->
        <section class="section trend-course">
            <div class="container">
                <div class="section-header aos" data-aos="fade-up">
                    <div class="section-sub-head">
                        <span>What’s New</span>
                        <h2>TRENDING COURSES</h2>
                    </div>
                    <div class="all-btn all-category d-flex align-items-center">
                        <a href="ShowAllCourse" class="btn btn-primary">All Courses</a>
                    </div>
                </div>
                <div class="owl-carousel trending-course owl-theme aos" data-aos="fade-up">

                    <c:forEach var="course" items="${sessionScope.listTCourse}">
                        <div class="course-box trend-box">
                            <div class="product trend-product">
                                <div class="product-img">
                                    <a href="CourseDetails?Cid=${course.id}">
                                        <img class="img-fluid" src="${course.image}" alt="${course.title}">
                                    </a>
                                </div>

                                <div class="product-content">

                                    <h3 class="title"><a href="course-details.html">${course.title}</a></h3>


                                    <div class="course-info d-flex align-items-center">

                                    </div>
                                    <div class="d-flex align-items-center justify-content-between">

                                        <c:choose>
                                            <c:when test="${sessionScope.usernameRole eq 'mentee'}">
                                                <div class="all-btn all-category d-flex align-items-center">
                                                    <a href="/HAPPYorSAD/CourseDetails?Cid=${course.id}" class="btn btn-primary">Request</a>
                                                </div>
                                            </c:when>
                                            <c:when test="${sessionScope.usernameRole eq 'mentor'}">
                                                <div class="all-btn all-category d-flex align-items-center">
                                                    <!--                                                    <a href="/HAPPYorSAD/login" class="btn btn-primary">Request</a>-->
                                                </div>
                                            </c:when>
                                            <c:when test="${sessionScope.usernameRole eq 'manager'}">
                                                <div class="all-btn all-category d-flex align-items-center">
                                                    <!--                                                    <a href="/HAPPYorSAD/login" class="btn btn-primary">Request</a>-->
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="all-btn all-category d-flex align-items-center">
                                                    <a href="/HAPPYorSAD/view/LoginUser.jsp" class="btn btn-primary">Request</a>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <!--
                                       <div class="feature-instructors">
                                                    <div class="section-header aos" data-aos="fade-up">
                                                        <div class="section-sub-head feature-head text-center">
                                                            <h2>Featured Instructor</h2>
                                                        </div>
                                                    </div>
                -->

                <!--                <div class="owl-carousel instructors-course owl-theme aos" data-aos="fade-up">
                
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
    </div>-->
            </div>-->
        </section>
        <!-- /Trending Course -->

        <!-- Leading Companies -->
        <section class="section lead-companies">
            <div class="container">
                <div class="section-header aos" data-aos="fade-up">
                    <div class="section-sub-head feature-head text-center">
                        <span>Trusted By</span>
                        <h2>500+ Leading Universities And Companies</h2>
                    </div>
                </div>
                <div class="lead-group aos" data-aos="fade-up">
                    <div class="lead-group-slider owl-carousel owl-theme">
                        <div class="item">
                            <div class="lead-img">
                                <img class="img-fluid" alt="Img" src="/HAPPYorSAD/assets/img/lead-01.png">
                            </div>
                        </div>
                        <div class="item">
                            <div class="lead-img">
                                <img class="img-fluid" alt="Img" src="/HAPPYorSAD/assets/img/lead-02.png">
                            </div>
                        </div>
                        <div class="item">
                            <div class="lead-img">
                                <img class="img-fluid" alt="Img" src="/HAPPYorSAD/assets/img/lead-03.png">
                            </div>
                        </div>
                        <div class="item">
                            <div class="lead-img">
                                <img class="img-fluid" alt="Img" src="/HAPPYorSAD/assets/img/lead-04.png">
                            </div>
                        </div>
                        <div class="item">
                            <div class="lead-img">
                                <img class="img-fluid" alt="Img" src="/HAPPYorSAD/assets/img/lead-05.png">
                            </div>
                        </div>
                        <div class="item">
                            <div class="lead-img">
                                <img class="img-fluid" alt="Img" src="/HAPPYorSAD/assets/img/lead-06.png">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- /Leading Companies -->


        <!-- Users Love -->
        <section class="section user-love">
            <div class="container">
                <div class="section-header white-header aos" data-aos="fade-up">
                    <div class="section-sub-head feature-head text-center">
                        <span>Check out these real quotes </span>
                        <h2>Users-love-us Don't take it from us.</h2>
                    </div>
                </div>
            </div>
        </section>
        <!-- /Users Love -->

        <!-- Say testimonial Four -->
        <section class="testimonial-four">
            <div class="review">
                <div class="container">
                    <div class="testi-quotes">
                        <img src="/HAPPYorSAD/assets/img/qute.png" alt="Img">
                    </div>
                    <div class="mentor-testimonial lazy slider aos" data-aos="fade-up" data-sizes="50vw ">
                        <div class="d-flex justify-content-center">
                            <div class="testimonial-all d-flex justify-content-center">
                                <div class="testimonial-two-head text-center align-items-center d-flex">
                                    <div class="testimonial-four-saying ">
                                        <div class="testi-right">
                                                                                        <img src="/HAPPYorSAD/assets/img/qute-01.png" alt="Img">

                                        </div>
                                        <p>The first rule of any technology used in a business is that automation applied to an efficient operation will magnify the efficiency. The second is that automation applied to an inefficient operation will magnify the inefficiency.
</p>
                                        <div class="four-testimonial-founder">
                                            <div class="fount-about-img">
                                                <a href="https://vi.wikipedia.org/wiki/Bill_Gates"><img src="/HAPPYorSAD/assets/img/user/R.jpg"
                                                                                                        alt="Img" class="img-fluid"></a>
                                            </div>
                                            <h3><a href="https://vi.wikipedia.org/wiki/Bill_Gates">Bill Gates</a></h3>
                                            <span>Co-founding The Software Company Microsoft</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="d-flex justify-content-center">
                            <div class="testimonial-all d-flex justify-content-center">
                                <div class="testimonial-two-head text-center align-items-center d-flex">
                                    <div class="testimonial-four-saying ">
                                        <div class="testi-right">
                                            <img src="/HAPPYorSAD/assets/img/qute-01.png" alt="Img">
                                        </div>
                                        <p>The only way to get love is to be lovable. It's very irritating if you have a lot of money. You'd like to think you could write a check: 'I'll buy a million dollars' worth of love.' But it doesn't work that way. The more you give love away, the more you get.</p>
                                        <div class="four-testimonial-founder">
                                            <div class="fount-about-img">
                                                <a href="https://en.wikipedia.org/wiki/Warren_Buffett"><img src="/HAPPYorSAD/assets/img/user/Warren_Buffett_at_the_2015_SelectUSA_Investment_Summit_(cropped).jpg"
                                                                                                            alt="Img" class="img-fluid"></a>
                                            </div>
                                            <h3><a href="https://en.wikipedia.org/wiki/Warren_Buffett">Warren Buffett</a></h3>
                                            <span>CEO of Berkshire Hathaway</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="d-flex justify-content-center">
                            <div class="testimonial-all d-flex justify-content-center">
                                <div class="testimonial-two-head text-center align-items-center d-flex">
                                    <div class="testimonial-four-saying ">
                                        <div class="testi-right">
                                            <img src="/HAPPYorSAD/assets/img/qute-01.png" alt="Img">
                                        </div>
                                        <p>I think it's very important to have a feedback loop, where you're constantly thinking about what you've done and how you could be doing it better. I think that's the single best piece of advice: constantly think about how you could be doing things better and questioning yourself.
                                           </p>
                                        <div class="four-testimonial-founder">
                                            <div class="fount-about-img">
                                                <a href="https://vi.wikipedia.org/wiki/Elon_Musk"><img src="/HAPPYorSAD/assets/img/user/USAFA_Hosts_Elon_Musk_(Image_1_of_17)_(cropped).jpg"
                                                                                                       alt="Img" class="img-fluid"></a>
                                            </div>
                                            <h3><a href="https://vi.wikipedia.org/wiki/Elon_Musk">Elon Musk</a></h3>
                                            <span>Key Roles In Tesla, SpaceX, And Twitter</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- /Say testimonial Four -->

        <!-- Become An Instructor -->
        <section class="section become-instructors aos" data-aos="fade-up">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-6 d-flex">
                        <a href="/HAPPYorSAD/view/RegisterUser.jsp" style="text-decoration: none; color: inherit;">
                            <div class="student-mentor cube-instuctor">
                                <h4>Become An Instructor</h4>
                                <div class="row">
                                    <div class="col-lg-7 col-md-12">
                                        <div class="top-instructors">
                                            <p>Top instructors from around the world teach millions of students on Mentoring.</p>
                                        </div>
                                    </div>
                                    <div class="col-lg-5 col-md-12">
                                        <div class="mentor-img">
                                            <img class="img-fluid" alt="Img" src="/HAPPYorSAD/assets/img/icon/become-02.svg">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                    <div class="col-lg-6 col-md-6 d-flex">
                        <a href="/HAPPYorSAD/view/RegisterUser.jsp" style="text-decoration: none; color: inherit;">
                            <div class="student-mentor yellow-mentor">
                                <h4>Transform Access To Education</h4>
                                <div class="row">
                                    <div class="col-lg-8 col-md-12">
                                        <div class="top-instructors">
                                            <p>Create an account to receive our newsletter, course recommendations and promotions.</p>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-md-12">
                                        <div class="mentor-img">
                                            <img class="img-fluid" alt="Img" src="/HAPPYorSAD/assets/img/icon/become-01.svg">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </section>
        <!-- /Become An Instructor -->


        <!-- Latest Blog -->

        <!-- /Latest Blog -->


    </body>

</html>

