<%-- 
    Document   : ViewCV
    Created on : Feb 20, 2025, 1:42:58 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.3.0/chart.umd.min.js"></script>

        <link href="css/cssCRUD/rating.css" rel="stylesheet" type="text/css"/>
        <style>
            .review-container {
            background: #fff;
            padding: 15px;
        }
        .review-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
        }
        .review-name {
            font-weight: bold;
        }
        .review-comment-title {
            font-style: italic;
            color: #666;
        }
        .review-stars i {
            color: #ffc107;
        }
        .star {
            color: #d4a017; /* Màu vàng cho sao */
        }
        
        .progress {
        height: 10px;
        background-color: #e0e0e0; /* Màu nền xám nhạt */
        border-radius: 5px;
    }
    .progress-bar {
        background-color: #ffc107 !important; /* Màu vàng */
        border-radius: 5px;
    }
    </style>
    </head>
    <body>
        <%@include file="../sourcesHome/homeHeader.jsp" %>  
        <div class="main-wrapper">

            <!-- Breadcrumb -->
            <div class="breadcrumb-bar breadcrumb-bar-info">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 col-12">
                            <div class="breadcrumb-list">
                                <h2 class="breadcrumb-title">Dashboard</h2>
                                <nav aria-label="breadcrumb" class="page-breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="Home">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Dashboard</li>
                                    </ol>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        <div class ="container">
                        <div class="row">
                            ${test}
                                                                 <!-- sidebar -->
                        <div class="col-xl-3 col-lg-3 theiaStickySidebar">
                           
                            <div class="settings-widget account-settings">
                                <div class="settings-menu">
                                    <h3>Dashboard</h3>
                                    <ul>
                                        <li class="nav-item active">
                                            <a href="/../HAPPYorSAD/ProfileServlet" class="nav-link">
                                                <i class="bx bxs-tachometer"></i>My Profile
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="instructor-enrolled-course.html" class="nav-link">
                                                <i class="bx bxs-graduation"></i>Enrolled Courses
                                            </a>
                                        </li>
                                         <li class="nav-item ">
                                            <a href="/../HAPPYorSAD/Slot" class="nav-link">
                                                <i class="bx bxs-graduation"></i>Available Timings

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
                                            <a href="Notifications" class="nav-link">
                                                <i class="bx bxs-bell"></i>Notifications
                                            </a>
                                        </li>

                                    </ul>
                                    <h3>Instructor</h3>
                                    <ul>
                                        <li class="nav-item">
                                            <a href="instructor-course.html" class="nav-link ">
                                                <i class="bx bxs-rocket"></i>My Courses
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="instructor-course.html" class="nav-link ">
                                                <i class="bx bxs-rocket"></i>My Curriculum Vitae
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="instructor-enrolled-course.html" class="nav-link">
                                                <i class="bx bxs-graduation"></i>Inviting Request
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="instructor-referral.html" class="nav-link">
                                                <i class="bx bxs-user-plus"></i>Statistic Request
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="instructor-announcements.html" class="nav-link">
                                                <i class="bx bxs-volume-full"></i>Announcements
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="instructor-withdraw.html" class="nav-link ">
                                                <i class="bx bxs-wallet"></i>Withdrawls
                                            </a>
                                        </li>

                                        <li class="nav-item">
                                            <a href="instructor-earnings.html" class="nav-link">
                                                <i class="bx bxs-badge-dollar"></i>Earnings
                                            </a>
                                        </li>
                                    </ul>
                                    <h3>Account Settings</h3>
                                    <ul>
                                        <li class="nav-item">
                                            <a href="updatementorprofile?username=${sessionScope.usernameUser}" class="nav-link ">
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
                            <!--${test}-->
                            
                            
                            
                            
                            
                            
                            <div class="col-lg-9 col-xl-9">
                                                    <div class="row">

              <div class="col-md-4 stretch-card grid-margin ">
                <div class="card bg-gradient-danger card-img-holder text-white rounded">
                  <div class="card-body border border-secondary">
                    <!--<img src="assets/images/dashboard/circle.svg" class="card-img-absolute" alt="circle-image" />-->
                    <h4 class="font-weight-normal mb-3">Total Earning <i class="mdi mdi-chart-line mdi-24px float-end"></i>
                    </h4>
                    <h2 class="mb-5">$ ${earning}</h2>
                    
                  </div>
                </div>
              </div>
              <div class="col-md-4 stretch-card grid-margin ">
                <div class="card bg-gradient-info card-img-holder text-white rounded">
                  <div class="card-body border border-success">
                    <!--<img src="assets/images/dashboard/circle.svg" class="card-img-absolute" alt="circle-image" />-->
                    <h4 class="font-weight-normal mb-3">Wallet Ballance <i class="mdi mdi-bookmark-outline mdi-24px float-end"></i>
                    </h4>
                    <h2 class="mb-5">$ ${balance}</h2>
                  </div>
                </div>
              </div>
              <div class="col-md-4 stretch-card grid-margin ">
                <div class="card bg-gradient-success card-img-holder text-white rounded">
                  <div class="card-body border border-primary">
                    <!--<img src="assets/images/dashboard/circle.svg" class="card-img-absolute" alt="circle-image" />-->
                    <h4 class="font-weight-normal mb-3">Completed Request <i class="mdi mdi-diamond mdi-24px float-end"></i>
                    </h4>
                    <h2 class="mb-5">${requestCompleted}</h2>
                  </div>
                </div>
              </div>
                                                                      </div>

            
                        <div class="row">

                            <div class="col-12 col-lg-7" >
                <div class="card">
                        <div class="card-header">
                                <h5 class="card-title">Request Number Received</h5>
                        </div>
                        <div class="card-body">
                                <div class="chart">
                                        <canvas id="chartjs-bar" style="height: 400px"></canvas>
                                </div>
                        </div>
                </div>
            </div>
            <div class="col-12 col-lg-5">
                    <div class="card">
                            <div class="card-header">
                                    <h5 class="card-title">Request Status</h5>
                                   
                            </div>
                            <div class="card-body">
                                    <div class="chart">
                                            <canvas id="chartjs-pie" style="height: 400px"></canvas>
                                    </div>
                            </div>
                    </div>
            </div>
                        </div>
                                
                                
                                
                                <div class="row">
    <h3>My Course</h3>
