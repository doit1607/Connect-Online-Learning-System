<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html> 

<html lang="en">

    <!-- Mirrored from dreamslms.dreamstechnologies.com/html/student-tickets.html by HTTrack Website Copier/3.x [XR&CO'2014], Tue, 11 Feb 2025 21:04:22 GMT -->
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>Dreams LMS</title>
        <link rel="shortcut icon" type="image/x-icon" href="/HAPPYorSAD/assets/img/favicon.svg">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/feather.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/boxicons/css/boxicons.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/select2/css/select2.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/dropzone/dropzone.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/owl.carousel.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/owl.theme.default.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/slick/slick.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/slick/slick-theme.css">

        <!-- AOS CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/aos/aos.css">

        <!-- Main CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css">
        <link rel="stylesheet" href="/HAPPYorSAD/css/cssRequestMnetee/RequestMentee.css"/>

        <!-- Theme Settings JS -->
        <script src="/HAPPYorSAD/assets/js/theme-script.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

        <style>
            .notification {
                position: fixed;
                top: 20px;
                right: 20px;
                background-color: red;
                color: white;
                border: 1px solid #ccc;
                padding: 15px;
                border-radius: 5px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.3);
                opacity: 0;
                transition: opacity 0.3s ease-in-out;
                z-index: 1000;
            }

            .notification.show {
                opacity: 1;
            }

            .notification p {
                margin: 0;
            }
            .updatebtn {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 8px 16px;
                font-size: 14px;
                font-weight: bold;
                text-decoration: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease-in-out;
            }

            .updatebtn:hover {
                background-color: #0056b3;
            }

            .updatebtn i {
                text-decoration: none;
            }
            .viewbtn {
                background-color: #28a745;
                color: white;
                border: none;
                padding: 8px 16px;
                font-size: 14px;
                font-weight: bold;
                text-decoration: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease-in-out;
            }

            .viewbtn:hover {
                background-color: #1e7e34;
            }

            .viewbtn i {
                text-decoration: none;
            }

        </style>
        <c:if test="${not empty sessionScope.msg}">
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    showNotification("${sessionScope.msg}");
                });
            </script>
            <c:remove var="msg" scope="session"/> 
        </c:if>
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
        </script>


    </head>

    <body>
        <div id="notification" class="notification">
            <p id="notification-message"></p>
        </div>
        <!-- Header -->
        <%@include file="../sourcesHome/homeHeader.jsp" %>
        <!-- /Header -->
        <div class="page-content">
            <div class="container">
                <div class="row">
                    <!-- sidebar -->
                    <!-- Breadcrumb -->
                    <div class="breadcrumb-bar breadcrumb-bar-info">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-12 col-12">
                                    <div class="breadcrumb-list">
                                        <h2 class="breadcrumb-title">List Request</h2>
                                        <nav aria-label="breadcrumb" class="page-breadcrumb">
                                            <ol class="breadcrumb">
                                                <li class="breadcrumb-item"><a href="Home">Home</a></li>
                                                <li class="breadcrumb-item active" aria-current="page">List Request</li>
                                            </ol>
                                        </nav>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /Breadcrumb -->	
                    <div class="col-xl-3 col-lg-3 theiaStickySidebar">

                        <div class="settings-widget account-settings">
                            <div class="settings-menu">
                                <h3>Dashboard</h3>
                                <ul>
                                    <li class="nav-item">
                                        <a href="/../HAPPYorSAD/ProfileServlet" class="nav-link">
                                            <i class="bx bxs-user"></i>Profile
                                        </a>
                                    </li>
                                    <li class="nav-item active">
                                        <a href="/../HAPPYorSAD/ShowMenteeRequest" class="nav-link">
                                            <i class="bx bxs-graduation"></i>Request
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="/../HAPPYorSAD/AttendanceMentee" class="nav-link">
                                            <i class="bx bxs-check-circle"></i>Attendance
                                        </a>
                                    </li>
                                    <c:if test="${sessionScope.menteeRequestStatus eq 'Completed'}">
                                        <li class="nav-item">
                                            <a href="reviewmentor" class="nav-link">
                                                <i class="bx bxs-bell"></i> Review Mentor
                                            </a>
                                        </li>
                                    </c:if>
                                </ul>
                                <h3>Account Settings</h3>
                                <ul>
                                    <li class="nav-item">
                                        <a href="updatementeeprofile?username=${sessionScope.usernameUser}" class="nav-link ">
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
                    <!-- /Sidebar -->

                    <!-- Page Content -->
                    <div class="col-md-9"> 
