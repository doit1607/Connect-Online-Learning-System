<%-- 
    Document   : AttendanceMentee
    Created on : Mar 10, 2025, 6:40:53 AM
    Author     : Ann
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    java.util.Calendar cal = java.util.Calendar.getInstance();
    int currentMonth = cal.get(java.util.Calendar.MONTH) + 1; // Tháng bắt đầu từ 0 nên cộng 1
    int currentYear = cal.get(java.util.Calendar.YEAR);
%>
<fmt:setLocale value="en"/>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Doccure - Mentee Attendance</title>

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

        <style>
            .temp-slot-item {
                background: #fffae6;
                border-left: 4px solid #ffc107;
                padding: 5px 10px;
                font-weight: bold;
                display: inline-flex;
                align-items: center;
            }
            .slot-box {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
            }
            .slot-header {
                font-size: 16px;
                font-weight: bold;
                padding: 10px;
                text-align: center;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                height: 100%;
            }
            .slot-body {
                padding: 5px;
            }
            .slot-body table {
                width: 100%;
                margin-bottom: 0;
            }
            .slot-footer {
                padding: 10px;
            }
            .row.slot-row {
                display: flex;
                flex-wrap: nowrap;
                overflow-x: auto;
                justify-content: flex-start;
                gap: 10px;
                padding: 10px 0;
            }
            .col-md.slot-column {
                flex: 0 0 calc(14.2857% - 10px);
                min-width: 120px;
                padding: 0;
            }
            .slot-present {
                background-color: rgba(0, 128, 0, 0.1);
                color: green;
                padding: 3px 6px;
                border-radius: 4px;
                font-weight: bold;
            }
            .slot-absent {
                background-color: rgba(255, 0, 0, 0.1);
                color: red;
                padding: 3px 6px;
                border-radius: 4px;
                font-weight: bold;
            }
            .slot-pending {
                background-color: rgba(255, 165, 0, 0.1);
                color: orange;
                padding: 3px 6px;
                border-radius: 4px;
                font-weight: bold;
            }
            .slot-clickable {
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .slot-clickable:hover {
                background-color: #f0f0f0;
            }
            .pending-indicator {
                margin-left: 5px;
                font-weight: bold;
            }
            .slot-studying {
                color: blue;
                font-weight: bold;
            }
        </style>
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
                                        <li class="breadcrumb-item active" aria-current="page">Attendance</li>
                                    </ol>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Page Content -->
            <div class="page-content">
                <div class="container">
                    <div class="row">
                        <!-- Sidebar -->
                        <div class="col-xl-3 col-lg-3 theiaStickySidebar">
                            <div class="settings-widget account-settings">
                                <div class="settings-menu">
                                    <h3>Dashboard</h3>
                                    <ul>
                                        <li class="nav-item">
                                            <a href="/HAPPYorSAD/ProfileServlet" class="nav-link">
                                                <i class="bx bxs-user"></i>Profile
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="/HAPPYorSAD/ShowMenteeRequest" class="nav-link">
                                                <i class="bx bxs-graduation"></i>Request
                                            </a>
                                        </li>
                                        <li class="nav-item active">
                                            <a href="/HAPPYorSAD/AttendanceMentee" class="nav-link">
                                                <i class="bx bxs-check-circle"></i>Attendance
                                            </a>
                                        </li>
                                        <c:if test="${sessionScope.menteeRequestStatus eq 'Completed'}">
                                            <li class="nav-item">
                                                <a href="reviewmentor" class="nav-link">
                                                    <i class="bx bxs-bell"></i> Review Mentor
                                                </a>
                                            </li>
                                        </c:if>
                                    </ul>
                                    <h3>Account Settings</h3>
                                    <ul>
                                        <li class="nav-item">
                                            <a href="updatementeeprofile?username=${sessionScope.usernameUser}" class="nav-link">
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

                        <!-- Main Content -->
                        <div class="col-lg-9 col-xl-9">
                            <div class="dashboard-header"><h3>Attendance</h3></div>
                            <div class="card custom-card">
                                <div class="card-body">
                                    <div class="card-header"><h3>Your Attendance</h3></div>
                                    <c:if test="${not empty message}">
                                        <div class="alert alert-success">${message}</div>
                                    </c:if>
                                    <c:if test="${not empty error}">
                                        <div class="alert alert-danger">${error}</div>
                                    </c:if>
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
                                    <!-- Week Navigation -->
                                    <div class="row mb-3">
                                        <div class="col-12 text-center">
                                            <form action="/HAPPYorSAD/AttendanceMentee" method="get" style="display:inline;">
                                                <input type="hidden" name="weekOffset" value="${weekOffset - 1}">
                                                <input type="hidden" name="month" value="${selectedMonth}">
                                                <input type="hidden" name="year" value="${selectedYear}">
                                                <button type="submit" class="btn btn-primary me-2">Previous Week</button>
                                            </form>
                                            <span>Week of ${weekStartDate} - ${weekEndDate}</span>
                                            <form action="/HAPPYorSAD/AttendanceMentee" method="get" style="display:inline;">
                                                <input type="hidden" name="weekOffset" value="${weekOffset + 1}">
                                                <input type="hidden" name="month" value="${selectedMonth}">
                                                <input type="hidden" name="year" value="${selectedYear}">
                                                <button type="submit" class="btn btn-primary ms-2">Next Week</button>
                                            </form>
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
                                                                                        <c:if test="${slot.slot_number == i}">
                                                                                            <c:choose>
                                                                                                <c:when test="${slot.status == 'present'}">
                                                                                                    <span class="slot-present">Slot ${slot.slot_number} <span class="pending-indicator">✓</span></span>
                                                                                                </c:when>
                                                                                                <c:when test="${slot.status == 'absent'}">
                                                                                                    <span class="slot-absent">Slot ${slot.slot_number} <span class="pending-indicator">✗</span></span>
                                                                                                </c:when>
                                                                                                <c:when test="${slot.status == 'Studying'}">
                                                                                                    <span class="slot-studying">Slot ${slot.slot_number} <span class="pending-indicator">📖</span></span>
                                                                                                </c:when>
                                                                                                <c:when test="${slot.status == 'confirm_present' || slot.status == 'confirm_absent'}">
                                                                                                    <form action="/HAPPYorSAD/AttendanceMentee" method="post" style="display:inline;">
                                                                                                        <input type="hidden" name="action" value="getMentorInfo">
                                                                                                        <input type="hidden" name="date" value="${day}">
                                                                                                        <input type="hidden" name="slot" value="${slot.slot_number}">
                                                                                                        <input type="hidden" name="month" value="${selectedMonth}">
                                                                                                        <input type="hidden" name="year" value="${selectedYear}">
                                                                                                        <input type="hidden" name="weekOffset" value="${weekOffset}">
                                                                                                        <button type="submit" class="slot-pending slot-clickable btn btn-link p-0">Slot ${slot.slot_number} <span class="pending-indicator">?</span></button>
                                                                                                    </form>
                                                                                                </c:when>
                                                                                                <c:otherwise>
                                                                                                    <span class="text-muted">Empty</span>
                                                                                                </c:otherwise>
                                                                                            </c:choose>
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

            <!-- Notification Modal for Request Completion -->
            <div class="modal fade" id="completionModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Request Completed</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p>${notification}</p>
                            <p><strong>Request đã hoàn thành hết các Slot.</strong> Nhấn để chuyển sang trang view request để xác nhận hoàn thành.</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <a href="/HAPPYorSAD/ShowMenteeRequest?requestId=${requestId}" class="btn btn-primary">Confirm Completion</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal for Confirmation -->
            <div class="modal fade" id="confirmationModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Confirm Attendance - Slot ${selectedSlot} on ${selectedDate}</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <c:choose>
                                <c:when test="${empty mentor}">
                                    <p class="text-muted">No mentor assigned to this slot.</p>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <p><strong>Mentor:</strong> ${mentor.name} (${mentor.email})</p>
                                    <p>Mentor marked your attendance as: 
                                        <strong>${slot.status == 'confirm_present' ? 'Present' : slot.status == 'confirm_absent' ? 'Absent' : slot.status}</strong>
                                    </p>
                                    <c:choose>
                                        <c:when test="${slot.status == 'confirm_present' || slot.status == 'confirm_absent'}">
                                            <form action="/HAPPYorSAD/AttendanceMentee" method="post">
                                                <input type="hidden" name="action" value="confirmAttendance">
                                                <input type="hidden" name="date" value="${selectedDate}">
                                                <input type="hidden" name="slot" value="${selectedSlot}">
                                                <input type="hidden" name="month" value="${selectedMonth}">
                                                <input type="hidden" name="year" value="${selectedYear}">
                                                <input type="hidden" name="weekOffset" value="${weekOffset}">
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                    <button type="submit" name="confirmation" value="confirm" class="btn btn-success">Confirm</button>
                                                    <button type="submit" name="confirmation" value="reject" class="btn btn-danger">Reject</button>
                                                </div>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <p class="text-muted">Attendance has been confirmed as ${slot.status}.</p>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Scripts -->
            <script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js"></script>
            <script src="/HAPPYorSAD/assets/js/bootstrap.bundle.min.js"></script>
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    // Tự động ẩn thông báo sau 3 giây
                    setTimeout(function () {
                        let alerts = document.querySelectorAll(".alert");
                        alerts.forEach(alert => {
                            alert.style.transition = "opacity 0.5s";
                            alert.style.opacity = "0";
                            setTimeout(() => alert.style.display = "none", 500);
                        });
                    }, 3000);

                    // Xử lý chọn tháng từ dropdown
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

                    // Hiển thị modal nếu được yêu cầu từ servlet
                <c:if test="${showModal}">
                    var confirmationModal = new bootstrap.Modal(document.getElementById("confirmationModal"));
                    confirmationModal.show();
                </c:if>

                <c:if test="${showCompletionModal}">
                    var completionModal = new bootstrap.Modal(document.getElementById("completionModal"));
                    completionModal.show();
                </c:if>
                });
            </script>

            <!-- Hidden Form for Month Selection -->
            <form id="monthForm" action="/HAPPYorSAD/AttendanceMentee" method="get" style="display:none;">
                <input type="hidden" name="month" id="hiddenMonth">
                <input type="hidden" name="year" id="hiddenYear">
                <input type="hidden" name="weekOffset" value="${weekOffset}">
            </form>
        </div>
    </body>
</html>