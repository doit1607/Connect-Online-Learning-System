<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.List" %>
<%@ page import="entity.Request" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>Dreams LMS</title>

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

        <style>
            /* ??nh d?ng h?ng tr?ng th?i */
            .status-group {
                display: flex;
                justify-content: space-between;
                align-items: center;
                position: relative;
                margin: 20px 0;
                padding: 0 20px;
            }

            /* Thanh n?i gi?a c?c tr?ng th?i */
            .status-group::before {
                content: "";
                position: absolute;
                top: 50%;
                left: 10%;
                right: 10%;
                height: 4px;
                background: #ddd;
                z-index: 0;
            }

            /* ??nh d?ng t?ng tr?ng th?i */
            .status-group input {
                display: none;
            }

            .status-group label {
                position: relative;
                display: flex;
                align-items: center;
                justify-content: center;
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background: #ddd;
                border: 3px solid #ddd;
                cursor: pointer;
                transition: 0.3s;
                font-size: 14px;
                font-weight: bold;
            }

            /* ??nh d?ng ch? d??i tr?ng th?i */
            .status-group label::after {
                content: attr(for);
                position: absolute;
                top: 45px;
                font-size: 14px;
                color: #555;
            }

            /* Khi tr?ng th?i ???c ch?n */
            .status-group input:checked + label {
                background: #28a745;
                border-color: #28a745;
                color: white;
            }

            /* Hi?u ?ng m?u xanh cho ???ng n?i */
            .status-group input:checked + label::before {
                content: "✔";
            }

            /* N?t Cancel t?ch ri?ng */
            .cancel-status label {
                display: inline-block;
                padding: 8px 16px;
                border-radius: 20px;
                cursor: pointer;
                font-weight: bold;
                color: red;
                background: transparent;
                transition: background 0.3s, color 0.3s;
            }

            /* Khi ch?n "Cancel", ??i m?u n?n */
            .cancel-status input:checked + label {
                background: red;
                color: white;
            }
            .confirm-btn {
                background-color: #007bff; /* Blue color */
                color: white;
                padding: 6px 12px 6px 10px; /* Adjusted padding for icon */
                margin-left: 8px;
                border: none;
                border-radius: 15px;
                cursor: pointer;
                font-size: 12px;
                font-weight: 500;
                transition: all 0.3s ease;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                display: inline-flex; /* For aligning icon and text */
                align-items: center;
                gap: 4px; /* Space between icon and text */
            }

            /* Hover effect */
            .confirm-btn:hover {
                background-color: #0056b3; /* Darker blue */
                transform: translateY(-1px);
                box-shadow: 0 4px 6px rgba(0,0,0,0.15);
            }

            /* Active/Click effect */
            .confirm-btn:active {
                transform: translateY(1px);
                box-shadow: 0 1px 2px rgba(0,0,0,0.1);
            }

            /* Checkmark icon */
            .confirm-btn::before {
                content: "✔"; /* Unicode checkmark */
                font-size: 14px;
            }
        </style>


    </head>
    <body>
        <!-- Header -->
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

                        <!-- sidebar -->
                        <div class="col-xl-3 col-lg-3 theiaStickySidebar">
                            <div class="settings-widget account-settings">
                                <div class="settings-menu">
                                    <h3>Dashboard</h3>
                                    <ul>
                                        <li class="nav-item">
                                            <a href="/../HAPPYorSAD/AcceptCV" class="accept-cv">
                                                <i class="fas fa-user"></i>Manage CV
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="CourseManager" class="nav-link">
                                                <i class="bx bxs-graduation"></i>Manage Course
                                            </a>
                                        </li>
                                        <li class="nav-item active">
                                            <a href="ShowAllRequest" class="nav-link">
                                                <i class="bx bxs-heart"></i>Request of Mentee
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="RequestSchedule" class="nav-link">
                                                <i class="bx bxs-star"></i>Request schedule
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="instructor-referral.html" class="nav-link">
                                                <i class="bx bxs-user-plus"></i>Referrals
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="instructor-notifications.html" class="nav-link">
                                                <i class="bx bxs-bell"></i>Notifications
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
                            <h1>List All Request</h1>

                            <div class="checkout-form">
                                <form action="ShowAllRequest" method="get" class="mb-3">
                                    <div class="container mt-4">
                                        <div class="row mb-3">
                                            <div class="col-12 text-center">
                                                <label class="d-block mb-2 fw-bold">Status</label>
                                                <div class="status-group">
                                                    <input type="radio" name="status" value="Open" id="Open" hidden>
                                                    <label for="Open">1</label>

                                                    <input type="radio" name="status" value="Pending" id="Pending" hidden>
                                                    <label for="Pending">2</label>

                                                    <input type="radio" name="status" value="Processing" id="Processing" hidden>
                                                    <label for="Processing">3</label>

                                                    <input type="radio" name="status" value="Completed" id="Completed" hidden>
                                                    <label for="Completed">4</label>

                                                    <input type="radio" name="status" value="Closed" id="Closed" hidden>
                                                    <label for="Closed">5</label>

                                                    <input type="radio" name="status" value="Cancel" id="Cancel" hidden>
                                                    <label for="Cancel">6</label>
                                                </div>
                                            </div>
                                        </div>

