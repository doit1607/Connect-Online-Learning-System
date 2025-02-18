<%-- 
    Document   : Set Schedule
    Created on : Feb 16, 2025, 12:46:26 AM
    Author     : Ann
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Doccure</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="/HAPPYorSAD/assets/img/favicon.png" type="image/x-icon">

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
                                    <li class="nav-item" role="presentation">
                                        <a class="nav-link" href="#" data-bs-toggle="tab"
                                           data-bs-target="#clinic-availability">Clinic Availability</a>
                                    </li>
                                </ul>
                            </div>
                            <div class="tab-content pt-0 timing-content">

                                <!-- General Availability -->
                                <div class="tab-pane fade show active" id="general-availability">
                                    <div class="card custom-card">
                                        <div class="card-body">
                                            <div class="card-header">
                                                <h3>Select Available Slots</h3>
                                            </div>

                                            <div class="available-tab">
                                                <label class="form-label">Select Available days</label>                                                
                                                <ul class="nav" role="tablist">
                                                    <c:forEach var="day" items="${days}" >
                                                        <li>                                                       
                                                            <a href="Slot?mentorId=${mentorId}&day=${day}" class="active ${selectedDay eq day ? 'active' : ''}" data-bs-toggle="tab"
                                                               data-bs-target="#${day}" aria-selected="true" role="tab">${day}</a>   

                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                            </div>

                                            <div class="tab-content pt-0">

                                                <!-- Slot -->
                                                 
                                                <div class="tab-pane active show" id="monday">
                                                    <div class="slot-box">
                                                        <div class="slot-header">
                                                            <h5>Monday</h5>
                                                            <ul>
                                                                <li>
                                                                    <a href="#" class="add-slot" data-bs-toggle="modal"
                                                                       data-bs-target="#add_slot">Add Slots</a>
                                                                </li>
                                                                <li>
                                                                    <a href="#" class="del-slot" data-bs-toggle="modal"
                                                                       data-bs-target="#delete_slot">Delete All</a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <div class="slot-body">
                                                            <c:choose>
                                                                <c:when test="${not empty slots}">
                                                                    <c:forEach var="day" items="${slots}">
                                                                        <ul class="time-slots">
                                                                            <li><i class="isax isax-clock"></i>${day.startTime} AM</li>

                                                                        </ul> 
                                                                    </c:forEach>                                              
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <p>No slots available for ${selectedDay}.</p>
                                                                </c:otherwise>

                                                            </c:choose>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- /Slot -->



                                                <div class="form-wrap">
                                                    <label class="col-form-label">Appointment Fees ($)</label>
                                                    <input type="text" class="form-control" value="254">
                                                </div>
                                                <div class="modal-btn text-end">
                                                    <a href="#" class="btn btn-gray" data-bs-toggle="modal"
                                                       data-bs-dismiss="modal">Cancel</a>
                                                    <button class="btn btn-primary prime-btn">Save Changes</button>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <!-- /General Availability -->

                                <!-- Clinic Availability -->
                                <div class="tab-pane fade" id="clinic-availability">
                                    <div class="clinic-wrap">
                                        <h5>Select Clinic</h5>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <select class="select-img">
                                                    <option data-image="assets/img/doctors-dashboard/clinic-01.jpg">The
                                                        Family Dentistry Clinic</option>
                                                    <option data-image="assets/img/doctors-dashboard/clinic-02.jpg">
                                                        Dentistry Clinic</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card custom-card">
                                        <div class="card-body">
                                            <div class="card-header">
                                                <h3>Select Available Slots</h3>
                                            </div>

                                            <div class="available-tab">
                                                <label class="form-label">Select Available days</label>
                                                <c:set var="days" value="MON,TUE,WED,THU,FRI,SAT,SUN" />
                                                <ul class="nav">
                                                    <c:forEach var="day" items="${days.split(',')}">
                                                        <li>                                                       
                                                            <a href="Slot?mentorId=${mentorId}&day=${day}" class="active ${selectedDay eq day ? 'active' : ''}" data-bs-toggle="tab"
                                                               data-bs-target="#monday-slot">${day}</a>                                                       
                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                            </div>

                                            <div class="tab-content pt-0">

                                                <!-- Slot -->
                                                <div class="tab-pane active show" id="monday-slot">
                                                    <div class="slot-box">
                                                        <div class="slot-header">
                                                            <h5>Monday</h5>
                                                            <ul>
                                                                <li>
                                                                    <a href="#" class="add-slot" data-bs-toggle="modal"
                                                                       data-bs-target="#add_slot">Add Slots</a>
                                                                </li>
                                                                <li>
                                                                    <a href="#" class="del-slot" data-bs-toggle="modal"
                                                                       data-bs-target="#delete_slot">Delete All</a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <div class="slot-body">
                                                            <ul class="time-slots">
                                                                <li><i class="isax isax-clock"></i>09:00 AM</li>
                                                                <li><i class="isax isax-clock"></i>09:30 AM</li>
                                                                <li class="slot-space">Space : 2</li>
                                                                <li><i class="isax isax-clock"></i>10:30 AM</li>
                                                                <li><i class="isax isax-clock"></i>11:00 AM</li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- /Slot -->

                                                <!-- Slot -->
                                                <div class="tab-pane fade" id="tuesday-slot">
                                                    <div class="slot-box">
                                                        <div class="slot-header">
                                                            <h5>Tuesday</h5>
                                                            <ul>
                                                                <li>
                                                                    <a href="#" class="add-slot" data-bs-toggle="modal"
                                                                       data-bs-target="#add_slot">Add Slots</a>
                                                                </li>
                                                                <li>
                                                                    <a href="#" class="del-slot" data-bs-toggle="modal"
                                                                       data-bs-target="#delete_slot">Delete All</a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <div class="slot-body">
                                                            <p>No Slots Available</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- /Slot -->

                                                <!-- Slot -->
                                                <div class="tab-pane fade" id="wednesday-slot">
                                                    <div class="slot-box">
                                                        <div class="slot-header">
                                                            <h5>Wednesday</h5>
                                                            <ul>
                                                                <li>
                                                                    <a href="#" class="add-slot" data-bs-toggle="modal"
                                                                       data-bs-target="#add_slot">Add Slots</a>
                                                                </li>
                                                                <li>
                                                                    <a href="#" class="del-slot" data-bs-toggle="modal"
                                                                       data-bs-target="#delete_slot">Delete All</a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <div class="slot-body">
                                                            <p>No Slots Available</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- /Slot -->

                                                <!-- Slot -->
                                                <div class="tab-pane fade" id="thursday-slot">
                                                    <div class="slot-box">
                                                        <div class="slot-header">
                                                            <h5>Thursday</h5>
                                                            <ul>
                                                                <li>
                                                                    <a href="#" class="add-slot" data-bs-toggle="modal"
                                                                       data-bs-target="#add_slot">Add Slots</a>
                                                                </li>
                                                                <li>
                                                                    <a href="#" class="del-slot" data-bs-toggle="modal"
                                                                       data-bs-target="#delete_slot">Delete All</a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <div class="slot-body">
                                                            <p>No Slots Available</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- /Slot -->

                                                <!-- Slot -->
                                                <div class="tab-pane fade" id="friday-slot">
                                                    <div class="slot-box">
                                                        <div class="slot-header">
                                                            <h5>Friday</h5>
                                                            <ul>
                                                                <li>
                                                                    <a href="#" class="add-slot" data-bs-toggle="modal"
                                                                       data-bs-target="#add_slot">Add Slots</a>
                                                                </li>
                                                                <li>
                                                                    <a href="#" class="del-slot" data-bs-toggle="modal"
                                                                       data-bs-target="#delete_slot">Delete All</a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <div class="slot-body">
                                                            <p>No Slots Available</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- /Slot -->

                                                <!-- Slot -->
                                                <div class="tab-pane fade" id="saturday-slot">
                                                    <div class="slot-box">
                                                        <div class="slot-header">
                                                            <h5>Saturday</h5>
                                                            <ul>
                                                                <li>
                                                                    <a href="#" class="add-slot" data-bs-toggle="modal"
                                                                       data-bs-target="#add_slot">Add Slots</a>
                                                                </li>
                                                                <li>
                                                                    <a href="#" class="del-slot" data-bs-toggle="modal"
                                                                       data-bs-target="#delete_slot">Delete All</a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <div class="slot-body">
                                                            <p>No Slots Available</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- /Slot -->

                                                <!-- Slot -->
                                                <div class="tab-pane fade" id="sunday-slot">
                                                    <div class="slot-box">
                                                        <div class="slot-header">
                                                            <h5>Sunday</h5>
                                                            <ul>
                                                                <li>
                                                                    <a href="#" class="add-slot" data-bs-toggle="modal"
                                                                       data-bs-target="#add_slot">Add Slots</a>
                                                                </li>
                                                                <li>
                                                                    <a href="#" class="del-slot" data-bs-toggle="modal"
                                                                       data-bs-target="#delete_slot">Delete All</a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <div class="slot-body">
                                                            <p>No Slots Available</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- /Slot -->

                                                <div class="form-wrap">
                                                    <label class="col-form-label">Appointment Fees ($)</label>
                                                    <input type="text" class="form-control" value="254">
                                                </div>
                                                <div class="modal-btn text-end">
                                                    <a href="#" class="btn btn-gray" data-bs-toggle="modal"
                                                       data-bs-dismiss="modal">Cancel</a>
                                                    <button class="btn btn-primary prime-btn">Save Changes</button>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <!-- /Clinic Availability -->

                            </div>
                        </div>

                    </div>

                    <div class="modal fade custom-modals" id="add_slot">
                        <div class="modal-dialog modal-dialog-centered modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Add New Slot</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                                        <i class="fa-solid fa-xmark"></i>
                                    </button>
                                </div>
                                <form action="SetSchedule">
                                    <div class="modal-body">
                                        <div class="timing-modal">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-wrap">
                                                        <label class="col-form-label">Start Time</label>
                                                        <input type="text" class="form-control timepicker1" value="04:00 PM">
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-wrap">
                                                        <label class="col-form-label">End Time</label>
                                                        <input type="text" class="form-control timepicker1">
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-wrap">
                                                        <label class="col-form-label">Appointment Intervals</label>
                                                        <select class="select">
                                                            <option>10 Minutes</option>
                                                            <option>20 Minutes</option>
                                                            <option>30 Minutes</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-wrap">
                                                        <label class="col-form-label">Appointment Durations</label>
                                                        <select class="select">
                                                            <option>30 Minutes</option>
                                                            <option>1 Hour</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-md-12">
                                                    <div class="form-wrap mb-0">
                                                        <label class="col-form-label d-block">Assign Appointment Spaces</label>
                                                        <div class="custom-control form-check custom-control-inline">
                                                            <input type="radio" id="space1" name="rating_option"
                                                                   class="form-check-input" value="price_free" checked="">
                                                            <label class="form-check-label" for="space1">Space 1</label>
                                                        </div>
                                                        <div class="custom-control form-check custom-control-inline">
                                                            <input type="radio" id="space2" name="rating_option"
                                                                   class="form-check-input" value="price_free" checked="">
                                                            <label class="form-check-label" for="space2">Space 2</label>
                                                        </div>
                                                        <div class="custom-control form-check custom-control-inline">
                                                            <input type="radio" id="space3" name="rating_option"
                                                                   class="form-check-input" value="price_free" checked="">
                                                            <label class="form-check-label" for="space3">Space 3</label>
                                                        </div>
                                                        <div class="custom-control form-check custom-control-inline">
                                                            <input type="radio" id="space4" name="rating_option"
                                                                   class="form-check-input" value="price_free" checked="">
                                                            <label class="form-check-label" for="space4">Space 4</label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <div class="modal-btn text-end">
                                            <a href="#" class="btn btn-gray" data-bs-toggle="modal" data-bs-dismiss="modal">Cancel</a>
                                            <button type="submit" class="btn btn-primary prime-btn">Save Changes</button>
                                        </div>
                                    </div>
                                </form>
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