<div class="row row-cols-1 row-cols-md-3 g-4" id="courseContainer">
    <c:choose>
        <c:when test="${not empty myCourses}">
            <c:forEach var="course" items="${myCourses}" varStatus="status">
                <div class="col course-item" data-index="${status.index}">
                    <div class="card h-100">
                        <img src="${course.image}" class="card-img-top" style="height: 200px" alt="Course Image">
                        <div class="card-body">
                            <h5 class="card-title">${course.title}</h5>
                            <!--<p class="card-text">${course.description}</p>-->
                            <a href="/CourseDetails?Cid=${course.id}" class="btn btn-primary">View details</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <p class="text-muted">No course to display.</p>
        </c:otherwise>
    </c:choose>
</div>
</div>

<!-- Pagination Buttons -->
<!-- Pagination Controls -->
<div class="d-flex justify-content-center align-items-center mt-3">
    <button id="prevPage" class="btn btn-outline-primary me-2">
        <i class="fas fa-arrow-left"></i>
    </button>
    <span id="pageInfo" class="mx-3 fw-bold"></span>
    <button id="nextPage" class="btn btn-outline-primary ms-2">
        <i class="fas fa-arrow-right"></i>
    </button>
</div>         
                                
                                <div class="row">
                                   <h3>Reviews</h3>
                                     <div class="col-md-4 text-center">
                                         
                <h1 class="display-3 fw-bold text-warning">${averageRating}&nbsp;<i class="fas fa-star star"></i></h1>

                <h6 class="text-muted">Based on ${reviews.size()} reviews</h6>
            </div>

    <%@ page import="java.util.Map" %>
