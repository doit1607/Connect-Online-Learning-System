<%-- 
    Document   : MentorDetail
    Created on : 26 Feb 2025, 4:50:05 pm
    Author     : Acer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<fmt:setLocale value="en"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mentor Detail</title>
        <link rel="shortcut icon" type="image/x-icon" href="/HAPPYorSAD/assets/img/favicon.svg">

        <!-- Theme Settings Js -->
        <script src="/HAPPYorSAD/assets/js/theme-script.js" type="text/javascript"></script>

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
            .social-icons {
                display: flex;
                gap: 20px;
            }
            .social-icons a {
                text-decoration: none;
                font-size: 40px;
                color: #333;
                transition: 0.3s;
            }
            .social-icons a:hover {
                transform: scale(1.2);
            }
            .fa-facebook {
                color: #1877F2;
            }
            .fa-youtube {
                color: #FF0000;
            }
            .fa-tiktok {
                color: #000;
            }
        </style>
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
                                        <li class="breadcrumb-item" aria-current="page">Course detail</li>
                                        <li class="breadcrumb-item" aria-current="page">Mentor detail</li>
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
                            <h1 style="color: white">${mentorname}</h1> 
                        
                            <div class="course-info d-flex align-items-center border-bottom-0 m-0 p-0">
                                <div class="cou-info">
                                    <img src="assets/img/icon/icon-01.svg" alt="Img">
                                    <p>12+ Lesson</p>
                                </div>
                                <div class="cou-info">
                                    <img src="assets/img/icon/timer-icon.svg" alt="Img">
                                    <p>9hr 30min</p>
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
                                    <div class="row">
                                        <div class="col-md-6">
                                            <h5>Mentor name</h5>
                                            <h5><p>- ${mentor.name}</p> </h5>
                                            <h5>Email</h5>
                                            <h5><p>- ${mentor.email}</p></h5> 
                                            <h5>Review from mentees</h5>
                                            <h5><p>- ${mentor.reviews}</p></h5>  
                                        </div>
                                        <div class="col-md-6">
                                            <h5>Expertise</h5>
                                            <h5><p>- ${mentor.expertise}</p></h5> 
                                            <h5>Bio</h5>
                                            <h5><p>- ${mentor.bio}</p></h5>   
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- /Overview -->

                            <!-- Mentor's Schedule -->
                            <div class="card overview-sec">
                                <div class="card-body">
                                    <h2 class="subs-title">Mentor's Schedule</h2>
                                    <form id="monthForm" action="/HAPPYorSAD/MentorDetail" method="GET">
                                        <input type="hidden" name="action" value="getMentorSlots">
                                        <input type="hidden" name="mentorId" value="${requestScope.mentorId}">
                                        <input type="hidden" name="month" id="monthInput" value="${requestScope.selectedMonth}">
                                        <input type="hidden" name="year" id="yearInput" value="${requestScope.selectedYear}">
                                        <div class="row align-items-center">
                                            <div class="col-12 col-sm-6">
                                                <h4 class="mb-1" id="mentorScheduleMonthYear">
                                                    ${formattedMonthYear}
                                                </h4>
                                                <p></p>
                                            </div>
                                            <div class="col-12 col-sm-6 text-sm-end">
                                                <button type="submit" class="btn btn-outline-primary btn-sm me-2" name="direction" value="prev">Previous Month</button>
                                                <button type="submit" class="btn btn-outline-primary btn-sm" name="direction" value="next">Next Month</button>
                                            </div>
                                        </div>
                                    </form>
                                    <p></p>
                                    <div class="row" id="mentorScheduleSlots">
                                        <c:forEach var="day" items="${weekDates}" varStatus="status">
                                            <c:set var="formattedDay" value="${day}" /> 
                                            <div class="col-md">
                                                <div class="slot-box">
                                                    <div class="slot-header text-center">
                                                        <h5>
                                                            <span class="week-day">${weekDays[status.index]}</span>
                                                            <span style="display: none;">${day}</span>
                                                        </h5>
                                                    </div>
                                                    <div class="slot-body">
                                                        <table class="table table-bordered text-center">
                                                            <tbody>
                                                                <c:forEach var="i" begin="1" end="5">
                                                                    <tr>
                                                                        <td>
                                                                            <c:set var="slotFound" value="false" />
                                                                            <c:forEach var="slot" items="${slotsByDay[formattedDay]}">  
                                                                                <c:if test="${slot.slotNumber == i}">
                                                                                    <c:set var="slotFound" value="true" />
                                                                                    <c:choose>
                                                                                        <c:when test="${slot.isBooked == true}">
                                                                                            <span class="text-danger">
                                                                                                <i class="isax isax-clock"></i> Slot ${slot.slotNumber} (Booked)
                                                                                            </span>
                                                                                        </c:when>
                                                                                        <c:otherwise>
                                                                                            <span class="text-success">
                                                                                                <i class="isax isax-clock"></i> Slot ${slot.slotNumber}
                                                                                            </span>
                                                                                        </c:otherwise>
                                                                                    </c:choose>
                                                                                </c:if>
                                                                            </c:forEach>
                                                                            <c:if test="${not slotFound}">
                                                                                <span class="text-muted">Empty</span>
                                                                            </c:if>
                                                                        </td>
                                                                    </tr>
                                                                </c:forEach>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                            <!-- /Mentor's Schedule -->

                            <!-- List of Courses -->
                            <div class="row">
                                <h2 class="subs-title">List of course mentor are training</h2>
                                <c:forEach var="o" items="${sessionScope.list}"> 
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
                                                        <div class="course-share d-flex align-items-center justify-content-center">
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
                            <!-- /List of Courses -->
                        </div>	

                        <div class="col-lg-4">
                            <div class="sidebar-sec">
                                <div class="video-sec vid-bg">
                                    <div class="card">
                                        <div class="card-body">
                                            <a href="" class="video-thumbnail" data-fancybox="">
                                                <img class="img-fluid" src="${mentor.image}" alt="Img">
                                            </a>
                                            <div class="video-details">                                              
                                                <div class="course-fee">
                                                    <div class="rating-img d-flex align-items-center">
                                                        <div class="social-icons">
                                                            <a href="https://www.facebook.com" target="_blank"><i class="fab fa-facebook"></i></a>
                                                            <a href="https://www.youtube.com" target="_blank"><i class="fab fa-youtube"></i></a>
                                                            <a href="https://www.tiktok.com" target="_blank"><i class="fab fa-tiktok"></i></a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <h2><a href="test?mentorId=${requestScope.mentorId}&courseId=${requestScope.courseId}&price=${requestScope.price}" class="btn btn-enroll w-100">Invite</a></h2>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /Video -->

