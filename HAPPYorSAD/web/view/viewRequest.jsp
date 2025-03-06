<%-- 
    Document   : viewRequest.jsp
    Created on : Feb 17, 2025, 5:17:52 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>Dreams LMS</title>

        <!-- Favicon -->
        <link rel="shortcut icon" type="image/x-icon" href="/HAPPYorSAD/assets/img/favicon.svg">


        <!-- Theme Settings Js -->
        <script src="/HAPPYorSAD/assets/js/theme-script.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap.min.css">

        <!-- Fontawesome CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/all.min.css">

        <!-- Feather CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/feather.css">

        <!-- Select2 CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/select2/css/select2.min.css">

        <!-- Dropzone -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/dropzone/dropzone.min.css">

        <!-- Boxioons CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/boxicons/css/boxicons.min.css">

        <!-- Main CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css">

        <!--<link rel="stylesheet" href="/HAPPYorSAD/assets/css/custom.css">-->
        <link href="css/Request.css" rel="stylesheet" type="text/css"/>





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
        <script defer src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015" integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ==" data-cf-beacon='{"rayId":"91074a70ad7f06b9","version":"2025.1.0","serverTiming":{"name":{"cfExtPri":true,"cfL4":true,"cfSpeedBrain":true,"cfCacheStatus":true}},"token":"3ca157e612a14eccbb30cf6db6691c29","b":1}' crossorigin="anonymous"></script>

        <link href="css/cssCRUD/createCV.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="../sourcesHome/homeHeader.jsp" %>

        <!--screen here-->
        <div class="container" style="margin-top: 100px; margin-bottom: 100px">
            <div class = "row">
                <!-- sidebar -->
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
                                    <a href="instructor-reviews.html" class="nav-link">
                                        <i class="bx bxs-star"></i>Reviews
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="/../HAPPYorSAD/Slot" class="nav-link">
                                        <i class="bx bxs-tachometer"></i>Schedule
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="Notifications" class="nav-link">
                                        <i class="bx bxs-bell"></i>Notifications
                                    </a>
                                </li>

                            </ul>
                            <h3>Instructor</h3>
                            <ul>
                                <li class="nav-item">
                                    <a href="/../HAPPYorSAD/ViewCV" class="nav-link ">
                                        <i class="bx bxs-rocket"></i>My Curriculum Vitae
                                    </a>
                                </li>
                                <li class="nav-item active">
                                    <a href="/../HAPPYorSAD/viewRequest" class="nav-link">
                                        <i class="bx bxs-graduation"></i>Inviting Request
                                    </a>
                                </li>
                            </ul>
                            <h3>Account Settings</h3>
                            <ul>
                                <li class="nav-item">
                                    <a href="updatementorprofile?username=${sessionScope.usernameUser}" class="nav-link ">
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
                <div class="col-lg-9 col-xl-9">
                    <div>
                        <h3>Requests</h3>
                        <span id="toggleFilter" style="cursor: pointer;">
                            <i class="fas fa-chevron-down"></i>
                        </span>
                    </div>

                    <div class="dashboard-header">
                        <div id="filterContainer" style="display: none;">    

                            <form action="viewRequest" method="GET">
                                <div class="row">

                                    <div class="col-md-8">
                                        Title:
                                        <input type="text" name="title" class="form-control" placeholder="Search title" value="${param.title}">
                                    </div>


                                    <div class="col-md-4">
                                        Created:
                                        <select name="date" id="date-range" class="form-select">
                                            <option value="0" ${param.date == '0' || empty param.date ? 'selected' : ''}>All</option>
                                            <option value="1" ${param.date == '1' ? 'selected' : ''}>Today</option>
                                            <option value="2" ${param.date == '2' ? 'selected' : ''}>Last 7 Days</option>
                                            <option value="3" ${param.date == '3' ? 'selected' : ''}>This Month</option>
                                        </select>
                                    </div>
                                    <div class="col-md-12" style="margin-top: 8px">
                                        <label>Status:</label><br>
                                        <input type="checkbox" name="status" value="Open" id="status-opening" ${param.status == 'Open' ? 'checked' : ''}>
                                        <label for="status-opening">Opening</label>
                                        &nbsp;&nbsp;&nbsp;
                                        <input type="checkbox" name="status" value="Closed" id="status-closed" ${param.status == 'Closed' ? 'checked' : ''}>
                                        <label for="status-closed">Closed</label>
                                        &nbsp;&nbsp;&nbsp;

                                        <input type="checkbox" name="status" value="Cancel" id="status-cancelled" ${param.status == 'Cancel' ? 'checked' : ''}>
                                        <label for="status-cancelled">Cancelled</label>
                                        &nbsp;&nbsp;&nbsp;

                                        <input type="checkbox" name="status" value="Processing" id="status-processing" ${param.status == 'Processing' ? 'checked' : ''}>
                                        <label for="status-processing">Processing</label>
                                    </div>


                                    <div class="col-md-12 mt-2">
                                        <button type="submit" class="btn btn-primary">Filter</button>
                                    </div>
                                </div>
                            </form>

                        </div>           
                    </div>
                    <!--<div class="col-lg-9 col-xl-9">
                        <h3>
                            Requests 
                            <span id="toggleFilter" style="cursor: pointer;">
                                <i class="fas fa-chevron-down"></i>
                            </span>
                        </h3>
                    
                        <div class="dashboard-header">
                            <div id="filterContainer" style="display: none;">
                                <form action="viewRequest" method="GET">
                                    <div class="row">
                                         Search Title 
                                        <div class="col-md-4">
                                            <input type="text" name="" class="form-control" placeholder="Search title" value="">
                                        </div>
                    
                                         Status Checkbox 
                                        <div class="col-md-5">
                                            <label>Status:</label><br>
                                            <input type="checkbox" name="" value="Open" id="status-opening" >
                                            <label for="status-opening">Opening</label>
                    
                                            <input type="checkbox" name="" value="Closed" id="status-closed">
                                            <label for="status-closed">Closed</label>
                    
                                            <input type="checkbox" name="" value="Cancelled" id="status-cancelled" >
                                            <label for="status-cancelled">Cancelled</label>
                    
                                            <input type="checkbox" name="" value="Processing" id="status-processing">
                                            <label for="status-processing">Processing</label>
                                        </div>
                    
                                         Date Range Dropdown 
                                        <div class="col-md-3">
                                            <select name="date" id="date-range" class="form-select">
                                                <option value="0" ${param.date == '0' || empty param.date ? 'selected' : ''}>All</option>
                                                <option value="1" ${param.date == '1' ? 'selected' : ''}>Today</option>
                                                <option value="2" ${param.date == '2' ? 'selected' : ''}>Last 7 Days</option>
                                                <option value="3" ${param.date == '3' ? 'selected' : ''}>This Month</option>
                                            </select>
                                        </div>
                    
                                         Filter Button 
                                        <div class="col-md-12 mt-2">
                                            <button type="submit" class="btn btn-primary">Filter</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>-->

                    <c:forEach var="request" items="${requests}">
                        <div class="appointment-wrap " >
                            <ul>
                                <li>
                                    <div class="patinet-information">
                                        <a href="#">
                                            <img src="${request.getMentee().getAvatarPath()}" alt="img">
                                        </a>
                                        <div class="patient-info">
                                            <p>Mentee</p>
                                            <h6><a href="#">${request.getMentee().getFullname()}</a></h6>
                                        </div>
                                    </div>
                                </li>
                                <li class="appointment-info" style="width: 50px">
                                    <p class="md-text">Title</p>
                                    <p><i class="isax isax-clock5"></i>${request.getTitle()}</p>
                                </li>
                                <li class="appointment-info">
                                    <p class="md-text">Start Date</p>
                                    <p><i class="isax isax-clock5"></i>${request.getStartDate()}</p>
                                </li>
                                <li class="appointment-info">
                                    <p class="md-text">End Date</p>
                                    <p><i class="isax isax-clock5"></i>${request.getEndDate()}</p>
                                </li>
                            </ul>
                            <div class="d-flex justify-content-end">
                                <button type="button" class="btn btn-secondary" 
                                        data-bs-toggle="modal" 
                                        data-bs-target="#acceptAppointmentModal_${request.getId()}">
                                    <i class="fa-solid fa-info"></i>&nbsp;Details
                                </button>
                            </div>

                        </div>

                        <!-- Modal cho từng request -->
                        <div class="modal fade" id="acceptAppointmentModal_${request.getId()}" tabindex="-1" 
                             aria-labelledby="acceptModalLabel_${request.getId()}" aria-hidden="true">
                            <div class="modal-dialog modal-xl">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h2 class="modal-title" id="acceptModalLabel_${request.getId()}">Request Details</h2>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i></button>
                                        <hr/>
                                    </div>
                                    <div class="modal-body">
                                        <div class="patinet-information">
                                            <a href="patient-profile.html">
                                                <img src="${request.getMentee().getAvatarPath()}" alt="img">
                                            </a>
                                            <div class="patient-info">
                                                <p>Mentee</p>
                                                <h6><a href="patient-profile.html">${request.getMentee().getFullname()}</a></h6>
                                            </div>
                                        </div>
                                        <div style="margin-top: 8px"><h3>${request.getTitle()}</h3></div>
                                        <hr/>
                                        <div><p><i class="isax isax-clock5"></i>${request.getContent()}</p></div>
                                        <hr/>

                                        <h3 style="margin-bottom: 18px">Courses</h3>


                                        <c:forEach var="course" items="${request.getRequestedCourses()}">
                                            <div class="card mb-3" style="max-width: 540px;">
                                                <div class="row g-0">
                                                    <div class="col-md-4">
                                                        <img src="${course.image}" class="img-fluid rounded-start" alt="img">
                                                    </div>
                                                    <div class="col-md-8">
                                                        
                                                        <div class="card-body">

                                                            <h5 class="card-title">${course.title}</h5>
                                                            <p class="card-text">${course.description}</p>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        <h3 style="margin-bottom: 18px">Schedule</h3>
                                        <i>Updating</i>
                                    </div>
                                    <div class="modal-footer">
                                        <ul class="request-action">
                                            <c:choose>
                                                <c:when test="${request.status eq 'Cancel'}">
                                                    <li><span class="text-danger"><i class="fa-solid fa-xmark"></i>Request Rejected</span></li>
                                                    </c:when>
                                                    <c:when test="${request.status eq 'Closed'}">
                                                    <li><span class="text-muted"><i class="fa-solid fa-lock"></i>Request Closed</span></li>
                                                    </c:when>
                                                    <c:when test="${request.status eq 'Processing'}">
                                                    <li><span class="text-success"><i class="fa-solid fa-check"></i>Request Accepted</span></li>
                                                    </c:when>
                                                    <c:when test="${request.status eq 'Open'}">
                                                    <li>
                                                        <form action="viewRequest" method="POST">
                                                            <input type="hidden" name="id" value="${request.id}">
                                                            <input type="hidden" name="status" value="Processing">
                                                            <button type="button" class="btn btn-success" onclick="confirmAccept(this)">
                                                                <i class="fa-solid fa-check"></i> Accept
                                                            </button>
                                                        </form>
                                                    </li>
                                                    <li>
                                                        <form action="viewRequest" method="POST" >
                                                            <input type="hidden" name="id" value="${request.id}">
                                                            <input type="hidden" name="status" value="Cancel">
                                                            <button type="button" class="btn btn-danger" onclick="return confirmReject(this)">
                                                                <i class="fa-solid fa-xmark"></i> Reject
                                                            </button>
                                                        </form>
                                                    </li>
                                                </c:when>
                                            </c:choose>
                                        </ul>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <nav>
                        <ul class="pagination">
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="viewRequest?date=${param.date}&limit=${limit}&page=${i}">${i}</a>
                                </li>
                            </c:forEach>
                        </ul>

                    </nav>
                </div>  
            </div>

        </div>


        <%@include file="../sourcesHome/homeFooter.jsp" %>    


        <!-- /Footer -->

        <!-- /Main Wrapper -->

        <!-- jQuery -->
        <script data-cfasync="false" src="../cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script><script src="assets/js/jquery-3.7.1.min.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

        <!-- Bootstrap Core JS -->
        <script src="assets/js/bootstrap.bundle.min.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

        <!-- Select2 JS -->
        <script src="assets/plugins/select2/js/select2.min.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

        <!-- Ckeditor JS -->
        <script src="assets/js/ckeditor.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

        <!-- Dropzone JS -->
        <script src="assets/plugins/dropzone/dropzone.min.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

        <!-- Sticky Sidebar JS -->
        <script src="assets/plugins/theia-sticky-sidebar/ResizeSensor.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>
        <script src="assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

        <!-- Custom JS -->
        <script src="assets/js/script.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

        <script src="../cdn-cgi/scripts/7d0fa10a/cloudflare-static/rocket-loader.min.js" data-cf-settings="27bb6e11b88bb1c6a1b7b5ff-|49" defer></script><script defer src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015" integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ==" data-cf-beacon='{"rayId":"9107445c681fe2ec","version":"2025.1.0","serverTiming":{"name":{"cfExtPri":true,"cfL4":true,"cfSpeedBrain":true,"cfCacheStatus":true}},"token":"3ca157e612a14eccbb30cf6db6691c29","b":1}' crossorigin="anonymous"></script>
        <script>
                                                                function confirmAccept(button) {
                                                                    if (confirm("Are you sure you want to accept?")) {
                                                                        let form = button.closest("form");
                                                                        form.submit();
                                                                    }
                                                                }

                                                                function confirmReject(button) {
                                                                    let reason = prompt("Please enter the reason for rejection:");
                                                                    if (reason) {
                                                                        // Tìm form cha của nút Reject
                                                                        let form = button.closest("form");

                                                                        // Thêm input ẩn để gửi lý do reject
                                                                        let input = document.createElement("input");
                                                                        input.type = "hidden";
                                                                        input.name = "reject_reason";
                                                                        input.value = reason;
                                                                        form.appendChild(input);

                                                                        // Gửi form
                                                                        form.submit();
                                                                    }
                                                                }
                                                                document.getElementById("toggleFilter").addEventListener("click", function () {
                                                                    var filterContainer = document.getElementById("filterContainer");
                                                                    var icon = this.querySelector("i");

                                                                    if (filterContainer.style.display === "none") {
                                                                        filterContainer.style.display = "block";
                                                                        icon.classList.remove("fa-chevron-down");
                                                                        icon.classList.add("fa-chevron-up");
                                                                    } else {
                                                                        filterContainer.style.display = "none";
                                                                        icon.classList.remove("fa-chevron-up");
                                                                        icon.classList.add("fa-chevron-down");
                                                                    }
                                                                });
                                                                document.addEventListener("DOMContentLoaded", function () {
                                                                    var filterContainer = document.getElementById("filterContainer");
                                                                    var toggleFilter = document.getElementById("toggleFilter");

                                                                    // Kiểm tra localStorage để quyết định có hiển thị bộ lọc không
                                                                    if (localStorage.getItem("filterVisible") === "true") {
                                                                        filterContainer.style.display = "block";
                                                                        toggleFilter.innerHTML = "&#9650;"; // Mũi tên hướng lên
                                                                    }

                                                                    // Khi nhấn vào toggle, ẩn/hiện bộ lọc và lưu trạng thái
                                                                    toggleFilter.addEventListener("click", function () {
                                                                        if (filterContainer.style.display === "none") {
                                                                            filterContainer.style.display = "block";
                                                                            toggleFilter.innerHTML = "&#9650;";
                                                                            localStorage.setItem("filterVisible", "true");
                                                                        } else {
                                                                            filterContainer.style.display = "none";
                                                                            toggleFilter.innerHTML = "&#9660;";
                                                                            localStorage.setItem("filterVisible", "false");
                                                                        }
                                                                    });
                                                                });
        </script>
    </body>
</html>
