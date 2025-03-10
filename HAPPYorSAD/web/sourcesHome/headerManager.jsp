<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 
    Document   : homeHeader
    Created on : Jan 19, 2025, 4:17:41 PM
    Author     : Ann
--%>
<!DOCTYPE html>
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
                                            <i class="feather-star me-1"></i> 
                                            Wallet: <span id="walletAmount"><fmt:formatNumber value="${sessionScope.walletBalance}" pattern="#,##0" /></span> <span id="currencySymbol"></span>

                                        </a>
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
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            document.getElementById("currencySymbol").innerHTML = "đ";
        });

    </script>
</html>

