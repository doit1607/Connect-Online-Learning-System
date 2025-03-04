<%-- 
    Document   : MentorDetail
    Created on : 26 Feb 2025, 4:50:05 pm
    Author     : Acer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mentor Detail</title>
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
                                        <li class="breadcrumb-item" aria-current="page">Course detail</li>
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
                                                        <div>

                                                        </div>
                                                    </div>
                                                </div>
                                                <h2><a href="test?mentorId=${requestScope.mentorId}&courseId=${requestScope.courseId}" class="btn btn-enroll w-100">Invite</a></h2>
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


