<%-- 
    Document   : slot_list
    Created on : Feb 18, 2025, 5:39:37 PM
    Author     : Ann
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%= session.getAttribute("scheduleId") %>

<fmt:setLocale value="en"/>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Doccure</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Favicon -->
        <link rel="shortcut icon" type="image/x-icon" href="/HAPPYorSAD/assets/img/favicon.svg">
        <link rel="apple-touch-icon" sizes="180x180" href="/HAPPYorSAD/assets/img/apple-touch-icon.png">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap.min.css">

        <!-- FontAwesome CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/all.min.css">

        <!-- Feather CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/feather.css">

        <!-- Icons -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/iconsax.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/boxicons/css/boxicons.min.css">

        <!-- Select2 CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/select2/css/select2.min.css">

        <!-- Bootstrap DateTimePicker -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap-datetimepicker.min.css">

        <!-- Dropzone -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/dropzone/dropzone.min.css">

        <!-- Custom & Main Styles -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/custom.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css">
        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css">

        <!-- Theme Script -->
        <script src="/HAPPYorSAD/assets/js/theme-script.js"></script>

        <!-- Ajax -->
        <script src="/HAPPYorSAD/assets/js/Ajax.js"></script>



        <style>
            .temp-slot-item {
                background: #fffae6;
                border-left: 4px solid #ffc107;
                padding: 5px 10px;
                font-weight: bold;

                .slot-box {
                    width: 100%;
                    min-width: 120px; /* Đảm bảo không quá nhỏ */
                    text-align: center;
                }

                .slot-header {
                    font-size: 16px;
                    font-weight: bold;
                }

                .slot-body {
                    padding: 10px;
                }

                .slot-body table {
                    width: 100%;
                }

                .slot-footer {
                    padding-top: 10px;
                }

                .slot-add {
                    padding-top: 10px;
                }

                .row {
                    display: flex;
                    flex-wrap: nowrap; /* Không cho xuống dòng */
                    overflow-x: auto; /* Cho phép cuộn ngang nếu thiếu chỗ */
                    justify-content: flex-start; /* Xếp các cột từ trái sang phải */
                    width: 100%; /* Đảm bảo container chiếm toàn bộ chiều rộng */
                    white-space: nowrap; /* Ngăn khoảng trắng gây xuống dòng */
                    box-sizing: border-box; /* Đảm bảo padding không vượt quá chiều rộng */
                }

                .col-md {
                    flex: 0 0 calc(14.28% - 10px); /* Điều chỉnh để trừ đi padding tổng cộng */
                    max-width: calc(14.28% - 10px); /* Điều chỉnh max-width tương ứng */
                    min-width: 150px; /* Giữ kích thước tối thiểu */
                    padding: 5px; /* Padding 5px mỗi bên, tổng 10px */
                    box-sizing: border-box; /* Padding nằm trong chiều rộng */
                    margin: 0; /* Đảm bảo không có margin dư thừa */
                }

                .temp-slot-highlight {
                    background-color: rgba(0, 128, 0, 0.1); /* Nền xanh nhạt */
                    border: 1px solid green; /* Viền xanh */
                    padding: 3px 6px;
                    border-radius: 4px;
                    font-weight: bold;
                    color: green;
                }

                .temp-slot-item i {
                    font-size: 12px; /* Icon nhỏ hơn */
                    margin-right: 4px;
                    color: darkgreen;
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
                                            <li class="breadcrumb-item"><a href="index-2.html">Home</a></li>
                                            <li class="breadcrumb-item active" aria-current="page">Available Timings</li>
                                        </ol>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /Breadcrumb -->

                <!-- Page Content -->
                <div class="page-content">
                    <div class="container">
                        <div class="row">



                            <div class="col-xl-3 col-lg-3 theiaStickySidebar">

                                <div class="settings-widget account-settings">
                                    <div class="settings-menu">
                                        <h3>Dashboard</h3>
                                        <ul>
                                            <li class="nav-item">
                                                <a href="/../HAPPYorSAD/ProfileServlet" class="nav-link">
                                                    <i class="bx bxs-tachometer"></i>My Profile
                                                </a>
                                            </li>
                                            <li class="nav-item">
                                                <a href="instructor-enrolled-course.html" class="nav-link">
                                                    <i class="bx bxs-graduation"></i>Enrolled Courses
                                                </a>
                                            </li>
                                            <li class="nav-item active" >
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
                                                <a href="instructor-notifications.html" class="nav-link">
                                                    <i class="bx bxs-bell"></i>Notifications
                                                </a>
                                            </li>

                                        </ul>
                                        <h3>Instructor</h3>
                                        <ul>
                                            <li class="nav-item">
                                                <a href="instructor-course.html" class="nav-link">
                                                    <i class="bx bxs-rocket"></i>My Courses
                                                </a>
                                            </li>
                                            <li class="nav-item">
                                                <a href="instructor-course.html" class="nav-link">
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
                                                <a href="instructor-withdraw.html" class="nav-link">
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
                                                <a href="updatementorprofile?username=${sessionScope.usernameUser}" class="nav-link">
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


                            <div class="col-lg-9 col-xl-9">
                                <div class="dashboard-header">
                                    <h3>Available Timings</h3>
                                </div>

                                <div class="appointment-tabs">
                                    <ul class="nav available-nav">
                                        <li class="nav-item" role="presentation">
                                            <a class="nav-link active" href="#" data-bs-toggle="tab" data-bs-target="#general-availability">General Availability</a>
                                        </li>
<!--                                        <li class="nav-item" role="presentation">
                                            <a class="nav-link" href="#" data-bs-toggle="tab" data-bs-target="#your-schedule">Your Schedule</a>
                                        </li>-->
                                    </ul>
                                </div>

                                <div class="tab-content pt-0 timing-content">
                                
                                    <div class="tab-pane fade show active" id="general-availability">
                                        <div class="card custom-card">
                                            <div class="card-body">
                                                <div class="card-header">
                                                    <h3>Select Available Slots</h3>
                                                </div>
                                                <div class="row">
                                                    <div class="col-12 col-sm-4 col-md-6">
                                                        <span> </span>
                                                        <h4 class="mb-1">
                                                            <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd MMMM yyyy"/>
                                                        </h4>
                                                        <p class="text-muted">
                                                            <fmt:formatDate value="<%= new java.util.Date() %>" pattern="EEEE"/>
                                                        </p>
                                                    </div>
                                                    <div class="col-12 col-sm-8 col-md-6 text-sm-end">
                                                        <li><a class="dropdown-item text-primary" id="addSchedule">+ Add Schedule</a></li>
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

                                                <div class="tab-content pt-0">
                                                    <div class="row">
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
                                                                                                    <span><i></i> Slot ${slot.slotNumber}</span>
                                                                                                    <c:set var="slotFound" value="true" />
                                                                                                </c:if>
                                                                                            </c:forEach>
                                                                                            <c:if test="${not empty sessionScope.tempSlotsByDate[formattedDay]}">
                                                                                                <c:forEach var="temp" items="${sessionScope.tempSlotsByDate[formattedDay]}">
                                                                                                    <c:if test="${temp.slotNumber == i}">
                                                                                                        <span class="temp-slot-item temp-slot-highlight">
                                                                                                            <i class="isax isax-clock"></i> Slot ${temp.slotNumber}
                                                                                                        </span>
                                                                                                        <c:set var="slotFound" value="true" />
                                                                                                    </c:if>
                                                                                                </c:forEach>
                                                                                            </c:if>
                                                                                            <c:if test="${not slotFound}">
                                                                                                <span class="text-muted">Empty</span>
                                                                                                <button type="button" class="btn btn-sm btn-success add-temp-slot" data-date="${formattedDay}" data-slot="${i}">+</button>
                                                                                            </c:if>
                                                                                        </td>
                                                                                    </tr>
                                                                                </c:forEach>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                    <div class="slot-footer mt-3 text-center">
                                                                        <form action="Slot?action=delete" method="post" onsubmit="return confirm('Are you sure you want to delete all slots?');">
                                                                            <input type="hidden" name="formattedDay" value="${formattedDay}"> 
                                                                            <input type="hidden" name="mentorId" value="${mentorId}"> 
                                                                            <input type="hidden" name="scheduleId" value="${scheduleId}"> 
                                                                            <button type="submit" class="del-slot text-danger btn btn-link">Delete All</button>
                                                                        </form>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-btn text-end">
                                                <form action="/HAPPYorSAD/Slot?action=save" method="post">
                                                    <a href="#" class="btn btn-gray" data-bs-toggle="modal" data-bs-dismiss="modal">Cancel</a>
                                                    <c:forEach var="day" items="${formattedWeekDates}">
                                                        <input type="hidden" name="formattedDays" value="${day}">
                                                    </c:forEach>
                                                    <input type="hidden" name="scheduleId" value="${scheduleId}"> 
                                                    <button type="submit" class="btn btn-primary prime-btn">Save Changes</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>

                                                    <!--                                     Your Schedule Tab (Dành cho mentor xem lịch đã xác nhận) 
                                                                                        <div class="tab-pane fade" id="your-schedule">
                                                                                            <div class="card custom-card">
                                                                                                <div class="card-body">
                                                                                                    <div class="card-header">
                                                                                                        <h3>Your Confirmed Schedule</h3>
                                                                                                    </div>
                                                                                                    <div class="row">
                                                                                                        <div class="col-12">
                                                                                                            <h4 class="mb-1">
                                                    <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd MMMM yyyy"/>
                                                </h4>
                                                <p class="text-muted">
                                                    <fmt:formatDate value="<%= new java.util.Date() %>" pattern="EEEE"/>
                                                </p>
                                            </div>
                                        </div>
                                        <div class="row">
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
                                                                    <span><i class="isax isax-clock"></i> Slot ${slot.slotNumber}</span>
                                                                    <c:set var="slotFound" value="true" />
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
                                    </div>-->
                                </div>
                            </div>
                        </div>
                        <!-- /General Availability -->
                    </div>
                </div>
            </div>  
            <form id="tempSlotForm" action="/HAPPYorSAD/Slot?action=add" method="post" style="display: none;">
                <input type="hidden" name="scheduleId" id="scheduleIdInput">
                <input type="hidden" name="slot_date" id="slotDateInput">  <!-- Đổi từ formattedDay thành slot_date -->
                <input type="hidden" name="slotNumber" id="slotNumberInput">
            </form>
            <form id="hiddenForm" action="/HAPPYorSAD/Slot" method="Get">
                <input type="hidden" name="month" id="hiddenMonth">
                <input type="hidden" name="year" id="hiddenYear">
            </form>

            <form id="addScheduleForm" action="/HAPPYorSAD/Slot" method="post" style="display: none;">
                <input type="hidden" name="mentorId" value="${mentorId}">
                <label>Start Date:</label>
                <input type="date" name="startDate" required>
                <label>End Date:</label>
                <input type="date" name="endDate" required>
                <button type="submit">Add</button>
            </form>


            <script>
                document.getElementById("addSchedule").addEventListener("click", function () {
                    document.getElementById("addScheduleForm").style.display = "block";
                });

                document.addEventListener("DOMContentLoaded", function () {
                    const selectedMonthSpan = document.getElementById("selectedMonth");
                    const submitBtn = document.querySelector(".submit-bbb");
                    const saveBtn = document.querySelector(".save-bbb");
                    const monthItems = document.querySelectorAll(".month-item");
                    document.querySelectorAll(".add-temp-slot").forEach(button => {
                        button.addEventListener("click", function () {
                            console.log("👉 Button clicked!"); // Kiểm tra sự kiện click

                            const scheduleId = 3; // Giả sử có sẵn giá trị
                            const slot_date = this.getAttribute("data-date");
                            const slotNumber = this.getAttribute("data-slot");

                            console.log("📌 Retrieved data:");
                            console.log("   ➤ slot_date", slot_date);
                            console.log("   ➤ slotNumber:", slotNumber);
                            console.log("   ➤ scheduleId:", scheduleId);
                            if (!slot_date || !/^\d{4}-\d{2}-\d{2}$/.test(slot_date.trim())) {
                                console.error("❌ Invalid date format:", slot_date);
                                alert("Invalid date format. Please use YYYY-MM-DD.");
                                return;
                            }

                            if (!slot_date || !slotNumber) {
                                console.error("❌ Missing required data!");
                                alert("Missing date or slot number!");
                                return;
                            }


                            // Tạo FormData để gửi
                            const params = new URLSearchParams();
                            params.append("scheduleId", scheduleId);
                            params.append("slot_date", slot_date);
                            params.append("slotNumber", slotNumber);

                            console.log("📤 Sending AJAX request...");

                            // Gửi request bằng fetch API (AJAX)
                            fetch("/HAPPYorSAD/Slot?action=add", {
                                method: "POST",
                                headers: {
                                    "Content-Type": "application/x-www-form-urlencoded"
                                },
                                body: params

                            })
                                    .then(response => response.text()) // Lấy phản hồi dạng text
                                    .then(data => {
                                        console.log("✅ Response received:", data);
                                        console.log("🔍 Params before sending:", params.toString());


                                        // Kiểm tra phản hồi nếu server trả về HTML hoặc text thông báo
                                        if (data.includes("success")) { // Giả sử server trả về "success" nếu thêm thành công
                                            alert("Slot added successfully!");
                                            updateSlotUI(slot_date, slotNumber); // Gọi hàm cập nhật UI
                                        } else {
                                            alert("Failed to add slot: " + data);
                                        }
                                    })
                                    .catch(error => {
                                        console.error("❌ Error sending request:", error);
                                        alert("An error occurred while adding slot.");
                                        console.log("🔍 Params before sending:", params.toString());

                                    });
                        });
                    });
                    function updateSlotUI(slot_date, slotNumber) {
                        console.log("🔄 Updating UI for:", slot_date, slotNumber);

                        // Kiểm tra slotNumber có hợp lệ không
                        if (!slotNumber || isNaN(slotNumber) || slotNumber < 1) {
                            console.error("❌ Invalid slotNumber:", slotNumber);
                            return;
                        }

                        // Tìm tất cả slot-box
                        const slotBoxes = document.querySelectorAll(".slot-box");

                        let slotBox = null;
                        slotBoxes.forEach(box => {
                            const header = box.querySelector(".slot-header h5");
                            if (header && header.textContent.includes(slot_date)) {
                                slotBox = box;
                            }
                        });

                        if (!slotBox) {
                            console.warn(`⚠️ Slot container not found for date: ${slot_date}`);
                            return;
                        }

                        const slotBody = slotBox.querySelector(".slot-body tbody");
                        if (!slotBody) {
                            console.error("🚨 Error: .slot-body not found inside slot-box!");
                            return;
                        }

                        // Tìm tất cả hàng trong bảng
                        const slotRows = slotBody.querySelectorAll("tr");

                        if (slotNumber > slotRows.length) {
                            console.warn(`⚠️ Slot number ${slotNumber} is out of range. Total slots: ${slotRows.length}`);
                            return;
                        }

                        const slotRow = slotRows[slotNumber - 1]; // Truy cập hàng đúng vị trí
                        const slotCell = slotRow.querySelector("td");

                        if (!slotCell) {
                            console.warn("⚠️ Slot cell not found!");
                            return;
                        }

                        // Kiểm tra xem slot đã tồn tại chưa
                        if (slotCell.querySelector(`.temp-slot-item[data-slot="${slotNumber}"]`)) {
                            console.log("✅ Slot already exists, skipping UI update.");
                            return;
                        }

                        // Tạo phần tử hiển thị slot tạm thời
                        const tempSlot = document.createElement("span");
                        tempSlot.classList.add("temp-slot-item", "temp-slot-highlight");
                        tempSlot.setAttribute("data-slot", slotNumber);
                        tempSlot.innerHTML = `<i class="isax isax-clock"></i> Slot ${slotNumber}`;

                        // Thêm slot vào UI trước nút "+"
                        const addButton = slotCell.querySelector("button.add-temp-slot");
                        if (addButton) {
                            slotCell.insertBefore(tempSlot, addButton);
                        } else {
                            slotCell.appendChild(tempSlot);
                        }

                        console.log("✅ UI updated: Added temp slot", slot_date, slotNumber);
                    }


                    // Xử lý chọn tháng

                    monthItems.forEach(item => {
                        item.addEventListener("click", function (event) {
                            event.preventDefault();
                            const selectedMonth = this.getAttribute("data-month");

                            // Hiển thị tháng đã chọn trên dropdown
                            document.getElementById("selectedMonth").textContent = selectedMonth;

                            // Tách giá trị tháng và năm
                            const parts = selectedMonth.split(" ");
                            if (parts.length === 2) {
                                const year = parts[1];
                                const month = parts[0];

                                document.getElementById("hiddenYear").value = year;
                                document.getElementById("hiddenMonth").value = month;

                                // Submit form ẩn
                                document.getElementById("hiddenForm").submit();
                            }
                        });

                    });
                    window.addEventListener("load", function () {
                        const savedMonth = localStorage.getItem("selectedMonth");
                        if (savedMonth) {
                            document.getElementById("selectedMonth").textContent = savedMonth;
                        }
                    });
                });





            </script>


            <!-- /Add Slots -->

            <!-- Remove Slots -->
            <div class="modal fade info-modal" id="delete_slot">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-body">
                            <div class="success-wrap">
                                <div class="success-info">
                                    <div class="text-center">
                                        <span class="icon-success bg-red"><i class="fa-solid fa-xmark"></i></span>
                                        <h3>Remove Slots</h3>
                                        <p>Are you sure you want to remove this slots?</p>
                                    </div>
                                </div>
                            </div>

                            <div class="modal-btn text-center">
                                <a href="#" class="btn btn-gray" data-bs-toggle="modal" data-bs-dismiss="modal">Yes, Remove</a>
                                <button class="btn btn-primary prime-btn">No, i Changed my mind</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%@include file="../sourcesHome/homeFooter.jsp" %>
            <!-- /Remove Slots -->

            <!-- jQuery -->
            <script data-cfasync="false" src="/HAPPYorSAD/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script><script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js" type="d693b69077856eb34d3f2643-text/javascript"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
            <script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js"></script>

            <!-- Bootstrap -->
            <script src="/HAPPYorSAD/assets/js/bootstrap.bundle.min.js"></script>

            <!-- Theia Sticky Sidebar -->
            <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/ResizeSensor.js"></script>
            <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js"></script>

            <!-- Select2 -->
            <script src="/HAPPYorSAD/assets/plugins/select2/js/select2.min.js"></script>

            <!-- CKEditor -->
            <script src="/HAPPYorSAD/assets/js/ckeditor.js"></script>

            <!-- Dropzone -->
            <script src="/HAPPYorSAD/assets/plugins/dropzone/dropzone.min.js"></script>

            <!-- Date & Time Picker -->
            <script src="/HAPPYorSAD/assets/js/moment.min.js"></script>
            <script src="/HAPPYorSAD/assets/js/bootstrap-datetimepicker.min.js"></script>

            <!-- Custom Script -->
            <script src="/HAPPYorSAD/assets/js/script.js"></script>

            <!-- Cloudflare & Performance Scripts -->
            <script src="/HAPPYorSAD/cdn-cgi/scripts/7d0fa10a/cloudflare-static/rocket-loader.min.js" defer></script>
            <script defer src="https://static.cloudflareinsights.com/beacon.min.js" crossorigin="anonymous"></script>
            <script data-cfasync="false" src="/HAPPYorSAD/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script>
            <script defer src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015" integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ==" data-cf-beacon='{"rayId":"91074a70ad7f06b9","version":"2025.1.0","serverTiming":{"name":{"cfExtPri":true,"cfL4":true,"cfSpeedBrain":true,"cfCacheStatus":true}},"token":"3ca157e612a14eccbb30cf6db6691c29","b":1}' 
            crossorigin="anonymous"></script>
            <script src="../cdn-cgi/scripts/7d0fa10a/cloudflare-static/rocket-loader.min.js" data-cf-settings="f9ce65d731ff2ad48261e344-|49" defer></script><script defer src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015" integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ==" data-cf-beacon='{"rayId":"9127c422e91802d2","version":"2025.1.0","serverTiming":{"name":{"cfExtPri":true,"cfL4":true,"cfSpeedBrain":true,"cfCacheStatus":true}},"token":"3ca157e612a14eccbb30cf6db6691c29","b":1}' crossorigin="anonymous"></script>

        </body>
    </html>