<!--                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <form action="ShowMenteeRequest" method="get" class="d-flex "> 
                                <input name="txt" type="text" id="searchInput" class="form-control me-2" style="max-width: 250px;" placeholder="Enter Course Name...">
                                <button type="submit" class="btn btn-primary px-4">Search</button>
                            </form>                                                      
                        </div>-->
                        <div class="formcontent">
                            <div>  
                                <table class="tablecontent">
                                    <thead>
                                        <tr>
                                            <td>Title</td>
                                            <td>Content</td>
                                            <td>TotalSlot</td>
                                            <td>Deadline Start</td>
                                            <td>Deadline End</td>
                                            <td>Status</td>
                                            <td>Action</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${sessionScope.listAllRequest}" var="o">
                                            <tr>
                                                <td>${o.title}</td>
                                                <td>${o.content}</td>
                                                <td>${o.totalSlot}</td>
                                                <td>${o.startDate}</td>
                                                <td>${o.endDate}</td>                                            
                                                <td>${o.status}</td>
                                                <td>
                                                    <c:if test="${o.status eq 'Draft'}">                                                           
                                                        <a href="/../HAPPYorSAD/test?mentorId=${o.mentorId}&courseId=${o.courseId}&title=${o.title}&content=${o.content}&startdate=${o.startDate}&enddate=${o.endDate}&requestId=${o.id}&service=update" class="updatebtn">Update</a>
                                                    </c:if>
                                                    <c:if test="${o.status != 'Draft'}">
                                                        <button type="button" class="viewbtn" data-bs-toggle="modal" data-bs-target="#requestModal_${o.id}">
                                                            View
                                                        </button>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <c:forEach items="${sessionScope.listAllRequest}" var="o">
                                    <div class="modal fade" id="requestModal_${o.id}" tabindex="-1" 
                                         aria-labelledby="requestModalLabel_${o.id}" aria-hidden="true">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="requestModalLabel_${o.id}">Request Details</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="request-details">
                                                        <p><strong>Mentor name:</strong> ${o.mentorname}</p>
                                                        <p><strong>Course name:</strong> ${o.coursename}</p>
                                                        <p><strong>Title:</strong> ${o.title}</p>
                                                        <p><strong>Content:</strong> ${o.content}</p>
                                                        <p><strong>Total Slots:</strong> ${o.totalSlot}</p> 
                                                        <p><strong>Total Price:</strong> <fmt:formatNumber value="${o.totalprice}" type="number" groupingUsed="true" />₫</p>
                                                        <p><strong>Deadline Start:</strong> ${o.startDate}</p>
                                                        <p><strong>Deadline End:</strong> ${o.endDate}</p>
                                                        <p><strong>Status:</strong> ${o.status}</p>
                                                        <p><strong>Schedule:</strong></p>
                                                        <div id="schedule-table-${o.id}"></div> <!-- Placeholder for schedule table -->


                                                        <c:if test="${specificRequestId eq o.id}">
                                                            <p><strong>Present Slots:</strong> ${presentCount}</p>
                                                            <p><strong>Absent Slots:</strong> ${absentCount}</p>
                                                            <p><strong>Refund Amount (for Absent Slots):</strong> <fmt:formatNumber value="${refundAmount}" type="number" groupingUsed="true" />₫</p>
                                                            <p><strong>Final Price (after Refund):</strong> <fmt:formatNumber value="${finalPrice}" type="number" groupingUsed="true" />₫</p>
                                                        </c:if>
                                                    </div>

                                                    <!-- Add JavaScript to load the schedule table when the modal is shown -->
                                                    <script>
                                                        document.addEventListener('DOMContentLoaded', function () {
                                                            const modal = document.getElementById('requestModal_${o.id}');
                                                            modal.addEventListener('shown.bs.modal', function () {
                                                                fetch('fetchSlot?requestId=${o.id}')
                                                                        .then(response => response.text())
                                                                        .then(data => {
                                                                            document.getElementById('schedule-table-${o.id}').innerHTML = data;
                                                                        })
                                                                        .catch(error => {
                                                                            console.error('Error loading schedule:', error);
                                                                            document.getElementById('schedule-table-${o.id}').innerHTML = '<p>Error loading schedule.</p>';
                                                                        });
                                                            });
                                                        });
                                                    </script>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>

                                                    <!-- Accept Request Button -->
                                                    <c:if test="${specificRequestId eq o.id and o.status ne 'Completed'}">
                                                        <form action="/HAPPYorSAD/ShowMenteeRequest" method="post" style="display:inline;">
                                                            <input type="hidden" name="action" value="CompleteRequest">
                                                            <input type="hidden" name="requestId" value="${o.id}">
                                                            <input type="hidden" name="totalPrice" value="${totalPrice}">
                                                            <input type="hidden" name="refundAmount" value="${refundAmount}">
                                                            <input type="hidden" name="finalPrice" value="${finalPrice}">
                                                            <button type="submit" class="btn btn-success">Complete Request</button>
                                                        </form>

                                                        <!-- Add More Slots Button -->
                                                        <c:if test="${absentCount > 0}">
                                                            <form action="/HAPPYorSAD/ShowMenteeRequest" method="post" style="display:inline;">
                                                                <input type="hidden" name="action" value="addMoreSlots">
                                                                <input type="hidden" name="requestId" value="${o.id}">
                                                                <button type="submit" class="btn btn-primary">Add More Slots</button>
                                                            </form>
                                                        </c:if>
                                                    </c:if>

                                                    <!-- Complete Request Button (for Accepted status with no absent slots) -->
                                                    <c:if test="${o.status eq 'Accepted' and specificRequestId eq o.id and absentCount == 0}">
                                                        <form action="/HAPPYorSAD/ShowMenteeRequest" method="post" style="display:inline;">
                                                            <input type="hidden" name="action" value="CompleteRequest">
                                                            <input type="hidden" name="requestId" value="${o.id}">
                                                            <input type="hidden" name="totalPrice" value="${totalPrice}">
                                                            <input type="hidden" name="refundAmount" value="${refundAmount}">
                                                            <input type="hidden" name="finalPrice" value="${finalPrice}">
                                                            <button type="submit" class="btn btn-warning">Complete Request</button>
                                                        </form>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Schedule fetch script -->
                                    <script>
                                        document.getElementById('requestModal_${o.id}').addEventListener('shown.bs.modal', function () {
                                            fetch('fetchSlot?requestId=${o.id}')
                                                    .then(response => response.text())
                                                    .then(data => {
                                                        document.getElementById('schedule-table-${o.id}').innerHTML = data;
                                                    })
                                                    .catch(error => {
                                                        console.error('Error loading schedule:', error);
                                                        document.getElementById('schedule-table-${o.id}').innerHTML = '<p>Error loading schedule.</p>';
                                                    });
                                        });
                                    </script>

                                </c:forEach>
                            </div>
                        </div>

                        <!-- /pagination -->
                        <div class="row">
                            <div class="col-md-12">
                                <!-- Pagination -->
                                <div class="pagination">
                                    <c:if test="${tag > 1}">
                                        <li class="page-item">
                                            <a href="ShowMenteeRequest?index=${tag-1}" class="page-link">Previous</a>
                                        </li>
                                    </c:if>

                                    <c:forEach begin="1" end="${endPage}" var="i">
                                        <a class="page-link ${tag == i?'active':''}" href="ShowMenteeRequest?index=${i}">${i}</a>
                                    </c:forEach>

                                    <c:if test="${tag < endPage}">
                                        <li class="page-item">
                                            <a href="ShowMenteeRequest?index=${tag+1}" class="page-link">Next</a>
                                        </li>
                                    </c:if>
                                </div>
                                <!-- /Pagination -->                              
                            </div>
                        </div>
                        <!-- /pagination -->

                    </div>
                </div>
            </div>
        </div>
        <!-- /Page Content -->

        <!-- Footer -->
        <%@include file="../sourcesHome/homeFooter.jsp" %>
        <!-- Cloudflare Email Decode -->
        <script data-cfasync="false" src="/HAPPYorSAD/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script>

        <!-- jQuery -->
        <script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js"></script>

        <!-- Bootstrap Core JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Select2 JS -->
        <script src="/HAPPYorSAD/assets/plugins/select2/js/select2.min.js"></script>

        <!-- CKEditor JS -->
        <script src="/HAPPYorSAD/assets/js/ckeditor.js"></script>

        <!-- Dropzone JS -->
        <script src="/HAPPYorSAD/assets/plugins/dropzone/dropzone.min.js"></script>

        <!-- Sticky Sidebar JS -->
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/ResizeSensor.js"></script>
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js"></script>

        <!-- Owl Carousel & Slick JS -->
        <script src="/HAPPYorSAD/assets/js/owl.carousel.min.js"></script>
        <script src="/HAPPYorSAD/assets/plugins/slick/slick.js"></script>

        <!-- AOS Animation JS -->
        <script src="/HAPPYorSAD/assets/plugins/aos/aos.js"></script>

        <!-- Counter & Waypoints -->
        <script src="/HAPPYorSAD/assets/js/jquery.waypoints.js"></script>
        <script src="/HAPPYorSAD/assets/js/jquery.counterup.min.js"></script>

        <!-- Custom JS -->
        <script src="/HAPPYorSAD/assets/js/script.js"></script>
        <script src="/HAPPYorSAD/assets/js/theme-script.js"></script>

        <!-- Cloudflare Performance Optimization -->
        <script defer src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015"
                integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ==" 
                data-cf-beacon='{"rayId":"91074a70ad7f06b9","version":"2025.1.0","serverTiming":{"name":{"cfExtPri":true,"cfL4":true,"cfSpeedBrain":true,"cfCacheStatus":true}},"token":"3ca157e612a14eccbb30cf6db6691c29","b":1}' 
        crossorigin="anonymous"></script>

    </body>

    <!-- Mirrored from dreamslms.dreamstechnologies.com/html/student-tickets.html by HTTrack Website Copier/3.x [XR&CO'2014], Tue, 11 Feb 2025 21:04:22 GMT -->
</html>