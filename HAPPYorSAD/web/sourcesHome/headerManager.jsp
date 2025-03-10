<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- 
    Document   : homeHeader
    Created on : Jan 19, 2025, 4:17:41 PM
    Author     : Ann
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>Dreams LMS</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            .user-wallet {
                margin-left: 10px;
                font-size: 16px; /* Tăng kích thước chữ */
                font-weight: 600;
                color: #fff;
                background-color: #FF6B6B; /* Màu tím nhạt */
                padding: 8px 16px; /* Tăng padding để làm to hơn */
                border-radius: 25px; /* Bo tròn góc nhiều hơn */
                border: 1px solid #7B1FA2; /* Viền màu tím đậm */
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Đổ bóng nhẹ */
                transition: all 0.3s ease; /* Hiệu ứng mượt mà */
                display: inline-flex;
                align-items: center;
                cursor: pointer; /* Thêm con trỏ khi hover */
                text-decoration: none; /* Loại bỏ gạch chân mặc định của thẻ <a> */
            }

            .user-wallet:hover {
                background-color: #7B1FA2; /* Màu tím đậm khi hover */
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Đổ bóng đậm hơn khi hover */
                transform: translateY(-2px); /* Hiệu ứng nổi lên */
            }

            .user-wallet i {
                margin-right: 8px; /* Tăng khoảng cách giữa icon và chữ */
                font-size: 14px; /* Tăng kích thước icon */
                color: #fff;
            }

            .user-nav {
                display: flex;
                align-items: center;
            }

            .user-nav .user-img {
                margin-right: 10px;
            }

            .user-nav .user-img img {
                border-radius: 50%;
                border: 2px solid #fff;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            .user-nav .status {
                position: absolute;
                bottom: 0;
                right: 0;
                width: 10px;
                height: 10px;
                background-color: #4CAF50;
                border-radius: 50%;
                border: 2px solid #fff;
            }

            /* CSS để giữ nguyên vị trí của số dư ví */
            .wallet-container {
                display: flex;
                align-items: center;
                margin-left: 10px; /* Khoảng cách giữa avatar và số dư ví */
            }
        </style>
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
                                </li>						
                                <li class="nav-item user-nav">

                                    <div class="wallet-container">
                                        <a href="#" class="dropdown-toggle" data-bs-toggle="dropdown">
                                            <span class="user-img">
                                                <img src="${not empty sessionScope.userAvatar ? sessionScope.userAvatar : '/HAPPYorSAD/assets/img/user/user.jpg'}" alt="Img">
                                                <span class="status online"></span>
                                            </span>
                                        </a>
                                        <a href="/../HAPPYorSAD/Wallet" class="user-wallet">
                                            <i class="fas fa-wallet"></i>
                                            <fmt:formatNumber value="${sessionScope.walletBalance}" pattern="#,##0" /> đ
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

                                            <a class="dropdown-item" href="/../HAPPYorSAD/LoginUser?service=logout"><i class="feather-log-out me-1"></i> Logout</a>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </nav>
                </div>
            </header>
            <!-- /Header -->
        </div>
    </body>
    <script>
        document.addEventListener("DOMContentLoaded", function () {

            document.getElementById("currencySymbol").innerHTML = "đ";


            const walletBalance = document.querySelector('.user-wallet');
            walletBalance.addEventListener('click', function (event) {
                event.preventDefault();
                window.location.href = "/../HAPPYorSAD/Wallet";
            });
        });
    </script>
</html>