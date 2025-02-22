<%-- 
    Document   : viewRequest.jsp
    Created on : Feb 17, 2025, 5:17:52 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>Dreams LMS</title>

        <!-- Favicon -->
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.svg">

        <!-- Theme Settings Js -->
        <script src="assets/js/theme-script.js" type="de0b254082679f4d756bbefa-text/javascript"></script>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">

        <!-- Fontawesome CSS -->
        <link rel="stylesheet" href="assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="assets/plugins/fontawesome/css/all.min.css">

        <!-- Feather CSS -->
        <link rel="stylesheet" href="assets/css/feather.css">

        <!-- Main CSS -->
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="assets/css/custom.css">

    </head>
    <body>
        <%@include file="../sourcesHome/homeHeader.jsp" %>
        
        <!--screen here-->
        <div class="container" style="margin-top: 100px; margin-bottom: 100px">
            <div class="col-lg-8 col-xl-10">

                <div class="dashboard-header">
                        <h3>Requests</h3>
                        <ul>
                                <li>
<!--                                        <div class="dropdown header-dropdown">
                                                <a class="dropdown-toggle nav-tog" data-bs-toggle="dropdown" href="javascript:void(0);">
                                                        Last 7 Days
                                                </a>
                                                <div class="dropdown-menu dropdown-menu-end">
                                                        <a href="javascript:void(0);" class="dropdown-item">
                                                                Today
                                                        </a>
                                                        <a href="javascript:void(0);" class="dropdown-item">
                                                                This Month
                                                        </a>
                                                        <a href="javascript:void(0);" class="dropdown-item">
                                                                Last 7 Days
                                                        </a>
                                                </div>
                                                                            </div>-->
                                    <form action="viewRequest" method="GET">
                                        <select name="date" id="date-range" class="form-select" onchange="this.form.submit()">
                                            <option value="0" ${param.date == '0' || empty param.date ? 'selected' : ''}>All</option>
                                            <option value="1" ${param.date == '1' ? 'selected' : ''}>Today</option>
                                            <option value="2" ${param.date == '2' ? 'selected' : ''}>Last 7 Days</option>
                                            <option value="3" ${param.date == '3' ? 'selected' : ''}>This Month</option>
                                        </select>
                                    </form>

                                </li>
                        </ul>
                </div>
                <c:forEach var="request" items="${requests}">
    <div class="appointment-wrap">
        <ul>
            <li>
                <div class="patinet-information">
                    <a href="patient-profile.html">
                        <img src="${request.getMentee().getAvatarPath()}" alt="img">
                    </a>
                    <div class="patient-info">
                        <p>Mentee</p>
                        <h6><a href="patient-profile.html">${request.getMentee().getFullname()}</a></h6>
                    </div>
                </div>
            </li>
            <li class="appointment-info" style="width: 300px">
                <p class="md-text">Title</p>
                <p><i class="isax isax-clock5"></i>${request.getTitle()}</p>
            </li>
            <li class="appointment-info">
                <p class="md-text">Created at</p>
                <p><i class="isax isax-clock5"></i>${request.getFormattedCreatedAt()}</p>
            </li>
            <li class="appointment-type">
                <p class="md-text">Deadline</p>
                <p><i class="isax isax-clock5"></i>${request.getDeadlineDate()}</p>
            </li>
            <li>
                <button type="button" class="btn btn-outline-secondary" 
                        data-bs-toggle="modal" 
                        data-bs-target="#acceptAppointmentModal_${request.getId()}">
                    <i class="fa-solid fa-info"></i>&nbsp;Details
                </button>
            </li>
        </ul>
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
<!--                        <div class="card">
                            <h6 class="card-header">${course.title}</h6>
                            <div class="card-body">
                              <p class="card-text">${course.description}</p>
                              <a href="#" class="btn btn-primary">View details</a>
                            </div>
                        </div>-->
                        <div class="card mb-3" style="max-width: 540px;">
                            <div class="row g-0">
                              <div class="col-md-4">
                                <img src="${course.image}" class="img-fluid rounded-start" alt="img">
                              </div>
                              <div class="col-md-8">
                                <div class="card-body">
                                  <h5 class="card-title">${course.title}</h5>
                                  <p class="card-text">${course.description}</p>
                                  <a href="#" class="btn btn-primary">View details</a>
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
                                    <a class="accept-link" onclick="updateStatus(${request.id}, 'Processing')">
                                        <i class="fa-solid fa-check"></i> Accept
                                    </a>
                                </li>
                                <li>
                                    <a class="reject-link" onclick="updateStatus(${request.id}, 'Cancel')">
                                        <i class="fa-solid fa-xmark"></i> Reject
                                    </a>
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
        
        
        
        
        
        
        
        
        
        <!-- Footer -->
        <footer class="footer">

            <!-- Footer Top -->
            <div class="footer-top">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-4 col-md-6">

                            <!-- Footer Widget -->
                            <div class="footer-widget footer-about">
                                <div class="footer-logo">
                                    <img src="assets/img/logo.svg" alt="logo">
                                </div>
                                <div class="footer-about-content">
                                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut consequat mauris Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut consequat mauris</p>
                                </div>
                            </div>
                            <!-- /Footer Widget -->

                        </div>

                        <div class="col-lg-2 col-md-6">

                            <!-- Footer Widget -->
                            <div class="footer-widget footer-menu">
                                <h2 class="footer-title">For Instructor</h2>
                                <ul>
                                    <li><a href="instructor-profile.html">Profile</a></li>
                                    <li><a href="login.html">Login</a></li>
                                    <li><a href="register.html">Register</a></li>
                                    <li><a href="instructor-list.html">Instructor</a></li>
                                    <li><a href="instructor-dashboard.html"> Dashboard</a></li>
                                </ul>
                            </div>
                            <!-- /Footer Widget -->

                        </div>

                        <div class="col-lg-2 col-md-6">

                            <!-- Footer Widget -->
                            <div class="footer-widget footer-menu">
                                <h2 class="footer-title">For Student</h2>
                                <ul>
                                    <li><a href="student-profile.html">Profile</a></li>
                                    <li><a href="login.html">Login</a></li>
                                    <li><a href="register.html">Register</a></li>
                                    <li><a href="students-list.html">Student</a></li>
                                    <li><a href="student-dashboard.html"> Dashboard</a></li>
                                </ul>
                            </div>
                            <!-- /Footer Widget -->

                        </div>

                        <div class="col-lg-4 col-md-6">

                            <!-- Footer Widget -->
                            <div class="footer-widget footer-contact">
                                <h2 class="footer-title">News letter</h2>
                                <div class="news-letter">
                                    <form>
                                        <input type="text" class="form-control" placeholder="Enter your email address" name="email">
                                    </form>
                                </div>
                                <div class="footer-contact-info">
                                    <div class="footer-address">
                                        <img src="assets/img/icon/icon-20.svg" alt="Img" class="img-fluid">
                                        <p> 3556  Beech Street, San Francisco,<br> California, CA 94108 </p>
                                    </div>
                                    <p>
                                        <img src="assets/img/icon/icon-19.svg" alt="Img" class="img-fluid">
                                        <a href="https://dreamslms.dreamstechnologies.com/cdn-cgi/l/email-protection" class="__cf_email__" data-cfemail="a8ccdacdc9c5dbc4c5dbe8cdd0c9c5d8c4cd86cbc7c5">[email&#160;protected]</a>
                                    </p>
                                    <p class="mb-0">
                                        <img src="assets/img/icon/icon-21.svg" alt="Img" class="img-fluid">
                                        +19 123-456-7890
                                    </p>
                                </div>
                            </div>
                            <!-- /Footer Widget -->

                        </div>

                    </div>
                </div>
            </div>
            <!-- /Footer Top -->

            <!-- Footer Bottom -->
            <div class="footer-bottom">
                <div class="container">

                    <!-- Copyright -->
                    <div class="copyright">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="privacy-policy">
                                    <ul>
                                        <li><a href="term-condition.html">Terms</a></li>
                                        <li><a href="privacy-policy.html">Privacy</a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="copyright-text">
                                    <p class="mb-0">&copy; 2024 DreamsLMS. All rights reserved.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /Copyright -->

                </div>
            </div>
            <!-- /Footer Bottom -->

        </footer>
        <!-- /Footer -->
        
        
        
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <!-- jQuery -->
        <script data-cfasync="false" src="cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script><script src="assets/js/jquery-3.7.1.min.js" type="4b9afacfe3a18f285e1d0e14-text/javascript"></script>

        <!-- Bootstrap Core JS -->
        <script src="assets/js/bootstrap.bundle.min.js" type="4b9afacfe3a18f285e1d0e14-text/javascript"></script>

        <!-- Select2 JS -->
        <script src="assets/plugins/select2/js/select2.min.js" type="4b9afacfe3a18f285e1d0e14-text/javascript"></script>

        <!-- Custom JS -->
        <script src="assets/js/script.js" type="4b9afacfe3a18f285e1d0e14-text/javascript"></script>

        <script src="cdn-cgi/scripts/7d0fa10a/cloudflare-static/rocket-loader.min.js" data-cf-settings="4b9afacfe3a18f285e1d0e14-|49" defer></script><script defer src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015" integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ==" data-cf-beacon='{"rayId":"9107442839460f2c","version":"2025.1.0","serverTiming":{"name":{"cfExtPri":true,"cfL4":true,"cfSpeedBrain":true,"cfCacheStatus":true}},"token":"3ca157e612a14eccbb30cf6db6691c29","b":1}' crossorigin="anonymous"></script>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function updateStatus(requestId, status) {
                fetch('/ViewRequest', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: `id=${requestId}&status=${status}`
                })
                .then(() => {
                    window.location.href = "/HAPPYorSAD/viewRequest"; // Chuyển hướng về trang chính sau khi cập nhật
                })
                .catch(error => console.error("Lỗi:", error));
            }

        </script>

    </body>
</html>
