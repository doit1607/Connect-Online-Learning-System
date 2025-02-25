<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html lang="en">

    <!-- Mirrored from dreamslms.dreamstechnologies.com/html/instructor-list.html by HTTrack Website Copier/3.x [XR&CO'2014], Tue, 11 Feb 2025 21:03:37 GMT -->
    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>Dreams LMS</title>

        <!-- Favicon -->
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.svg">

        <!-- Theme Settings Js -->
        <script src="assets/js/theme-script.js" type="4b9afacfe3a18f285e1d0e14-text/javascript"></script>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">

        <!-- Fontawesome CSS -->
        <link rel="stylesheet" href="assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="assets/plugins/fontawesome/css/all.min.css">

        <!-- Feather CSS -->
        <link rel="stylesheet" href="assets/css/feather.css">

        <!-- Select2 CSS -->
        <link rel="stylesheet" href="assets/plugins/select2/css/select2.min.css">

        <!-- Main CSS -->
        <link rel="stylesheet" href="assets/css/style.css">
        <style>
            .col-md-6 {
                flex: 0 0 auto;
                width: 100% !important;
            }
            .page-content{
                padding-top: 100px  !important;
            }
        </style>

    </head>
    <body>
        <%@include file="../sourcesHome/homeHeader.jsp" %>
        
        <!-- Main Wrapper -->


        <div class="main-wrapper">



            <!-- Page Wrapper -->
            <div class="page-content">

                <div class="container">
                    <% 
             String message = (String) session.getAttribute("message");
             String error = (String) session.getAttribute("error");
             if (message != null) { 
                    %>
                    <div class="alert alert-success"><%= message %></div>
                    <%
                        session.removeAttribute("message");
                        }
                        if (error != null) {
                    %>
                    <div class="alert alert-danger"><%= error %></div>
                    <%
                        session.removeAttribute("error");
                        }
                    %>
                    <div class="row">
                        <div class="col-lg-9">

                            <!-- Filter -->
                            <div class="showing-list">
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="d-flex align-items-center">
                                            <div class="view-icons">
                                                <a href="instructor-grid.html" class="grid-view "><i class="feather-grid"></i></a>
                                                <a href="instructor-list.html" class="list-view active"><i class="feather-list"></i></a>
                                            </div>
                                            <div class="show-result">
                                                <h4>Showing 1-9 of 50 results</h4>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">	
                                        <div class="show-filter add-course-info">
                                            <!-- Search Form -->
                                            <form id="searchForm" action="viewMentor" method="GET" class="mb-4">
                                                <div class="input-group">
                                                    <input type="text" id="searchInput" name="search" class="form-control" placeholder="Search mentor..." value="${param.search}">
                                                    <button class="btn btn-primary" type="submit"><i class="fas fa-search"></i>Search</button>
                                                </div>
                                            </form>

                                        </div>	
                                    </div>
                                </div>
                            </div>
                            <!-- /Filter -->
                            <c:choose>
                                <c:when test="${not empty listMentor}">
                                    <c:forEach var="mentor" items="${listMentor}" varStatus="status">

                                        <div class="row">

                                            <!-- Instructor List -->
                                            <div class="col-lg-12 d-flex">
                                                <div class="instructor-list flex-fill">
                                                    <div class="instructor-img">
                                                        <a href="instructor-profile.html">
                                                            <img src="${mentor.getImage() != null ? mentor.getImage() : 'default-avatar.png'}" alt="Avatar" class="mentor-avatar">

                                                        </a>
                                                    </div>
                                                    <div class="instructor-content">												
                                                        <h5><a href="instructor-profile.html">${mentor.name}</a></h5>
                                                        <h6>Mentor</h6>
                                                        <div class="instructor-info">
                                                            <div class="rating-img d-flex align-items-center">
                                                                <i class="fas fa-star me-1"></i> 
                                                                <p>${mentor.getBaseRate()} request</p>
                                                            </div>

                                                            <div class="course-view d-flex align-items-center ms-0">
                                                                <i class="fas fa-percent me-1"></i> 
                                                                <p>${mentor.getMultiplier()}%</p>
                                                            </div>

                                                            <div class="rating-img d-flex align-items-center">
                                                                <i class="fas fa-dollar-sign me-1"></i> 
                                                                <p>${mentor.getPricePerSlot()}</p>
                                                            </div>

                                                            <div class="rating">							
                                                                <i class="fas fa-star filled"></i>                                                            
                                                                <span class="d-inline-block average-rating"><span>${mentor.rating}
                                                                    </span></span>
                                                            </div>											
                                                            <a href="#rate" class="rating-count"><i class="fa-regular fa-heart"></i></a>
                                                        </div>
                                                        <div class="instructor-badge">
                                                            <span class="web-badge">${mentor.expertise}</span>

                                                        </div>
                                                        <div>
                                                            <form method="post" action="viewMentor" onsubmit="return confirmAction(this);">
                                                                <input type="hidden" name="username" value="${mentor.getUser().getUsername()}">

                                                                <c:if test="${mentor.getUser().getStatus().equals('active')}">
                                                                    <input type="hidden" name="status" value="inactive">
                                                                    <button type="submit" class="btn btn-sm btn-danger">Inactive</button>
                                                                </c:if>

                                                                <c:if test="${!mentor.getUser().getStatus().equals('active')}">
                                                                    <input type="hidden" name="status" value="active">
                                                                    <button type="submit" class="btn btn-sm btn-success">Active</button>
                                                                </c:if>
                                                            </form>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </c:forEach>

                                </div>
                            </c:when>
                            <c:otherwise>
                                <p class="text-center text-muted">Không tìm thấy Mentor nào.</p>
                            </c:otherwise>
                        </c:choose>


                    </div>

                    <!-- /pagination -->
                    <!-- Pagination -->
                    <nav>
                        <ul class="pagination">
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="viewMentor?search=${param.search}&limit=${limit}&page=${i}">${i}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </nav>

                    <!-- /pagination -->

                </div>



            </div>
        </div>
    </div>
    <!-- /Page Wrapper -->

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

</div>
<!-- /Main Wrapper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>


<!-- jQuery -->
<script data-cfasync="false" src="../cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script><script src="assets/js/jquery-3.7.1.min.js" type="4b9afacfe3a18f285e1d0e14-text/javascript"></script>

<!-- Bootstrap Core JS -->
<script src="assets/js/bootstrap.bundle.min.js" type="4b9afacfe3a18f285e1d0e14-text/javascript"></script>

<!-- Select2 JS -->
<script src="assets/plugins/select2/js/select2.min.js" type="4b9afacfe3a18f285e1d0e14-text/javascript"></script>

<!-- Custom JS -->
<script src="assets/js/script.js" type="4b9afacfe3a18f285e1d0e14-text/javascript"></script>

<script src="../cdn-cgi/scripts/7d0fa10a/cloudflare-static/rocket-loader.min.js" data-cf-settings="4b9afacfe3a18f285e1d0e14-|49" defer></script><script defer src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015" integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ==" data-cf-beacon='{"rayId":"9107442839460f2c","version":"2025.1.0","serverTiming":{"name":{"cfExtPri":true,"cfL4":true,"cfSpeedBrain":true,"cfCacheStatus":true}},"token":"3ca157e612a14eccbb30cf6db6691c29","b":1}' crossorigin="anonymous"></script>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
                                                                document.getElementById("searchInput").addEventListener("input", function () {
                                                                    let searchValue = this.value.trim();
                                                                    let url = "viewMentor?search=" + encodeURIComponent(searchValue);

                                                                    fetch(url)
                                                                            .then(response => response.text())
                                                                            .then(data => {
                                                                                // Cập nhật danh sách mentor
                                                                                let parser = new DOMParser();
                                                                                let doc = parser.parseFromString(data, "text/html");
                                                                                let newTable = doc.querySelector("table");

                                                                                if (newTable) {
                                                                                    document.querySelector("table").innerHTML = newTable.innerHTML;
                                                                                }
                                                                            })
                                                                            .catch(error => console.error("Error:", error));
                                                                });
                                                                function confirmAction(form) {
                                                                    let actionText = form.querySelector("button").textContent.trim();
                                                                    return confirm("Bạn có chắc chắn muốn " + actionText.toLowerCase() + " mentor này không?");
                                                                }

</script>
</body>

<!-- Mirrored from dreamslms.dreamstechnologies.com/html/instructor-list.html by HTTrack Website Copier/3.x [XR&CO'2014], Tue, 11 Feb 2025 21:03:40 GMT -->
</html>