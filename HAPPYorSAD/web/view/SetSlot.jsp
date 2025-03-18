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
        <title>Doccure - Available Timings</title>

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
            .temp-slot-highlight {
                background-color: rgba(0, 128, 0, 0.1);
                border: 1px solid green;
                padding: 3px 6px;
                border-radius: 4px;
                color: green;
            }
            .add-temp-slot {
                margin-left: 5px;
            }
            .loading {
                opacity: 0.5;
                pointer-events: none;
            }
            .schedule-list {
                margin-bottom: 20px;
            }
            .week-navigation {
                display: flex;
                justify-content: space-between;
                align-items: center;
                width: 100%;
                max-width: 600px;
                margin: 0 auto;
            }
            .week-navigation form {
                display: inline-block;
            }
            .week-navigation button {
                font-size: 14px;
                padding: 6px 12px;
            }
            .dropdown-menu {
                display: none;
            }
            .dropdown:hover .dropdown-menu {
                display: none !important;
            }
            .dropdown.show .dropdown-menu {
                display: block !important;
            }
        </style>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                setTimeout(function () {
                    let alerts = document.querySelectorAll(".alert");
                    alerts.forEach(alert => {
                        alert.style.transition = "opacity 0.5s";
                        alert.style.opacity = "0";
                        setTimeout(() => alert.style.display = "none", 500);
                    });
                }, 3000);
            });
        </script>
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
                                        <li class="breadcrumb-item active" aria-current="page">Available Timings</li>
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
                            <div class="dashboard-header"><h3>General Availability</h3></div>
                            <div class="card custom-card">
                                <div class="card-body">
                                    <div class="card-header"><h3>Select Available Slots</h3></div>
                                    <div class="row align-items-center mb-3">
                                        <div class="col-12 col-sm-4 col-md-6">
                                            <h4 class="mb-1">${nextMonth} ${nextYear}</h4>
                                            <p class="text-muted">Schedule ID: ${nextScheduleId}</p>
                                        </div>
                                        <div class="col-12 col-sm-8 col-md-6 text-sm-end">
                                            <div class="dropdown d-inline-block">
                                                <a href="#" class="dropdown-toggle text-primary" id="scheduleMonthDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                                    <i class="far fa-calendar-alt me-2"></i>
                                                    <span id="selectedScheduleMonth">${nextMonth} ${nextYear}</span>
                                                    <i class="fas fa-chevron-down ms-2"></i>
                                                </a>
                                                <ul class="dropdown-menu" aria-labelledby="scheduleMonthDropdown">
                                                    <c:forEach var="schedule" items="${assignedSchedulesForDropdown}">
                                                        <c:set var="scheduleMonth" value="${schedule.start_date.toLocalDate().monthValue}"/>
                                                        <c:set var="scheduleYear" value="${schedule.start_date.toLocalDate().year}"/>
                                                        <li>
                                                            <form action="/HAPPYorSAD/SetSlot" method="post" style="margin: 0;">
                                                                <input type="hidden" name="action" value="selectSchedule">
                                                                <input type="hidden" name="scheduleId" value="${schedule.id}">
                                                                <button type="submit" class="dropdown-item schedule-month-item ${(schedule.id == nextScheduleId) ? 'active' : ''}">
                                                                    ${scheduleMonth} ${scheduleYear}
                                                                </button>
                                                            </form>
                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                            </div>
                                            <a href="#" class="text-primary ms-3" id="addSchedule">+ Add Schedule</a>
                                        </div>
                                    </div>
                                    <div class="row slot-row">
                                        <c:choose>
                                            <c:when test="${empty nextWeekDates}">
                                                <div class="col-12"><p class="text-warning">No week dates available for selected schedule.</p></div>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach var="day" items="${nextWeekDates}" varStatus="status">
                                                    <div class="col-md slot-column">
                                                        <div class="slot-box">
                                                            <div class="slot-header">
                                                                <h5>${weekDays[status.index]}</h5>
                                                                <small>${day}</small>
                                                            </div>
                                                            <div class="slot-body">
                                                                <table class="table table-bordered text-center">
                                                                    <tbody>
                                                                        <c:forEach var="i" begin="1" end="5">
                                                                            <tr>
                                                                                <td>
                                                                                    <c:set var="slotFound" value="false"/>
                                                                                    <c:forEach var="slot" items="${nextSlotsByDay[day]}">
                                                                                        <c:if test="${slot.slotNumber == i}">
                                                                                            <span>Slot ${slot.slotNumber}</span>
                                                                                            <c:set var="slotFound" value="true"/>
                                                                                        </c:if>
                                                                                    </c:forEach>
                                                                                    <c:forEach var="temp" items="${sessionScope.tempSlotsByDate[day]}">
                                                                                        <c:if test="${temp.slotNumber == i}">
                                                                                            <span class="temp-slot-item temp-slot-highlight">
                                                                                                <i class="isax isax-clock"></i> Slot ${temp.slotNumber}
                                                                                            </span>
                                                                                            <c:set var="slotFound" value="true"/>
                                                                                        </c:if>
                                                                                    </c:forEach>
                                                                                    <c:if test="${not slotFound}">
                                                                                        <span class="text-muted">Empty</span>
                                                                                        <button type="button" class="btn btn-sm btn-success add-temp-slot" 
                                                                                                data-date="${day}" data-slot="${i}">+</button>
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
                                <div class="card-footer text-end">
                                    <form action="/HAPPYorSAD/SetSlot?action=save" method="post">
                                        <input type="hidden" name="scheduleId" value="${nextScheduleId}">
                                        <button type="button" class="btn btn-gray" onclick="window.location.reload()">Cancel</button>
                                        <button type="submit" class="btn btn-primary prime-btn">Save Changes</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Hidden Forms -->
        <form id="tempSlotForm" action="/HAPPYorSAD/SetSlot?action=add" method="post" style="display:none;">
            <input type="hidden" name="scheduleId" id="scheduleIdInput" value="${nextScheduleId}">
            <input type="hidden" name="slot_date" id="slotDateInput">
            <input type="hidden" name="slotNumber" id="slotNumberInput">
        </form>
        <form id="monthForm" action="/HAPPYorSAD/SetSlot" method="get" style="display:none;">
            <input type="hidden" name="month" id="hiddenMonth">
            <input type="hidden" name="year" id="hiddenYear">
        </form>

        <script>
            document.addEventListener("DOMContentLoaded", () => {
                const scheduleId = "${nextScheduleId}";
                const addScheduleBtn = document.getElementById("addSchedule");
                const addSlotButtons = document.querySelectorAll(".add-temp-slot");

                // Handle adding slots
                addSlotButtons.forEach(button => {
                    button.addEventListener("click", async () => {
                        const date = button.dataset.date;
                        const slotNumber = button.dataset.slot;

                        if (!date || !slotNumber || !scheduleId || scheduleId === "-1") {
                            alert("Invalid slot data or no schedule selected");
                            return;
                        }

                        button.classList.add("loading");
                        try {
                            const response = await fetch("/HAPPYorSAD/SetSlot?action=add", {
                                method: "POST",
                                headers: {"Content-Type": "application/x-www-form-urlencoded"},
                                body: new URLSearchParams({scheduleId, slot_date: date, slotNumber})
                            });
                            if (response.ok) {
                                updateSlotUI(date, slotNumber, button);
                            } else {
                                alert("Failed to add slot: " + await response.text());
                            }
                        } catch (error) {
                            alert("Error adding slot: " + error.message);
                        } finally {
                            if (button)
                                button.classList.remove("loading");
                        }
                    });
                });

                function updateSlotUI(date, slotNumber, button) {
                    const slotCell = button.closest("td");
                    if (slotCell) {
                        slotCell.innerHTML = `
                            <span class="temp-slot-item temp-slot-highlight">
                                <i class="isax isax-clock"></i> Slot ${slotNumber}
                            </span>`;
                    }
                }

                // Handle adding new schedule
                if (addScheduleBtn) {
                    addScheduleBtn.addEventListener("click", (e) => {
                        e.preventDefault();
                        fetch("/HAPPYorSAD/SetSlot?action=addSchedule", {method: "POST"})
                                .then(() => location.reload());
                    });
                }
            });
        </script>

        <div class="modal fade" id="messageModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Thông báo</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <c:if test="${not empty message}">
                            <div class="alert alert-info">${message}</div>
                        </c:if>
                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger">${errorMessage}</div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                let message = "${message}";
                let errorMessage = "${errorMessage}";
                if (message || errorMessage) {
                    let modal = new bootstrap.Modal(document.getElementById("messageModal"));
                    modal.show();
                    setTimeout(function () {
                        modal.hide();
                    }, 3000);
                }
            });
        </script>
    </body>
</html>