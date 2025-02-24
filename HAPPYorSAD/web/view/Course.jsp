<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

    </head>

    <body>

        <!-- Main Wrapper -->
        <div class="main-wrapper">

            <!-- Header -->
            <%@include file="/../sourcesHome/homeHeader.jsp" %>
            <!-- /Header -->

            <!-- Breadcrumb -->
            <div class="breadcrumb-bar">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 col-12">
                            <div class="breadcrumb-list">
                                <nav aria-label="breadcrumb" class="page-breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="index-2.html">Home</a></li>
                                        <li class="breadcrumb-item" aria-current="page">Courses</li>
                                        <li class="breadcrumb-item active" aria-current="page">All Courses</li>
                                    </ol>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /Breadcrumb -->

            <!-- Course -->
            <section class="course-content">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-9">

                            <!-- Filter -->
                            <div class="showing-list">
                                <div class="row">
                                    <div class="col-lg-6">
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
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="show-filter add-course-info ">
                                            <form action="#">
                                                <div class="row gx-2 align-items-center">
                                                    <div class="col-md-6 col-item">
                                                        <div class=" search-group">
                                                            <i class="feather-search"></i>
                                                            <input type="text" class="form-control"
                                                                   placeholder="Search our courses">
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6 col-lg-6 col-item">
                                                        <div class="input-block select-form mb-0">
                                                            <select class="form-select select" name="sellist1">
                                                                <option>Newly published </option>
                                                                <option>published 1</option>
                                                                <option>published 2</option>
                                                                <option>published 3</option>
                                                            </select>
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
                                <c:forEach items="${sessionScope.listAllCousre}" var="o">
                                    <div class="col-lg-12 col-md-12 d-flex">
                                        <div class="course-box course-design list-course d-flex">
                                            <div class="product">
                                                <div class="product-img">
                                                    <a href="CourseDetails?Cid=${o.id}">
                                                        <img class="img-fluid" alt="Img" src="${o.image}" ">
                                                    </a>
                                                </div>
                                                <div class="product-content">
                                                    <div class="head-course-title">
                                                        <h3 class="title"><a href="CourseDetails?Cid=${o.id}">${o.title}</a></h3>
                                                        <div class="all-btn all-category d-flex align-items-center">
                                                            <a href="CourseDetails?Cid=${o.id}" class="btn btn-primary">Course ID: ${o.id}</a>
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
                                    <ul class="pagination lms-page">
                                        <li class="page-item prev">
                                            <a class="page-link" href="javascript:void(0)" tabindex="-1">
                                                <i class="fas fa-angle-left"></i>
                                            </a>
                                        </li>
                                        <li class="page-item first-page active">
                                            <a class="page-link" href="javascript:void(0)">1</a>
                                        </li>
                                        <li class="page-item">
                                            <a class="page-link" href="javascript:void(0)">2</a>
                                        </li>
                                        <li class="page-item">
                                            <a class="page-link" href="javascript:void(0)">3</a>
                                        </li>
                                        <li class="page-item">
                                            <a class="page-link" href="javascript:void(0)">4</a>
                                        </li>
                                        <li class="page-item">
                                            <a class="page-link" href="javascript:void(0)">5</a>
                                        </li>
                                        <li class="page-item next">
                                            <a class="page-link" href="javascript:void(0)">
                                                <i class="fas fa-angle-right"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <!-- /pagination -->

                        </div>
                        <div class="col-lg-3 theiaStickySidebar">
                            <div class="filter-clear">
                                <div class="clear-filter d-flex align-items-center">
                                    <h4><i class="feather-filter"></i>Filters</h4>
                                    <div class="clear-text">
                                        <p>CLEAR</p>
                                    </div>
                                </div>

                                <!-- Search Filter -->
                                <div class="card search-filter categories-filter-blk">
                                    <div class="card-body">
                                        <div class="filter-widget mb-0">
                                            <div class="categories-head d-flex align-items-center">
                                                <h4>Course categories</h4>
                                                <i class="fas fa-angle-down"></i>
                                            </div>
                                            <div>
                                                <label class="custom_check">
                                                    <input type="checkbox" name="select_specialist">
                                                    <span class="checkmark"></span> Backend (3)

                                                </label>
                                            </div>
                                            <div>
                                                <label class="custom_check">
                                                    <input type="checkbox" name="select_specialist">
                                                    <span class="checkmark"></span> CSS (2)
                                                </label>
                                            </div>
                                            <div>
                                                <label class="custom_check">
                                                    <input type="checkbox" name="select_specialist">
                                                    <span class="checkmark"></span> Frontend (2)
                                                </label>
                                            </div>
                                            <div>
                                                <label class="custom_check">
                                                    <input type="checkbox" name="select_specialist" checked>
                                                    <span class="checkmark"></span> General (2)
                                                </label>
                                            </div>
                                            <div>
                                                <label class="custom_check">
                                                    <input type="checkbox" name="select_specialist" checked>
                                                    <span class="checkmark"></span> IT & Software (2)
                                                </label>
                                            </div>
                                            <div>
                                                <label class="custom_check">
                                                    <input type="checkbox" name="select_specialist">
                                                    <span class="checkmark"></span> Photography (2)
                                                </label>
                                            </div>
                                            <div>
                                                <label class="custom_check">
                                                    <input type="checkbox" name="select_specialist">
                                                    <span class="checkmark"></span> Programming Language (3)
                                                </label>
                                            </div>
                                            <div>
                                                <label class="custom_check mb-0">
                                                    <input type="checkbox" name="select_specialist">
                                                    <span class="checkmark"></span> Technology (2)
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /Search Filter -->

                                <!-- Search Filter -->
                                <div class="card search-filter">
                                    <div class="card-body">
                                        <div class="filter-widget mb-0">
                                            <div class="categories-head d-flex align-items-center">
                                                <h4>Instructors</h4>
                                                <i class="fas fa-angle-down"></i>
                                            </div>
                                            <div>
                                                <label class="custom_check">
                                                    <input type="checkbox" name="select_specialist">
                                                    <span class="checkmark"></span> Keny White (10)

                                                </label>
                                            </div>
                                            <div>
                                                <label class="custom_check">
                                                    <input type="checkbox" name="select_specialist">
                                                    <span class="checkmark"></span> Hinata Hyuga (5)
                                                </label>
                                            </div>
                                            <div>
                                                <label class="custom_check">
                                                    <input type="checkbox" name="select_specialist">
                                                    <span class="checkmark"></span> John Doe (3)
                                                </label>
                                            </div>
                                            <div>
                                                <label class="custom_check mb-0">
                                                    <input type="checkbox" name="select_specialist" checked>
                                                    <span class="checkmark"></span> Nicole Brown
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /Search Filter -->

                                <!-- Search Filter -->
                                <div class="card search-filter ">
                                    <div class="card-body">
                                        <div class="filter-widget mb-0">
                                            <div class="categories-head d-flex align-items-center">
                                                <h4>Price</h4>
                                                <i class="fas fa-angle-down"></i>
                                            </div>
                                            <div>
                                                <label class="custom_check custom_one">
                                                    <input type="radio" name="select_specialist">
                                                    <span class="checkmark"></span> All (18)

                                                </label>
                                            </div>
                                            <div>
                                                <label class="custom_check custom_one">
                                                    <input type="radio" name="select_specialist">
                                                    <span class="checkmark"></span> Free (3)

                                                </label>
                                            </div>
                                            <div>
                                                <label class="custom_check custom_one mb-0">
                                                    <input type="radio" name="select_specialist" checked>
                                                    <span class="checkmark"></span> Paid (15)
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /Search Filter -->

                                <!-- Latest Posts -->
                                <div class="card post-widget ">
                                    <div class="card-body">
                                        <div class="latest-head">
                                            <h4 class="card-title">Latest Courses</h4>
                                        </div>
                                        <ul class="latest-posts">
                                            <li>
                                                <div class="post-thumb">
                                                    <a href="course-details.html">
                                                        <img class="img-fluid" src="/HAPPYorSAD/assets/img/blog/blog-01.jpg" alt="Img">
                                                    </a>
                                                </div>
                                                <div class="post-info free-color">
                                                    <h4>
                                                        <a href="course-details.html">Introduction LearnPress ? LMS
                                                            plugin</a>
                                                    </h4>
                                                    <p>FREE</p>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="post-thumb">
                                                    <a href="course-details.html">
                                                        <img class="img-fluid" src="/HAPPYorSAD/assets/img/blog/blog-02.jpg" alt="Img">
                                                    </a>
                                                </div>
                                                <div class="post-info">
                                                    <h4>
                                                        <a href="course-details.html">Become a PHP Master and Make Money</a>
                                                    </h4>
                                                    <p>$200</p>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="post-thumb">
                                                    <a href="#">
                                                        <img class="img-fluid" src="/HAPPYorSAD/assets/img/blog/blog-03.jpg" alt="Img">
                                                    </a>
                                                </div>
                                                <div class="post-info free-color">
                                                    <h4>
                                                        <a href="blog-details.html">Learning jQuery Mobile for Beginners</a>
                                                    </h4>
                                                    <p>FREE</p>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="post-thumb">
                                                    <a href="course-details.html">
                                                        <img class="img-fluid" src="/HAPPYorSAD/assets/img/blog/blog-01.jpg" alt="Img">
                                                    </a>
                                                </div>
                                                <div class="post-info">
                                                    <h4>
                                                        <a href="course-details.html.html">Improve Your CSS Workflow with
                                                            SASS</a>
                                                    </h4>
                                                    <p>$200</p>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="post-thumb ">
                                                    <a href="course-details.html">
                                                        <img class="img-fluid" src="/HAPPYorSAD/assets/img/blog/blog-02.jpg" alt="Img">
                                                    </a>
                                                </div>
                                                <div class="post-info free-color">
                                                    <h4>
                                                        <a href="course-details.html">HTML5/CSS3 Essentials in 4-Hours</a>
                                                    </h4>
                                                    <p>FREE</p>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <!-- /Latest Posts -->

                            </div>
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