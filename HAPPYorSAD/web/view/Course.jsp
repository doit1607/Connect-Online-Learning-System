<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">


    <!-- Mirrored from dreamslms.dreamstechnologies.com/html/course-list.html by HTTrack Website Copier/3.x [XR&CO'2014], Tue, 11 Feb 2025 21:04:25 GMT -->
    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>Course List</title>

        <!-- Favicon -->
        <link rel="shortcut icon" type="image/x-icon" href="/HAPPYorSAD/assets/img/favicon.svg">

        <!-- Theme Settings Js -->
        <script src="/HAPPYorSAD/assets/js/theme-script.js" type="ed8c0f9a7decd809791bf17a-text/javascript"></script>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap.min.css">

        <!-- Fontawesome CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/all.min.css">

        <!-- Select2 CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/select2/css/select2.min.css">

        <!-- Feathericon CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/feather/feather.css">

        <!-- Main CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css">
        <link rel="stylesheet" href="/HAPPYorSAD/css/cssCourse/cssCourse.css"/>
    </head>
    <style>
        .tablecontent td.active a {           
            color: #f0ad4e; /* Màu ch? tr?ng */
            font-weight: bold;
            text-decoration: none;
            padding: 5px;
            border-radius: 5px;
        }
    </style>
    <body>

        <!-- Main Wrapper -->
        <div class="main-wrapper">

            <!-- Header -->
            <%@include file="/../sourcesHome/homeHeader.jsp" %>
            <!-- /Header -->

            <!-- Course -->
            <section class="course-content">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-9">
                            <!-- Filter -->
                            <div class="showing-list">
                                <div class="row">
                                    <!--                                    <div class="col-lg-6">
                                                                            <div class="d-flex align-items-center">
                                                                                <div class="view-icons">
                                                                                    <a href="course-grid.html" class="grid-view">
                                                                                        <i class="feather-grid"></i>
                                                                                    </a>
                                                                                    <a href="course-list.html" class="list-view active">
                                                                                        <i class="feather-list"></i>
                                                                                    </a>
                                                                                </div>
                                                                                <div class="show-result">
                                                                                    <h4>Showing 1-9 of 50 results</h4>
                                                                                </div>
                                                                            </div>
                                                                        </div>-->
                                    <div class="col-lg-6">
                                        <div class="show-filter add-course-info ">
                                            <form action="ShowAllCourse" method="get">
                                                <div class="row gx-2 align-items-center">
                                                    <div class="col-md-6 col-item">
                                                        <div class=" search-group">
                                                            <i class="feather-search"></i>
                                                            <input name="txt" type="text" class="form-control"
                                                                   placeholder="Search our courses">
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- /Filter -->
                            <div class="row">
                                <c:forEach items="${listAllCousre}" var="o">
                                    <div class="col-lg-12 col-md-12 d-flex">
                                        <div class="course-box course-design list-course d-flex">
                                            <div class="product">
                                                <div class="product-img">
                                                    <a href="CourseDetails?Cid=${o.id}">
                                                        <img  class="img-fluid" alt="Img" src="${o.image}">
                                                    </a>
                                                </div>
                                                <div class="product-content">
                                                    <div class="head-course-title">
                                                        <h3 class="title"><a href="CourseDetails?Cid=${o.id}">${o.title}</a></h3>                                                 
                                                        <div class="all-btn all-category d-flex align-items-center">
                                                            <a href="CourseDetails?Cid=${o.id}" class="btn btn-primary">MORE DETAIL</a>
                                                        </div>                                             
                                                    </div>
                                                    <div class="course-group d-flex mb-0">
                                                        <div class="course-group-img d-flex">
                                                            <div class="cou-info">
                                                                <img src="assets/img/icon/people.svg" alt="Img">
                                                                <p> Total: ${o.total_Mentor} Mentor </p>
                                                            </div> 
                                                        </div>

                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <!-- /pagination -->
                            <div class="row">
                                <div class="col-md-12">
                                    <!-- Pagination -->
                                    <div class="pagination">
                                        <c:if test="${tag > 1}">
                                            <li class="page-item">
                                                <a href="ShowAllCourse?index=${tag-1}" class="page-link">Previous</a>
                                            </li>
                                        </c:if>

                                        <c:forEach begin="1" end="${endPage}" var="i">
                                            <a class="page-link ${tag == i?'active':''}" href="ShowAllCourse?index=${i}">${i}</a>
                                        </c:forEach>

                                        <c:if test="${tag < endPage}">
                                            <li class="page-item">
                                                <a href="ShowAllCourse?index=${tag+1}" class="page-link">Next</a>
                                            </li>
                                        </c:if>
                                    </div>
                                    <!-- /Pagination -->                              
                                </div>
                            </div>
                            <!-- /pagination -->

                        </div>
                        <div class="col-md-3">
                            <table class="tablecontent">
                                <thead>
                                    <tr>
                                        <th>Course Major</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${listAllMaojor}" var="o">
                                        <tr>
                                            <td class="${tagg == o.id ? 'active' : ''}">
                                                <a href="ShowAllCourseByMajorId?Mid=${o.id}">${o.name}</a>
                                            </td>
                                        </tr>                                  
                                    </c:forEach>

                                </tbody>
                            </table>

                        </div>

                    </div>
                </div>
            </section>
            <!-- /Course -->

            <!-- Footer -->
            <%@include file="/../sourcesHome/homeFooter.jsp" %>            
            <!-- /Footer -->

        </div>
        <!-- /Main Wrapper -->

        <!-- jQuery -->
        <script data-cfasync="false" src="/HAPPYorSAD/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script><script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js" type="ed8c0f9a7decd809791bf17a-text/javascript"></script>

        <!-- Bootstrap Core JS -->
        <script src="/HAPPYorSAD/assets/js/bootstrap.bundle.min.js" type="ed8c0f9a7decd809791bf17a-text/javascript"></script>

        <!-- Select2 JS -->
        <script src="/HAPPYorSAD/assets/plugins/select2/js/select2.min.js" type="ed8c0f9a7decd809791bf17a-text/javascript"></script>

        <!-- Sticky Sidebar JS -->
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/ResizeSensor.js" type="ed8c0f9a7decd809791bf17a-text/javascript"></script>
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js" type="ed8c0f9a7decd809791bf17a-text/javascript"></script>

        <!-- Custom JS -->
        <script src="/HAPPYorSAD/assets/js/script.js" type="ed8c0f9a7decd809791bf17a-text/javascript"></script>

        <script src="/HAPPYorSAD/cdn-cgi/scripts/7d0fa10a/cloudflare-static/rocket-loader.min.js" data-cf-settings="ed8c0f9a7decd809791bf17a-|49" defer></script><script defer src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015" integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ==" data-cf-beacon='{"rayId":"91074462f90fe2ec","version":"2025.1.0","serverTiming":{"name":{"cfExtPri":true,"cfL4":true,"cfSpeedBrain":true,"cfCacheStatus":true}},"token":"3ca157e612a14eccbb30cf6db6691c29","b":1}' crossorigin="anonymous"></script>
    </body>


    <!-- Mirrored from dreamslms.dreamstechnologies.com/html/course-list.html by HTTrack Website Copier/3.x [XR&CO'2014], Tue, 11 Feb 2025 21:04:35 GMT -->
</html>