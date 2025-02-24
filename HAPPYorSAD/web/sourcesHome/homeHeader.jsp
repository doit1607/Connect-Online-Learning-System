<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : homeHeader
    Created on : Jan 19, 2025, 4:17:41 PM
    Author     : Ann
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<c:if test = "${sessionScope.usernameRole != null}">
    <html>
        <head>

            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
            <title>Dreams LMS</title>

        </head>
        <body>

            <!-- Main Wrapper -->
            <div class="main-wrapper">

                <!-- Header -->
                <header class="header header-page">
                    <div class="header-fixed">
                        <nav class="navbar navbar-expand-lg header-nav scroll-sticky">
                            <div class="container ">
                                <div class="navbar-header">
                                    <a id="mobile_btn" href="javascript:void(0);">
                                        <span class="bar-icon">
                                            <span></span>
                                            <span></span>
                                            <span></span>
                                        </span>
                                    </a>
                                    <a  class="navbar-brand logo">
                                        <img src="/HAPPYorSAD/assets/img/logo.svg" class="img-fluid" alt="Logo">
                                    </a>
                                </div>
                                <div class="main-menu-wrapper">
                                    <div class="menu-header">
                                        <a  class="menu-logo">
                                            <img src="/HAPPYorSAD/assets/img/logo.svg" class="img-fluid" alt="Logo">
                                        </a>
                                        <a id="menu_close" class="menu-close" href="javascript:void(0);">
                                            <i class="fas fa-times"></i>
                                        </a>
                                    </div>
                                    <ul class="main-nav">
                                        <li class="has-submenu">
                                            <a href="/../HAPPYorSAD/Home">Home <i class="fas fa-chevron-down"></i></a>
                                            <ul class="submenu">
                                            </ul>
                                        </li>
                                        <li class="has-submenu">
                                            <a href="/../HAPPYorSAD/ViewMentor_Mentee">Mentor <i class="fas fa-chevron-down"></i></a>
                                            <ul class="submenu">

                                                <li><a href="ViewMentor_Mentee">Mentor List</a></li>
                                                    <c:if test = "${sessionScope.usernameRole eq 'mentor'}">
                                                    <li><a href="/../HAPPYorSAD/ProfileServlet">Dashboard</a></li>
                                                    <li><a href="ViewCV">My CV</a></li>
                                                    <li><a href="Slot">Schedule</a></li>
                                                    <li><a href="instructor-reviews.html">Reviews</a></li>
                                                    <li><a href="instructor-orders.html">Request</a></li>
                                                    <li><a href="instructor-notifications.html">Notifications</a></li>
                                                    </c:if>
                                            </ul>
                                        </li>	
                                        <c:if test="${sessionScope.usernameRole eq 'mentee'}">
                                            <li class="has-submenu">
                                                <a href="#">Mentee<i class="fas fa-chevron-down"></i></a>
                                                <ul class="submenu first-submenu">
                                                    <li><a href="/../HAPPYorSAD/ProfileServlet"> Mentee Dashboard</a></li>
                                                    <li><a href="student-courses.html">Enrolled Courses</a></li>
                                                    <li><a href="Schedule">Book</a></li>

                                                </ul>
                                            </li>	
                                        </c:if>
                                        <li class="has-submenu">
                                            <a href="#">Courses <i class="fas fa-chevron-down"></i></a>
                                            <ul class="submenu">
                                                <c:if test="${sessionScope.usernameRole eq 'mentor' and sessionScope.cvStatus eq 'approved'}">
                                                    <!--                                                    <li><a href="CreateCourses">Add Course</a></li>-->
                                                </c:if>

                                                <li><a href="/../HAPPYorSAD/ShowAllCourse">Course List</a></li>

                                            </ul>
                                        </li>

                                    </ul>		 
                                </div>	 
                                <ul class="nav header-navbar-rht">		
                                    <li class="nav-item user-nav">
                                        <div>
                                            <a href="javascript:void(0);" id="dark-mode-toggle" class="dark-mode-toggle  ">
                                                <i class="fa-solid fa-moon"></i>
                                            </a>
                                            <a href="javascript:void(0);" id="light-mode-toggle" class="dark-mode-toggle ">
                                                <i class="fa-solid fa-sun"></i>
                                            </a>
                                        </div>
                                    </li>						
                                    <li class="nav-item user-nav">
                                        <a href="#" class="dropdown-toggle" data-bs-toggle="dropdown">
                                            <span class="user-img">
                                                <img src="${not empty sessionScope.userAvatar ? sessionScope.userAvatar : '/HAPPYorSAD/assets/img/user/user.jpg'}" alt="Img">
                                                <span class="status online"></span>
                                            </span>
                                        </a>

                                        <div class="users dropdown-menu dropdown-menu-right" data-popper-placement="bottom-end">
                                            <div class="user-header">
                                                <div class="avatar avatar-sm">
                                                    <img src="${not empty sessionScope.userAvatar ? sessionScope.userAvatar : '/HAPPYorSAD/assets/img/user/user.jpg'}" alt="User Image" class="avatar-img rounded-circle">
                                                </div>
                                                <div class="user-text">
                                                    <h6>${sessionScope.usernameUser}</h6>
                                                    <p class="text-muted mb-0">${sessionScope.usernameRole}</p>
                                                </div>
                                            </div>
                                            <a class="dropdown-item" href="/../HAPPYorSAD/view/Wallet.jsp">
                                                <i class="feather-star me-1"></i> Wallet:
                                                <fmt:formatNumber value="${sessionScope.walletBalance}" 
                                                                  type="number" 
                                                                  pattern="#,##0" 
                                                                  currencySymbol="" /> đ
                                            </a>
                                            <a class="dropdown-item" href="/../HAPPYorSAD/ProfileServlet"><i class="feather-home me-1"></i> Dashboard</a>
                                            <c:if test ="${sessionScope.usernameRole eq 'mentee'}">
                                                <a class="dropdown-item" href="/../HAPPYorSAD/updatementeeprofile"><i class="feather-user me-1"></i> Profile</a>
                                            </c:if>
                                            <c:if test ="${sessionScope.usernameRole eq 'mentor'}">
                                                <a class="dropdown-item" href="/../HAPPYorSAD/updatementorprofile"><i class="feather-user me-1"></i> Profile</a>
                                            </c:if>




                                            <c:if test="${sessionScope.usernameRole eq 'mentor'}">
                                                <c:choose>
                                                    <c:when test="${empty sessionScope.cvStatus || sessionScope.cvStatus eq 'rejected'}">
                                                        <a class="dropdown-item" href="CreateCV"><i class="feather-star me-1"></i> Create CV</a>
                                                    </c:when>

                                                    <c:when test="${sessionScope.cvStatus eq 'draft'}">
                                                        <a class="dropdown-item" href="UpdateCV"><i class="feather-star me-1"></i> Update CV</a>
                                                    </c:when>

                                                    <c:when test="${sessionScope.cvStatus eq 'Pending'}">
                                                        <!--<a class="dropdown-item" href="ViewCV"><i class="feather-star me-1"></i> View CV</a>-->
                                                    </c:when>
                                                </c:choose>
                                            </c:if>
                                            <!--                                            <a class="dropdown-item" href="<c:choose>
                                                <c:when test="${sessionScope.usernameRole == 'mentee'}">
                                                    updatementeeprofile?username=${sessionScope.usernameUser}
                                                </c:when>
                                                <c:otherwise>
                                                    updatementorprofile?username=${sessionScope.usernameUser}
                                                </c:otherwise>
                                            </c:choose>">
                                             <i class="feather-star me-1"></i> Edit Profile
                                         </a>-->
                                            <a class="dropdown-item" href="/../HAPPYorSAD/LoginUser?service=logout"><i class="feather-log-out me-1"></i> Logout</a>
                                        </div>
                                    </li>

                                </ul>
                            </div>
                        </nav>
                    </div>
                </header>
                <!-- /Header -->
        </body>

    </html>
