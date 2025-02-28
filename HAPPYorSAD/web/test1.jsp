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


        </style>
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
                                                    <ul>

                                                        <c:forEach var="entry" items="${weekDateInfoMap}">
                                                            <li>
                                                                <span>${entry.value['dayOfWeek']}</span>
                                                                <span class="slot-date">${entry.value['day']} ${entry.value['month']} 
                                                                    <small class="slot-year">${entry.value['year']}</small>
                                                                </span>
                                                            </li>
                                                        </c:forEach>


                                                    </ul>
                                                </div>
                                                <!-- /Day Slot -->

                                            </div>
                                        </div>
                                    </div>
                                    <!-- /Schedule Header -->

                                    <!-- Schedule Content -->
                                    <div class="schedule-cont">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <!-- Time Slot -->
                                                <div class="time-slot">
                                                    <ul class="clearfix">
                                                        <c:forEach var="entry" items="${weekDateInfoMap}">
                                                            <li>
                                                                <c:choose>
                                                                    <c:when test="${not empty slotsByDay[entry.key]}">
                                                                        <c:forEach var="slot" items="${slotsByDay[entry.key]}">
                                                                            <a href="#" class="timing" data-slot-info="${entry.key}_${slot.slotNumber}">
                                                                                <span>${slotTimeMap[slot.slotNumber]}</span>
                                                                            </a>
                                                                        </c:forEach>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <p>No slots available</p>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </li>
                                                        </c:forEach>
                                                    </ul>
                                                </div>

                                                <label>
                                                    <input type="checkbox" id="repeatBooking"> Repeat Booking
                                                </label>
                                                <button id="bookSlots">Book Selected Slots</button>
                                                <button type="button" id="clearAllBtn" class="clear-btn">Clear</button>
                                                <!-- /Time Slot -->

                                            </div>
                                        </div>
                                    </div>
                                    <!-- /Schedule Content -->

                                </div>


                                <!-- /Schedule Widget -->

                                <div class="price-display">
                                    Total Price: <span class="price-amount">0</span>
                                </div>
                                <!-- Submit Section -->
                                <div class="button-container">
                                    <input type="hidden" name="service" id="serviceInput" value="">
                                    <input type="hidden" id="totalPriceInput" name="totalprice">
                                    <button type="submit" class="submit-bbb">Submit</button>
                                    <button type="button" class="save-bbb">Save</button>
                                </div>
                                <!-- /Submit Section -->
                        </div>
                        </form>

                    </div>
                </div>

            </div>

            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    const timeSlots = document.querySelectorAll(".timing");
                    const priceDisplay = document.querySelector(".price-amount");
                    const pricePerSlot = ${requestScope.price}; // Lấy giá từ requestScope
                    const walletBalance = ${sessionScope.walletBalance}; // Lấy số dư ví
                    const totalSlotsInput = document.getElementById("totalSlots");
                    const submitBtn = document.querySelector(".submit-bbb"); // Nút Submit
                    const saveBtn = document.querySelector(".save-bbb"); // Nút Save
                    const serviceInput = document.getElementById("serviceInput"); // Input ẩn chứa giá trị service
                    const bookingForm = document.getElementById("bookingForm"); // Form chính
                    const totalPriceInput = document.getElementById("totalPriceInput"); // Input ẩn chứa totalPrice
                    let totalPrice = 0;
                    let totalSlots = 0;
                    let selectedSlots = new Set();
                    function updateUI() {
                        priceDisplay.textContent = totalPrice;
                        totalSlotsInput.value = totalSlots;
                        totalPriceInput.value = totalPrice;
                        if (totalPrice > walletBalance) {
                            showNotification("Deposit your wallet to add more slot");
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

                    timeSlots.forEach(slot => {
                        slot.addEventListener("click", function (event) {
                            event.preventDefault();
                            let slotInfo = this.dataset.slotInfo;
                            if (selectedSlots.has(slotInfo)) {
                                selectedSlots.delete(slotInfo);
                                this.classList.remove("selected");
                                totalPrice -= pricePerSlot;
                                totalSlots--;
                            } else {
                                selectedSlots.add(slotInfo);
                                this.classList.add("selected");
                                totalPrice += pricePerSlot;
                                totalSlots++;
                            }

                            updateUI();
                        });
                    });
                    const clearAllBtn = document.getElementById("clearAllBtn");
                    if (clearAllBtn) {
                        clearAllBtn.addEventListener("click", function () {
                            document.querySelectorAll(".timing.selected").forEach(function (slot) {
                                slot.classList.remove("selected");
                            });
                            totalSlots = 0;
                            totalPrice = 0;
                            selectedSlots.clear();
                            updateUI();
                        });
                    }

                    submitBtn.addEventListener("click", function (event) {
                        if (bookingForm.checkValidity()) {
                            serviceInput.value = "submit";
                            totalPriceInput.value = totalPrice;
                            bookingForm.requestSubmit(); // Kích hoạt kiểm tra required
                        } else {
                            event.preventDefault(); // Ngăn form gửi nếu có lỗi
                            showNotification("Please fill in all required fields.");
                        }
                    });

                    saveBtn.addEventListener("click", function (event) {
                        if (bookingForm.checkValidity()) {
                            serviceInput.value = "save";
                            bookingForm.requestSubmit();
                        } else {
                            event.preventDefault();
                            showNotification("Please fill in all required fields.");
                        }
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