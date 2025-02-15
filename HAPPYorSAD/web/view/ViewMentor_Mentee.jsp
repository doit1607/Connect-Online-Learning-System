<%-- 
    Document   : ViewMentor_Mentee
    Created on : Feb 6, 2025, 11:00:49 AM
    Author     : Ann
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Mentor & Mentee Listing</title>
        <!-- Favicon -->
        <link rel="shortcut icon" type="image/x-icon" href="/HAPPYorSAD/assets/img/favicon.svg">

        <!-- Theme Settings Js -->
        <script src="/HAPPYorSAD/assets/js/theme-script.js" type="4b9afacfe3a18f285e1d0e14-text/javascript"></script>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap.min.css">

        <!-- Fontawesome CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/all.min.css">

        <!-- Feather CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/feather.css">

        <!-- Select2 CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/select2/css/select2.min.css">

        <!-- Main CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css">

    </head>
    <body>
        <%@include file="../sourcesHome/homeHeader.jsp" %>



        <!-- Breadcrumb -->
        <div class="breadcrumb-bar">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-12">
                        <div class="breadcrumb-list">
                            <nav aria-label="breadcrumb" class="page-breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="index-2.html">Home</a></li>
                                    <li class="breadcrumb-item">Pages</li>
                                    <li class="breadcrumb-item">Instructors List</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /Breadcrumb -->

        <!-- Page Wrapper -->
        <div class="page-content">

            <div class="container">
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
                                        <form action="#">
                                            <div class="row gx-2 align-items-center">	
                                                <div class="col-md-6 col-item">
                                                    <div class=" search-group">
                                                        <i class="feather-search"></i>
                                                        <input type="text" class="form-control" placeholder="Search our courses" >
                                                    </div>
                                                </div>
                                                <div class="col-md-6 col-lg-6 col-item">
                                                    <div class="input-block select-form mb-0">
                                                        <select class="form-select select"  name="sellist1">
                                                            <option>Newly published </option>
                                                            <option>Angular</option>
                                                            <option>React</option>
                                                            <option>Nodejs</option>
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

                            <!-- Instructor List -->
                            <c:forEach var="mentor" items="${listAllMentorSuggestion}"> 
                                <div class="col-lg-12 d-flex">
                                    <div class="instructor-list flex-fill">
                                        <div class="instructor-img">
                                            <a href="ProfileServlet">
                                                <img class="img-fluid" alt="Img" src="${mentor.image}">
                                            </a>
                                        </div>
                                        <div class="instructor-content">												
                                            <h5><a href="ProfileServlet">${mentor.name}</a></h5>
                                            <h6>@${mentor.username}</h6>
                                            <div class="instructor-info">
                                                <div class="rating-img d-flex align-items-center justify-content-center">
                                                    <img src="assets/img/icon/icon-01.svg" class="me-1" alt="Img">
                                                    <p>12+ Lesson</p>
                                                </div>
                                                <div class="course-view d-flex align-items-center justify-content-center">
                                                    <img src="assets/img/icon/icon-02.svg" class="me-1" alt="Img">
                                                    <p>9hr 30min</p>
                                                </div>
                                                <div class="rating-img d-flex align-items-center">
                                                    <img src="assets/img/icon/user-icon.svg" class="me-1" alt="Img">
                                                    <p>${mentor.total_mentees} Mentees</p>
                                                </div>
                                                <div class="rating">
                                                    <c:set var="ratingValue" value="${mentor.rating}"/>
                                                    <c:set var="numReviews" value="${mentor.total_reviews}"/> 
                                                    <c:set var="fullStars" value="${Math.floor(ratingValue)}"/>
                                                    <c:forEach begin="1" end="5" varStatus="loop">
                                                        <c:choose>
                                                            <c:when test="${loop.index <= fullStars}">
                                                                <i class="fas fa-star filled"></i>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <i class="fas fa-star"></i>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                    <span class="d-inline-block average-rating"><span>${ratingValue}</span> (${numReviews})</span>
                                                </div>

                                                <a href="#rate" class="rating-count"><i class="fa-regular fa-heart"></i></a>
                                            </div>
                                            <div class="instructor-badge">
                                                <span class="web-badge">${mentor.expertise}</span>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            <!-- /Instructor List -->

                        </div>

                        <!-- /pagination -->
                        <div class="row">
                            <div class="col-md-12">
                                <ul class="pagination lms-page lms-pagination">
                                    <li class="page-item prev">
                                        <a class="page-link" href="javascript:void(0);" tabindex="-1"><i class="fas fa-angle-left"></i></a>
                                    </li>
                                    <li class="page-item first-page active">
                                        <a class="page-link" href="javascript:void(0);">1</a>
                                    </li>
                                    <li class="page-item">
                                        <a class="page-link" href="javascript:void(0);">2</a>
                                    </li>
                                    <li class="page-item">
                                        <a class="page-link" href="javascript:void(0);">3</a>
                                    </li>
                                    <li class="page-item">
                                        <a class="page-link" href="javascript:void(0);">4</a>
                                    </li>
                                    <li class="page-item">
                                        <a class="page-link" href="javascript:void(0);">5</a>
                                    </li>
                                    <li class="page-item next">
                                        <a class="page-link" href="javascript:void(0);"><i class="fas fa-angle-right"></i></a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <!-- /pagination -->

                    </div>

                    <div class="col-lg-3">
                        <div class="filter-clear">
                            <div class="clear-filter d-flex align-items-center">
                                <h4><i class="feather-filter"></i>Filters</h4>
                                <div class="clear-text">
                                    <p>CLEAR</p>
                                </div>
                            </div>

                            <!-- Search Filter -->
                            <div class="card search-filter">
                                <div class="card-body">
                                    <div class="filter-widget mb-0">
                                        <div class="categories-head d-flex align-items-center">
                                            <h4>Course categories</h4>
                                            <i class="fas fa-angle-down"></i>
                                        </div>
                                        <div>
                                            <label class="custom_check">
                                                <input type="checkbox" name="select_specialist" >
                                                <span class="checkmark"></span> Backend (3)

                                            </label>
                                        </div>
                                        <div>
                                            <label class="custom_check">
                                                <input type="checkbox" name="select_specialist" >
                                                <span class="checkmark"></span>  CSS (2)
                                            </label>
                                        </div>
                                        <div>
                                            <label class="custom_check">
                                                <input type="checkbox" name="select_specialist">
                                                <span class="checkmark"></span>  Frontend (2)
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
                                                <span class="checkmark"></span>  Programming Language (3)
                                            </label>
                                        </div>
                                        <div>
                                            <label class="custom_check mb-0">
                                                <input type="checkbox" name="select_specialist">
                                                <span class="checkmark"></span>  Technology (2)
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
                                                <input type="checkbox" name="select_specialist" >
                                                <span class="checkmark"></span> Keny White (10)

                                            </label>
                                        </div>
                                        <div>
                                            <label class="custom_check">
                                                <input type="checkbox" name="select_specialist" >
                                                <span class="checkmark"></span>  Hinata Hyuga (5)
                                            </label>
                                        </div>
                                        <div>
                                            <label class="custom_check">
                                                <input type="checkbox" name="select_specialist">
                                                <span class="checkmark"></span>  John Doe (3)
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
                                                <input type="radio" name="select_specialist" >
                                                <span class="checkmark"></span> All (18)

                                            </label>
                                        </div>
                                        <div>
                                            <label class="custom_check custom_one">
                                                <input type="radio" name="select_specialist" >
                                                <span class="checkmark"></span>  Free (3) 

                                            </label>
                                        </div>
                                        <div>
                                            <label class="custom_check custom_one mb-0">
                                                <input type="radio" name="select_specialist" checked>
                                                <span class="checkmark"></span>  Paid (15)
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- /Search Filter -->

                        </div>
                    </div>

                </div>
            </div>
        </div>
        <!-- /Page Wrapper -->


        <%@include file="../sourcesHome/homeFooter.jsp" %>
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
