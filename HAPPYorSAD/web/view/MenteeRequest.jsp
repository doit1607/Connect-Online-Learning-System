<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html> 
<html lang="en">

    <!-- Mirrored from dreamslms.dreamstechnologies.com/html/student-tickets.html by HTTrack Website Copier/3.x [XR&CO'2014], Tue, 11 Feb 2025 21:04:22 GMT -->
    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>Dreams LMS</title>

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

        <link rel="stylesheet" href="/HAPPYorSAD/css/cssRequestMnetee/RequestMentee.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <body>
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
                    <div class="col-md-3  ">
                        <div class="settings-widget dash-profile">
                            <div class="settings-menu">
                                <div class="profile-bg">
                                    <div class="profile-img">
                                        <a href="student-profile.html"><img src="${mentee.image}"></a>
                                    </div>
                                </div>
                                <div class="profile-group">
                                    <div class="profile-name text-center">
                                        <h4><a href="student-profile.html">${mentee.name}</a></h4>
                                        <p>Student</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="settings-widget account-settings">
                            <div class="settings-menu">
                                <h3>Dashboard</h3>
                                <ul>
                                    <li class="nav-item">
                                        <a href="student-profile.html" class="nav-link">
                                            <i class="bx bxs-user"></i>My Profile
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="student-wishlist.html" class="nav-link">
                                            <i class="bx bxs-heart"></i>Wishlist
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="student-reviews.html" class="nav-link">
                                            <i class="bx bxs-star"></i>Reviews
                                        </a>
                                    </li>                                  
                                    <li class="nav-item">
                                        <a href="student-referral.html" class="nav-link">
                                            <i class="bx bxs-user-plus"></i>Referrals
                                        </a>
                                    </li>
                                    <li class="nav-item active">
                                        <a href="student-tickets.html" class="nav-link">
                                            <i class="bx bxs-coupon"></i>View request
                                        </a>
                                    </li>
                                </ul>
                                <h3>Account Settings</h3>
                                <ul>
                                    <li class="nav-item">
                                        <a href="student-settings.html" class="nav-link ">
                                            <i class="bx bxs-cog"></i>Settings
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="index-2.html" class="nav-link">
                                            <i class="bx bxs-log-out"></i>Logout
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>			
                    </div>
                    <!-- Page Content -->
                    <div class="col-md-9"> 
                        <h3>Request List</h3>
                        <div class="formcontent">
                            <div>  
                                <table class="tablecontent">
                                    <thead>
                                        <tr>
                                            <td>title</td>
                                            <td>totalSlot</td>
                                            <td>startDate</td>
                                            <td>endDate</td>
                                            <td>content</td>
                                            <td>status</td>
                                            <td>createdAt</td>
                                            <td>updatedAt</td>
                                            <td>courseIds</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${sessionScope.listAllRequest}" var="o">
                                            <tr>
                                                <td>${o.title}</td>
                                                <td>${o.totalSlot}</td>
                                                <td>${o.startDate}</td>
                                                <td>${o.endDate}</td>
                                                <td>${o.content}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${o.status eq 'Draft'}">${o.status}
                                                            <a href="UpdateRequest?id=${o.id}" target="_blank">Update</a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${o.status}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>${o.createdAt}</td>
                                                <td>${o.updatedAt}</td>
                                                <td>${o.courseId}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                            </div>
                        </div> 
                        <div class="dash-pagination">
                            <div class="row align-items-center">
                                <div class="col-6">
                                    <p>Page 1 of 2</p>
                                </div>
                                <div class="col-6">
                                    <ul class="pagination">
                                        <li class="active">
                                            <a href="#">1</a>
                                        </li>
                                        <li>
                                            <a href="#">2</a>
                                        </li>
                                        <li>
                                            <a href="#"><i class="bx bx-chevron-right"></i></a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <!-- /Page Content -->

        <!-- Footer -->
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

    <!-- Mirrored from dreamslms.dreamstechnologies.com/html/student-tickets.html by HTTrack Website Copier/3.x [XR&CO'2014], Tue, 11 Feb 2025 21:04:22 GMT -->
</html>