</c:if>
<c:if test = "${sessionScope.usernameRole == null}">
    <html>
        <head>
            <meta charset="utf-8">         
            <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">         
            <title>Dreams LMS</title>          


        </head>
        <body>
            <div class="main-wrapper">
                <header class="header header-page">
                    <div class="header-fixed">
                        <nav class="navbar navbar-expand-lg header-nav scroll-sticky">
                            <div class="container ">
                                <div class="navbar-header">
                                    <a id="mobile_btn" href="javascript:void(0);">
                                        <span class="bar-icon">
                                            <span></span>
                                            <span></span>
                                            <span></span>
                                        </span>
                                    </a>
                                    <a href="index-2.html" class="navbar-brand logo">
                                        <img src="/HAPPYorSAD/assets/img/logo.svg" class="img-fluid" alt="Logo">
                                    </a>
                                </div>
                                <div class="main-menu-wrapper">
                                    <div class="menu-header">
                                        <a class="menu-logo">
                                            <img src="/HAPPYorSAD/assets/img/logo.svg" class="img-fluid" alt="Logo">
                                        </a>
                                        <a id="menu_close" class="menu-close" href="javascript:void(0);">
                                            <i class="fas fa-times"></i>
                                        </a>
                                    </div>
                                    <ul class="main-nav">
                                        <li class="has-submenu">
                                            <a href="/../HAPPYorSAD/Home">Home <i class="fas fa-chevron-down"></i></a>
                                            <ul class="submenu">
                                            </ul>
                                        </li>
                                        <li class="has-submenu">
                                            <a href="ViewMentor_Mentee">Mentor <i class="fas fa-chevron-down"></i></a>
                                            <ul class="submenu">
                                                <li><a href="course-list.html">Mentor List</a></li>
                                            </ul>
                                        </li>	
                                        <li class="has-submenu">
                                            <a href="#">Courses <i class="fas fa-chevron-down"></i></a>
                                            <ul class="submenu">
                                                <li><a href="/../HAPPYorSAD/ShowAllCourse">Course List</a></li>
                                            </ul>
                                        </li>

                                    </ul>		 
                                </div>
                                <ul class="nav header-navbar-rht">
                                    <li class="nav-item">
                                        <div>
                                            <a href="javascript:void(0);" id="dark-mode-toggle" class="dark-mode-toggle  ">
                                                <i class="fa-solid fa-moon"></i>
                                            </a>
                                            <a href="javascript:void(0);" id="light-mode-toggle" class="dark-mode-toggle ">
                                                <i class="fa-solid fa-sun"></i>
                                            </a>
                                        </div>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link header-sign" href="view/LoginUser.jsp">Login</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link header-login" href="view/RegisterUser.jsp">Register</a>
                                    </li>
                                </ul>
                            </div>
                        </nav>
                    </div>
                </header>
                <!-- /Header -->
            </div>
        </body>
    </html>
</c:if>
