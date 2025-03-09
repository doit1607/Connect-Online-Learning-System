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
<%@ page import="java.util.Calendar, java.text.SimpleDateFormat, java.util.ArrayList, java.util.List, java.util.HashMap, java.util.Map" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Doccure</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- Favicon & Icons -->
        <link rel="shortcut icon" href="/HAPPYorSAD/assets/img/favicon.svg">
        <link rel="apple-touch-icon" sizes="180x180" href="/HAPPYorSAD/assets/img/apple-touch-icon.png">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/feather.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/iconsax.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/boxicons/css/boxicons.min.css">

        <!-- CSS Libraries -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/select2/css/select2.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap-datetimepicker.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/dropzone/dropzone.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css">

        <!-- Custom & Main Styles -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/custom.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css">

        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <style>
            .temp-slot-item {
                background: #fffae6;
                border-left: 4px solid #ffc107;
                padding: 5px 10px;
                font-weight: bold;
            }
            .slot-box {
                width: 100%;
                min-width: 120px;
                text-align: center;
            }
            .slot-header {
                font-size: 16px;
                font-weight: bold;
            }
            .slot-body {
                padding: 0px;
            }
            .slot-body table {
                width: 100%;
            }
            .slot-footer, .slot-add {
                padding-top: 10px;
            }
            .row {
                display: flex;
                flex-wrap: nowrap;
                overflow-x: auto;
                justify-content: flex-start;
                width: 100%;
                white-space: nowrap;
                box-sizing: border-box;
            }
            .col-md {
                flex: 0 0 calc(14.2857% - 6px); /* 100% / 7 = 14.2857%, trừ đi padding nhỏ hơn */
                max-width: calc(14.2857% - 6px);
                min-width: 120px; /* Giảm từ 150px xuống 120px để nhỏ hơn */
                padding: 3px; /* Giảm padding từ 5px xuống 3px mỗi bên, tổng 6px */
                box-sizing: border-box;
                margin: 3px;
            }
            .temp-slot-highlight {
                background-color: rgba(0, 128, 0, 0.1);
                border: 1px solid green;
                padding: 3px 6px;
                border-radius: 4px;
                font-weight: bold;
                color: green;
            }
            .temp-slot-item i {
                font-size: 12px;
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
                        <div class="col-md-12">
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

            <!-- Page Content -->
            <div class="page-content">
                <div class="container">
                    <div class="row">
                        <!-- Sidebar -->
                        <div class="col-xl-3 col-lg-3 theiaStickySidebar">
                            <div class="settings-widget account-settings">
                                <div class="settings-menu">
                                    <h3>Dashboard</h3>
                                    <ul>
                                        <li class="nav-item"><a href="/../HAPPYorSAD/ProfileServlet" class="nav-link"><i class="bx bxs-tachometer"></i>My Profile</a></li>
                                        <li class="nav-item"><a href="instructor-enrolled-course.html" class="nav-link"><i class="bx bxs-graduation"></i>Enrolled Courses</a></li>
                                        <li class="nav-item active"><a href="/../HAPPYorSAD/Slot" class="nav-link"><i class="bx bxs-graduation"></i>Available Timings</a></li>
                                        <li class="nav-item"><a href="instructor-reviews.html" class="nav-link"><i class="bx bxs-star"></i>Reviews</a></li>
                                    </ul>
                                    <h3>Instructor</h3>
                                    <ul>
                                        <li class="nav-item"><a href="instructor-course.html" class="nav-link"><i class="bx bxs-rocket"></i>My Courses</a></li>
                                        <li class="nav-item"><a href="instructor-course.html" class="nav-link"><i class="bx bxs-rocket"></i>My Curriculum Vitae</a></li>
                                        <li class="nav-item"><a href="instructor-enrolled-course.html" class="nav-link"><i class="bx bxs-graduation"></i>Inviting Request</a></li>
                                    </ul>
                                    <h3>Account Settings</h3>
                                    <ul>
                                        <li class="nav-item"><a href="updatementorprofile?username=${sessionScope.usernameUser}" class="nav-link"><i class="bx bxs-cog"></i>Settings</a></li>
                                        <li class="nav-item"><a href="LoginUser?service=logout" class="nav-link"><i class="bx bxs-log-out"></i>Logout</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <!-- Main Content -->
                        <div class="col-lg-9 col-xl-9">
                            <div class="dashboard-header"><h3>Available Timings</h3></div>
                            <div class="appointment-tabs">
                                <ul class="nav available-nav">
                                    <li class="nav-item"><a class="nav-link active" href="#" data-bs-toggle="tab" data-bs-target="#general-availability">General Availability</a></li>
                                    <li class="nav-item"><a class="nav-link" href="#" data-bs-toggle="tab" data-bs-target="#your-schedule">Your Schedule</a></li>
                                </ul>
                            </div>

                            <div class="tab-content pt-0 timing-content">
                                <div class="tab-pane fade show active" id="general-availability">
                                    <div class="card custom-card">
                                        <div class="card-body">
                                            <div class="card-header"><h3>Select Available Slots</h3></div>
                                            <div class="row">
                                                <div class="col-12 col-sm-4 col-md-6">
                                                    <h4 class="mb-1"><fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd MMMM yyyy"/></h4>
                                                    <p class="text-muted"><fmt:formatDate value="<%= new java.util.Date() %>" pattern="EEEE"/></p>
                                                </div>
                                                <div class="col-12 col-sm-8 col-md-6 text-sm-end">
                                                    <a class="dropdown-item text-primary" href="#" id="addSchedule">+ Add Schedule</a>                                                        <i class="far fa-calendar-alt me-2"></i><span id="selectedMonth">Choose month</span><i class="fas fa-chevron-down ms-2"></i>
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
                                                                    <h5><span class="week-day">${weekDays[status.index]}</span><span style="display: none;">${day}</span></h5>
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
                                                                                                    <span class="temp-slot-item temp-slot-highlight"><i class="isax isax-clock"></i> Slot ${temp.slotNumber}</span>
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
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Hidden Forms -->
        <form id="tempSlotForm" action="/HAPPYorSAD/Slot?action=add" method="post" style="display: none;">
            <input type="hidden" name="scheduleId" id="scheduleIdInput">
            <input type="hidden" name="slot_date" id="slotDateInput">
            <input type="hidden" name="slotNumber" id="slotNumberInput">
        </form>
        <form id="hiddenForm" action="/HAPPYorSAD/Slot" method="get">
            <input type="hidden" name="month" id="hiddenMonth">
            <input type="hidden" name="year" id="hiddenYear">
        </form>
        <form id="addScheduleForm" action="/HAPPYorSAD/Slot" method="post" style="display: none;">
            <input type="hidden" name="mentorId" value="${mentorId}">
            <label>Start Date:</label><input type="date" name="startDate" required>
            <label>End Date:</label><input type="date" name="endDate" required>
            <button type="submit">Add</button>
        </form>

        <!-- Scripts -->
        <script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js"></script>
        <script src="/HAPPYorSAD/assets/js/bootstrap.bundle.min.js"></script>
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/ResizeSensor.js"></script>
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js"></script>
        <script src="/HAPPYorSAD/assets/plugins/select2/js/select2.min.js"></script>
        <script src="/HAPPYorSAD/assets/js/ckeditor.js"></script>
        <script src="/HAPPYorSAD/assets/plugins/dropzone/dropzone.min.js"></script>
        <script src="/HAPPYorSAD/assets/js/moment.min.js"></script>
        <script src="/HAPPYorSAD/assets/js/bootstrap-datetimepicker.min.js"></script>
        <script src="/HAPPYorSAD/assets/js/script.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>

        <script>

                                                                        document.addEventListener("DOMContentLoaded", () => {


                                                                            document.getElementById("addSchedule").addEventListener("click", function (event) {
                                                                                event.preventDefault(); // Ngăn hành vi mặc định của thẻ <a>

                                                                                const scheduleId = "${scheduleId}"; // Lấy scheduleId hiện tại từ session hoặc attribute
                                                                                if (!scheduleId) {
                                                                                    alert("No current schedule found. Please select a schedule first.");
                                                                                    return;
                                                                                }

                                                                                const params = new URLSearchParams();
                                                                                params.append("action", "addSchedule");
                                                                                params.append("scheduleId", scheduleId);

                                                                                fetch("/HAPPYorSAD/Slot", {
                                                                                    method: "POST",
                                                                                    headers: {"Content-Type": "application/x-www-form-urlencoded"},
                                                                                    body: params
                                                                                })
                                                                                        .then(response => response.json()) // Giả sử servlet trả về JSON với thông tin tháng và năm
                                                                                        .then(data => {
                                                                                            if (data.status === "success") {
                                                                                                alert("New schedule for the next month added successfully!");
                                                                                                // Chuyển hướng đến URL mới với tháng và năm vừa thêm
                                                                                                window.location.href = `/HAPPYorSAD/Slot?month=${data.month}&year=${data.year}`;
                                                                                            } else {
                                                                                                alert("Failed to add new schedule: " + data.message);
                                                                                            }
                                                                                        })
                                                                                        .catch(error => alert("An error occurred while adding the schedule: " + error));
                                                                            });
                                                                            document.querySelectorAll(".add-temp-slot").forEach(button => {
                                                                                button.addEventListener("click", function () {
                                                                                    const scheduleId = 3; // Hardcoded for now
                                                                                    const slot_date = this.getAttribute("data-date");
                                                                                    const slotNumber = parseInt(this.getAttribute("data-slot")); // Chuyển đổi sang số nguyên
                                                                                    if (!slot_date || !/^\d{4}-\d{2}-\d{2}$/.test(slot_date.trim())) {
                                                                                        alert("Invalid date format. Please use YYYY-MM-DD.");
                                                                                        return;
                                                                                    }
                                                                                    if (!slotNumber || isNaN(slotNumber) || slotNumber < 1 || slotNumber > 5) {
                                                                                        alert("Invalid slot number.");
                                                                                        return;
                                                                                    }

                                                                                    const params = new URLSearchParams();
                                                                                    params.append("scheduleId", scheduleId);
                                                                                    params.append("slot_date", slot_date);
                                                                                    params.append("slotNumber", slotNumber);

                                                                                    fetch("/HAPPYorSAD/Slot?action=add", {
                                                                                        method: "POST",
                                                                                        headers: {"Content-Type": "application/x-www-form-urlencoded"},
                                                                                        body: params
                                                                                    })
                                                                                            .then(response => response.text())
                                                                                            .then(data => {
                                                                                                if (data.includes("success")) {
                                                                                                    alert("Slot added successfully!");
                                                                                                    updateSlotUI(slot_date, slotNumber, this); // Truyền nút vào hàm
                                                                                                } else {
                                                                                                    alert("Failed to add slot: " + data);
                                                                                                }
                                                                                            })
                                                                                            .catch(error => alert("An error occurred while adding slot."));
                                                                                });
                                                                            });

                                                                            function updateSlotUI(slot_date, slotNumber, button) {
                                                                                const slotBox = [...document.querySelectorAll(".slot-box")].find(box =>
                                                                                    box.querySelector(".slot-header h5").textContent.includes(slot_date));
                                                                                if (!slotBox)
                                                                                    return;

                                                                                const slotRow = slotBox.querySelectorAll(".slot-body tbody tr")[slotNumber - 1];
                                                                                if (!slotRow)
                                                                                    return;

                                                                                const slotCell = slotRow.querySelector("td");
                                                                                if (!slotCell)
                                                                                    return;

                                                                                // Tạo slot tạm mới
                                                                                const tempSlot = document.createElement("span");
                                                                                tempSlot.classList.add("temp-slot-item", "temp-slot-highlight");
                                                                                tempSlot.innerHTML = `<i class="isax isax-clock"></i> Slot ${slotNumber}`;

                                                                                // Xóa toàn bộ nội dung cũ trong slotCell (bao gồm "Empty" và nút "+")
                                                                                slotCell.innerHTML = ""; // Xóa tất cả nội dung
                                                                                slotCell.appendChild(tempSlot); // Thêm slot tạm
                                                                            }

                                                                            document.querySelectorAll(".month-item").forEach(item => {
                                                                                item.addEventListener("click", (event) => {
                                                                                    event.preventDefault();
                                                                                    const selectedMonth = item.getAttribute("data-month");
                                                                                    document.getElementById("selectedMonth").textContent = selectedMonth;

                                                                                    const [month, year] = selectedMonth.split(" ");
                                                                                    document.getElementById("hiddenYear").value = year;
                                                                                    document.getElementById("hiddenMonth").value = month;
                                                                                    document.getElementById("hiddenForm").submit();
                                                                                });
                                                                            });
                                                                        });
        </script>

        <%@include file="../sourcesHome/homeFooter.jsp" %>
    </body>
</html>