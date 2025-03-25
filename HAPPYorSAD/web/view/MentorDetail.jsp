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
        <script src="/HAPPYorSAD/assets/js/theme-script.js" type="text/javascript"></script>
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/feather.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/select2/css/select2.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/dropzone/dropzone.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/boxicons/css/boxicons.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css">   
        <style>

            /* Định dạng chung cho slot-box */
            .slot-box {
                transition: all 0.3s ease;
                border: 1px solid #e9ecef;
            }
            .slot-box:hover {
                transform: translateY(-5px);
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            }

            /* Định dạng header của slot */
            .slot-header .week-day {
                font-size: 1.1rem;
                color: #007bff;
            }
            .slot-header small {
                font-size: 0.9rem;
            }

            /* Định dạng bảng slot */
            .slot-body .table {
                border-collapse: collapse;
                font-size: 0.9rem;
            }
            .slot-body .table td {
                vertical-align: middle;
                padding: 10px;
                border: 1px solid #dee2e6;
            }
            .slot-body .text-success,
            .slot-body .text-danger {
                font-weight: 500;
            }
            .slot-body .text-muted {
                font-style: italic;
            }

            /* Căn chỉnh nút điều hướng */
            .btn-group .btn {
                margin-left: 5px;
            }
            .btn-sm {
                padding: 0.4rem 0.8rem;
                font-size: 0.875rem;
            }

            .mentor-image {
                max-height: 200px; /* Adjust this value to scale the image */
                object-fit: cover; /* Ensures the image scales nicely without distortion */
                border-radius: 8px; /* Optional: Adds a slight rounded corner */
            }

            .course-info .cou-info {
                margin-right: 20px; /* Adds spacing between course info items */
            }

            @media (max-width: 767px) {
                .mentor-image {
                    max-height: 150px; /* Smaller height for mobile */
                    margin-bottom: 15px; /* Adds spacing below image on mobile */
                }
                .course-info {
                    justify-content: center; /* Center course info on mobile */
                }
            }

            /* Định dạng viền cho slot */
            .border-green {
                border: 2px solid #28a745 !important;
                padding: 5px;
                border-radius: 4px;
                display: inline-block;
            }

            .border-red {
                border: 2px solid #dc3545 !important;
                padding: 5px;
                border-radius: 4px;
                display: inline-block;
            }

            /* Định dạng popover */
            .popover {
                max-width: 300px;
            }

            .popover-body {
                color: #333;
                font-size: 0.9rem;
            }

            .slot-info {
                cursor: pointer;
            }
        </style>

        <style>
            /* ... Các CSS khác giữ nguyên ... */

            /* Định dạng chung cho slot-box */
            .slot-box {
                transition: all 0.3s ease;
                border: 1px solid #e9ecef;
                border-radius: 8px;
                background-color: #fff;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
                margin-bottom: 15px;
            }
            .slot-box:hover {
                transform: translateY(-3px);
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            }

            /* Định dạng header của slot */
            .slot-header {
                background-color: #f8f9fa;
                padding: 10px;
                border-bottom: 1px solid #e9ecef;
                border-top-left-radius: 8px;
                border-top-right-radius: 8px;
            }
            .slot-header .week-day {
                font-size: 1.2rem;
                color: #007bff;
                font-weight: 600;
                margin-bottom: 5px;
            }
            .slot-header small {
                font-size: 0.85rem;
                color: #6c757d;
            }

            /* Định dạng body của slot */
            .slot-body {
                padding: 15px;
            }
            .slot-body .table {
                border-collapse: collapse;
                font-size: 0.9rem;
                margin-bottom: 0;
            }
            .slot-body .table td {
                vertical-align: middle;
                padding: 12px;
                border: 1px solid #e9ecef;
                transition: background-color 0.3s ease;
            }
            .slot-body .table td:hover {
                background-color: #f8f9fa;
            }
            .slot-body .text-success,
            .slot-body .text-danger {
                font-weight: 600;
            }
            .slot-body .text-muted {
                font-style: italic;
                color: #adb5bd;
            }

            /* Định dạng viền cho slot */
            .border-green {
                border: 2px solid #28a745 !important;
                padding: 6px 10px;
                border-radius: 6px;
                display: inline-block;
                background-color: rgba(40, 167, 69, 0.05);
                transition: background-color 0.3s ease;
            }
            .border-green:hover {
                background-color: rgba(40, 167, 69, 0.1);
            }

            .border-red {
                border: 2px solid #dc3545 !important;
                padding: 6px 10px;
                border-radius: 6px;
                display: inline-block;
                background-color: rgba(220, 53, 69, 0.05);
                transition: background-color 0.3s ease;
            }
            .border-red:hover {
                background-color: rgba(220, 53, 69, 0.1);
            }

            /* Định dạng popover */
            .popover {
                max-width: 300px;
                border: 1px solid #e9ecef;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }
            .popover-body {
                color: #333;
                font-size: 0.9rem;
                padding: 10px;
            }

            .slot-info {
                cursor: pointer;
                font-weight: 500;
            }

            /* Định dạng card chứa schedule */
            .overview-sec {
                border: none;
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
                background-color: #fff;
                margin-bottom: 30px;
            }
            .overview-sec .card-body {
                padding: 25px;
            }
            .overview-sec .subs-title {
                font-size: 1.5rem;
                color: #343a40;
                font-weight: 700;
                margin-bottom: 20px;
                border-bottom: 2px solid #007bff;
                padding-bottom: 8px;
                display: inline-block;
            }

            /* Định dạng nút điều hướng (Previous/Next) */
            .btn-outline-primary,
            .btn-outline-secondary {
                border-radius: 6px;
                font-weight: 500;
                transition: all 0.3s ease;
            }
            .btn-outline-primary:hover {
                background-color: #007bff;
                color: #fff;
                border-color: #007bff;
            }
            .btn-outline-secondary:hover {
                background-color: #6c757d;
                color: #fff;
                border-color: #6c757d;
            }
            .btn-sm {
                padding: 0.4rem 1rem;
                font-size: 0.9rem;
            }

            /* Căn chỉnh các nút và tiêu đề tháng */
            #mentorScheduleMonthYear {
                font-size: 1.3rem;
                color: #343a40;
                font-weight: 600;
            }
            .product-img img {
                width: 100%; /* ??t chi?u r?ng c? ??nh cho ?nh */
                height: 200px; /* ??t chi?u cao c? ??nh cho ?nh */
                object-fit: cover; /* C?t và ?i?u ch?nh ?nh ?? v?a v?i khung mà không b? méo */
                border-radius: 8px; /* Bo tròn góc ?nh (tu? ch?nh n?u mu?n) */
            }

            .mentor_image {
                width: 250px;
                height: 250px;
                border-radius: 10px;
                object-fit: cover;
                border: 2px solid #ddd;               
            }

            .rating {
                color: #FFD700; /* Màu vàng */
                font-size: 18px;
            }

            .star.empty {
                color: #ccc; /* Màu xám cho sao trống */
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
            <div class="inner-banner" style="background-image: url('https://png.pngtree.com/thumb_back/fh260/back_pic/00/03/83/64561fca51da066.jpg');background-size: cover; background-position: center;">
                <div class="container">
                    <div class="row">
                        <!-- Left Column: Mentor Image -->
                        <div class="col-md-3">
                            <a>
                                <img class="mentor_image" src="${mentor.image}" alt="Mentor Image">
                            </a>
                        </div>
                        <!-- Right Column: Mentor Info -->
                        <div class="col-md-9">
                            <h1 style="color: white">${mentorname}</h1>
                            <div class="col-md-2">
                                <h2>
                                    <a href="test?mentorId=${requestScope.mentorId}&courseId=${requestScope.courseId}&price=${requestScope.price}" 
                                       class="btn btn-enroll w-100">Invite</a>
                                </h2>
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
                        <div class="col-lg-14">

                            <!-- Overview -->
                            <div class="card overview-sec">
                                <div class="card-body">
                                    <h2 class="subs-title">Overview</h2>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <h5>Mentor name</h5>
                                            <h5><p>- ${mentor.name}</p></h5>
                                            <h5>Email</h5>
                                            <h5><p>- ${mentor.email}</p></h5>                                          
                                        </div>
                                        <div class="col-md-6">
                                            <h5>Expertise</h5>
                                            <h5><p>- ${mentor.expertise}</p></h5>
                                            <h5>Bio</h5>
                                            <h5><p>- ${mentor.bio}</p></h5>
                                            <button type="button" class="btn btn-primary mt-2" data-bs-toggle="modal" data-bs-target="#cvModal">
                                                View CV
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Modal -->
                            <div class="modal fade" id="cvModal" tabindex="-1" aria-labelledby="cvModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="cvModalLabel">${mentor.name}'s CV</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <!-- Sử dụng iframe để gọi servlet -->
                                            <iframe src="/HAPPYorSAD//viewCVMODAL?mentorId=${mentor.id}" width="100%" height="900px" frameborder="0"></iframe>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- /Overview -->


                            <!-- Mentor's Schedule -->
                            <!-- Mentor's Schedule -->
                            <div class="card overview-sec">
                                <div class="card-body">
                                    <h2 class="subs-title">Mentor's Schedule</h2>
                                    <form id="monthForm" action="/HAPPYorSAD/MentorDetail" method="GET">
                                        <input type="hidden" name="action" value="getMentorSlots">
                                        <input type="hidden" name="mentorId" value="${requestScope.mentorId}">
                                        <input type="hidden" name="courseId" value="${requestScope.courseId}"> <!-- Thêm courseId -->
                                        <input type="hidden" name="price" value="${requestScope.price}"> <!-- Thêm price -->
                                        <input type="hidden" name="mentorname" value="${mentorname}"> <!-- Thêm price -->

                                        <input type="hidden" name="month" id="monthInput" value="${requestScope.selectedMonth != null ? requestScope.selectedMonth : currentMonth}">
                                        <input type="hidden" name="year" id="yearInput" value="${requestScope.selectedYear != null ? requestScope.selectedYear : currentYear}"><div class="row align-items-center">
                                            <div class="col-12 col-sm-6">
                                                <h4 class="mb-1" id="mentorScheduleMonthYear">${formattedMonthYear}</h4>
                                                <p></p>
                                            </div>
                                            <div class="col-12 col-sm-6 text-sm-end">
                                                <button type="submit" class="btn btn-outline-primary btn-sm me-2" name="direction" value="prev">Previous Month</button>
                                                <button type="submit" class="btn btn-outline-primary btn-sm" name="direction" value="next">Next Month</button>
                                            </div>
                                        </div>
                                        <div class="row align-items-center mt-2">
                                            <div class="col-6 text-start">
                                                <button type="submit" class="btn btn-outline-secondary btn-sm" name="direction" value="prevWeek">Previous Week</button>
                                            </div>
                                            <div class="col-6 text-end">
                                                <button type="submit" class="btn btn-outline-secondary btn-sm" name="direction" value="nextWeek">Next Week</button>
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
                                                        <div class="text-center">
                                                            <h10>${formattedDay}</h10>
                                                        </div>
                                                        <small class="text-muted fs-6">${formattedDate}</small> 
                                                        <table class="table table-bordered text-center">
                                                            <tbody>
                                                                <c:forEach var="i" begin="1" end="5">
                                                                    <tr>
                                                                        <td>
                                                                            <c:set var="slotFound" value="false" />
                                                                            <c:forEach var="slot" items="${slotsByDay[formattedDay]}">  
                                                                                <c:if test="${slot.slot_number_id == i}">
                                                                                    <c:set var="slotFound" value="true" />
                                                                                    <!-- Tính toán thời gian bắt đầu và kết thúc dựa trên bảng dữ liệu -->
                                                                                    <c:set var="startTime">
                                                                                        <c:choose>
                                                                                            <c:when test="${slot.slot_number_id == 1}">07:30</c:when>
                                                                                            <c:when test="${slot.slot_number_id == 2}">10:00</c:when>
                                                                                            <c:when test="${slot.slot_number_id == 3}">13:00</c:when>
                                                                                            <c:when test="${slot.slot_number_id == 4}">15:30</c:when>
                                                                                            <c:when test="${slot.slot_number_id == 5}">19:30</c:when>
                                                                                        </c:choose>
                                                                                    </c:set>
                                                                                    <c:set var="endTime">
                                                                                        <c:choose>
                                                                                            <c:when test="${slot.slot_number_id == 1}">09:30</c:when>
                                                                                            <c:when test="${slot.slot_number_id == 2}">12:00</c:when>
                                                                                            <c:when test="${slot.slot_number_id == 3}">15:00</c:when>
                                                                                            <c:when test="${slot.slot_number_id == 4}">17:30</c:when>
                                                                                            <c:when test="${slot.slot_number_id == 5}">21:30</c:when>
                                                                                        </c:choose>
                                                                                    </c:set>
                                                                                    <span 
                                                                                        class="slot-info ${slot.status == 'Available' ? 'border-green' : 'border-red'}"
                                                                                        data-bs-toggle="popover" 
                                                                                        data-bs-trigger="hover" 
                                                                                        data-bs-html="true"
                                                                                        data-bs-content="
                                                                                        <strong>Slot:</strong> ${slot.slot_number_id}<br>
                                                                                        <strong>Date:</strong> ${formattedDay}<br>
                                                                                        <strong>Start:</strong> ${startTime}<br>
                                                                                        <strong>End:</strong> ${endTime}<br>
                                                                                        <strong>Status:</strong> ${slot.status == 'Available' ? 'Available' : 'Booked'}"
                                                                                        >
                                                                                        <c:choose>
                                                                                            <c:when test="${slot.status == 'Available'}">
                                                                                                <span class="text-success">
                                                                                                    <i class="isax isax-clock"></i> Slot ${slot.slot_number_id}
                                                                                                </span>
                                                                                            </c:when>
                                                                                            <c:otherwise>
                                                                                                <span class="text-danger">
                                                                                                    <i class="isax isax-clock"></i> Slot ${slot.slot_number_id}
                                                                                                </span>
                                                                                            </c:otherwise>
                                                                                        </c:choose>
                                                                                    </span>
                                                                                </c:if>
                                                                            </c:forEach>
                                                                            <c:if test="${not slotFound}">
                                                                                <span class="slot-info"
                                                                                      data-bs-toggle="popover" 
                                                                                      data-bs-trigger="hover" 
                                                                                      data-bs-html="true"
                                                                                      data-bs-content="
                                                                                      <strong>Slot:</strong> ${i}<br>
                                                                                      <strong>Date:</strong> ${formattedDay}<br>
                                                                                      <strong>Start:</strong> 
                                                                                      <c:choose>
                                                                                          <c:when test='${i == 1}'>07:30</c:when>
                                                                                          <c:when test='${i == 2}'>10:00</c:when>
                                                                                          <c:when test='${i == 3}'>13:00</c:when>
                                                                                          <c:when test='${i == 4}'>15:30</c:when>
                                                                                          <c:when test='${i == 5}'>19:30</c:when>
                                                                                      </c:choose><br>
                                                                                      <strong>End:</strong> 
                                                                                      <c:choose>
                                                                                          <c:when test='${i == 1}'>09:30</c:when>
                                                                                          <c:when test='${i == 2}'>12:00</c:when>
                                                                                          <c:when test='${i == 3}'>15:00</c:when>
                                                                                          <c:when test='${i == 4}'>17:30</c:when>
                                                                                          <c:when test='${i == 5}'>21:30</c:when>
                                                                                      </c:choose><br>
                                                                                      <strong>Status:</strong> Unavailable"
                                                                                      >Empty</span>
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
                            <!-- /Mentor's Schedule -->

                            <!-- Reviews from Mentees -->
                            <!-- Reviews from Mentees -->
                            <div class="card overview-sec">
                                <div class="card-body">
                                    <h2 class="subs-title">Reviews from Mentees</h2>
                                    <c:choose>
                                        <c:when test="${empty listReview}">
                                            <p>No reviews yet.</p>
                                        </c:when>
                                        <c:otherwise>
                                            <!-- Hiển thị tất cả review, nhưng ẩn các review từ 5 trở đi -->
                                            <c:forEach var="review" items="${listReview}" varStatus="loop">
                                                <div class="review-item mb-3 p-3 border rounded shadow-sm ${loop.index >= 5 ? 'd-none' : ''}" data-hidden="${loop.index >= 5}">
                                                    <div class="d-flex align-items-center">
                                                        <!-- Hiển thị ảnh mentee -->
                                                        <img src="${review.image}" alt="Mentee Image" class="mentee-img me-3">
                                                        <div>
                                                            <!-- Hiển thị tên mentee -->
                                                            <p class="fw-bold mb-1">${review.name}</p>
                                                            <!-- Hiển thị rating bằng sao -->
                                                            <div class="rating">
                                                                <c:forEach var="i" begin="1" end="${review.rating}">
                                                                    <span class="star">★</span>
                                                                </c:forEach>
                                                                <c:forEach var="i" begin="${review.rating + 1}" end="5">
                                                                    <span class="star empty">★</span>
                                                                </c:forEach>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!-- Hiển thị bình luận -->
                                                    <p class="mt-2 text-muted">${review.commit}</p>
                                                </div>
                                            </c:forEach>

                                            <!-- Nếu có nhiều hơn 5 review, hiển thị nút "Tải thêm" -->
                                            <c:if test="${listReview.size() > 5}">
                                                <div class="text-center">
                                                    <button id="loadMoreBtn" class="btn btn-outline-primary">Load more feedback</button>
                                                </div>
                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <!-- /Reviews from Mentees -->
                            <!-- /Reviews from Mentees -->

                            <!-- List of Courses -->
                            <div class="row">
                                <h2 class="subs-title">List of course mentor are training</h2>
                                <c:forEach var="o" items="${sessionScope.list}"> 
                                    <div class="col-lg-4 col-md-6 d-flex">
                                        <div class="course-box course-design d-flex ">
                                            <div class="product">
                                                <div class="product-img">
                                                    <a href="CourseDetails?Cid=${o.id}">
                                                        <img class="img-fluid" alt="Img" src="${o.image}">
                                                    </a>
                                                </div>
                                                <div class="product-content">

                                                    <h3 class="title"><a href="CourseDetails?Cid=${o.id}">${o.title}</a></h3>                                                   

                                                    <div class="all-btn all-category d-flex align-items-center">
                                                        <a href="CourseDetails?Cid=${o.id}" class="btn btn-primary">MORE DETAIL</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <!-- /List of Courses -->
                        </div>    
                    </div>    
                </div>
            </section>
            <!-- /Pricing Plan -->
        </div>

        <!-- /Main Wrapper -->
        <%@include file="../sourcesHome/homeFooter.jsp" %>            
        <script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js" type="text/javascript"></script>
        <script src="/HAPPYorSAD/assets/js/bootstrap.bundle.min.js" type="text/javascript"></script>
        <script src="/HAPPYorSAD/assets/plugins/select2/js/select2.min.js" type="text/javascript"></script>
        <script src="/HAPPYorSAD/assets/js/ckeditor.js" type="text/javascript"></script>
        <script src="/HAPPYorSAD/assets/plugins/dropzone/dropzone.min.js" type="text/javascript"></script>
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/ResizeSensor.js" type="text/javascript"></script>
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js" type="text/javascript"></script>
        <script src="/HAPPYorSAD/assets/js/script.js" type="text/javascript"></script>

        <!-- Script khởi tạo popover -->
        <script>
            $(document).ready(function () {
                // Khởi tạo popover với tùy chọn để hiển thị HTML
                $('[data-bs-toggle="popover"]').popover({
                    html: true,
                    trigger: 'hover',
                    placement: 'top' // Có thể thay đổi vị trí: 'top', 'bottom', 'left', 'right'
                });

                // Đảm bảo popover được đóng khi rời khỏi
                $('[data-bs-toggle="popover"]').on('mouseleave', function () {
                    $(this).popover('hide');
                });

                // Xử lý sự kiện khi nhấn nút "Tải thêm feedback"
                $('#loadMoreBtn').on('click', function () {
                    // Hiển thị tất cả các review-item đang bị ẩn
                    $('.review-item[data-hidden="true"]').removeClass('d-none').attr('data-hidden', 'false');
                    // Ẩn nút "Tải thêm" sau khi hiển thị hết
                    $(this).hide();
                });
            });
        </script>

    </body>
</html>