<%
    Map<Integer, Double> starPercentage = (Map<Integer, Double>) request.getAttribute("starPercentage");
%>

<div class="col-md-8">
    <div class="rating-bars">
        <% for (int i = 5; i >= 1; i--) { %>
            <div class="rating-bar mb-3">
                <div class="d-flex justify-content-between align-items-center mb-1">
                    <span><%= i %> <i class="fas fa-star star"></i></span>
                    <small class="text-muted"><%= String.format("%.1f", starPercentage.get(i)) %>%</small>
                </div>
                <div class="progress">
                    <div class="progress-bar bg-warning" role="progressbar" style="width: <%= starPercentage.get(i) %>%;"></div>
                </div>
            </div>
        <% } %>
    </div>
</div>
        
                                </div>  
                                <hr/>
                                <div class="container mt-4">
    <!-- <div class="review-container d-flex align-items-start">
        <img src="https://i.pravatar.cc/50" alt="User Avatar" class="review-avatar me-3">
        <div>
            <div class="d-flex align-items-center">
                <span class="review-name">Ken</span>
                <div class="review-stars ms-2">
                    <i class="bi bi-star-fill"></i>
                    <i class="bi bi-star-fill"></i>
                    <i class="bi bi-star-fill"></i>
                    <i class="bi bi-star-fill"></i>
                    <i class="bi bi-star-half"></i>
                </div>
            </div>
            <div class="review-comment-title">My comment title</div>
            <p class="mb-0">Fun Course!!</p>
        </div>
    </div>-->
    
    <%@ page import="java.util.List" %>
<%@ page import="entity.MentorReview" %>

<%
    List<MentorReview> reviews = (List<MentorReview>) request.getAttribute("reviews");
%>

<div class="filter-buttons mb-3">
    <button class="btn btn-primary filter-btn" data-star="all">All</button>
    <% for (int i = 5; i >= 1; i--) { %>
        <button class="btn btn-outline-primary filter-btn" data-star="<%= i %>"><%= i %> <i class="bi bi-star-fill"></i></button>
    <% } %>
</div>
<div class="container" style="height: 420px">
        <% if (reviews != null && !reviews.isEmpty()) { %>
            <% for (MentorReview review : reviews) { %>
                <div class="row review-item">

            <div class="col-12 ">
                <div class="card p-3 ">
                    <div class="row align-items-center"
                         data-rating="<%= review.getRating() %>">
                        <!-- Cột avatar -->
                        <div class="col-auto d-flex align-items-center">
                            <img src="<%= review.getMentee().getAvatarPath() %>" alt="User Avatar" 
                                 class="review-avatar img-fluid rounded-circle">
                        </div>
                        <!-- Cột nội dung review -->
                        <div class="col">
                            <div class="d-flex align-items-center">
                                <span class="review-name fw-bold"><%= review.getMentee().getFullname() %></span>
                                &nbsp;&nbsp;&nbsp;
                                <div class="review-stars ms-2">
                                    <% for (int i = 0; i < review.getRating(); i++) { %>
                                        <i class="bi bi-star-fill text-warning"></i>
                                    <% } %>
                                </div>
                                <small class="text-muted ms-auto text-end"><%= review.getCreatedAt().format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")) %></small>
                            </div>
                            <hr/>
                            <p class="mb-0"><%= review.getCommit() %></p>
                        </div>
                    </div>
                </div>
            </div>
                        </div>
            <% } %>
        <% } else { %>
            <p>Không có đánh giá nào.</p>
        <% } %>
    
</div>


<!--<div class="pagination mt-3">
    <button class="btn btn-secondary" id="prevPage">« Prev</button>
    <span id="pageIndicator">Page 1</span>
    <button class="btn btn-secondary" id="nextPage">Next »</button>
