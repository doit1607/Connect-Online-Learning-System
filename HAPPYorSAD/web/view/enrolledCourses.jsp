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

        <link href="css/cssCRUD/createCV.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="../sourcesHome/homeHeader.jsp" %>  
                <div class="page-content">
            <div class="container">
                <div class="row">

                    <!-- sidebar -->

                    <!-- Breadcrumb -->
                    <div class="breadcrumb-bar breadcrumb-bar-info">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-12 col-12">
                                    <div class="breadcrumb-list">
                                        <h2 class="breadcrumb-title">Enrolled Courses</h2>
                                        <nav aria-label="breadcrumb" class="page-breadcrumb">
                                            <ol class="breadcrumb">
                                                <li class="breadcrumb-item"><a href="Home">Home</a></li>
                                                <li class="breadcrumb-item active" aria-current="page">Enrolled Courses</li>
                                            </ol>
                                        </nav>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /Breadcrumb -->	
                    <div class="col-md-3  ">
                        <div class="settings-widget account-settings">
                            <div class="settings-menu">
                                <h3>Dashboard</h3>
                                <ul>
                                    <li class="nav-item">
                                        <a href="student-profile.html" class="nav-link">
                                            <i class="bx bxs-user"></i>My Profile
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="student-wishlist.html" class="nav-link">
                                            <i class="bx bxs-heart"></i>Wishlist
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="student-reviews.html" class="nav-link">
                                            <i class="bx bxs-star"></i>Reviews
                                        </a>
                                    </li>                                  
                                    <li class="nav-item">
                                        <a href="student-referral.html" class="nav-link">
                                            <i class="bx bxs-user-plus"></i>Referrals
                                        </a>
                                    </li>
                                    <li class="nav-item active">
                                        <a href="student-tickets.html" class="nav-link">
                                            <i class="bx bxs-coupon"></i>View request
                                        </a>
                                    </li>
                                </ul>
                                <h3>Account Settings</h3>
                                <ul>
                                    <li class="nav-item">
                                        <a href="student-settings.html" class="nav-link ">
                                            <i class="bx bxs-cog"></i>Settings
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="index-2.html" class="nav-link">
                                            <i class="bx bxs-log-out"></i>Logout
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>			
                    </div>
                    <!-- Page Content -->
                    <div class="col-md-9"> 
                        <!--in progess-->
                        <div class="row">
<!--                            <div class="col-md-12">
    <h5>In Processing</h5>
    <c:choose>
        <c:when test="${not empty processingCourses}">
            <c:forEach var="course" items="${processingCourses}">
                                    <div class="card mb-3 w-100">
                                        <div class="row g-0">
                                            <div class="col-md-3">
                                                <img src="${course.image}" class="img-fluid rounded-start" alt="Course Image">
                                            </div>
                                            <div class="col-md-9">
                                                <div class="card-body">
                                                    <h5 class="card-title">${course.title}</h5>
                                                    <p class="card-text">${course.description}</p>
                                                    <a href="/CourseDetails?Cid=${course.id}" class="btn btn-primary">View details</a>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
        </c:when>
        <c:otherwise>
            <p class="text-muted">No course in progress.</p>
        </c:otherwise>
    </c:choose>
</div>

<div class="col-md-12 mt-3">
    <h5>Completed</h5>
    <c:choose>
        <c:when test="${not empty completedCourses}">
            <c:forEach var="course" items="${completedCourses}">
                                    <div class="card mb-3 w-100">
                                        <div class="row g-0">
                                            <div class="col-md-3">
                                                <img src="${course.image}" class="img-fluid rounded-start" alt="Course Image">
                                            </div>
                                            <div class="col-md-9">
                                                <div class="card-body">
                                                    <h5 class="card-title">${course.title}</h5>
                                                    <p class="card-text">${course.description}</p>
                                                    <a href="CourseDetails?Cid=${course.id}" class="btn btn-primary">View details</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
        </c:when>
        <c:otherwise>
            <p class="text-muted">No completed courses.</p>
        </c:otherwise>
    </c:choose>
</div>-->
<div class="mb-3">
    <input type="text" id="searchCourse" class="form-control" placeholder="Search courses...">
</div>

                            <div class="col-md-12">
    <h5>In Progress</h5>
    <div class="row" id="processingCoursesContainer">
        <c:choose>
            <c:when test="${not empty processingCourses}">
                <c:forEach var="course" items="${processingCourses}" varStatus="status">
                    <div class="col-md-12 course-item-processing" data-index="${status.index}">
                        <div class="card mb-3 w-100">
                            <div class="row g-0">
                                <div class="col-md-3">
                                    <img src="${course.image}" class="img-fluid rounded-start" alt="Course Image">
                                </div>
                                <div class="col-md-9">
                                    <div class="card-body">
                                        <h5 class="card-title">${course.title}</h5>
                                        <p class="card-text">${course.description}</p>
                                        <a href="/CourseDetails?Cid=${course.id}" class="btn btn-primary">View details</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p class="text-muted">No course in progress.</p>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Pagination Controls -->
    <div class="d-flex justify-content-center align-items-center mt-3">
        <button id="prevPageProcessing" class="btn btn-outline-primary me-2"><i class="fas fa-arrow-left"></i></button>
        <span id="pageInfoProcessing" class="mx-3 fw-bold"></span>
        <button id="nextPageProcessing" class="btn btn-outline-primary ms-2"><i class="fas fa-arrow-right"></i></button>
    </div>
