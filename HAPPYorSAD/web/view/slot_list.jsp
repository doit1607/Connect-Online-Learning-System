<%-- 
    Document   : slot_list
    Created on : Feb 18, 2025, 5:39:37 PM
    Author     : Ann
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
        <link rel="shortcut icon" href="/HAPPYorSAD/assets/img/favicon.png" type="image/x-icon">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link rel="apple-touch-icon" sizes="180x180" href="/HAPPYorSAD/assets/img/apple-touch-icon.png">
        <script src="/HAPPYorSAD/assets/js/theme-script.js" type="a18776aee842a8e5f3a30141-text/javascript"></script>
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/all.min.css">

        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/iconsax.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/feather.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/select2/css/select2.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap-datetimepicker.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/custom.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css">
        
        <script src="/HAPPYorSAD//assets/js/Ajax.js"></script>


        <style>
            .temp-slot-item {
                background: #fffae6;
                border-left: 4px solid #ffc107;
                padding: 5px 10px;
                font-weight: bold;
            }
        </style>


    </head>
    <body>

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

                        <!-- sidebar -->
                        <div class="col-xl-3 col-lg-3 theiaStickySidebar">
                            <div class="settings-widget dash-profile">
                                <div class="settings-menu">
                                    <div class="profile-bg">
                                        <div class="profile-img">
                                            <a href="instructor-profile.html"><img src="assets/img/user/user-17.jpg"
                                                                                   alt="Img"></a>
                                        </div>
                                    </div>
                                    <div class="profile-group">
                                        <div class="profile-name text-center">
                                            <h4><a href="instructor-profile.html">Eugene Andre</a></h4>
                                            <p>Instructor</p>
                                            <a href="add-course.html" class="add-course btn-primary">Add New Course</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="settings-widget account-settings">
                                <div class="settings-menu">
                                    <h3>Dashboard</h3>
                                    <ul>
                                        <li class="nav-item active">
                                            <a href="instructor-dashboard.html" class="nav-link">
                                                <i class="bx bxs-tachometer"></i>Dashboard
                                            </a>
                                        </li>
                                        <li class="nav-item ">
                                            <a href="instructor-profile.html" class="nav-link">
                                                <i class="bx bxs-user"></i>My Profile
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="instructor-enrolled-course.html" class="nav-link">
                                                <i class="bx bxs-graduation"></i>Enrolled Courses
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
                                            <a href="instructor-settings.html" class="nav-link ">
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
                        <!-- /Sidebar -->


                        <div class="col-lg-9 col-xl-9">

                            <div class="dashboard-header">
                                <h3>Available Timings</h3>
                            </div>

                            <div class="appointment-tabs">
                                <ul class="nav available-nav">
                                    <li class="nav-item" role="presentation">
                                        <a class="nav-link active" href="#" data-bs-toggle="tab"
                                           data-bs-target="#general-availability">General Availability</a>
                                    </li>
                                </ul>
                            </div>
                            <div class="tab-content pt-0 timing-content">

                                <div class="tab-pane fade show active" id="general-availability">
                                    <div class="card custom-card">
                                        <div class="card-body">
                                            <div class="card-header">
                                                <h3>Select Available Slots</h3>
                                            </div>

                                            <div class="available-tab">
                                                <label class="form-label">Select Available days</label>
                                                <ul class="nav">
                                                    <c:forEach var="day" items="${weekDays}">
                                                        <li>
                                                            <a href="Slot?scheduleId=${scheduleId}&day=${day}" 
                                                               class="${selectedDay eq day ? 'active' : ''}">
                                                                ${day}
                                                            </a>
                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                            </div>

                                            <div class="tab-content pt-0">
                                                <div class="tab-pane fade show active" id="${selectedDay}">
                                                    <h3>Slot khả dụng cho ngày ${param.slotDate}</h3>

                                                    <div class="slot-box">
                                                        <div class="slot-header">
                                                            <h5>${selectedDay}</h5>
                                                        </div>

                                                        <div class="slot-body">
                                                            <div class="row">
                                                                <div class="col-md-8">
                                                                    <c:choose>
                                                                        <c:when test="${not empty slots}">
                                                                            <ul class="time-slots">
                                                                                <c:forEach var="slot" items="${slots}">
                                                                                    <li><i class="isax isax-clock"></i> ${slot.startTime}</li>
                                                                                    </c:forEach>

                                                                                <c:if test="${not empty sessionScope.tempSlotsByDate[selectedDate]}">
                                                                                    <c:forEach var="temp" items="${sessionScope.tempSlotsByDate[selectedDate]}">
                                                                                        <li class="temp-slot-item">
                                                                                            <i class="isax isax-clock"></i> ${temp.startTime}
                                                                                        </li>
                                                                                    </c:forEach>
                                                                                </c:if>

                                                                            </ul>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <c:choose>
                                                                                <c:when test="${not empty slots or not empty sessionScope.tempSlotsByDate[selectedDate]}">
                                                                                    <ul class="time-slots">
                                                                                        <c:forEach var="slot" items="${slots}">
                                                                                            <li><i class="isax isax-clock"></i> ${slot.startTime}</li>
                                                                                            </c:forEach>

                                                                                        <c:if test="${not empty sessionScope.tempSlotsByDate[selectedDate]}">
                                                                                            <c:forEach var="temp" items="${sessionScope.tempSlotsByDate[selectedDate]}">
                                                                                                <li class="temp-slot-item">
                                                                                                    <i class="isax isax-clock"></i> ${temp.startTime}
                                                                                                </li>
                                                                                            </c:forEach>
                                                                                        </c:if>
                                                                                    </ul>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <p>No slots available for ${selectedDay}.</p>
                                                                                </c:otherwise>
                                                                            </c:choose>

                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <form action="Slot?action=add" method="post">
                                                                        <input type="hidden" name="scheduleId" value="${scheduleId}">
                                                                        <input type="hidden" name="day" value="${selectedDay}">

                                                                        <label>Choose slot:</label>
                                                                        <select name="slot_number_id" class="form-control">
                                                                            <c:forEach var="slot" items="${availableSlots}">
                                                                                <option value="${slot.id}">${slot.slotNumber} (${slot.startTime} - ${slot.endTime})</option>
                                                                            </c:forEach>
                                                                        </select>

                                                                        <!-- Checkbox để chọn repeat slot hàng tuần -->
                                                                        <div class="form-check mt-2">
                                                                            <input class="form-check-input" type="checkbox" name="repeatWeekly" id="repeatWeekly" value="true">
                                                                            <label class="form-check-label" for="repeatWeekly">
                                                                                Repeat weekly until schedule ends
                                                                            </label>
                                                                        </div>

                                                                        <button type="submit" class="btn btn-primary mt-2">Add Slot</button>
                                                                    </form>

                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="slot-footer mt-3">
                                                            <form action="Slot?action=delete" method="post" onsubmit="return confirm('Are you sure you want to delete all slots?');">
                                                                <input type="hidden" name="date" value="${date}"> 
                                                                <input type="hidden" name="mentorId" value="${mentorId}"> 
                                                                <input type="hidden" name="scheduleId" value="${scheduleId}"> 
                                                                <button type="submit" class="del-slot text-danger btn btn-link">Delete All</button>
                                                            </form>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                                <div class="modal-btn text-end">

                                    <form action="Slot?action=save" method="post">
                                        <a href="#" class="btn btn-gray" data-bs-toggle="modal" data-bs-dismiss="modal">Cancel</a>

                                        <input type="hidden" name="scheduleId" value="${scheduleId}"> 
                                        <button type="submit" class="btn btn-primary prime-btn">Save Changes</button>
                                    </form>
                                </div>


                            </div>
                        </div>
                    </div>
                    <!-- /General Availability -->



                </div>
            </div>

        </div>


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
        <!-- /Remove Slots -->

        <script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js" type="a18776aee842a8e5f3a30141-text/javascript"></script>
        <script src="/HAPPYorSAD/assets/js/bootstrap.bundle.min.js" type="a18776aee842a8e5f3a30141-text/javascript"></script>
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/ResizeSensor.js"
        type="a18776aee842a8e5f3a30141-text/javascript"></script>
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js"
        type="a18776aee842a8e5f3a30141-text/javascript"></script>
        <script src="/HAPPYorSAD/assets/plugins/select2/js/select2.min.js" type="a18776aee842a8e5f3a30141-text/javascript"></script>
        <script src="/HAPPYorSAD/assets/js/moment.min.js" type="a18776aee842a8e5f3a30141-text/javascript"></script>
        <script src="/HAPPYorSAD/assets/js/bootstrap-datetimepicker.min.js" type="a18776aee842a8e5f3a30141-text/javascript"></script>
        <script src="/HAPPYorSAD/assets/js/script.js" type="a18776aee842a8e5f3a30141-text/javascript"></script>
        <script src="/HAPPYorSAD/cdn-cgi/scripts/7d0fa10a/cloudflare-static/rocket-loader.min.js"
        data-cf-settings="a18776aee842a8e5f3a30141-|49" defer></script>
        <script defer
                src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015"
                integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ=="
                data-cf-beacon='{"rayId":"9127c0ff5d5b02d2","version":"2025.1.0","serverTiming":{"name":{"cfExtPri":true,"cfL4":true,"cfSpeedBrain":true,"cfCacheStatus":true}},"token":"3ca157e612a14eccbb30cf6db6691c29","b":1}'
        crossorigin="anonymous"></script>
    </body>
</html>