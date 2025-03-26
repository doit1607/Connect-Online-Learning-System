<%-- 
    Document   : AcceptCV
    Created on : Feb 16, 2025, 11:52:34 PM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <!-- Mirrored from dreamslms.dreamstechnologies.com/html/mentee-settings.html by HTTrack Website Copier/3.x [XR&CO'2014], Tue, 11 Feb 2025 21:04:22 GMT -->
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>Dreams LMS</title>

        <link rel="shortcut icon" type="image/x-icon" href="/HAPPYorSAD/assets/img/favicon.svg">


        <!-- Theme Settings Js -->
        <script src="/HAPPYorSAD/assets/js/theme-script.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.3.0/chart.umd.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <!--<link href="css/cssCRUD/rating.css" rel="stylesheet" type="text/css"/>-->
        <style>
            .table-responsive {
    max-height: 300px; /* Giới hạn chiều cao của bảng */
    overflow-y: auto; /* Tạo thanh cuộn dọc */
}
            .badge-rank {
    position: absolute;
    top: 10px;
    left: 10px;
    background-color: #ff5722;
    color: white;
    font-weight: bold;
    padding: 5px 10px;
    border-radius: 5px;
    font-size: 16px;
}

.card {
    border-radius: 15px;
    overflow: hidden;
    transition: transform 0.3s ease-in-out;
}

.card:hover {
    transform: scale(1.05);
}

.btn-primary {
    background-color: #ff5722;
    border: none;
}

.btn-primary:hover {
    background-color: #e64a19;
}
.avatar {
    width: 50px; /* Điều chỉnh kích thước nhỏ hơn */
    height: 50px; /* Phải bằng width để ảnh tròn */
    border-radius: 50%; /* Làm cho ảnh tròn */
    object-fit: cover; /* Cắt ảnh để vừa khung tròn */
}
        </style>
    </head>
    <body>
        <!-- Main Wrapper -->
        <div class="main-wrapper">
            <!-- Header -->
            <%@include file="/../sourcesHome/headerManager.jsp" %>
            <!-- /Header -->
            <!-- Breadcrumb -->
            <div class="breadcrumb-bar breadcrumb-bar-info">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 col-12">
                            <div class="breadcrumb-list">
                                <h2 class="breadcrumb-title">Manager</h2>

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
                            <div class="settings-widget account-settings">
                                <div class="settings-menu">
                                    <h3 onclick="window.location.href='/HAPPYorSAD/Manager'">Dashboard</h3>
                                    <ul>
                                        <li class="nav-item">
                                            <a href="/../HAPPYorSAD/AcceptCV" class="accept-cv">
                                                <i class="fas fa-user"></i>Manage CV
                                            </a>
                                        <li class="nav-item">
                                            <a href="CourseManager" class="nav-link">
                                                <i class="bx bxs-graduation"></i>Manage Courses
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="ApproveCourse" class="nav-link">
                                                <i class="bx bxs-graduation"></i>Request Course
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="ConfirmSchedule" class="nav-link">
                                                <i class="bx bxs-graduation"></i>Manage Schedule
                                            </a>
                                        </li>

                                        <li class="nav-item">
                                            <a href="ShowAllRequest" class="nav-link">
                                                <i class="bx bxs-heart"></i>Manage Request Mentee
                                            </a>
                                        </li>

                                        <li class="nav-item">
                                            <a href="menteestatistic" class="nav-link">
                                                <i class="bx bxs-user-plus"></i>Manage Static Mentee
                                            </a>
                                        </li>
                                    </ul>

                                    <ul>
                                        <li class="nav-item">
                                            <a href="LoginUser?service=logout" class="nav-link">
                                                <i class="bx bxs-log-out"></i>Logout
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-9 col-lg-9">
                            <div class="container-fluid">
                                <div class="row">
							<div class="col-md-4 stretch-card grid-margin">
								<div class="card bg-gradient-danger card-img-holder text-white">
									<div class="card-body border border-secondary">
										
										<h4 class="font-weight-normal mb-3">
											Number of Mentors
											<i class="mdi mdi-chart-line mdi-24px float-end"></i>
										</h4>
										<h2 class="mb-5">${mentorCount}</h2>
										
									</div>
								</div>
							</div>
							<div class="col-md-4 stretch-card grid-margin">
								<div class="card bg-gradient-info card-img-holder text-white">
									<div class="card-body border border-success">
										
										<h4 class="font-weight-normal mb-3">
											Number of Mentees
											<i
												class="mdi mdi-bookmark-outline mdi-24px float-end"
											></i>
										</h4>
										<h2 class="mb-5">${menteeCount}</h2>
										
									</div>
								</div>
							</div>
							<div class="col-md-4 stretch-card grid-margin">
								<div
									class="card bg-gradient-success card-img-holder text-white"
								>
									<div class="card-body border border-primary">
										
										<h4 class="font-weight-normal mb-3">
											Number of Courses
											<i class="mdi mdi-diamond mdi-24px float-end"></i>
										</h4>
										<h2 class="mb-5">${courseCount}</h2>
										
									</div>
								</div>
							</div>
						</div>
                                <div class="row">
							
							<div class="col-md-6 stretch-card grid-margin">
								<div class="card bg-gradient-info card-img-holder text-white">
									<div class="card-body border border-info">
										
										<h4 class="font-weight-normal mb-3">
											Completed Requests
											<i
												class="mdi mdi-bookmark-outline mdi-24px float-end"
											></i>
										</h4>
										<h2 class="mb-5">${requestCompleted}</h2>
										
									</div>
								</div>
							</div>
							<div class="col-md-6 stretch-card grid-margin">
								<div
									class="card bg-gradient-success card-img-holder text-white"
								>
									<div class="card-body border border-danger">
										
										<h4 class="font-weight-normal mb-3">
											Total Revenue
											<i class="mdi mdi-diamond mdi-24px float-end"></i>
										</h4>
										<h2 class="mb-5">$ ${earning}</h2>
										
									</div>
								</div>
							</div>
						</div>
                                
                                
                                
                                
                                                <!--Charts-->
                                                
                                                                        <div class="row">

                            <div class="col-12 col-lg-7" >
                <div class="card">
                        <div class="card-header">
                                <h5 class="card-title">Number of new Mentors and Mentees by month</h5>
                        </div>
                        <div class="card-body">
                                <div class="chart" style="height: 400px">
                                        <canvas id="mentorMenteeChart"></canvas>
                                </div>
                        </div>
                </div>
            </div>
            <div class="col-12 col-lg-5">
                    <div class="card">
                            <div class="card-header">
                                    <h5 class="card-title">Request Status</h5>
                                   
                            </div>
                            <div class="card-body">
                                    <div class="chart" style="height: 400px">
                                            <canvas id="requestStatusChart" ></canvas>
                                    </div>
                            </div>
                    </div>
            </div>
                        </div>


                                                
                                                
						<div class="row">
							<div class="col-12 grid-margin">
								<div class="card">
									<div class="card-body">
										<h4 class="card-title">Top 10 Mentors By Earning</h4>
										<div class="table-responsive">
											<table class="table">
												<thead>
													<tr>
														<th></th>
														<th>Name</th>
														<th>Email</th>
														<th>Earning</th>
													</tr>
												</thead>
                                                                                                
												<tbody>
                                                                                                    <c:forEach var="m" items="${top10mentorByEarning}">

													<tr>
														<td>
															<img
																src="${m.image}"
																class="me-2 avatar"
																alt="image"
															/>
															
														</td>
														<td>${m.name}</td>
														<td>
															${m.email}
														</td>
														
														<td>${m.revenue*0.8}</td>
													</tr>
                                                                                                        </c:forEach>
													
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
                                                    <div class="col-12 grid-margin">
								<div class="card">
									<div class="card-body">
										<h4 class="card-title">Top 10 Mentors By Earning</h4>
										<div class="table-responsive">
											<table class="table">
												<thead>
													<tr>
														<th></th>
														<th>Name</th>
														<th>Email</th>
														<th>Rating</th>
													</tr>
												</thead>
                                                                                                
												<tbody>
                                                                                                    <c:forEach var="m" items="${top10mentorByRating}">

													<tr>
														<td>
															<img
																src="${m.image}"
																class="me-2 avatar"
																alt="image"
															/>
															
														</td>
														<td>${m.name}</td>
														<td>
															${m.email}
														</td>
														
														<td>${m.rating}</td>
													</tr>
                                                                                                        </c:forEach>
													
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
                                                <div class="row">
							<div class="col-12 grid-margin">
								<div class="card">
									<div class="card-body">
										<h4 class="card-title">Top 10 Mentees</h4>
										<div class="table-responsive">
											<table class="table">
												<thead>
													<tr>
														<th></th>
														<th>Name</th>
														<th>Email</th>
														<th>Spending</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="m" items="${top10Mentee}">

													<tr>
														<td>
															<img
																src="${m.image}"
																class="me-2 avatar"
																alt="image"
															/>
															
														</td>
														<td>${m.name}</td>
														<td>
															${m.email}
														</td>
														
														<td>${m.totalSpent}</td>
													</tr>
                                                                                                        </c:forEach>
													
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
                                                
<!--                                                <div class="row row-cols-1 row-cols-md-5 g-3">
                                                    <h4 class="col-12">Top 5 Favorite Courses</h4>
                                                    <c:forEach var="course" items="${favoriteCourses}">
                                                        <div class="col">
                                                            <div class="card h-100">
                                                                <img src="${course.image}" class="card-img-top" style="height: 200px;" alt="Course Image">
                                                                <div class="card-body">
                                                                    <h5 class="card-title">${course.title}</h5>
                                                                    <p class="card-text">${course.description}</p>
                                                                    <a href="/CourseDetails?Cid=${course.id}" class="btn btn-primary">View details</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </div>-->
<div class="container mt-4">
    <h2 class="text-center mb-4">🏆 Top 5 Favorite Courses 🏆</h2>
    <div class="row">
        <c:forEach var="course" items="${favoriteCourses}" varStatus="status">
            <div class="col-md-4 mb-4" <c:if test="${status.index >= 3}">style="flex: 0 0 50%; max-width: 33%;"</c:if>>
                <div class="card h-100 shadow-lg">
                    <div class="position-relative">
                        <span class="badge-rank">#${status.index + 1}</span>
                        <img src="${course.image}" class="card-img-top" style="height: 200px; object-fit: cover;" alt="Course Image">
                    </div>
                    <div class="card-body text-center">
                        <h5 class="card-title">${course.title}</h5>
                        Total Enroll: ${course.menteeCount+1}
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
                                                                               <!-- jQuery -->

<!--						<div class="row">
							<div class="col-12 grid-margin">
								<div class="card">
									<div class="card-body">
										<h4 class="card-title">Bad Reviews</h4>
										<div class="table-responsive">
											<table class="table">
												<thead>
													<tr>
														<th>Assignee</th>
														<th>Subject</th>
														<th>Status</th>
														<th>Last Update</th>
														<th>Tracking ID</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>
															<img
																src="assets/images/faces/face1.jpg"
																class="me-2"
																alt="image"
															/>
															David Grey
														</td>
														<td>Fund is not recieved</td>
														<td>
															<label class="badge badge-gradient-success"
																>DONE</label
															>
														</td>
														<td>Dec 5, 2017</td>
														<td>WD-12345</td>
													</tr>
													
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>-->
                            </div>
                        </div>
                    </div>
                </div>
            </div>	
        </div>	
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
        <!-- /Page Content -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>



<script>
    var ctx = document.getElementById('mentorMenteeChart').getContext('2d');

    var chartData = {
        labels: [],
        datasets: [
            {
                label: 'Mentors',
                data: [],
                borderColor: 'blue',
                backgroundColor: 'rgba(0, 0, 255, 0.2)',
                borderWidth: 2
            },
            {
                label: 'Mentees',
                data: [],
                borderColor: 'green',
                backgroundColor: 'rgba(0, 255, 0, 0.2)',
                borderWidth: 2
            }
        ]
    };

    <c:forEach var="stat" items="${mentorMenteeStats}">
        chartData.labels.push("${stat.month}");
        chartData.datasets[0].data.push(${stat.mentor_count});
        chartData.datasets[1].data.push(${stat.mentee_count});
    </c:forEach>

    new Chart(ctx, {
        type: 'line',
        data: chartData,
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>
<script>
    // Dữ liệu từ server
    var requestData = {
        labels: ["Cancel", "Closed", "Draft", "Open", "Pending", "Processing"],
        datasets: [{
            data: [], // Sẽ cập nhật từ JSP
            backgroundColor: ["#FFCC00", "#009900", "#3366FF", "#FF3300", "#9900FF", "#00CCCC"], // Đủ màu cho 6 trạng thái
        }]
    };

    // Lặp qua danh sách và thêm dữ liệu từ JSP
    <c:forEach var="stat" items="${listRequestByStatus}" varStatus="loop">
        requestData.datasets[0].data.push(${stat});
    </c:forEach>

    // Vẽ biểu đồ
    var ctxs = document.getElementById("requestStatusChart").getContext("2d");
    new Chart(ctxs, {
        type: "pie",
        data: requestData,
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: "top"
                }
            }
        }
    });
</script>
</script>
    </body>

    <!-- Mirrored from dreamslms.dreamstechnologies.com/html/mentee-settings.html by HTTrack Website Copier/3.x [XR&CO'2014], Tue, 11 Feb 2025 21:04:23 GMT -->
</html>

