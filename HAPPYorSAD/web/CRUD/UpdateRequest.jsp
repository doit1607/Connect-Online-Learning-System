<%-- 
    Document   : CreateRequest
    Created on : 21 Feb 2025, 3:45:26 pm
    Author     : Acer
--%>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Request</title>
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        td {
            width: 14%;
            height: 50px;
            text-align: center;

        }
        .has-slot {
            background-color: #a0e7a0;
            font-weight: bold;
            border-radius: 8px;
            margin-top: 2px;
            margin-left: 2px;
            margin-right: 2px;
            margin-bottom: 2px;
        }
        .no-slot {
            background-color: #f7f7f7;

        }
        .today {
            background-color: #4CAF50 !important;
            color: white;
            font-weight: bold;
            border: 2px solid #2E7D32;
        }
        .slot-section {
            margin-top: 20px;
        }
        .month-nav {
            display: flex;
            justify-content: space-between;
            margin: 20px 0;
        }
        .month-nav button {
            padding: 10px;
            cursor: pointer;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
        }
        .month-nav button:hover {
            background: #0056b3;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {
            // Chuyển tháng bằng AJAX
            function changeMonth(offset) {
                let month = ${currentMonth};
                let year = ${currentYear};

                month += offset;
                if (month < 1) {
                    month = 12;
                    year--;
                } else if (month > 12) {
                    month = 1;
                    year++;
                }

                $.ajax({
                    url: "Schedule",
                    type: "GET",
                    data: {month: month, year: year},
                    success: function (response) {
                        $("body").html(response); // Cập nhật nội dung trang
                    }
                });
            }

            $(".month-nav button").on("click", function () {
                let offset = $(this).text().includes("Tháng trước") ? -1 : 1;
                changeMonth(offset);
            });

            // Load slot theo ngày bằng AJAX
            $(document).on("click", ".load-slots", function (e) {
                e.preventDefault();
                let slotDate = $(this).data("date");

                $.ajax({
                    url: "Schedule",
                    type: "GET",
                    data: {slotDate: slotDate},
                    success: function (response) {
                        $(".slot-section").fadeOut(200, function () {
                            $(this).html($(response).find(".slot-section").html()).fadeIn(200);
                        });
                    }
                });
            });

            // Gửi form đặt lịch bằng AJAX
            $(document).on("submit", "form[action='Schedule']", function (e) {
                e.preventDefault();
                let formData = $(this).serialize();

                $.ajax({
                    url: "Schedule",
                    type: "POST",
                    data: formData,
                    success: function (response) {
                        alert("Đặt lịch thành công!");
                        $(".slot-section").fadeOut(200, function () {
                            $(this).html($(response).find(".slot-section").html()).fadeIn(200);
                        });
                    }
                });
            });
        });
    </script>
    <body>
        <%@include file="../sourcesHome/homeHeader.jsp" %>
        <!-- Breadcrumb -->
        <div class="breadcrumb-bar breadcrumb-bar-info">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-12">
                        <div class="breadcrumb-list">
                            <h2 class="breadcrumb-title">Update Request</h2>
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
        <!-- /Breadcrumb -->	

        <div class="content">
            <div class="container">
                <div class="row">

                    <div class="modal-body custom-modal-body col-md-7 col-lg-8 row">

                        <div class="wallet_content">
                            <div class="wallet_title">
                                <div class="col-md-6"> <h4>Wallet</h4> </div>

                                <div class="col-md-6"><h4>Mentee Details</h4>  </div>
                            </div>

                            <div class="wallet">
                                <div class="col-md-6">
                                    <div class="payment-amount">
                                        <h6 ><i class="fa fa-money" style="font-size:20px"></i> Account Balance(Số dư tài khoản):</h6>                                    
                                        <span>120.000</span>                                      
                                    </div> 
                                    <br>
                                    <div>
                                        <h6><a href="view/Wallet.jsp" class=" Recharge">Recharge</a></h6>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <ul>
                                        <li>
                                            <h6>Full Name</h6>
                                        <h7>${mentee.name}</h7>
                                        </li>
                                        <li>
                                            <h6>Email</h6>
                                        <h7>${mentee.email}</h7>
                                        </li>
                                    </ul>

                                </div>
                            </div>
                        </div><br>
                        <!-- Form chính để tạo Request -->
                        <form action="UpdateRquest" method="POST"> 
                            <div>
                                <h4>Add New Request</h4>
                            </div> 
                            <input type="hidden" name="mentee_id" value="${sessionScope.menteeId}">
                            <input type="hidden" name="mentor_id" value="${sessionScope.mentorId1}"/>
                            <input type="hidden" name="course_id" value="${sessionScope.courseId1}"/>
                       
                            <label>Title:</label>
                            <input class="inputtext" type="text" name="title" required/><br>
                            <br>
                            <!-- Lịch Mentor -->
                            <h10>Lịch Mentor - ${monthName} ${currentYear}</h10>
                            <div>                          
                                <div class="month-nav">
                                    <button type="button" onclick="changeMonth(-1)">⬅ Tháng trước</button>
                                    <button type="button" onclick="changeMonth(1)">Tháng sau ➡</button>
                                </div>

                                <table>
                                    <tr>
                                        <th>Sun</th><th>Mon</th><th>Tue</th><th>Wed</th><th>Thu</th><th>Fri</th><th>Sat</th>
                                    </tr>
                                    <tr>
                                        <c:forEach var="date" items="${dates}" varStatus="status">
                                            <c:if test="${status.index % 7 == 0 && status.index != 0}">
                                            </tr><tr>
                                            </c:if>
                                            <c:choose>
                                                <c:when test="${empty date}">
                                                    <td class="no-slot"></td>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:set var="formattedDate" value="${currentMonth}-${date}-${currentYear}" />
                                                    <td class="has-slot ${date == currentDay ? 'today' : ''}">
                                                        <a href="CreateRequest?slotDate=${formattedDate}&mentorId=${mentorId}&month=${currentMonth}&year=${currentYear}">
                                                            ${date}
                                                        </a>
                                                    </td>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </tr>
                                </table>
                            </div>
                             <!-- oi dng dung tam start date end date -->
                            <label>Start Date:</label>
                            <input class="date" type="date" name="start_date" required><br>

                            <label>End Date:</label>
                            <input class="date" type="date" name="end_date" required><br>
                            
                            <label>Content:</label>
                            <textarea class="contenttex" name="content" rows="3" required></textarea><br/>
                            <label>Total Slot:</label>
                            <input type="number" name="total_slot" required><br>
                            <button class="btn btn-enroll" type="submit" name="action" value="save_draft">Save as Draft</button>
                            <button class="btn btn-enroll" type="submit" name="action" value="submit">Submit</button>                          
                        </form>

                        <!-- Form riêng để đặt lịch -->
                        <c:if test="${not empty param.slotDate}">
                            <div class="slot-section">
                                <h3>Slot khả dụng cho ngày ${param.slotDate}</h3>
                                <form action="CreateRequest" method="post">
                                    <input type="hidden" name="action" value="book">
                                    <input type="hidden" name="slotDate" value="${param.slotDate}">
                                    <c:choose>
                                        <c:when test="${empty morningSlots and empty afternoonSlots and empty eveningSlots}">
                                            <p>Không có Slot nào khả dụng.</p>
                                        </c:when>
                                        <c:otherwise>
                                            <h4>🌞 Morning Slots</h4>
                                            <ul>
                                                <c:forEach var="slot" items="${morningSlots}">
                                                    <li>
                                                        <input type="checkbox" name="startTimes" value="${slot.startTime}"> ${slot.startTime}
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                            <h4>🌆 Afternoon Slots</h4>
                                            <ul>
                                                <c:forEach var="slot" items="${afternoonSlots}">
                                                    <li>
                                                        <input type="checkbox" name="startTimes" value="${slot.startTime}"> ${slot.startTime}
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                            <h4>🌙 Evening Slots</h4>
                                            <ul>
                                                <c:forEach var="slot" items="${eveningSlots}">
                                                    <li>
                                                        <input type="checkbox" name="startTimes" value="${slot.startTime}"> ${slot.startTime}
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </c:otherwise>
                                    </c:choose>
                                    <button type="submit">Đặt lịch</button>
                                </form>
                            </div>
                        </c:if>
                    </div>

                    <div class="col-md-5 col-lg-4 row">

                        <!-- Booking Summary -->
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Mentor detail</h4>
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
                                    </div>
                                </div>
                                <!-- Booking Doctor Info -->

                                <div class="booking-summary">
                                    <div class="booking-item-wrap">
                                         <div class="booking-total">
                                            <ul class="booking-total-list">
                                                <li>
                                                    <span>Total slot</span>
                                                    <span class="total-cost">5</span>
                                                </li>
                                            </ul>
                                        </div>

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

