<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="en"/>

<!DOCTYPE html>
<html>
    <head>

        <meta charset="UTF-8">
        <title>DreamLMS</title>
        <link rel="shortcut icon" type="image/x-icon" href="/HAPPYorSAD/assets/img/favicon.svg">
        <script src="/HAPPYorSAD/assets/js/theme-script.js" type="d693b69077856eb34d3f2643-text/javascript"></script>
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/feather.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/select2/css/select2.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/dropzone/dropzone.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/boxicons/css/boxicons.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css">
        <style>
            .timing.selected {
                background-color: #007bff;
                color: white;
                border: 2px solid #0056b3;
            }
            .schedule-widget {
                min-height: 100px;
                border-radius: 4px;
            }
            .schedule-widget .schedule-header {
                border-bottom: 1px solid #E6E8EE;
                padding: 10px 20px;
                border-radius: 4px 4px 0 0;
            }
            .schedule-widget .schedule-header h4 {
                font-size: 18px;
                font-weight: 600;
                margin: 3px 0 0;
            }

            .day-slot ul {
                float: left;
                list-style: none;
                position: relative;
                width: 100%;
                margin: auto -5px 0 -5px;
                padding: 0;
            }
            .day-slot ul li {
                float: left;
                padding-left: 5px;
                padding-right: 5px;
                text-align: center;
                width: 14.28%;
            }
            .day-slot ul li span {
                display: block;
                font-size: 18px;
                text-transform: uppercase;
            }
            @media (max-width: 767.96px) {
                .day-slot ul li span {
                    font-size: 16px;
                    text-transform: unset;
                }
            }
            .day-slot ul li span.slot-date {
                display: block;
                color: #757575;
                font-size: 14px;
            }
            .day-slot ul li small.slot-year {
                color: #757575;
                font-size: 14px;
            }
            @media (max-width: 767.96px) {
                .day-slot ul li small.slot-year {
                    display: none;
                }
            }
            .day-slot ul li.left-arrow {
                text-align: center;
                width: 20px !important;
                transform: translateY(-50%);
                -webkit-transform: translateY(-50%);
                -ms-transform: translateY(-50%);
                position: absolute;
                top: 50%;
                left: 0;
                padding: 0;
            }
            @media (max-width: 991.96px) {
                .day-slot ul li.left-arrow {
                    left: -10px;
                }
            }
            .day-slot ul li.right-arrow {
                text-align: center;
                width: 20px !important;
                transform: translateY(-50%);
                -webkit-transform: translateY(-50%);
                -ms-transform: translateY(-50%);
                position: absolute;
                top: 50%;
                right: -11px;
                padding: 0;
            }

            .schedule-cont {
                padding: 20px;
            }

            .time-slot ul {
                list-style: none;
                margin: auto -5px 0 -5px;
                padding: 0;
            }
            .time-slot ul li {
                float: left;
                padding-left: 5px;
                padding-right: 5px;
                width: 14.28%;
            }
            .time-slot ul li .timing {
                background-color: #e9e9e9;
                border: 1px solid #e9e9e9;
                border-radius: 3px;
                color: #757575;
                display: block;
                font-size: 14px;
                margin-bottom: 10px;
                padding: 5px 5px;
                text-align: center;
                position: relative;
            }
            .time-slot ul li .timing:hover {
                background-color: #FFF;
            }
            .time-slot ul li .timing:last-child {
                margin-bottom: 0;
            }
            .time-slot ul li .timing.selected {
                background-color: #0E82FD;
                border: 1px solid #0E82FD;
                color: #FFF;
            }
            .time-slot ul li .timing.selected::before {
                color: #FFF;
                content: "\f00c";
                font-family: "Font Awesome 5 Free";
                font-size: 12px;
                font-weight: 900;
                position: absolute;
                top: 6px;
                right: 6px;
            }
            @media (max-width: 991.96px) {
                .time-slot ul li .timing.selected::before {
                    display: none;
                }
            }
            .time-slot ul li .timing.selected:hover {
                color: #757575;
            }
            .time-slot ul li .timing.selected:hover::before {
                color: #757575;
            }

            .schedule-list {
                border-bottom: 1px solid #cfcfcf;
                margin-bottom: 50px;
                padding-bottom: 50px;
            }
            .schedule-list:last-child {
                border-bottom: 0;
                margin-bottom: 0;
                padding-bottom: 0;
            }

            .submit-section.proceed-btn {
                margin: 0 0 30px;
            }
            @media (max-width: 767.96px) {
                .submit-section.proceed-btn {
                    margin-bottom: 20px;
                }
            }
            /* ... (các style ?ã có) ... */

            /* ... (các style ?ã có) ... */

            .title-container {
                margin-bottom: 20px;
            }

            .title-container label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }

            .title-container input[type="text"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #ced4da;
                border-radius: 4px;
                box-sizing: border-box;
                font-size: 16px;
            }

            .title-container input[type="text"]:focus {
                border-color: #80bdff;
                outline: 0;
                box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
            }

            .content-container {
                margin-bottom: 20px;
            }

            .content-container label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }

            .content-container textarea {
                width: 100%;
                height: 100px;
                padding: 10px;
                border: 1px solid #ced4da;
                border-radius: 4px;
                box-sizing: border-box;
                font-size: 16px;
                resize: vertical;
            }

            .content-container textarea:focus {
                border-color: #80bdff;
                outline: 0;
                box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
            }
            .date-container {
                display: flex;
                gap: 20px; /* Adjust gap as needed */
                margin-top: 20px;
                margin-bottom: 20px;
            }

            .date-container label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }

            .date-container input[type="date"] {
                width: 400px; /* 1.5 times wider (200px * 1.5) - Adjust as needed */
                height: 80px;  /* Double the height (40px * 2) - Adjust as needed */
                font-size: 16px; /* Adjust font size if needed */
                padding: 10px;    /* Adjust padding if needed */
                border: 1px solid #ced4da;
                border-radius: 4px;
                box-sizing: border-box;
            }

            .date-container input[type="date"]:focus {
                border-color: #80bdff;
                outline: 0;
                box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
            }

            /* Optional: Style the datepicker dropdown if needed (browser-specific) */
            /* Example for Chrome: */
            .date-container input[type="date"]::-webkit-calendar-picker-indicator {
                width: 40px; /* Adjust width as needed */
                height: 40px; /* Adjust height as needed */
                .modal {
                    display: none;
                    position: fixed;
                    z-index: 1000;
                    left: 50%;
                    top: 50%;
                    transform: translate(-50%, -50%);
                    width: 300px;
                    background: white;
                    padding: 20px;
                    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
                    border-radius: 10px;
                    text-align: center;
                }

                .modal-content {
                    font-size: 16px;
                }

                .modal button {
                    margin-top: 15px;
                    padding: 8px 15px;
                    border: none;
                    background: #007bff;
                    color: white;
                    font-size: 14px;
                    cursor: pointer;
                    border-radius: 5px;
                }

                .modal button:hover {
                    background: #0056b3;
                }
            }
            .price-display {
                background-color: #f8f9fa;
                border: 1px solid #007bff;
                color: #007bff;
                font-size: 16px;
                font-weight: bold;
                padding: 8px 15px;
                text-align: center;
                border-radius: 5px;
                display: inline-block;
            }

            .price-display .price-amount {
                font-size: 18px;
                color: #28a745;
            }
            .clear-btn {
                background-color: #dc3545;
                color: white;
                border: none;
                padding: 8px 15px;
                font-size: 14px;
                border-radius: 5px;
                cursor: pointer;
                margin-top: 10px;
                display: block;
            }

            .clear-btn:hover {
                background-color: #c82333;
            }
            .button-container {
                padding-top: 10px;
                gap: 10px; /* Kho?ng cách gi?a hai nút */
                justify-content: center; /* C?n gi?a */
            }

            .submit-bbb, .save-bbb {
                background-color: #007bff; /* Màu xanh d??ng */
                color: white; /* Màu ch? tr?ng */
                border: none;
                padding: 10px 20px;
                font-size: 16px;
                font-weight: bold;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.2s;
                text-align: center;
                width: auto;
                min-width: 100px; /* ??m b?o kích th??c ??ng nh?t */
            }

            .submit-bbb:hover, .save-bbb:hover {
                background-color: #0056b3; /* Màu xanh ??m h?n khi hover */
                transform: scale(1.05);
            }

            .submit-bbb:active, .save-bbb:active {
                background-color: #004494; /* Màu t?i h?n khi b?m */
                transform: scale(1);
            }
            .notification {
                position: fixed; /* Giữ nguyên */
                top: 20px; /* Thay bottom bằng top */
                right: 20px; /* Giữ nguyên */
                background-color: red; /* Đặt màu nền đỏ */
                color: white; /* Đặt màu chữ trắng để dễ đọc trên nền đỏ */
                border: 1px solid #ccc;
                padding: 15px;
                border-radius: 5px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.3);
                opacity: 0; /* Ẩn ban đầu */
                transition: opacity 0.3s ease-in-out; /* Hiệu ứng mờ dần */
                z-index: 1000;
            }

            .notification.show {
                opacity: 1; /* Hiện khi có class 'show' */
            }

            .notification p {
                margin: 0; /* Loại bỏ margin mặc định của <p> */
            }

            #repeatOptions {
                padding-left: 20px;
            }
            .clear-btn {
                margin-left: 10px;
            }
            .week-list {
                display: flex;
                align-items: center;
                list-style: none;
                padding: 0;
            }
            .week-list li {
                margin: 0 5px;
            }
            .left-arrow, .right-arrow {
                cursor: pointer;
            }
            #bookedSchedule {
                margin-top: 20px;
                border: 1px solid #ccc;
                padding: 10px;
            }
            .schedule-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 10px;
            }
            .schedule-table th, .schedule-table td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }
            .schedule-table th {
                background-color: #f2f2f2;
            }


            .slot-row {
                margin: 5px 0; /* Khoảng cách giữa các hàng */
            }

            /* Style cơ bản cho tất cả các slot */
            .timing {
                display: inline-block;
                padding: 10px 15px;
                margin: 5px;
                text-decoration: none;
                color: #333;
                border: 1px solid #ccc;
                border-radius: 5px;
                transition: all 0.3s ease;
                min-width: 100px; /* Đảm bảo kích thước tối thiểu để đồng đều */
                text-align: center;
            }

            /* Style cho slot khả dụng */
            .timing:not(.disabled) {
                background-color: #4CAF50; /* Màu xanh lá */
                color: white;
                cursor: pointer;
            }

            .timing:not(.disabled):hover {
                background-color: #45a049;
                border-color: #45a049;
            }

            /* Style cho slot không khả dụng (trống) */
            .timing.disabled {
                background-color: #f0f0f0; /* Màu xám nhạt */
                color: #999;
                cursor: not-allowed;
                opacity: 0.7;
                pointer-events: none; /* Không thể click */
            }

            /* Đảm bảo span hiển thị đồng đều */
            .timing span {
                font-size: 14px;
            }




        </style>

        <script>
            var slotTimeMap = {
                1: "7:30-09:30",
                2: "10:00-12:00",
                3: "13:00-15:00",
                4: "15:30-17:30",
                5: "19:30-21:30"

            };
            var timeToSlotMap = Object.fromEntries(
                    Object.entries(slotTimeMap).map(([key, value]) => [value, key])
                    );
        </script> 
        <script>
            function showNotification(message) {
                const notification = document.getElementById("notification");
                const notificationMessage = document.getElementById("notification-message");

                notificationMessage.textContent = message;
                notification.classList.add("show"); // Hiển thị popup

                // Tự động ẩn sau 3 giây (tùy chỉnh)
                setTimeout(() => {
                    notification.classList.remove("show");
                }, 3000);
            }
            document.addEventListener("DOMContentLoaded", function () {
                const startDateInput = document.getElementById("start-date");
                const endDateInput = document.getElementById("end-date");

                startDateInput.addEventListener("change", function () {
                    const today = new Date();
                    today.setHours(0, 0, 0, 0);
                    const startDate = new Date(this.value);

                    if (startDate < today) {
                        showNotification("Start Date cannot be in the past!"); // Thay alert()
                        this.value = "";
                    }
                });

                endDateInput.addEventListener("change", function () {
                    const startDate = new Date(startDateInput.value);
                    const endDate = new Date(this.value);

                    if (startDateInput.value && endDate < startDate) {
                        showNotification("End Date cannot be earlier than Start Date!"); // Thay alert()
                        this.value = "";
                    }
                });
            });

        </script>
    </head>
    <div id="notification" class="notification">
        <p id="notification-message"></p>
    </div>
    <body>
        <%@include file="/sourcesHome/homeHeader.jsp" %>
        <div id="custom-alert" class="modal">
            <div class="modal-content">
                <p id="alert-message"></p>
                <button id="close-alert">OK</button>
            </div>
        </div>

        <!-- Main Wrapper -->
        <div class="main-wrapper">
            <div class="breadcrumb-bar breadcrumb-bar-info">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 col-12">
                            <div class="breadcrumb-list">
                                <h2 class="breadcrumb-title">Create Request</h2>
                                <nav aria-label="breadcrumb" class="page-breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="Home">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Course List</li>
                                        <li class="breadcrumb-item active" aria-current="page">Course Detail</li>
                                        <li class="breadcrumb-item active" aria-current="page">Create Request</li>
                                    </ol>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>



            <!-- Page Content -->
            <div class="content doctor-content">
                <div class="container">

                    <div class="row">
                        <div class="col-12">

                            <!--                            <div class="card">
                                                            <div class="card-body"> 
                                                                <form action="/../HAPPYorSAD/test" method="post">
                                                                    <input type="hidden" name="mentorId" value="${requestScope.mentorId}"> 
                                                                    <input type="hidden" name="courseId" value="${requestScope.courseId}"> 
                                                                    <input type="hidden" name="price" value="${requestScope.price}"> 
                                                                    <div class="booking-doc-info">
                                                                        <img src="${requestScope.mentorrequest.image}" alt="User Image">
                            
                                                                        <div class="booking-info">
                                                                            <h4><a href="">${requestScope.mentorrequest.name}</a></h4>
                                                                            <div class="rating">
                                                                                <i class="fas fa-star filled"></i>
                                                                                <i class="fas fa-star filled"></i>
                                                                                <i class="fas fa-star filled"></i>
                                                                                <i class="fas fa-star filled"></i>
                                                                                <i class="fas fa-star"></i>
                                                                                <span class="d-inline-block average-rating">${requestScope.mentorrequest.rating}</span>
                                                                            </div>
                                                                            <p class="text-muted mb-0"><i class="fas fa-map-marker-alt"></i>${requestScope.mentorrequest.bio}</p>
                                                                        </div>
                                                                    </div>
                                                            </div>
                                                        </div>-->
                            <form id="bookingForm" action="/../HAPPYorSAD/test" method="post">
                                <input type="hidden" name="mentorId" value= "${requestScope.mentorId}">   
                                <input type="hidden" name="courseId" value="${requestScope.courseId}">   
                                <input type="hidden" name="price" value="${requestScope.price}">   
                                <c:if test="${not empty requestScope.requestId}">
                                    <input type="hidden" name="requestId" value="${requestScope.requestId}">
                                </c:if>
                                <input type="hidden" id="currentWeekOffset" value="0"> 


                                <div class="title-container">
                                    <label for="request-title">Title:</label>
                                    <input type="text" id="request-title" name="title"<c:if test="${requestScope.title != null}">value="${requestScope.title}" </c:if>required>
                                    </div>

                                    <div class="content-container">
                                        <label for="request-content">Content:</label>
                                        <textarea id="request-content" name="content" required><c:if test="${not empty requestScope.content}">${requestScope.content}</c:if></textarea>
                                    </div>
                                    <div class="date-container">
                                        <div>
                                            <label for="start-date">Deadline Start:</label>
                                            <input type="date" id="start-date" name="startdate"
                                            <c:if test="${not empty requestScope.startdate}">
                                                value="<fmt:formatDate value='${requestScope.startdate}' pattern='yyyy-MM-dd'/>"
                                            </c:if> required>
                                    </div>
                                    <div>
                                        <label for="end-date">Deadline End:</label>
                                        <input type="date" id="end-date" name="enddate"
                                               <c:if test="${not empty requestScope.enddate}">
                                                   value="<fmt:formatDate value='${requestScope.enddate}' pattern='yyyy-MM-dd'/>"
                                               </c:if> required>
                                    </div>
                                </div>



                                <div class="row">
                                    <div class="col-12 col-sm-4 col-md-6">
                                        <h4 class="mb-1">
                                            <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd MMMM yyyy"/>
                                        </h4>
                                        <!--                                    <p class="text-muted">
                                        <fmt:formatDate value="<%= new java.util.Date() %>" pattern="EEEE"/>
                                    </p>-->

                                    </div>
                                    <div class="col-12 col-sm-8 col-md-6 text-sm-end">
                                        <div class="dropdown">
                                            <button class="bookingrange btn btn-white btn-sm mb-3 dropdown-toggle" type="button" id="monthDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                                <i class="far fa-calendar-alt me-2"></i>
                                                <span id="selectedMonth">Choose month</span>
                                                <i class="fas fa-chevron-down ms-2"></i>
                                            </button>
                                            <ul class="dropdown-menu" aria-labelledby="monthDropdown">
                                                <input type="hidden" name="year" id="selectedYear">
                                                <input type="hidden" name="month" id="selectedMonthValue">
                                                <c:forEach var="month" items="${months}">
                                                    <li><a class="dropdown-item month-item" data-month="${month}">${month}</a></li>
                                                    </c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <input type="hidden" name="totalSlots" id="totalSlots" value="0">
                                <!-- Schedule Widget -->
                                <!-- Schedule Widget -->
                                <div class="card booking-schedule schedule-widget">

                                    <!-- Schedule Header -->
                                    <div class="schedule-header">
                                        <div class="row">
                                            <div class="col-md-12">

                                                <!-- Day Slot -->
                                                <div class="day-slot">
                                                    <ul class="week-list">
                                                        <li class="left-arrow">
                                                            <a href="javascript:void(0)" onclick="changeWeek(-1)">
                                                                <i class="fa fa-chevron-left"></i>
                                                            </a>
                                                        </li>
                                                        <c:forEach var="entry" items="${weekDateInfoMap}">
                                                            <li>
                                                                <span>${entry.value['dayOfWeek']}</span>
                                                                <span class="slot-date">${entry.value['day']} ${entry.value['month']} 
                                                                    <small class="slot-year">${entry.value['year']}</small>
                                                                </span>
                                                            </li>
                                                        </c:forEach>
                                                        <li class="right-arrow">
                                                            <a href="javascript:void(0)" onclick="changeWeek(1)">
                                                                <i class="fa fa-chevron-right"></i>
                                                            </a>
                                                        </li>


                                                    </ul>
                                                </div>
                                                <!-- /Day Slot -->

                                                <script>
                                                </script>

                                            </div>
                                        </div>
                                    </div>
                                    <!-- /Schedule Header -->

                                    <!-- Schedule Content -->
                                    <div class="schedule-cont">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <!-- Time Slot -->
                                                <div class="time-slot" id="timeSlotContainer">
                                                    <ul class="clearfix">
                                                        <c:forEach var="entry" items="${weekDateInfoMap}">
                                                            <li>
                                                                <c:choose>
                                                                    <c:when test="${not empty slotsByDay[entry.key]}">
                                                                        <!-- Lặp 5 lần cho mỗi slot từ 1 đến 5 -->
                                                                        <c:forEach var="slotNumber" begin="1" end="5">
                                                                            <div class="slot-row"> <!-- Thêm div để chia thành từng hàng -->
                                                                                <c:set var="slotFound" value="false" />
                                                                                <c:forEach var="slot" items="${slotsByDay[entry.key]}">
                                                                                    <c:if test="${slot.slotNumber == slotNumber}">
                                                                                        <a href="#" class="timing" data-slot-info="${entry.key}_${slot.slotNumber}">
                                                                                            <span>Slot ${slotNumber}</span> <!-- Hiển thị Slot1, Slot2, ... -->                                                                                        </a>
                                                                                            <c:set var="slotFound" value="true" />
                                                                                        </c:if>
                                                                                    </c:forEach>
                                                                                    <c:if test="${not slotFound}">
                                                                                    <a href="#" class="timing disabled" data-slot-info="${entry.key}_${slotNumber}" style="background-color: #f0f0f0;color: #999;"> 

                                                                                        <span>Slot ${slotNumber}</span> <!-- Hiển thị Slot1, Slot2, ... -->                                                                                    </a>
                                                                                    </c:if>
                                                                            </div>
                                                                        </c:forEach>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <div class="slot-row">
                                                                            <!-- Nếu không có slot nào, hiển thị 5 hàng disabled -->
                                                                            <c:forEach var="slotNumber" begin="1" end="5">
                                                                                <a href="#" class="timing disabled" data-slot-info="${entry.key}_${slotNumber}" style="background-color: #f0f0f0;color: #999;"> 
                                                                                    <span>Slot ${slotNumber}</span> <!-- Hiển thị Slot1, Slot2, ... -->                                                                            </a>
                                                                                </c:forEach>
                                                                        </div>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </li>
                                                        </c:forEach>
                                                    </ul>
                                                </div>
                                                <!-- /Time Slot -->
                                                <label>
                                                    <input type="checkbox" id="repeatBooking"> Repeat Booking
                                                </label>
                                                <div id="repeatOptions" style="display: none; margin-top: 10px;">
                                                    <label>Chế độ lặp lại:</label>
                                                    <div>
                                                        <input type="radio" id="repeatByWeeks" name="repeatMode" value="weeks" checked>
                                                        <label for="repeatByWeeks">Theo số tuần</label>
                                                        <input type="radio" id="repeatBySlots" name="repeatMode" value="slots">
                                                        <label for="repeatBySlots">Theo số lượng slot</label>
                                                    </div>
                                                    <div id="weeksOption">
                                                        <label for="repeatWeeks">Số tuần (tối đa 4): </label>
                                                        <select id="repeatWeeks">
                                                            <option value="1">+1 tuần</option>
                                                            <option value="2">+2 tuần</option>
                                                            <option value="3">+3 tuần</option>
                                                            <option value="4">+4 tuần</option>
                                                        </select>
                                                    </div>
                                                    <div id="slotsOption" style="display: none;">
                                                        <label for="maxSlots">Số lượng slot tối đa: </label>
                                                        +<input type="number" id="maxSlots" min="1" max="20" value="5">
                                                    </div>
                                                </div>
                                                <button id="bookSlots" type="button">Book Selected Slots</button>
                                                <button type="button" id="clearAllBtn" class="clear-btn">Clear</button>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /Schedule Content -->

                                    <!-- Schedule hiển thị slot đã book (thời khóa biểu) -->
                                    <!-- Schedule hiển thị slot đã book (thời khóa biểu) -->
                                    <div id="bookedSchedule">
                                        <h3>Thời Khóa Biểu của Bạn</h3>
                                        <table class="schedule-table">
                                            <thead>
                                                <tr>
                                                    <th>Thứ</th>
                                                    <th>Ngày</th>
                                                    <th>Tháng</th>
                                                    <th>Năm</th>
                                                    <th>Slot</th> <!-- Thêm cột Slot -->
                                                    <th>Thời Gian</th>
                                                    <th>Trạng Thái</th>
                                                </tr>
                                            </thead>
                                            <tbody id="bookedSlotsContainer">
                                                <!-- Bảng trống ban đầu, sẽ được cập nhật khi chọn slot -->
                                            </tbody>
                                        </table>
                                    </div>

                                </div><!-- /Schedule Widget -->

                                <div class="price-display">
                                    Total Price: <span class="price-amount">0</span>
                                </div>
                                <!-- Submit Section -->
                                <div class="button-container">
                                    <input type="hidden" name="service" id="serviceInput" value="">
                                    <input type="hidden" id="totalPriceInput" name="totalprice" value="0">
                                    <button type="button" class="submit-bbb">Submit</button>
                                    <button type="button" class="save-bbb">Save</button>
                                </div>
                                <!-- /Submit Section -->
                        </div>

                        </form>

                    </div>
                </div>

            </div>

            <form id="hiddenForm" action="/HAPPYorSAD/test" method="GET">
                <input type="hidden" name="mentorId" id="hiddenMentorId">
                <input type="hidden" name="courseId" id="hiddenCourseId">
                <input type="hidden" name="price" id="hiddenPrice">
                <input type="hidden" name="year" id="hiddenYear">
                <input type="hidden" name="month" id="hiddenMonth">
                <input type="hidden" name="service" id="hiddenService">
            </form>


            <script>
                // Hàm đổi tuần và cập nhật time-slot
                function changeWeek(offset) {
                    let currentOffset = parseInt(document.getElementById("currentWeekOffset").value);
                    let newOffset = currentOffset + offset;
                    document.getElementById("currentWeekOffset").value = newOffset;

                    let formData = new FormData();
                    formData.append("action", "changeWeek");
                    formData.append("weekOffset", newOffset);
                    formData.append("mentorId", document.querySelector("input[name='mentorId']").value);
                    formData.append("courseId", document.querySelector("input[name='courseId']").value);

                    fetch("/HAPPYorSAD/test", {
                        method: "POST",
                        body: formData,
                        credentials: "same-origin"
                    })
                            .then(response => {
                                if (!response.ok)
                                    throw new Error("Network response was not ok " + response.status);
                                return response.text(); // Nhận HTML trực tiếp
                            })
                            .then(data => {
                                console.log("Raw response from changeWeek:", data);
                                // Cập nhật tuần và slot
                                const parser = new DOMParser();
                                const doc = parser.parseFromString(data, "text/html");
                                const newWeekList = doc.querySelector(".week-list").innerHTML;
                                const newTimeSlot = doc.querySelector(".time-slot").innerHTML;

                                document.querySelector("#weekList").innerHTML = newWeekList;
                                document.getElementById("timeSlotContainer").innerHTML = newTimeSlot;

                                // Cập nhật lại timeSlots
                                window.timeSlots = document.querySelectorAll(".timing");
                                updateTempSlotUI(); // Cập nhật lại giao diện với slot mới
                            })
                            .catch(error => {
                                console.error("Lỗi khi đổi tuần:", error);
                                alert("Lỗi khi đổi tuần: " + error.message);
                            });
                }
                document.addEventListener("DOMContentLoaded", function () {
                    // Biến để theo dõi các handler đã được gắn
                    const eventHandlersAttached = {
                        submitBtn: false,
                        bookSlotsBtn: false,
                        clearAllBtn: false,
                        timeSlots: false
                    };
                    // Khai báo các biến cần thiết
                    const timeSlots = document.querySelectorAll(".timing");
                    const priceDisplay = document.querySelector(".price-amount");
                    const pricePerSlot = ${requestScope.price};
                    const walletBalance = ${sessionScope.walletBalance};
                    const totalSlotsInput = document.getElementById("totalSlots");
                    const submitBtn = document.querySelector(".submit-bbb");
                    let isSubmitProcessing = false;

                    const saveBtn = document.querySelector(".save-bbb");
                    const monthItems = document.querySelectorAll(".month-item");
                    const selectedMonthSpan = document.getElementById("selectedMonth");
                    const bookSlotsBtn = document.getElementById("bookSlots");
                    const repeatCheckbox = document.getElementById("repeatBooking");
                    const repeatOptions = document.getElementById("repeatOptions");
                    const repeatByWeeks = document.getElementById("repeatByWeeks");
                    const repeatBySlots = document.getElementById("repeatBySlots");
                    const weeksOption = document.getElementById("weeksOption");
                    const slotsOption = document.getElementById("slotsOption");
                    const repeatWeeks = document.getElementById("repeatWeeks");
                    const maxSlotsInput = document.getElementById("maxSlots");
                    const bookedSlotsContainer = document.getElementById("bookedSlotsContainer");

                    const requestTitle = document.getElementById("request-title");
                    const requestContent = document.getElementById("request-content");
                    const startDate = document.getElementById("start-date");
                    const endDate = document.getElementById("end-date");

                    let slotRepeatMap = new Map(); // Map để lưu slot gốc và các slot lặp lại của nó
                    let totalPrice = 0;
                    let totalSlots = 0;
                    let selectedSlots = new Set();
                    // Biến tạm để lưu slot đã book, lưu dưới dạng chuỗi ngăn cách bởi dấu phẩy

                    let tempSlotBooked = new Set((sessionStorage.getItem("tempSlotBooked") || "").split(",").filter(slot => slot.trim() !== ""));

                    // Khôi phục dữ liệu form từ sessionStorage
                    function restoreFormData() {
                        const savedTitle = sessionStorage.getItem("requestTitle");
                        const savedContent = sessionStorage.getItem("requestContent");
                        const savedStartDate = sessionStorage.getItem("startDate");
                        const savedEndDate = sessionStorage.getItem("endDate");

                        if (savedTitle)
                            requestTitle.value = savedTitle;
                        if (savedContent)
                            requestContent.value = savedContent;
                        if (savedStartDate)
                            startDate.value = savedStartDate;
                        if (savedEndDate)
                            endDate.value = savedEndDate;
                    }

                    // Lưu dữ liệu form vào sessionStorage
                    function saveFormData() {
                        sessionStorage.setItem("requestTitle", requestTitle.value);
                        sessionStorage.setItem("requestContent", requestContent.value);
                        sessionStorage.setItem("startDate", startDate.value);
                        sessionStorage.setItem("endDate", endDate.value);
                        sessionStorage.setItem("tempSlotBooked", Array.from(tempSlotBooked).join(","));
                    }

                    // Xóa dữ liệu form khỏi sessionStorage sau khi submit thành công
                    function clearFormData() {
                        sessionStorage.removeItem("requestTitle");
                        sessionStorage.removeItem("requestContent");
                        sessionStorage.removeItem("startDate");
                        sessionStorage.removeItem("endDate");
                        sessionStorage.removeItem("tempSlotBooked");
                    }

                    function updateBookedSchedule() {
                        console.log("Starting updateBookedSchedule function");
                        bookedSlotsContainer.innerHTML = ""; // Xóa nội dung cũ
                        console.log("Cleared bookedSlotsContainer HTML");

                        tempSlotBooked.forEach(slot => {
                            var slotTimeMap = {
                                1: "7:30-09:30",
                                2: "10:00-12:00",
                                3: "13:00-15:00",
                                4: "15:30-17:30",
                                5: "19:30-21:30"
                            };
                            var timeToSlotMap = Object.fromEntries(
                                    Object.entries(slotTimeMap).map(([key, value]) => [value, key])
                                    );
                            console.log("Processing slot:", slot);
                            let [dateStr, slotNumber] = slot.split("_");
                            console.log("Parsed slot - dateStr:", dateStr, "slotNumber:", slotNumber);

                            let date = new Date(dateStr);
                            console.log("Converted date:", date);

                            let dayOfWeek = date.toLocaleString("vi-VN", {weekday: "long"});
                            let day = date.getDate();
                            let month = date.toLocaleString("vi-VN", {month: "long"});
                            let year = date.getFullYear();
                            let slotTime = slotTimeMap[slotNumber] || "Unknown Time";
                            console.log("Extracted values - dayOfWeek:", dayOfWeek, "day:", day, "month:", month, "year:", year, "slotTime:", slotTime);

                            // Tạo hàng và các ô thủ công
                            let tr = document.createElement("tr");
                            let tdDayOfWeek = document.createElement("td");
                            let tdDay = document.createElement("td");
                            let tdMonth = document.createElement("td");
                            let tdYear = document.createElement("td");
                            let tdSlot = document.createElement("td"); // Thêm ô cho Slot
                            let tdSlotTime = document.createElement("td");
                            let tdStatus = document.createElement("td");

                            tdDayOfWeek.textContent = dayOfWeek;
                            tdDay.textContent = day;
                            tdMonth.textContent = month;
                            tdYear.textContent = year;
                            tdSlotTime.textContent = slotTime;
                            tdSlot.textContent = "Slot " + slotNumber; // Sử dụng nối chuỗi thay vì template literal               
                            tdStatus.textContent = "Đã chọn";


                            console.log("Created td elements - dayOfWeek:", tdDayOfWeek.textContent, "day:", tdDay.textContent, "month:", tdMonth.textContent, "year:", tdYear.textContent, "slotTime:", tdSlotTime.textContent, "status:", tdStatus.textContent);

                            tr.appendChild(tdDayOfWeek);
                            tr.appendChild(tdDay);
                            tr.appendChild(tdMonth);
                            tr.appendChild(tdYear);
                            tr.appendChild(tdSlot); // Thêm ô Slot vào hàng
                            tr.appendChild(tdSlotTime);
                            tr.appendChild(tdStatus);
                            console.log("Appended td elements to tr");

                            bookedSlotsContainer.appendChild(tr);
                            console.log("Added row to bookedSlotsContainer, current HTML:", bookedSlotsContainer.innerHTML);
                        });
                        console.log("Finished updateBookedSchedule function, total slots processed:", tempSlotBooked.size);
                    }

                    console.log("Initializing updateTempSlotUI");


                    console.log("Khởi tạo script...");
                    console.log("Giá mỗi slot:", pricePerSlot);
                    console.log("Số dư ví:", walletBalance);
                    console.log("Slot đã book tạm:", Array.from(tempSlotBooked));

                    // Hàm cập nhật UI
                    function updateUI() {
                        console.log("Cập nhật UI...");
                        console.log("Tổng giá hiện tại:", totalPrice);
                        console.log("Số slot đã chọn:", totalSlots);

                        priceDisplay.textContent = totalPrice;
                        totalSlotsInput.value = totalSlots;
                        document.getElementById("totalPriceInput").value = totalPrice;
                        console.log("Giá trị được gán vào totalPriceInput:", document.getElementById("totalPriceInput").value);

                        if (totalPrice > walletBalance) {
                            showNotification("Bạn không đủ tiền trong ví để đặt thêm slot!");
                            submitBtn.disabled = true;
                            saveBtn.disabled = true;
                            submitBtn.classList.add("disabled");
                            saveBtn.classList.add("disabled");
                        } else {
                            submitBtn.disabled = false;
                            saveBtn.disabled = false;
                            submitBtn.classList.remove("disabled");
                            saveBtn.classList.remove("disabled");
                        }
                    }

                    // Cập nhật giao diện khi có slot đã book tạm
                    function updateTempSlotUI() {
                        timeSlots.forEach(slot => {
                            let slotInfo = slot.dataset.slotInfo;
                            if (tempSlotBooked.has(slotInfo)) {
                                slot.classList.add("selected");
                            } else {
                                slot.classList.remove("selected");
                            }
                        });
                        totalSlots = tempSlotBooked.size;
                        totalPrice = totalSlots * pricePerSlot;
                        updateUI();
                        updateBookedSchedule(); // Cập nhật thời khóa biểu ngay khi chọn hoặc bỏ chọn slot
                        console.log("Finished updateTempSlotUI function, totalSlots:", totalSlots, "totalPrice:", totalPrice);
                    }

                    // Hàm tạo slot lặp lại dựa trên chế độ
                    function generateRepeatedSlots(slot, mode, weeks, maxSlots) {
                        let repeatedSlots = new Set();
                        let [dateStr, slotNumber] = slot.split("_");
                        let slotDate = new Date(dateStr);
                        let currentDate = new Date(slotDate);
                        let slotCount = 1; // Đếm slot gốc
                        console.log("SlotDate:", currentDate);
                        console.log("repeatedSlots", repeatedSlots);

                        repeatedSlots.add(slot); // Thêm slot gốc
                        console.log("Generating repeated slots for:", slot, "mode:", mode, "weeks:", weeks, "maxSlots:", maxSlots);
                        let repeatedSlotsArray = []; // Lưu các slot lặp lại để gán vào slotRepeatMap

                        if (mode === "weeks" && repeatCheckbox.checked) {
                            for (let week = 1; week <= weeks; week++) {
                                currentDate.setDate(currentDate.getDate() + 7);
                                let newSlot = currentDate.toISOString().split('T')[0] + "_" + slotNumber;
                                repeatedSlots.add(newSlot);
                                repeatedSlotsArray.push(newSlot); // Thêm vào danh sách lặp lại
                                slotCount++;
                                console.log("Added repeated slot:", newSlot);
                            }
                        } else if (mode === "slots" && repeatCheckbox.checked && slotCount < maxSlots) {
                            while (slotCount < maxSlots) {
                                currentDate.setDate(currentDate.getDate() + 7);
                                let newSlot = currentDate.toISOString().split('T')[0] + "_" + slotNumber;
                                repeatedSlots.add(newSlot);
                                repeatedSlotsArray.push(newSlot); // Thêm vào danh sách lặp lại
                                slotCount++;
                                console.log("Added repeated slot:", newSlot);
                            }
                        }
                        if (repeatedSlotsArray.length > 0) {
                            slotRepeatMap.set(slot, repeatedSlotsArray);
                        }
                        console.log("Generated repeated slots:", Array.from(repeatedSlots));
                        console.log("Updated slotRepeatMap:", Array.from(slotRepeatMap.entries()));
                        return Array.from(repeatedSlots);
                    }

                    // Hiển thị/ẩn tùy chọn repeat và chế độ
                    repeatCheckbox.addEventListener("change", function () {
                        repeatOptions.style.display = this.checked ? "block" : "none";
                        console.log("Repeat checkbox changed to:", this.checked);
                    });

                    repeatByWeeks.addEventListener("change", function () {
                        if (this.checked) {
                            weeksOption.style.display = "block";
                            slotsOption.style.display = "none";
                            console.log("Switched to weeks mode");
                        }
                    });

                    repeatBySlots.addEventListener("change", function () {
                        if (this.checked) {
                            weeksOption.style.display = "none";
                            slotsOption.style.display = "block";
                            console.log("Switched to slots mode");
                        }
                    });

                    // Lưu dữ liệu form khi thay đổi
                    [requestTitle, requestContent, startDate, endDate].forEach(input => {
                        input.addEventListener("input", saveFormData);
                    });
                    // Gắn handler cho timeSlots nếu chưa gắn
                    if (!eventHandlersAttached.timeSlots) {
                        timeSlots.forEach(slot => {
                            slot.addEventListener("click", function (event) {
                                event.preventDefault();
                                console.log("Time slot clicked - Handler triggered for ", this.dataset.slotInfo, "on element: ", this, "at", new Date().toISOString());

                                let slotInfo = this.dataset.slotInfo;
                                if (tempSlotBooked.has(slotInfo)) {
                                    tempSlotBooked.delete(slotInfo);
                                    this.classList.remove("selected");
                                    if (slotRepeatMap.has(slotInfo)) {
                                        const repeatedSlots = slotRepeatMap.get(slotInfo);
                                        repeatedSlots.forEach(repeatedSlot => {
                                            tempSlotBooked.delete(repeatedSlot);
                                        });
                                        slotRepeatMap.delete(slotInfo);
                                    }
                                } else {
                                    tempSlotBooked.add(slotInfo);
                                    this.classList.add("selected");
                                    if (repeatCheckbox.checked) {
                                        let mode = repeatByWeeks.checked ? "weeks" : "slots";
                                        let weeks = parseInt(repeatWeeks.value) || 1;
                                        let maxSlots = parseInt(maxSlotsInput.value) || 5;
                                        let repeatedSlots = generateRepeatedSlots(slotInfo, mode, weeks, maxSlots);
                                        repeatedSlots.forEach(s => {
                                            if (!tempSlotBooked.has(s)) {
                                                tempSlotBooked.add(s);
                                            }
                                        });
                                    }
                                }

                                saveFormData();
                                totalSlots = tempSlotBooked.size;
                                totalPrice = totalSlots * pricePerSlot;
                                updateUI();
                                updateBookedSchedule();
                            });
                        });
                        eventHandlersAttached.timeSlots = true;
                    }

                    let isBookProcessing = false; // Flag để tránh gửi lặp
                    // Gắn handler cho bookSlotsBtn nếu chưa gắn
                    if (!eventHandlersAttached.bookSlotsBtn) {
                        let isBookProcessing = false;
                        bookSlotsBtn.addEventListener("click", function (event) {
                            event.preventDefault();
                            console.log("Book Slots clicked - Handler triggered on element: ", this, "at", new Date().toISOString());
                            if (isBookProcessing)
                                return;
                            isBookProcessing = true;

                            console.log("Book Slots clicked - Handler triggered at " + new Date().toISOString());

                            if (tempSlotBooked.size === 0) {
                                alert("Vui lòng chọn ít nhất một slot!");
                                isBookProcessing = false;
                                return;
                            }

                            let formData = new FormData();
                            tempSlotBooked.forEach(slot => {
                                formData.append("tempSlotBooked", slot);
                            });
                            console.log("Sending FormData for Book:", Array.from(formData.entries()));

                            fetch("/HAPPYorSAD/test?action=book", {
                                method: "POST",
                                body: formData,
                                credentials: "same-origin"
                            })
                                    .then(response => {
                                        if (!response.ok)
                                            throw new Error("Network response was not ok " + response.status);
                                        return response.text();
                                    })
                                    .then(data => {
                                        console.log("Raw response from Book:", data);
                                        const message = data.trim() || "Đã lưu tạm thành công nhưng không có phản hồi chi tiết từ server!";
                                        alert(message);
                                        updateTempSlotUI();
                                    })
                                    .catch(error => {
                                        console.error("Lỗi khi gửi Book:", error);
                                        alert("Lỗi khi lưu tạm: " + error.message);
                                    })
                                    .finally(() => {
                                        isBookProcessing = false;
                                    });

                            saveFormData();
                        });
                        eventHandlersAttached.bookSlotsBtn = true;
                    }

                    // Gắn handler cho clearAllBtn nếu chưa gắn
                    if (!eventHandlersAttached.clearAllBtn && clearAllBtn) {
                        let isClearProcessing = false;
                        clearAllBtn.addEventListener("click", function (event) {
                            event.preventDefault();
                            if (isClearProcessing)
                                return;
                            isClearProcessing = true;

                            console.log("Clear clicked - Handler triggered at " + new Date().toISOString());

                            tempSlotBooked.clear();
                            slotRepeatMap.clear();
                            sessionStorage.removeItem("tempSlotBooked");
                            timeSlots.forEach(slot => slot.classList.remove("selected"));
                            if (bookedSlotsContainer) {
                                bookedSlotsContainer.innerHTML = "";
                            }
                            totalSlots = 0;
                            totalPrice = 0;
                            updateUI();

                            fetch("/HAPPYorSAD/test?action=clear", {
                                method: "POST",
                                credentials: "same-origin"
                            })
                                    .then(response => response.text())
                                    .then(data => console.log("Clear response:", data))
                                    .catch(error => console.error("Lỗi khi clear:", error))
                                    .finally(() => {
                                        isClearProcessing = false;
                                    });
                        });
                        eventHandlersAttached.clearAllBtn = true;
                    }
                    // Gắn handler cho submitBtn nếu chưa gắn
                    if (!eventHandlersAttached.submitBtn) {
                        let isSubmitProcessing = false;
                        submitBtn.addEventListener("click", function (event) {
                            event.preventDefault();
                            if (isSubmitProcessing)
                                return;
                            isSubmitProcessing = true;

                            console.log("Submit clicked - Handler triggered at " + new Date().toISOString());

                            const bookingForm = document.getElementById("bookingForm");
                            if (bookingForm.checkValidity()) {
                                if (tempSlotBooked.size === 0) {
                                    showNotification("Please select at least one slot before submitting!");
                                    isSubmitProcessing = false;
                                    return;
                                }

                                document.getElementById("serviceInput").value = "submit";
                                document.getElementById("totalPriceInput").value = totalPrice;

                                let formData = new FormData(bookingForm);
                                tempSlotBooked.forEach(slot => {
                                    formData.append("tempSlotBooked", slot);
                                });
                                console.log("Sending FormData for Submit:", Array.from(formData.entries()));

                                fetch(bookingForm.action, {
                                    method: "POST",
                                    body: formData,
                                    credentials: "same-origin"
                                })
                                        .then(response => {
                                            if (!response.ok)
                                                throw new Error("Network response was not ok " + response.status);
                                            return response.text();
                                        })
                                        .then(data => {
                                            console.log("Raw response from Submit:", data);
                                            const message = data.trim() || "Submit thành công nhưng không có phản hồi chi tiết từ server!";
                                            alert(message);
                                            if (message.includes("successfully")) {
                                                clearFormData();
                                                tempSlotBooked.clear();
                                                slotRepeatMap.clear();
                                                updateTempSlotUI();
                                                bookedSlotsContainer.innerHTML = "";
                                                totalSlots = 0;
                                                totalPrice = 0;
                                                updateUI();
                                                window.location.href = "/HAPPYorSAD/ShowMenteeRequest";
                                            }
                                        })
                                        .catch(error => {
                                            console.error("Lỗi khi gửi dữ liệu:", error);
                                            alert("Lỗi khi submit: " + error.message);
                                        })
                                        .finally(() => {
                                            isSubmitProcessing = false;
                                        });
                            } else {
                                showNotification("Please fill in all required fields.");
                                isSubmitProcessing = false;
                            }
                        });
                        eventHandlersAttached.submitBtn = true;
                    }

                    // Xử lý nút Save
                    saveBtn.addEventListener("click", function (event) {
                        if (bookingForm.checkValidity()) {
                            document.getElementById("serviceInput").value = "save";
                            // Lưu dữ liệu trước khi submit
                            saveFormData();
                            bookingForm.requestSubmit();
                        } else {
                            event.preventDefault();
                            showNotification("Please fill in all required fields.");
                        }
                    });

                    // Xử lý chọn tháng
                    monthItems.forEach(item => {
                        item.addEventListener("click", function (event) {
                            event.preventDefault();
                            const selectedMonth = this.getAttribute("data-month");
                            document.getElementById("selectedMonth").textContent = selectedMonth;

                            const parts = selectedMonth.split(" ");
                            if (parts.length === 2) {
                                const year = parts[1];
                                const month = parts[0];
                                document.getElementById("hiddenMentorId").value = document.querySelector("input[name='mentorId']").value;
                                document.getElementById("hiddenCourseId").value = document.querySelector("input[name='courseId']").value;
                                document.getElementById("hiddenPrice").value = document.querySelector("input[name='price']").value;
                                document.getElementById("hiddenYear").value = year;
                                document.getElementById("hiddenMonth").value = month;
                                document.getElementById("hiddenForm").submit();
                            }
                        });
                    });

                    submitBtn.removeEventListener("click", submitHandler); // Xóa handler cũ nếu có
                    submitBtn.addEventListener("click", submitHandler);


                    // Khởi tạo UI với slot và form đã book tạm
                    window.addEventListener("load", function () {
                        const savedMonth = localStorage.getItem("selectedMonth");
                        if (savedMonth) {
                            document.getElementById("selectedMonth").textContent = savedMonth;
                        }
                        updateTempSlotUI();
                        restoreFormData();
                        repeatByWeeks.checked = true;
                        weeksOption.style.display = "block";
                        slotsOption.style.display = "none";
                    });
                });

            </script>
            <c:if test="${not empty sessionScope.msg}">
                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        showNotification("${sessionScope.msg}");
                    });
                </script>
                <c:remove var="msg" scope="session"/> 
            </c:if>


            <!-- /Page Content -->
            <%@include file="/sourcesHome/homeFooter.jsp" %>


        </div>
        <!-- /Main Wrapper -->
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

</html>