</div>

<div class="col-md-12 mt-3">
    <h5>Completed</h5>
    <div class="row" id="completedCoursesContainer">
        <c:choose>
            <c:when test="${not empty completedCourses}">
                <c:forEach var="course" items="${completedCourses}" varStatus="status">
                    <div class="col-md-12 course-item-completed" data-index="${status.index}">
                        <div class="card mb-3 w-100">
                            <div class="row g-0">
                                <div class="col-md-3">
                                    <img src="${course.image}" class="img-fluid rounded-start" alt="Course Image">
                                </div>
                                <div class="col-md-9">
                                    <div class="card-body">
                                        <h5 class="card-title">${course.title}</h5>
                                        <p class="card-text">${course.description}</p>
                                        <a href="CourseDetails?Cid=${course.id}" class="btn btn-primary">View details</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p class="text-muted">No completed courses.</p>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Pagination Controls -->
    <div class="d-flex justify-content-center align-items-center mt-3">
        <button id="prevPageCompleted" class="btn btn-outline-primary me-2"><i class="fas fa-arrow-left"></i></button>
        <span id="pageInfoCompleted" class="mx-3 fw-bold"></span>
        <button id="nextPageCompleted" class="btn btn-outline-primary ms-2"><i class="fas fa-arrow-right"></i></button>
    </div>
</div>

                        </div>
                            
                            
                    </div>
                    
                

        <!-- /Page Content -->
        <%@include file="../sourcesHome/homeFooter.jsp" %>


    </footer>
    <!-- /Footer -->

    <!-- /Main Wrapper -->

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
    setupPagination("processingCoursesContainer", "prevPageProcessing", "nextPageProcessing", "pageInfoProcessing", 3);
    setupPagination("completedCoursesContainer", "prevPageCompleted", "nextPageCompleted", "pageInfoCompleted", 3);
});

function setupPagination(containerId, prevBtnId, nextBtnId, pageInfoId, itemsPerPage) {
    const container = document.getElementById(containerId);
    const items = Array.from(container.getElementsByClassName(`course-item-${containerId.includes("processing") ? "processing" : "completed"}`));
    let currentPage = 0;
    const totalPages = Math.ceil(items.length / itemsPerPage);

    function renderPage() {
        // Ẩn tất cả các mục
        items.forEach((item) => (item.style.display = "none"));

        // Hiển thị các mục trong trang hiện tại
        const startIndex = currentPage * itemsPerPage;
        const endIndex = startIndex + itemsPerPage;
        for (let i = startIndex; i < endIndex && i < items.length; i++) {
            items[i].style.display = "block";
        }

        // Cập nhật trạng thái nút phân trang
        document.getElementById(prevBtnId).disabled = currentPage === 0;
        document.getElementById(nextBtnId).disabled = currentPage === totalPages - 1;


    }

    // Xử lý sự kiện nút
    document.getElementById(prevBtnId).addEventListener("click", function () {
        if (currentPage > 0) {
            currentPage--;
            renderPage();
        }
    });

    document.getElementById(nextBtnId).addEventListener("click", function () {
        if (currentPage < totalPages - 1) {
            currentPage++;
            renderPage();
        }
    });

    // Hiển thị trang đầu tiên
    if (items.length > 0) {
        renderPage();
    } else {
        document.getElementById(prevBtnId).disabled = true;
        document.getElementById(nextBtnId).disabled = true;
    }
}
document.addEventListener("DOMContentLoaded", function () {
    const searchInput = document.getElementById("searchCourse");

    searchInput.addEventListener("input", function () {
        const searchText = searchInput.value.toLowerCase();

        // Lọc danh sách khóa học đang học
        document.querySelectorAll(".course-item-processing").forEach((course) => {
            const title = course.querySelector(".card-title").textContent.toLowerCase();
            const description = course.querySelector(".card-text").textContent.toLowerCase();
            course.style.display = title.includes(searchText) || description.includes(searchText) ? "" : "none";
        });

        // Lọc danh sách khóa học đã hoàn thành
        document.querySelectorAll(".course-item-completed").forEach((course) => {
            const title = course.querySelector(".card-title").textContent.toLowerCase();
            const description = course.querySelector(".card-text").textContent.toLowerCase();
            course.style.display = title.includes(searchText) || description.includes(searchText) ? "" : "none";
        });
    });
});

    </script>
</body>
</html>