</div>-->
    
<div class="d-flex justify-content-center align-items-center mt-3">
    <button id="prevPage2" class="btn btn-outline-primary me-2">
        <i class="fas fa-arrow-left"></i>
    </button>
    <!--<span id="pageInfo" class="mx-3 fw-bold"></span>-->
    <button id="nextPage2" class="btn btn-outline-primary ms-2">
        <i class="fas fa-arrow-right"></i>
    </button>
</div> 
    
    
</div>
                                
                                
                                
                                
                                                </div>


        </div>
            
            
        <!-- /Page Content -->
        <%@include file="../sourcesHome/homeFooter.jsp" %>





    <!-- jQuery -->
    <script data-cfasync="false" src="../cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script><script src="assets/js/jquery-3.7.1.min.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

    <!-- Bootstrap Core JS -->
    <script src="assets/js/bootstrap.bundle.min.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

    <!-- Select2 JS -->
    <script src="assets/plugins/select2/js/select2.min.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

    <!-- Ckeditor JS -->
    <script src="assets/js/ckeditor.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

    <!-- Dropzone JS -->
    <script src="assets/plugins/dropzone/dropzone.min.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

    <!-- Sticky Sidebar JS -->
    <script src="assets/plugins/theia-sticky-sidebar/ResizeSensor.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>
    <script src="assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

    <!-- Custom JS -->
    <script src="assets/js/script.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

    <script src="../cdn-cgi/scripts/7d0fa10a/cloudflare-static/rocket-loader.min.js" data-cf-settings="27bb6e11b88bb1c6a1b7b5ff-|49" defer></script><script defer src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015" integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ==" data-cf-beacon='{"rayId":"9107445c681fe2ec","version":"2025.1.0","serverTiming":{"name":{"cfExtPri":true,"cfL4":true,"cfSpeedBrain":true,"cfCacheStatus":true}},"token":"3ca157e612a14eccbb30cf6db6691c29","b":1}' crossorigin="anonymous"></script>
    <script>
        
        document.addEventListener("DOMContentLoaded", function () {
    const filterButtons = document.querySelectorAll(".filter-btn");
    const reviews = document.querySelectorAll(".review-item");
    const prevPageBtn = document.getElementById("prevPage2");
    const nextPageBtn = document.getElementById("nextPage2");
    let currentPage = 1;
    const reviewsPerPage = 3;
    let filteredReviews = Array.from(reviews);
    
    function showPage(page) {
        const startIndex = (page - 1) * reviewsPerPage;
        const endIndex = startIndex + reviewsPerPage;
        
        reviews.forEach(review => review.style.display = "none");
        filteredReviews.slice(startIndex, endIndex).forEach(review => review.style.display = "block");
        
        prevPageBtn.disabled = page === 1;
        nextPageBtn.disabled = endIndex >= filteredReviews.length;
    }
    
    function filterReviews(star) {
        if (star === "all") {
            filteredReviews = Array.from(reviews);
        } else {
            filteredReviews = Array.from(reviews).filter(review => 
                review.querySelector("[data-rating]").getAttribute("data-rating") === star
            );
        }
        currentPage = 1;
        showPage(currentPage);
    }
    
    filterButtons.forEach(button => {
        button.addEventListener("click", function () {
            const star = this.getAttribute("data-star");
            filterReviews(star);
        });
    });
    
    prevPageBtn.addEventListener("click", function () {
        if (currentPage > 1) {
            currentPage--;
            showPage(currentPage);
        }
    });
    
    nextPageBtn.addEventListener("click", function () {
        if (currentPage * reviewsPerPage < filteredReviews.length) {
            currentPage++;
            showPage(currentPage);
        }
    });
    
    showPage(currentPage);
});
        
    </script>
    <script>
        
        document.addEventListener('DOMContentLoaded', function() {
  const stars = document.querySelectorAll('.rating-star');
  const ratingInput = document.getElementById('rating');

  stars.forEach(star => {
    star.addEventListener('click', function() {
      const rating = this.getAttribute('data-rating');
      ratingInput.value = rating;
      resetStars();
      for (let i = 0; i < rating; i++) {
        stars[i].classList.remove('bi-star');
        stars[i].classList.add('bi-star-fill');
      }
    });
  });

  function resetStars() {
    stars.forEach(star => {
      star.classList.remove('bi-star-fill');
      star.classList.add('bi-star');
    });
  }
});
	document.addEventListener("DOMContentLoaded", function () {
        const courses = document.querySelectorAll(".course-item");
        const itemsPerPage = 3; // Mỗi trang hiển thị 3 khóa học
        let currentPage = 1;
        const totalPages = Math.ceil(courses.length / itemsPerPage);

        function showPage(page) {
            courses.forEach((course, index) => {
                course.style.display = (index >= (page - 1) * itemsPerPage && index < page * itemsPerPage) ? "block" : "none";
            });

//            document.getElementById("pageInfo").textContent = `Page ${page} of ${totalPages}`;
            document.getElementById("prevPage").disabled = (page === 1);
            document.getElementById("nextPage").disabled = (page === totalPages);
        }

        document.getElementById("prevPage").addEventListener("click", function () {
            if (currentPage > 1) {
                currentPage--;
                showPage(currentPage);
            }
        });

        document.getElementById("nextPage").addEventListener("click", function () {
            if (currentPage < totalPages) {
                currentPage++;
                showPage(currentPage);
            }
        });

        showPage(currentPage);
    });	
	