<!--                                 Include 
                                <div class="card include-sec">
                                    <div class="card-body">
                                        <div class="cat-title">
                                            <h4>Includes</h4>
                                        </div>
                                    </div>
                                </div>
                                 /Include 

                                 Features 
                                <div class="card feature-sec">
                                    <div class="card-body">
                                        <div class="cat-title">
                                            <h4>Includes</h4>
                                        </div>
                                    </div>
                                </div>
                                 /Features -->
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
        <script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js" type="text/javascript"></script>

        <!-- Bootstrap Core JS -->
        <script src="/HAPPYorSAD/assets/js/bootstrap.bundle.min.js" type="text/javascript"></script>

        <!-- Select2 JS -->
        <script src="/HAPPYorSAD/assets/plugins/select2/js/select2.min.js" type="text/javascript"></script>

        <!-- Ckeditor JS -->
        <script src="/HAPPYorSAD/assets/js/ckeditor.js" type="text/javascript"></script>

        <!-- Dropzone JS -->
        <script src="/HAPPYorSAD/assets/plugins/dropzone/dropzone.min.js" type="text/javascript"></script>

        <!-- Sticky Sidebar JS -->
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/ResizeSensor.js" type="text/javascript"></script>
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js" type="text/javascript"></script>

        <!-- Custom JS -->
        <script src="/HAPPYorSAD/assets/js/script.js" type="text/javascript"></script>
    </body>
</html>