<!--                                        <div class="row mb-3">
                                            <div class="col-12 text-center cancel-status">
                                                <input type="radio" name="status" value="Cancel" id="Cancel" hidden>
                                                <label for="Cancel">Cancel</label>
                                            </div>
                                        </div>-->

                                        <div class="row g-3 align-items-center">
                                            <div class="col-md-4">
                                                <label for="search" class="form-label">Search</label>
                                                <input type="text" id="search" name="search" class="form-control" placeholder="Enter username">
                                            </div>

                                            <div class="col-md-4">
                                                <label for="startDate" class="form-label">Start Date</label>
                                                <input type="date" id="startDate" name="startDate" class="form-control">
                                            </div>

                                            <div class="col-md-4">
                                                <label for="endDate" class="form-label">End Date</label>
                                                <input type="date" id="endDate" name="endDate" class="form-control">
                                            </div>
                                        </div>

                                        <!-- N?t t?m ki?m -->
                                        <div class="row mt-3">
                                            <div class="col-12 text-center">
                                                <button type="submit" class="btn btn-primary px-4">Search</button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <div class="table-responsive custom-table">
                                    <table class="table table-nowrap mb-0">
                                        <tr>
                                            <th>No.</th>
                                            <th>ID</th>
                                            <th>Username</th>
                                            <th>Title</th>
                                            <th>Price</th>
                                            <th>Status</th>
                                        </tr>
                                        <c:forEach items="${requestScope.requestList}" var="o" varStatus="status1">
                                            <tr>
                                                <td><div class="STT text-center"><h6>${status1.index + 1}</h6></div></td>
                                                <td><a href="ShowAllRequest?action=detail&id=${o.id}">${o.id}</a></td>
                                                <td>${o.getUserMentee()}</td>
                                                <td>${o.title}</td>
                                                <td>${o.totalprice}</td>
                                                <td>
                                                    <div style="display: inline-block; vertical-align: middle;">
                                                        <div style="background-color: ${o.status == 'Open' ? '#28a745' : 
                                                                                        (o.status == 'Pending' ? '#fd7e14' : 
                                                                                        (o.status == 'Processing' ? '#007bff' : 
                                                                                        (o.status == 'Completed' ? '#6f42c1' :
                                                                                        (o.status == 'Closed' ? '#6c757d' : '#dc3545'))))};
                                                             color: white; padding: 8px 12px; border-radius: 5px; display: inline-block;">
                                                            ${o.status}
                                                        </div>
                                                        <c:if test="${o.status == 'Pending'}">
                                                            <form action="ShowAllRequest" method="get" style="display: inline;">
                                                                <input type="hidden" name="service" value="confirm">
                                                                <input type="hidden" name="requestid" value="${o.id}">
                                                                <input type="hidden" name="totalprice" value="${o.totalprice}">
                                                                <button type="submit" class="confirm-btn">
                                                                    Confirm
                                                                </button>
                                                            </form>
                                                        </c:if>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty requestScope.requestList}">
                                            <tr><td colspan="5" class="text-center">No requests found</td></tr>
                                        </c:if>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <script>
                            document.addEventListener("DOMContentLoaded", function () {
                                const urlParams = new URLSearchParams(window.location.search);
                                const selectedStatus = urlParams.get("status");

                                if (selectedStatus) {
                                    document.getElementById(selectedStatus).checked = true;
                                }
                            });
                        </script>
                    </div>
                </div>
            </div>
        </div>
    </body>

    <script data-cfasync="false" src="/HAPPYorSAD/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script>
    <script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

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
</html>