</script>
<script>
    var barLabels = ${barLabels};
            var barDataLastYear = ${barDataLastYear};
            var barDataThisYear = ${barDataThisYear};
             var pieLabels = ${pieLabels};
                var pieData = ${pieData};

   document.addEventListener("DOMContentLoaded", function() {
		// Kiểm tra xem phần tử canvas có tồn tại không
		var ctx = document.getElementById("chartjs-bar");
		if (!ctx) {
			console.error("Canvas element not found!");
			return;
		}
                
		// Khởi tạo biểu đồ
		new Chart(ctx, {
			type: "bar",
			data: {
				labels: barLabels,
				datasets: [{
					label: "Last year",
					backgroundColor: "#007bff",  // Thay thế window.theme.primary
					borderColor: "#007bff",
					data: barDataLastYear,
					barPercentage: 0.75,
					categoryPercentage: 0.5
				}, {
					label: "This year",
					backgroundColor: "#dee2e6",
					borderColor: "#dee2e6",
					data: barDataThisYear,
					barPercentage: 0.75,
					categoryPercentage: 0.5
				}]
			},
			options: {
				responsive: true,
				maintainAspectRatio: false,
				plugins: {
					legend: {
						display: true,
						position: 'top'
					}
				},
				scales: {
					y: {
						beginAtZero: true,
						ticks: {
							stepSize: 20
						}
					},
					x: {
						grid: {
							display: false
						}
					}
				}
			}
		});
	});
        document.addEventListener("DOMContentLoaded", function() {
			// Pie chart
			new Chart(document.getElementById("chartjs-pie"), {
				type: "pie",
				data: {
					labels: pieLabels,
					datasets: [{
						data: pieData,
						backgroundColor: [
                                                    "#007bff",  // Màu xanh (primary)
                                                    "#ffc107",  // Màu vàng (warning)
                                                    "#dc3545",  // Màu đỏ (danger)
                                                    "#dee2e6"   // Màu xám nhạt
                                                ],

						borderColor: "transparent"
					}]
				},
				options: {
					maintainAspectRatio: false,
					legend: {
						display: false
					}
				}
			});
		});
</script>

        	<!--<script src="assets/js/chart.js"></script>-->
</body>
</html>
