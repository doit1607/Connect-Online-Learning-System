<%-- 
    Document   : CreateRequest
    Created on : 21 Feb 2025, 3:45:26 pm
    Author     : Acer
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Request</title>
        <link rel="shortcut icon" type="image/x-icon" href="/HAPPYorSAD/assets/img/favicon.svg">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/owl.carousel.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/owl.theme.default.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/slick/slick.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/slick/slick-theme.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/select2/css/select2.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/aos/aos.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css">
        <link rel="stylesheet" href="/HAPPYorSAD/css/cssCRUD/CreateRequest.css"/>
    </head>
    <body>
        <%@include file="../sourcesHome/homeHeader.jsp" %>
        <!-- Breadcrumb -->
        <div class="breadcrumb-bar breadcrumb-bar-info">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-12">
                        <div class="breadcrumb-list">
                            <h2 class="breadcrumb-title">Support Tickets</h2>
                            <nav aria-label="breadcrumb" class="page-breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="index-2.html">Home</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Support Tickets</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /Breadcrumb -->	
        <div class="content">
            <div class="container">
                <div class="row">

                    <div class="modal-body custom-modal-body col-md-7 col-lg-8 row">

                        <form action="CreateRequest" method="POST"> 
                            <div >
                                <h4>Add New Request</h4>
                            </div> 
                            <input type="hidden" name="mentee_id" value="${sessionScope.menteeId}">
                            <input type="hidden" name="mentor_id" value="${sessionScope.mentorId}"/>

                            <label>Title:</label>
                            <input class="inputtext" type="text" name="title" required/><br/>

                            <label>Deadline Date:</label><br>
                            <input class="date" type="date" name="deadline_date" required/><br/>

                            <label>Deadline Hour:</label><br>
                            <input class="time" type="time" name="deadline_hour" required/><br/>

                            <label>Content:</label>
                            <textarea class="contenttex" name="content" rows="3" required></textarea><br/>

                            <label>Courses:</label><br/>
                            <c:forEach items="${sessionScope.listAllCourse}" var="o">
                                <div class="checkbox"> 
                                    <input type="checkbox" name="courseIds" value="${o.id}"/> ${o.title}<br/>
                                </div>
                            </c:forEach>
                        </form>
                        <form>
                            <!-- Personal Information -->
                            <div>
                                <h4>Personal Information</h4>
                                <div class="row">
                                    <div >
                                        <div>
                                            <label>Full Name</label>
                                            <input class="inputtext" type="text">
                                        </div>
                                    </div>                                        
                                    <div class="col-md-6 ">
                                        <div>
                                            <label>Email</label>
                                            <input class="email" type="email">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div>
                                            <label>Phone</label>
                                            <input class="inputtext" type="text">
                                        </div>
                                    </div>
                                </div>                                     
                            </div>
                            <!-- /Personal Information -->

                            <div>
                                <h4>Payment Method</h4>

                                <!-- Credit Card Payment -->
                                <div >
                                    <label >
                                        <input type="radio" name="radio" checked>
                                        <span ></span>
                                        Credit card
                                    </label>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div >
                                                <label>Name on Card</label>
                                                <input class="inputtext" type="text">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div>
                                                <label >Card Number</label>
                                                <input class="inputtext" type="text">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div>
                                                <label>Expiry Month</label>
                                                <input class="inputtext" type="text">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div>
                                                <label>Expiry Year</label>
                                                <input class="inputtext" type="text">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div>
                                                <label>CVV</label>
                                                <input class="inputtext" type="text">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /Credit Card Payment -->
                            </div>


                            <!-- /Checkout Form -->
                            <button class="btn btn-enroll" type="submit">Create Request</button>
                        </form>
                    </div>

                    <div class="col-md-5 col-lg-4 row">

                        <!-- Booking Summary -->
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Booking Summary</h4>
                            </div>
                            <div class="card-body">

                                <!-- Booking Doctor Info -->
                                <div class="booking-doc-info">
                                    <a href="doctor-profile.html" class="booking-doc-img">
                                        <img src="assets/img/doctors/doctor-thumb-02.jpg" alt="User Image">
                                    </a>
                                    <div class="booking-info">
                                        <h4><a href="doctor-profile.html">Dr. Darren Elder</a></h4>
                                        <div class="rating">
                                            <i class="fas fa-star filled"></i>
                                            <i class="fas fa-star filled"></i>
                                            <i class="fas fa-star filled"></i>
                                            <i class="fas fa-star filled"></i>
                                            <i class="fas fa-star"></i>
                                            <span class="d-inline-block average-rating">35</span>
                                        </div>
                                        <div class="clinic-details">
                                            <p class="doc-location"><i class="fas fa-map-marker-alt"></i> Newyork, USA</p>
                                        </div>
                                    </div>
                                </div>
                                <!-- Booking Doctor Info -->

                                <div class="booking-summary">
                                    <div class="booking-item-wrap">
                                        <ul class="booking-date">
                                            <li>Date :<span> 16 Nov 2023</span></li>
                                            <li>Time :<span> 10:00 AM</span></li>
                                        </ul>
                                        <ul class="booking-fee">
                                            <li>Consulting Fee <span>$100</span></li>
                                            <li>Booking Fee <span>$10</span></li>
                                            <li>Video Call <span>$50</span></li>
                                        </ul>
                                        <div class="booking-total">
                                            <ul class="booking-total-list">
                                                <li>
                                                    <span>Total</span>
                                                    <span class="total-cost">$160</span>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /Booking Summary -->

                    </div>
                </div>    

            </div>   
        </div> 
        <%@include file="../sourcesHome/homeFooter.jsp" %>     
        <script>
            document.querySelector("form").addEventListener("submit", function (event) {
                let title = document.querySelector('input[name="title"]').value.trim();
                let deadlineDate = document.querySelector('input[name="deadline_date"]').value;
                let deadlineHour = document.querySelector('input[name="deadline_hour"]').value;
                let content = document.querySelector('textarea[name="content"]').value.trim();
                let courseChecked = document.querySelectorAll('input[name="courseIds"]:checked').length > 0;

                if (!title || !deadlineDate || !deadlineHour || !content) {
                    alert("Vui lòng điền đầy đủ thông tin!");
                    event.preventDefault(); // Ngăn form submit nếu có trường bị thiếu
                    return;
                }

                if (!courseChecked) {
                    alert("Vui lòng chọn ít nhất một khóa học!");
                    event.preventDefault();
                    return;
                }
            });
        </script>
        <script src="/HAPPYorSAD/assets/js/theme-script.js"></script>
        <script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="/HAPPYorSAD/assets/js/jquery.waypoints.js"></script>
        <script src="/HAPPYorSAD/assets/js/jquery.counterup.min.js"></script>
        <script src="/HAPPYorSAD/assets/plugins/select2/js/select2.min.js"></script>
        <script src="/HAPPYorSAD/assets/js/owl.carousel.min.js"></script>
        <script src="/HAPPYorSAD/assets/plugins/slick/slick.js"></script>
        <script src="/HAPPYorSAD/assets/plugins/aos/aos.js"></script>
        <script src="/HAPPYorSAD/assets/js/script.js"></script>
    </body>

</html>

