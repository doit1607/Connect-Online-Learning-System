<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>Dreams LMS</title>
        <!-- Favicon -->
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
        <<link rel="stylesheet" href="/HAPPYorSAD/css/cssStatistic/MenteeStatistic.css"/>
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

                         <div class="col-xl-3 col-lg-3 theiaStickySidebar">
                            <div class="settings-widget account-settings">
                                <div class="settings-menu">
                                    <h3>Dashboard</h3>
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
                                            <a href="ConfirmSchedule" class="nav-link">
                                                <i class="bx bxs-graduation"></i>Manage Scheudle
                                            </a>
                                        </li>

                                        <li class="nav-item">
                                            <a href="ShowAllRequest" class="nav-link">
                                                <i class="bx bxs-heart"></i>Manage Request Mentee
                                            </a>
                                        </li>

                                        <li class="nav-item active">
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
                            <h1>Static Mentee</h1>
                             <form action="menteestatistic" method="post" class="d-flex "> 
                                    <input name="txt" type="text" id="searchInput" class="form-control me-2" style="max-width: 250px;" placeholder="Enter Mentee Name...">
                                     <button type="submit" class="btn btn-primary px-4">Search</button>
                                </form>  
                            <div class="checkout-form">
                                <div class="table-responsive custom-table">

                                    <table class="table table-nowrap mb-0">
                                        <tr>
                                            <th>No.</th>
                                            <th>ID</th>
                                            <th>Image</th>
                                            <th>Name</th>
                                            <th>User Name</th>
                                            <th>Email</th>
                                            <th>Total Hours</th>
                                            <th>Total Courses</th>
                                        </tr>


                                        <c:forEach items="${mentees}" var="o" varStatus="status1">
                                            <tr>
                                                <td><div class="STT text-center"> <h6>${status1.index + 1}</h6></div></td>
                                                <td>${o.id}</td>
                                                <td> <img  class="img-fluid" alt="Img" src="${o.image}"></td>
                                                <td>${o.name}</td>
                                                <td>${o.userName}</td>
                                                <td>${o.email}</td>
                                                <td>${o.totalHours}</td>
                                                <td>${o.totalCourses}</td>
                                            </tr>
                                        </c:forEach>
                                    </table>

                                </div>                               
                            </div>
                            <!-- /pagination -->
                            <div class="row">
                                <div class="col-md-12">
                                    <!-- Pagination -->
                                    <div class="pagination">
                                        <c:if test="${tag > 1}">
                                            <li class="page-item">
                                                <a href="menteestatistic?index=${tag-1}" class="page-link">Previous</a>
                                            </li>
                                        </c:if>

                                        <c:forEach begin="1" end="${endPage}" var="i">
                                            <a class="page-link ${tag == i?'active':''}" href="menteestatistic?index=${i}">${i}</a>
                                        </c:forEach>

                                        <c:if test="${tag < endPage}">
                                            <li class="page-item">
                                                <a href="menteestatistic?index=${tag+1}" class="page-link">Next</a>
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
        </div>
    </body>
</html>