<%-- 
    Document   : MySchedule
    Created on : Mar 19, 2025, 12:57:46 AM
    Author     : Ann
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
java.util.Calendar cal = java.util.Calendar.getInstance();
int currentMonth = cal.get(java.util.Calendar.MONTH) + 1;
int currentYear = cal.get(java.util.Calendar.YEAR);
%>
<fmt:setLocale value="en"/>

<!DOCTYPE html>
<html>
    <head>
        <!-- Same head content as original -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Doccure - Your Schedule</title>

        <!-- Favicon & Icons -->
        <link rel="shortcut icon" href="/HAPPYorSAD/assets/img/favicon.svg">
        <link rel="apple-touch-icon" sizes="180x180" href="/HAPPYorSAD/assets/img/apple-touch-icon.png">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/feather.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/iconsax.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/boxicons/css/boxicons.min.css">

        <!-- CSS Libraries -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/select2/css/select2.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap-datetimepicker.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/dropzone/dropzone.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/custom.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css">
    </head>
    <body>
        <%@include file="../sourcesHome/homeHeader.jsp" %>

        <div class="main-wrapper">
            <!-- Breadcrumb -->
            <div class="breadcrumb-bar breadcrumb-bar-info">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="breadcrumb-list">
                                <h2 class="breadcrumb-title">Dashboard</h2>
                                <nav aria-label="breadcrumb" class="page-breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="index-2.html">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Your Schedule</li>
                                    </ol>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="page-content">
                <div class="container">
                    <div class="row">
                        <div class="page-content">
                            <div class="container">
                                <div class="row">
                                    <div class="col-xl-3 col-lg-3 theiaStickySidebar">

                                        <div class="settings-widget account-settings">
                                            <div class="settings-menu">
                                                <h3>Dashboard</h3>
                                                <ul>
                                                    <li class="nav-item ">
                                                        <a href="/../HAPPYorSAD/ProfileServlet" class="nav-link">
                                                            <i class="bx bxs-tachometer"></i>Profile
                                                        </a>
                                                    </li>
                                                    <li class="nav-item active">
                                                        <a href="/../HAPPYorSAD/SetSlot" class="nav-link">
                                                            <i class="bx bxs-tachometer"></i>Schedule
                                                        </a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a href="/../HAPPYorSAD/MySchedule" class="nav-link">
                                                            <i class="bx bxs-graduation"></i>My Schedule
                                                        </a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a href="Notifications" class="nav-link">
                                                            <i class="bx bxs-bell"></i>Notifications
                                                        </a>
                                                    </li>
                                                </ul>
                                                <h3>Instructor</h3>
                                                <ul>
                                                    <li class="nav-item">
                                                        <a href="/../HAPPYorSAD/ViewCV" class="nav-link ">
                                                            <i class="bx bxs-rocket"></i>Curriculum Vitae
                                                        </a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a href="/../HAPPYorSAD/viewRequest" class="nav-link">
                                                            <i class="bx bxs-graduation"></i>Inviting Request
                                                        </a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a href="/../HAPPYorSAD/Attendance" class="nav-link">
                                                            <i class="bx bxs-graduation"></i>Attendance
                                                        </a>
                                                    </li>
                                                </ul>
                                                <h3>Account Settings</h3>
                                                <ul>
                                                    <li class="nav-item">
                                                        <a href="updatementorprofile?username=${sessionScope.usernameUser}" class="nav-link ">
                                                            <i class="bx bxs-cog"></i>Settings
                                                        </a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a href="LoginUser?service=logout" class="nav-link">
                                                            <i class="bx bxs-log-out"></i>Logout
                                                        </a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>                         


                                    <div class="col-lg-9 col-xl-9">
                                        <div class="dashboard-header"><h3>Your Schedule</h3></div>
                                        <div class="card custom-card">
                                            <div class="card-body">
                                                <div class="card-header"><h3>Your Schedule</h3></div>
                                                <div class="row align-items-center mb-3">
                                                    <div class="col-12 col-sm-4 col-md-6">
                                                        <h4 class="mb-1"><fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd MMMM yyyy"/></h4>
                                                        <p class="text-muted"><fmt:formatDate value="<%= new java.util.Date() %>" pattern="EEEE"/></p>
                                                    </div>
                                                    <div class="col-12 col-sm-8 col-md-6 text-sm-end">
                                                        <div class="dropdown d-inline-block">
                                                            <a href="#" class="dropdown-toggle text-primary" id="monthDropdown" data-bs-toggle="dropdown">
                                                                <i class="far fa-calendar-alt me-2"></i>
                                                                <span id="selectedMonth">${selectedMonth} ${selectedYear}</span>
                                                                <i class="fas fa-chevron-down ms-2"></i>
                                                            </a>
                                                            <ul class="dropdown-menu" aria-labelledby="monthDropdown">
                                                                <c:forEach var="i" begin="1" end="<%=currentMonth%>">
                                                                    <li><a class="dropdown-item month-item" href="#" data-month="${i} ${selectedYear}">${i} ${selectedYear}</a></li>
                                                                    </c:forEach>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row mb-3">
                                                    <div class="col-12 text-center">
                                                        <form action="/HAPPYorSAD/MySchedule" method="get" style="display:inline;">
                                                            <input type="hidden" name="weekOffset" value="${weekOffset - 1}">
                                                            <input type="hidden" name="month" value="${selectedMonth}">
                                                            <input type="hidden" name="year" value="${selectedYear}">
                                                            <button type="submit" class="btn btn-primary me-2">Previous Week</button>
                                                        </form>
                                                        <span>Week of ${weekStartDate} - ${weekEndDate}</span>
                                                        <c:if test="${canNextWeek}">
                                                            <form action="/HAPPYorSAD/MySchedule" method="get" style="display:inline;">
                                                                <input type="hidden" name="weekOffset" value="${weekOffset + 1}">
                                                                <input type="hidden" name="month" value="${selectedMonth}">
                                                                <input type="hidden" name="year" value="${selectedYear}">
                                                                <button type="submit" class="btn btn-primary ms-2">Next Week</button>
                                                            </form>
                                                        </c:if>
                                                    </div>
                                                </div>
                                                <div class="row slot-row">
                                                    <c:choose>
                                                        <c:when test="${empty weekDates}">
                                                            <div class="col-12"><p class="text-warning">No week dates available for this month.</p></div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:forEach var="day" items="${weekDates}" varStatus="status">
                                                                <div class="col-md slot-column">
                                                                    <div class="slot-box">
                                                                        <div class="slot-header">
                                                                            <h5>${weekDays[status.index]}<span style="font-size: 0.8em; display: block;">${day.split('-')[2]}/${day.split('-')[1]}</span></h5>
                                                                        </div>
                                                                        <div class="slot-body">
                                                                            <table class="table table-bordered text-center">
                                                                                <tbody>
                                                                                    <c:forEach var="i" begin="1" end="5">
                                                                                        <tr>
                                                                                            <td>
                                                                                                <c:set var="slotFound" value="false"/>
                                                                                                <c:forEach var="slot" items="${slotsByDay[day]}">
                                                                                                    <c:if test="${slot.slotNumber == i}">
                                                                                                        <span>Slot ${slot.slotNumber}</span>
                                                                                                        <c:set var="slotFound" value="true"/>
                                                                                                    </c:if>
                                                                                                </c:forEach>
                                                                                                <c:if test="${not slotFound}">
                                                                                                    <span class="text-muted">Empty</span>
                                                                                                </c:if>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </c:forEach>
                                                                                </tbody>
                                                                            </table>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </c:forEach>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Same scripts -->
                        <script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js"></script>
                        <script src="/HAPPYorSAD/assets/js/bootstrap.bundle.min.js"></script>
                        <script>
                            document.addEventListener("DOMContentLoaded", () => {
                                const monthItems = document.querySelectorAll(".month-item");
                                monthItems.forEach(item => {
                                    item.addEventListener("click", (e) => {
                                        e.preventDefault();
                                        const [month, year] = item.dataset.month.split(" ");
                                        document.getElementById("selectedMonth").textContent = item.dataset.month;
                                        document.getElementById("hiddenMonth").value = month;
                                        document.getElementById("hiddenYear").value = year;
                                        document.getElementById("monthForm").submit();
                                    });
                                });
                            });
                        </script>
                        <form id="monthForm" action="/HAPPYorSAD/MySchedule" method="get" style="display:none;">
                            <input type="hidden" name="month" id="hiddenMonth">
                            <input type="hidden" name="year" id="hiddenYear">
                        </form>
                    </div>
                    </body>
                    </html>