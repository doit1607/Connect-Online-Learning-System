
</html>
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

            .delete-btn {
                max-width: 300px; /* Đặt giới hạn chiều rộng */

                white-space: normal; /* Cho phép xuống dòng */
                word-wrap: break-word; /* Ngắt dòng khi cần */
                overflow-wrap: break-word; /* Hỗ trợ tốt hơn cho các trình duyệt mới */
                width: 100%; /* Tràn hết chiều rộng của ô */
                display: block; /* Đảm bảo button là block element để full width */
                padding: 10px;
                font-size: 14px;
                text-align: center;
                background-color: #b22222; /* Màu đỏ đậm giống hình của bạn */
                color: white; /* Chữ màu trắng */
                border: none; /* Xóa viền */
                cursor: pointer;
            }


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

            /* Schedule Content */
            .schedule-cont {
                padding: 20px;
            }

            /* Time Slot Container */
            .time-slot {
                width: 100%;
            }

            .time-slot ul {
                list-style: none;
                margin: 0;
                padding: 0;
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
            }

            .time-slot ul li {
                float: left;
                padding: 0 5px;
                width: 14.28%; /* 7 cột cho 7 ngày trong tuần */
                box-sizing: border-box;
            }

            /* Slot Row */
            .slot-row {
                margin: 5px 0;
            }

            /* Style cơ bản cho tất cả các slot */
            .timing {
                display: block; /* Đảm bảo slot chiếm toàn bộ chiều rộng của li */
                padding: 10px 15px;
                margin: 5px 0; /* Khoảng cách giữa các slot trong cùng một ngày */
                text-decoration: none;
                border-radius: 5px;
                transition: all 0.3s ease;
                text-align: center;
                border: 2px solid transparent;
                background-color: #e9e9e9; /* Màu nền mặc định nếu không có trạng thái */
                color: #757575;
                font-size: 14px;
                position: relative;
                cursor: pointer;

            }

            .timing:hover {
                background-color: #fff; /* Hiệu ứng hover cho slot không bị vô hiệu hóa */
            }

            /* Các trạng thái slot */
            .timing.slot-studying {
                background-color: #ff0000; /* Màu đỏ cho Studying (Mentor bận) */
                color: white;
                border: 2px solid #cc0000;
            }

            .timing.slot-booked {
                background-color: #ffff00; /* Màu vàng cho Booked (Đã được đặt bởi Mentee) */
                color: #333;
                border: 2px solid #cccc00;
            }

            .timing.slot-available {
                background-color: #4CAF50; /* Màu xanh lá cho Available (Còn trống) */
                color: white;
                border: 2px solid #3d8b40;
            }

            .timing.slot-notset {
                background-color: #f0f0f0; /* Màu xám nhạt cho Notset (Không khả dụng) */
                color: #999;
                border: 2px solid #d3d3d3;
                cursor: not-allowed;
                opacity: 0.7;
                pointer-events: none; /* Không cho phép nhấp */
            }

            /* Trạng thái selected */
            .timing.selected {
                border: 2px dashed #007bff; /* Viền nét đứt xanh dương khi chọn */
                /* Không ghi đè màu nền để giữ màu trạng thái */
            }

            .timing.selected::before {
                content: "\f00c"; /* Biểu tượng check */
                font-family: "Font Awesome 5 Free";
                font-size: 12px;
                font-weight: 900;
                position: absolute;
                top: 6px;
                right: 6px;
                color: #007bff; /* Màu xanh dương cho biểu tượng */
            }

            /* Đảm bảo span trong slot hiển thị đồng đều */
            .timing span {
                font-size: 14px;
                display: block;
            }

            /* Responsive */
            @media (max-width: 767.96px) {
                .time-slot ul li {
                    width: 33.33%; /* 3 cột trên mobile */
                }

                .timing {
                    font-size: 12px;
                    padding: 8px 10px;
                }

                .timing span {
                    font-size: 12px;
                }

                .timing.selected::before {
                    font-size: 10px;
                    top: 4px;
                    right: 4px;
                }
            }

            @media (max-width: 991.96px) {
                .time-slot ul li {
                    width: 20%; /* 5 cột trên tablet */
                }
            }
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
            /* Style cơ bản cho tất cả các slot */

            .dropdown-item.active {
                background-color: #007bff;
                color: white;
            }

            /* Sửa lỗi cú pháp cho date picker */
            .date-container input[type="date"]::-webkit-calendar-picker-indicator {
                width: 40px;
                height: 40px;
                padding: 0;
            }

            /* Style cho mentor-course-info */
            .mentor-course-info .card {
                border: 1px solid #e6e8ee;
                border-radius: 8px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            .mentor-course-info .card-header {
                background-color: #f8f9fa;
                border-bottom: 1px solid #e6e8ee;
                padding: 10px 20px;
            }
            .mentor-course-info .card-title {
                margin: 0;
                font-size: 20px;
                font-weight: 600;
                color: #333;
            }
            .mentor-course-info .card-body {
                padding: 20px;
            }
            .mentor-course-info img {
                object-fit: cover;
            }
            .mentor-course-info h5 {
                font-size: 18px;
                margin-bottom: 10px;
                color: #007bff;
            }
            .mentor-course-info p {
                margin: 5px 0;
                font-size: 14px;
                color: #757575;
            }

            @media (max-width: 767.96px) {
                .mentor-course-info .col-md-6 {
                    margin-bottom: 20px;
                }
            }



            .yellow {
                background-color: #ffff99; /* Màu vàng nhạt */
                border: 1px solid #ffcc00; /* Viền vàng đậm */
            }

            .red {
                background-color: #ff9999; /* Màu đỏ nhạt */
                border: 1px solid #ff0000; /* Viền đỏ đậm */
            }

            .green {
                background-color: #99ff99; /* Màu xanh nhạt */
                border: 1px solid #00cc00; /* Viền xanh đậm */
            }

            .slot-notset {
                background-color: #cccccc; /* Màu xám cho slot không được set */
                border: 1px solid #999999;
            }
            /* Custom Modal Styles */
            .custom-modal {
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5); /* Nền mờ */
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .custom-modal-content {
                background-color: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                width: 90%;
                max-width: 400px;
                text-align: center;
            }

            .custom-modal-content p {
                margin: 0 0 15px;
                font-size: 16px;
                color: #333;
            }

            .modal-btn {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 8px 20px;
                font-size: 14px;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .modal-btn:hover {
                background-color: #0056b3;
            }
            /* Repeat Booking Section */
            #repeatBooking {
                margin-right: 5px;
            }

            #repeatOptions {
                background-color: #f8f9fa;
                padding: 15px;
                border-radius: 5px;
                border: 1px solid #e6e8ee;
                margin-top: 10px;
            }

            #repeatOptions label {
                font-weight: bold;
                color: #333;
                display: block;
                margin-bottom: 5px;
            }

            /* Repeat Mode Options */
            .repeat-mode-options {
                display: flex;
                gap: 20px;
                margin-bottom: 10px;
            }

            .repeat-mode-options input[type="radio"] {
                margin-right: 5px;
            }

            .repeat-mode-options label {
                font-weight: normal;
                margin-bottom: 0;
            }

            /* Repeat Option Blocks */
            .repeat-option {
                margin-top: 10px;
            }

            .repeat-option label {
                display: inline-block;
                margin-right: 10px;
            }

            .repeat-option .form-select,
            .repeat-option .form-input {
                display: inline-block;
                width: auto;
                padding: 6px 12px;
                border: 1px solid #ced4da;
                border-radius: 4px;
                font-size: 14px;
                vertical-align: middle;
            }

            .repeat-option .form-select:focus,
            .repeat-option .form-input:focus {
                border-color: #80bdff;
                outline: 0;
                box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
            }

            .repeat-option .form-input {
                width: 80px; /* Giới hạn chiều rộng cho input number */
            }

            /* Buttons */
            .btn {
                padding: 8px 15px;
                font-size: 14px;
                border-radius: 5px;
                border: none;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .btn-primary {
                background-color: #007bff;
                color: white;
            }

            .btn-primary:hover {
                background-color: #0056b3;
            }

            .btn-danger {
                background-color: #dc3545;
                color: white;
            }

            .btn-danger:hover {
                background-color: #c82333;
            }

            /* Responsive */
            @media (max-width: 767.96px) {
                .repeat-mode-options {
                    flex-direction: column;
                    gap: 10px;
                }

                .repeat-option .form-select,
                .repeat-option .form-input {
                    width: 100%;
                }

                .btn {
                    width: 100%;
                    margin-top: 5px;
                }
            }

            .delete-btn {
                background-color: #ff4444;
                color: white;
                border: none;
                padding: 5px 10px;
                cursor: pointer;
            }
            .delete-btn:hover {
                background-color: #cc0000;
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
                notification.classList.add("show");

                setTimeout(() => {
                    notification.classList.remove("show");
                }, 3000);
            }

            document.addEventListener("DOMContentLoaded", function () {
                const endDateInput = document.getElementById("end-date");

                // Chỉ kiểm tra endDate so với startDate (nếu có) và ngày hiện tại
                endDateInput.addEventListener("change", function () {
                    const today = new Date();
                    today.setHours(0, 0, 0, 0);
                    const endDate = new Date(this.value);

                    if (endDate < today) {
                        showNotification("End Date cannot be in the past!");
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
        <!-- Custom Modal for Notifications -->
        <div id="customModal" class="custom-modal" style="display: none;">
            <div class="custom-modal-content">
                <p id="customModalMessage"></p>
                <button id="closeModalBtn" class="modal-btn">OK</button>
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
                    <!-- Mentor and Course Info Section -->
                    <div class="mentor-course-info mb-4">
                        <div class="row">
                            <!-- Course Info (Left Side) -->
                            <div>
                                <div>
                                    <div class="card-header">
                                        <h4 class="card-title">Course Information</h4>
                                    </div>
                                    <div class="card-body">
                                        <div class="d-flex align-items-center">
                                            <img src="${requestScope.course.image}" alt="Course Image" class="img-fluid rounded me-3" style="max-width: 100px; max-height: 100px;">
                                            <div>
                                                <h5>${requestScope.course.title}</h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Mentor Info (Right Side) -->
                            <div>
                                <div>
                                    <div class="card-header">
                                        <h4 class="card-title">Mentor Information</h4>
                                    </div>
                                    <div class="card-body">
                                        <div class="d-flex align-items-center">
                                            <img src="${requestScope.mentorrequest.image}" alt="Mentor Image" class="img-fluid rounded me-3" style="max-width: 100px; max-height: 100px;">
                                            <div>
                                                <h5>${requestScope.mentorrequest.name}</h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- End Mentor and Course Info Section -->

                    <div class="row">
                        <div class="col-12">
                            <form id="bookingForm" action="/../HAPPYorSAD/test" method="post">
                                <input type="hidden" name="mentorId" value="${requestScope.mentorId}">
                                <input type="hidden" name="courseId" value="${requestScope.courseId}">
                                <input type="hidden" name="price" value="${requestScope.price}">
                                <c:if test="${not empty requestScope.requestId}">
                                    <input type="hidden" name="requestId" value="${requestScope.requestId}">
                                </c:if>
                                <input type="hidden" id="currentWeekOffset" value="0">

                                <div class="title-container">
                                    <label for="request-title">Title:</label>
                                    <input type="text" id="request-title" name="title" <c:if test="${requestScope.title != null}">value="${requestScope.title}"</c:if> required>
                                    </div>

                                    <div class="content-container">
                                        <label for="request-content">Content:</label>
                                        <textarea id="request-content" name="content" required><c:if test="${not empty requestScope.content}">${requestScope.content}</c:if></textarea>
                                    </div>
                                    <div class="date-container">
                                        <div>
                                            <label for="end-date">Expected Confirmation Deadline:</label>
                                            <input type="date" id="end-date" name="enddate" value="${requestScope.enddate}" required>
                                    </div>
                                </div>
                        </div>

                        <div class="row">
                            <div class="col-12 col-sm-4 col-md-6">
                                <h4 class="mb-1">
                                    <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd MMMM yyyy"/>
                                </h4>
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
                                                                <!-- Repeat 5 times for slots 1 to 5 -->
                                                                <c:forEach var="slotNumber" begin="1" end="5">
                                                                    <div class="slot-row">
                                                                        <c:set var="slotKey" value="${entry.key}_${slotNumber}" />
                                                                        <c:set var="slotFound" value="false" />
                                                                        <c:forEach var="slot" items="${slotsByDay[entry.key]}">
                                                                            <c:if test="${slot.slotNumber == slotNumber}">
                                                                                <c:set var="mentorStatus" value="${slot.status}" />
                                                                                <c:set var="menteeStatus" value="${slotStatusMap[slotKey]}" />
                                                                                <c:set var="isSelectable" value="${mentorStatus == 'Available' && (menteeStatus == null || menteeStatus == 'Available')}" />
                                                                                <a href="#" 
                                                                                   class="timing
                                                                                   ${menteeStatus == 'Studying' && mentorStatus == 'Studying' ? 'red' : ''}
                                                                                   ${menteeStatus == 'Duplicated' && mentorStatus == 'Available' ? 'yellow' : ''}
                                                                                   ${mentorStatus == 'Available' && (menteeStatus == null || menteeStatus == 'Available') ? 'green' : ''}"
                                                                                   data-slot-info="${entry.key}_${slot.slotNumber}"
                                                                                   data-selectable="${isSelectable}"
                                                                                   data-bs-toggle="tooltip" 
                                                                                   data-bs-title="Start: ${slot.startTime} | End: ${slot.endTime} | Mentor Status: ${mentorStatus} | Your Slot Status: ${menteeStatus != null ? menteeStatus : 'Not Booked'}">
                                                                                    <span>Slot ${slotNumber}</span>
                                                                                </a>
                                                                                <c:set var="slotFound" value="true" />
                                                                            </c:if>
                                                                        </c:forEach>
                                                                        <c:if test="${not slotFound}">
                                                                            <a href="#" 
                                                                               class="timing slot-notset"
                                                                               data-slot-info="${entry.key}_${slotNumber}" 
                                                                               data-selectable="false"
                                                                               data-bs-toggle="tooltip" 
                                                                               data-bs-title="Date: ${entry.key} | Start: ${slotTimeMap[slotNumber].split('-')[0]} | End: ${slotTimeMap[slotNumber].split('-')[1]} | Status: Unavailable">
                                                                                <span>Slot ${slotNumber}</span>
                                                                            </a>
                                                                        </c:if>
                                                                    </div>
                                                                </c:forEach>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="slot-row">
                                                                    <c:forEach var="slotNumber" begin="1" end="5">
                                                                        <a href="#" 
                                                                           class="timing slot-notset"
                                                                           data-slot-info="${entry.key}_${slotNumber}" 
                                                                           data-bs-toggle="tooltip" 
                                                                           data-bs-title="Date: ${entry.key} | Start: ${slotTimeMap[slotNumber].split('-')[0]} | End: ${slotTimeMap[slotNumber].split('-')[1]} | Status: Unavailable">
                                                                            <span>Slot ${slotNumber}</span>
                                                                        </a>
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
                                            <label>Repeat Mode:</label>
                                            <div class="repeat-mode-options">
                                                <input type="radio" id="repeatByWeeks" name="repeatMode" value="weeks" checked>
                                                <label for="repeatByWeeks">By Weeks</label>
                                                <input type="radio" id="repeatBySlots" name="repeatMode" value="slots">
                                                <label for="repeatBySlots">By Number of Slots</label>
                                            </div>
                                            <div id="weeksOption" class="repeat-option">
                                                <label for="repeatWeeks">Number of Weeks (max 4):</label>
                                                <select id="repeatWeeks" class="form-select">
                                                    <option value="1">+ 1 week</option>
                                                    <option value="2">+ 2 weeks</option>
                                                    <option value="3">+ 3 weeks</option>
                                                    <option value="4">+ 4 weeks</option>
                                                </select>
                                            </div>
                                            <div id="slotsOption" class="repeat-option" style="display: none;">
                                                <label for="maxSlots">Maximum Number of Slots:</label>
                                                <input type="number" id="maxSlots" class="form-input" min="1" max="20" value="5">
                                            </div>
                                        </div>
                                        <button id="bookSlots" type="button" class="btn btn-primary">Book Selected Slots</button>
                                        <button type="button" id="clearAllBtn" class="btn btn-danger clear-btn">Clear</button>
                                    </div>
                                </div>
                            </div>
                            <!-- /Schedule Content -->

                            <div class="legend">
                                <h5>Legend:</h5>
                                <table class="legend-table">
                                    <tr>
                                        <td><span class="timing red"></span></td>
                                        <td>This slot has been booked</td>
                                    </tr>
                                    <tr>
                                        <td><span class="timing yellow"></span></td>
                                        <td>This slot conflicts with another your subject’s slot</td>
                                    </tr>
                                    <tr>
                                        <td><span class="timing green"></span></td>
                                        <td>Available to book</td>
                                    </tr>
                                </table>
                            </div>

                            <!-- Schedule for selected slots -->
                            <div id="bookedSchedule">

                                <div id="savedSchedule" style="margin-top: 20px;">
                                    <h3>Saved Schedule</h3>
                                    <table class="schedule-table">
                                        <tbody id="savedSlotsContainer">
                                            <tr><td colspan="7">Loading schedule...</td></tr>
                                        </tbody>
                                    </table>
                                    <h3>Selected Schedule</h3>
                                    <table class="schedule-table">
                                        <thead>
                                            <tr>
                                                <th>Day</th>
                                                <th>Date</th>
                                                <th>Month</th>
                                                <th>Year</th>
                                                <th>Slot</th>
                                                <th>Time</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody id="bookedSlotsContainer">
                                            <!-- Empty initially, updated dynamically by JavaScript -->
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
                <input type="hidden" name="weekOffset" id="weekOffset" value="${weekOffset}">
                <input type="hidden" name="service" id="hiddenService">
                <!-- Thêm các trường mới -->
                <input type="hidden" name="title" value="${requestScope.title}">
                <input type="hidden" name="content" value="${requestScope.content}">
                <input type="hidden" name="startdate" value="<%= java.time.LocalDate.now().toString() %>">
                <input type="hidden" name="enddate" value="${requestScope.enddate}">
                <c:if test="${not empty requestScope.requestId}">
                    <input type="hidden" name="pricee" id="hiddenPrice" value="${requestScope.pricee}">
                </c:if>

                <c:if test="${not empty requestScope.requestId}">
                    <input type="hidden" name="requestId" id="hiddenRequestId" value="${requestScope.requestId}">
                </c:if>

            </form>

            <span id="selectedMonth" style="display:none;">${currentMonth} ${currentYear}</span>

            <script type="text/javascript">
                function changeWeek(offsetChange) {
                    console.log('Changing week with offset:', offsetChange);
                    let currentOffset = parseInt(document.getElementById("weekOffset").value) || 0;
                    let newOffset = currentOffset + offsetChange;

                    const selectedMonthElement = document.getElementById("selectedMonth");
                    const selectedMonth = selectedMonthElement.textContent.trim();
                    const parts = selectedMonth.split(" ");
                    if (parts.length !== 2) {
                        console.error('Invalid month format. Expected format: "Month Year" (e.g., "March 2025")');
                        return;
                    }
                    const month = parts[0];
                    const year = parts[1];

                    try {
                        document.getElementById("hiddenMentorId").value = document.querySelector("input[name='mentorId']")?.value || "";
                        document.getElementById("hiddenCourseId").value = document.querySelector("input[name='courseId']")?.value || "";


                        console.log("Price from input[name='price']: ", document.querySelector("input[name='price']")?.value);
                        document.getElementById("hiddenPrice").value = document.querySelector("input[name='price']")?.value || "";


                        document.getElementById("hiddenYear").value = year;
                        document.getElementById("hiddenMonth").value = month;
                        document.getElementById("weekOffset").value = newOffset;

// Giữ nguyên service từ URL hiện tại
                        const urlParams = new URLSearchParams(window.location.search);
                        const service = urlParams.get('service');
                        if (service) {
                            document.getElementById("hiddenService").value = service;
                        }

                        console.log('Submitting form with offset:', newOffset);
                        document.getElementById("hiddenForm").submit();
                    } catch (error) {
                        console.error('Error while submitting form:', error);
                    }
                }
            </script>

            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const urlParams = new URLSearchParams(window.location.search);
                    const requestId = urlParams.get('requestId');
                    const menteeId = '<%= session.getAttribute("menteeId") != null ? session.getAttribute("menteeId") : "0" %>'; // Lấy từ session, đảm bảo là số     
                    const scheduleTable = document.getElementById('savedSlotsContainer');

                    if (requestId) {
                        fetch('FetchSlotsForRequest?requestId=' + requestId + '&menteeId=' + menteeId + '&format=main')
                                .then(response => {
                                    if (!response.ok)
                                        throw new Error('Network response was not ok: ' + response.status);
                                    return response.text();
                                })
                                .then(data => scheduleTable.innerHTML = data)
                                .catch(error => {
                                    console.error('Error loading schedule:', error);
                                    scheduleTable.innerHTML = '<tr><td colspan="7">Failed to load schedule. Please try again later.</td></tr>';
                                });
                    } else {
                        console.error('No requestId found in URL');
                        scheduleTable.innerHTML = '<tr><td colspan="7">No request ID provided</td></tr>';
                    }
                });

                function deleteSlot(slotId) {
                    if (confirm('Bạn có chắc muốn xóa slot này?')) {
                        fetch('FetchSlotsForRequest?slotId=' + slotId, {
                            method: 'DELETE'
                        })
                                .then(response => {
                                    if (!response.ok)
                                        throw new Error('Failed to delete');
                                    return response.text();
                                })
                                .then(data => {
                                    alert(data); // Hiển thị thông báo từ server
                                    location.reload(); // Tải lại trang sau khi xóa
                                })
                                .catch(error => {
                                    console.error('Error deleting slot:', error);
                                    alert('Xóa slot thất bại!');
                                });
                    }
                }
            </script>

            <script>
                function showNotification(message) {
                    const modal = document.getElementById("customModal");
                    const modalMessage = document.getElementById("customModalMessage");
                    const closeBtn = document.getElementById("closeModalBtn");

                    modalMessage.textContent = message;
                    modal.style.display = "flex";

                    closeBtn.onclick = function () {
                        modal.style.display = "none";
                    };

                    modal.onclick = function (event) {
                        if (event.target === modal) {
                            modal.style.display = "none";
                        }
                    };
                }

                const eventHandlersAttached = {
                    submitBtn: false,
                    bookSlotsBtn: false,
                    clearAllBtn: false,
                    timeSlots: false,
                    saveBtn: false
                };

                document.addEventListener("DOMContentLoaded", function () {
                    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
                    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                        return new bootstrap.Tooltip(tooltipTriggerEl);
                    });

                    const timeSlots = document.querySelectorAll(".timing");
                    const priceDisplay = document.querySelector(".price-amount");
                    const pricePerSlot = ${requestScope.price};
                    const walletBalance = ${sessionScope.walletBalance};
                    const totalSlotsInput = document.getElementById("totalSlots");
                    const submitBtn = document.querySelector(".submit-bbb");
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
                    const endDate = document.getElementById("end-date");
                    const clearAllBtn = document.getElementById("clearAllBtn");
                    const bookingForm = document.getElementById("bookingForm");

                    let slotRepeatMap = new Map();
                    let totalPrice = 0;
                    let totalSlots = 0;
                    let selectedSlots = new Set();
                    let tempSlotBooked = new Set((sessionStorage.getItem("tempSlotBooked") || "").split(",").filter(slot => slot.trim() !== ""));
                    let isBookProcessing = false;
                    let isSubmitProcessing = false;
                    let isSaveProcessing = false;
                    let isClearProcessing = false;

                    function restoreFormData() {
                        const savedTitle = sessionStorage.getItem("requestTitle");
                        const savedContent = sessionStorage.getItem("requestContent");
                        const savedEndDate = sessionStorage.getItem("endDate");

                        if (savedTitle)
                            requestTitle.value = savedTitle;
                        if (savedContent)
                            requestContent.value = savedContent;
                        if (savedEndDate)
                            endDate.value = savedEndDate;
                    }

                    function saveFormData() {
                        sessionStorage.setItem("requestTitle", requestTitle.value);
                        sessionStorage.setItem("requestContent", requestContent.value);
                        sessionStorage.setItem("endDate", endDate.value);
                        sessionStorage.setItem("tempSlotBooked", Array.from(tempSlotBooked).join(","));
                    }

                    function clearFormData() {
                        sessionStorage.removeItem("requestTitle");
                        sessionStorage.removeItem("requestContent");
                        sessionStorage.removeItem("endDate");
                        sessionStorage.removeItem("tempSlotBooked");
                    }

                    function updateBookedSchedule() {
                        bookedSlotsContainer.innerHTML = "";
                        tempSlotBooked.forEach(slot => {
                            var slotTimeMap = {
                                1: "7:30-09:30",
                                2: "10:00-12:00",
                                3: "13:00-15:00",
                                4: "15:30-17:30",
                                5: "19:30-21:30"
                            };
                            let [dateStr, slotNumber] = slot.split("_");
                            let date = new Date(dateStr);
                            let dayOfWeek = date.toLocaleString("en-US", {weekday: "long"});
                            let day = date.getDate();
                            let month = date.toLocaleString("en-US", {month: "long"});
                            let year = date.getFullYear();
                            let slotTime = slotTimeMap[slotNumber] || "Unknown Time";

                            let tr = document.createElement("tr");
                            let tdDayOfWeek = document.createElement("td");
                            let tdDay = document.createElement("td");
                            let tdMonth = document.createElement("td");
                            let tdYear = document.createElement("td");
                            let tdSlot = document.createElement("td");
                            let tdSlotTime = document.createElement("td");
                            let tdStatus = document.createElement("td");

                            tdDayOfWeek.textContent = dayOfWeek;
                            tdDay.textContent = day;
                            tdMonth.textContent = month;
                            tdYear.textContent = year;
                            tdSlot.textContent = "Slot " + slotNumber;
                            tdSlotTime.textContent = slotTime;
                            tdStatus.textContent = "Selected";

                            tr.appendChild(tdDayOfWeek);
                            tr.appendChild(tdDay);
                            tr.appendChild(tdMonth);
                            tr.appendChild(tdYear);
                            tr.appendChild(tdSlot);
                            tr.appendChild(tdSlotTime);
                            tr.appendChild(tdStatus);

                            bookedSlotsContainer.appendChild(tr);
                        });
                    }

                    function updateUI() {
                        priceDisplay.textContent = totalPrice;
                        totalSlotsInput.value = totalSlots;
                        document.getElementById("totalPriceInput").value = totalPrice;

                        if (totalPrice > walletBalance) {
                            showNotification("Insufficient wallet balance to book more slots!");
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
                        updateBookedSchedule();
                    }

                    function generateRepeatedSlots(slot, mode, weeks, maxSlots) {
                        let repeatedSlots = new Set();
                        let [dateStr, slotNumber] = slot.split("_");
                        let slotDate = new Date(dateStr);
                        let currentDate = new Date(slotDate);
                        let slotCount = 1;

                        repeatedSlots.add(slot);
                        let repeatedSlotsArray = [];

                        if (mode === "weeks" && repeatCheckbox.checked) {
                            for (let week = 1; week <= weeks; week++) {
                                currentDate.setDate(currentDate.getDate() + 7);
                                let newSlot = currentDate.toISOString().split('T')[0] + "_" + slotNumber;
                                repeatedSlots.add(newSlot);
                                repeatedSlotsArray.push(newSlot);
                                slotCount++;
                            }
                        } else if (mode === "slots" && repeatCheckbox.checked && slotCount < maxSlots) {
                            while (slotCount < maxSlots) {
                                currentDate.setDate(currentDate.getDate() + 7);
                                let newSlot = currentDate.toISOString().split('T')[0] + "_" + slotNumber;
                                repeatedSlots.add(newSlot);
                                repeatedSlotsArray.push(newSlot);
                                slotCount++;
                            }
                        }
                        if (repeatedSlotsArray.length > 0) {
                            slotRepeatMap.set(slot, repeatedSlotsArray);
                        }
                        return Array.from(repeatedSlots);
                    }

                    repeatCheckbox.addEventListener("change", function () {
                        repeatOptions.style.display = this.checked ? "block" : "none";
                    });

                    repeatByWeeks.addEventListener("change", function () {
                        if (this.checked) {
                            weeksOption.style.display = "block";
                            slotsOption.style.display = "none";
                        }
                    });

                    repeatBySlots.addEventListener("change", function () {
                        if (this.checked) {
                            weeksOption.style.display = "none";
                            slotsOption.style.display = "block";
                        }
                    });

                    [requestTitle, requestContent, endDate].forEach(input => {
                        input.addEventListener("input", saveFormData);
                    });

                    if (!eventHandlersAttached.timeSlots) {
                        timeSlots.forEach(slot => {
                            slot.addEventListener("click", function (event) {
                                event.preventDefault();
                                let slotInfo = this.dataset.slotInfo;
                                let isSelectable = this.dataset.selectable === "true";

                                if (!isSelectable) {
                                    if (this.classList.contains("yellow")) {
                                        showNotification("Your study schedule conflicts with this slot, please choose another slot.");
                                    } else if (this.classList.contains("red")) {
                                        showNotification("This slot has already been booked, please choose another slot.");
                                    } else {
                                        showNotification("Only green (Available) slots can be selected!");
                                    }
                                    return;
                                }

                                if (tempSlotBooked.has(slotInfo)) {
                                    tempSlotBooked.delete(slotInfo);
                                    this.classList.remove("selected");
                                    if (slotRepeatMap.has(slotInfo)) {
                                        slotRepeatMap.get(slotInfo).forEach(repeatedSlot => tempSlotBooked.delete(repeatedSlot));
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
                                            let repeatedSlotElement = document.querySelector(`.timing[data-slot-info="${s}"]`);
                                            if (repeatedSlotElement && repeatedSlotElement.dataset.selectable === "true") {
                                                tempSlotBooked.add(s);
                                                repeatedSlotElement.classList.add("selected");
                                            } else if (repeatedSlotElement) {
                                                if (repeatedSlotElement.classList.contains("yellow")) {
                                                    showNotification("Your study schedule conflicts with repeated slot " + s + ", please adjust your selection.");
                                                } else if (repeatedSlotElement.classList.contains("red")) {
                                                    showNotification("Repeated slot " + s + " has already been booked, please adjust your selection.");
                                                }
                                            }
                                        });
                                    }
                                }
                                saveFormData();
                                totalSlots = tempSlotBooked.size;
                                totalPrice = totalSlots * pricePerSlot;
                                updateTempSlotUI();
                            });
                        });
                        eventHandlersAttached.timeSlots = true;
                    }

                    if (!eventHandlersAttached.bookSlotsBtn && bookSlotsBtn) {
                        console.log("Attaching handler for bookSlotsBtn at " + new Date().toISOString());
                        bookSlotsBtn.addEventListener("click", function (event) {
                            event.preventDefault();
                            console.log("Book Slots clicked - Handler triggered at " + new Date().toISOString());

                            if (isBookProcessing) {
                                console.log("Book processing, skipping...");
                                return;
                            }
                            isBookProcessing = true;
                            bookSlotsBtn.disabled = true;
                            bookSlotsBtn.classList.add("disabled");

                            if (tempSlotBooked.size === 0) {
                                showNotification("Please select at least one slot!");
                                isBookProcessing = false;
                                bookSlotsBtn.disabled = false;
                                bookSlotsBtn.classList.remove("disabled");
                                return;
                            }

                            let formData = new FormData();
                            formData.append("submissionId", Date.now() + "_" + Math.random().toString(36).substr(2, 9));
                            tempSlotBooked.forEach(slot => formData.append("tempSlotBooked", slot));
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
                                        if (!data.includes("error")) {
                                            updateTempSlotUI();
                                            showNotification(`Successfully booked ${tempSlotBooked.size} slots!`);
                                        }
                                    })
                                    .catch(error => {
                                        console.error("Error during booking:", error);
                                        showNotification("Error during booking: " + error.message);
                                    })
                                    .finally(() => {
                                        isBookProcessing = false;
                                        bookSlotsBtn.disabled = false;
                                        bookSlotsBtn.classList.remove("disabled");
                                        console.log("Book processing completed");
                                    });

                            saveFormData();
                        });
                        eventHandlersAttached.bookSlotsBtn = true;
                    }

                    if (!eventHandlersAttached.clearAllBtn && clearAllBtn) {
                        console.log("Attaching handler for clearAllBtn at " + new Date().toISOString());
                        clearAllBtn.addEventListener("click", function (event) {
                            event.preventDefault();
                            console.log("Clear clicked - Handler triggered at " + new Date().toISOString());

                            if (isClearProcessing) {
                                console.log("Clear processing, skipping...");
                                return;
                            }
                            isClearProcessing = true;
                            clearAllBtn.disabled = true;
                            clearAllBtn.classList.add("disabled");

                            tempSlotBooked.clear();
                            slotRepeatMap.clear();
                            sessionStorage.removeItem("tempSlotBooked");
                            timeSlots.forEach(slot => slot.classList.remove("selected"));
                            if (bookedSlotsContainer)
                                bookedSlotsContainer.innerHTML = "";
                            totalSlots = 0;
                            totalPrice = 0;
                            updateUI();

                            fetch("/HAPPYorSAD/test?action=clear", {
                                method: "POST",
                                credentials: "same-origin"
                            })
                                    .then(response => {
                                        if (!response.ok)
                                            throw new Error("Network response was not ok " + response.status);
                                        return response.text();
                                    })
                                    .then(data => {
                                        console.log("Clear response:", data);
                                    })
                                    .catch(error => {
                                        console.error("Error during clearing:", error);
                                        showNotification("Error clearing slots: " + error.message);
                                    })
                                    .finally(() => {
                                        isClearProcessing = false;
                                        clearAllBtn.disabled = false;
                                        clearAllBtn.classList.remove("disabled");
                                        console.log("Clear processing completed");
                                    });
                        });
                        eventHandlersAttached.clearAllBtn = true;
                    }

                    if (!eventHandlersAttached.submitBtn && submitBtn) {
                        submitBtn.addEventListener("click", function (event) {
                            event.preventDefault();
                            console.log("Submit clicked - Handler triggered at " + new Date().toISOString());

                            if (isSubmitProcessing) {
                                console.log("Submit processing, skipping...");
                                return;
                            }
                            isSubmitProcessing = true;
                            submitBtn.disabled = true;
                            submitBtn.classList.add("disabled");

                            if (bookingForm.checkValidity()) {
                                if (tempSlotBooked.size === 0) {
                                    showNotification("Please select at least one slot before submitting!");
                                    isSubmitProcessing = false;
                                    submitBtn.disabled = false;
                                    submitBtn.classList.remove("disabled");
                                    return;
                                }

                                document.getElementById("serviceInput").value = "submit";
                                document.getElementById("totalPriceInput").value = totalPrice;

                                let formData = new FormData(bookingForm);
                                formData.append("submissionId", Date.now() + "_" + Math.random().toString(36).substr(2, 9));
                                tempSlotBooked.forEach(slot => formData.append("tempSlotBooked", slot));
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
                                            if (data.includes("successfully")) {
                                                clearFormData();
                                                tempSlotBooked.clear();
                                                slotRepeatMap.clear();
                                                updateTempSlotUI();
                                                bookedSlotsContainer.innerHTML = "";
                                                totalSlots = 0;
                                                totalPrice = 0;
                                                updateUI();
                                                showNotification("Request created successfully!");
                                                window.location.href = "/HAPPYorSAD/ShowMenteeRequest";
                                            }
                                        })
                                        .catch(error => {
                                            console.error("Error during submission:", error);
                                            showNotification("Error during submission: " + error.message);
                                        })
                                        .finally(() => {
                                            isSubmitProcessing = false;
                                            submitBtn.disabled = false;
                                            submitBtn.classList.remove("disabled");
                                            console.log("Submit processing completed");
                                        });
                            } else {
                                showNotification("Please fill in all required fields.");
                                isSubmitProcessing = false;
                                submitBtn.disabled = false;
                                submitBtn.classList.remove("disabled");
                            }
                        });
                        eventHandlersAttached.submitBtn = true;
                    }

                    if (!eventHandlersAttached.saveBtn && saveBtn) {
                        console.log("Attaching handler for saveBtn at " + new Date().toISOString());
                        saveBtn.addEventListener("click", function (event) {
                            event.preventDefault();
                            console.log("Save clicked - Handler triggered at " + new Date().toISOString());

                            if (isSaveProcessing) {
                                console.log("Save processing, skipping...");
                                return;
                            }
                            isSaveProcessing = true;
                            saveBtn.disabled = true;
                            saveBtn.classList.add("disabled");

                            if (bookingForm.checkValidity()) {
                                if (tempSlotBooked.size === 0) {
                                    showNotification("Please select at least one slot before saving!");
                                    isSaveProcessing = false;
                                    saveBtn.disabled = false;
                                    saveBtn.classList.remove("disabled");
                                    return;
                                }

                                document.getElementById("serviceInput").value = "save";
                                document.getElementById("totalPriceInput").value = totalPrice;

                                let formData = new FormData(bookingForm);
                                formData.append("submissionId", Date.now() + "_" + Math.random().toString(36).substr(2, 9));
                                tempSlotBooked.forEach(slot => formData.append("tempSlotBooked", slot));
                                console.log("Sending FormData for Save:", Array.from(formData.entries()));

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
                                            console.log("Raw response from Save:", data);
                                            if (data.includes("ShowMenteeRequest")) {
                                                clearFormData();
                                                tempSlotBooked.clear();
                                                slotRepeatMap.clear();
                                                updateTempSlotUI();
                                                bookedSlotsContainer.innerHTML = "";
                                                totalSlots = 0;
                                                totalPrice = 0;
                                                updateUI();
                                                showNotification("Request saved successfully!");
                                                window.location.href = "/HAPPYorSAD/ShowMenteeRequest";
                                            } else {
                                                showNotification("Failed to save request. Please try again.");
                                            }
                                        })
                                        .catch(error => {
                                            console.error("Error during saving:", error);
                                            showNotification("Error during saving: " + error.message);
                                        })
                                        .finally(() => {
                                            isSaveProcessing = false;
                                            saveBtn.disabled = false;
                                            saveBtn.classList.remove("disabled");
                                            console.log("Save processing completed");
                                        });
                            } else {
                                showNotification("Please fill in all required fields.");
                                isSaveProcessing = false;
                                saveBtn.disabled = false;
                                saveBtn.classList.remove("disabled");
                            }
                        });
                        eventHandlersAttached.saveBtn = true;
                    }

                    monthItems.forEach(item => {
                        item.addEventListener("click", function (event) {
                            event.preventDefault();

                            const selectedMonth = this.getAttribute("data-month");
                            document.getElementById("selectedMonth").textContent = selectedMonth;
                            localStorage.setItem("selectedMonth", selectedMonth);

                            const parts = selectedMonth.split(" ");
                            if (parts.length === 2) {
                                const year = parts[1];
                                const month = parts[0];
                                document.getElementById("hiddenMentorId").value = document.querySelector("input[name='mentorId']").value;
                                document.getElementById("hiddenCourseId").value = document.querySelector("input[name='courseId']").value;
                                document.getElementById("hiddenPrice").value = document.querySelector("input[name='price']").value;
                                document.getElementById("hiddenYear").value = year;
                                document.getElementById("hiddenMonth").value = month;
                                document.getElementById("weekOffset").value = 0; // Reset weekOffset khi chọn tháng mới
                                const urlParams = new URLSearchParams(window.location.search);
                                const service = urlParams.get('service');
                                if (service) {
                                    document.getElementById("hiddenService").value = service;
                                }
                                document.getElementById("hiddenForm").submit();
                            }
                        });
                    });

                    window.addEventListener("load", function () {
                        const savedMonth = localStorage.getItem("selectedMonth");
                        const currentDate = new Date();
                        const currentMonth = currentDate.toLocaleString("en-US", {month: "long"});
                        const currentYear = currentDate.getFullYear();
                        const defaultMonth = `${currentMonth} ${currentYear}`;

                                    if (savedMonth) {
                                        document.getElementById("selectedMonth").textContent = savedMonth;
                                        monthItems.forEach(item => {
                                            if (item.getAttribute("data-month") === savedMonth) {
                                                item.classList.add("active");
                                            } else {
                                                item.classList.remove("active");
                                            }
                                        });
                                    } else {
                                        document.getElementById("selectedMonth").textContent = defaultMonth;
                                        monthItems.forEach(item => {
                                            if (item.getAttribute("data-month") === defaultMonth) {
                                                item.classList.add("active");
                                            } else {
                                                item.classList.remove("active");
                                            }
                                        });
                                        localStorage.setItem("savedMonth", defaultMonth);
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
        <script data-cfasync="false" src="/HAPPYorSAD/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script>
        <script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js" type="d693b69077856eb34d3f2643-text/javascript"></script>
        <script src="/HAPPYorSAD/assets/js/bootstrap.bundle.min.js" type="d693b69077856eb34d3f2643-text/javascript"></script>
        <script src="/HAPPYorSAD/assets/plugins/select2/js/select2.min.js" type="d693b69077856eb34d3f2643-text/javascript"></script>
        <script src="/HAPPYorSAD/assets/js/ckeditor.js" type="d693b69077856eb34d3f2643-text/javascript"></script>
        <script src="/HAPPYorSAD/assets/plugins/dropzone/dropzone.min.js" type="d693b69077856eb34d3f2643-text/javascript"></script>
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/ResizeSensor.js" type="d693b69077856eb34d3f2643-text/javascript"></script>
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js" type="d693b69077856eb34d3f2643-text/javascript"></script>
        <script src="/HAPPYorSAD/assets/js/script.js" type="d693b69077856eb34d3f2643-text/javascript"></script>
        <script src="/HAPPYorSAD/cdn-cgi/scripts/7d0fa10a/cloudflare-static/rocket-loader.min.js" 
        data-cf-settings="d693b69077856eb34d3f2643-|49" defer></script>
        <script defer src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015" integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ==" data-cf-beacon='{"rayId":"91074a70ad7f06b9","version":"2025.1.0","serverTiming":{"name":{"cfExtPri":true,"cfL4":true,"cfSpeedBrain":true,"cfCacheStatus":true}},"token":"3ca157e612a14eccbb30cf6db6691c29","b":1}' 
        crossorigin="anonymous"></script>
    </body>
</html>