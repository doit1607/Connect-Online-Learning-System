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
        <title>Doccure - Attendance</title>

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
            .slot-clickable {
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .slot-clickable:hover {
                background-color: #f0f0f0;
            }
            .loading {
                opacity: 0.5;
                pointer-events: none;
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
            .text-warning {
                color: #ffc107 !important;
            }
            .fw-bold {
                font-weight: bold;
            }
        </style>

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

                // Tự động hiển thị modal nếu có dữ liệu từ session
                <c:if test="${showModal}">
                    var modal = new bootstrap.Modal(document.getElementById("attendanceModal"));
                    modal.show();
                </c:if>

                // Xử lý khi modal đóng để xóa showModal khỏi session
                const attendanceModalEl = document.getElementById("attendanceModal");
                attendanceModalEl.addEventListener("hidden.bs.modal", function () {
                    // Gửi yêu cầu để xóa showModal khỏi session
                    var xhr = new XMLHttpRequest();
                    xhr.open("POST", "/HAPPYorSAD/Attendance?action=clearModal&month=${selectedMonth}&year=${selectedYear}&weekOffset=${weekOffset}", true);
                    xhr.send();
                });
            });

            // Hàm submit form để lấy thông tin mentee
            function showAttendanceModal(date, slot, month, year, weekOffset) {
                if (!date || !slot || !month || !year || !weekOffset) {
                    console.error("Missing parameters:", { date, slot, month, year, weekOffset });
                    alert("Error: Missing required parameters.");
                    return;
                }

                // Tìm form tương ứng với hàng được click
                var form = document.createElement("form");
                form.method = "POST";
                form.action = "/HAPPYorSAD/Attendance";

                // Thêm các input ẩn
                var inputs = [
                    { name: "action", value: "getMentees" },
                    { name: "date", value: date },
                    { name: "slot", value: slot },
                    { name: "month", value: month },
                    { name: "year", value: year },
                    { name: "weekOffset", value: weekOffset }
                ];

                inputs.forEach(input => {
                    var inputElement = document.createElement("input");
                    inputElement.type = "hidden";
                    inputElement.name = input.name;
                    inputElement.value = input.value;
                    form.appendChild(inputElement);
                });

                document.body.appendChild(form);
                form.submit();
            }
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
                                            <a href="/../HAPPYorSAD/ProfileServlet" class="nav-link">
                                                <i class="bx bxs-tachometer"></i>Profile
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="/../HAPPYorSAD/SetSlot" class="nav-link">
                                                <i class="bx bxs-tachometer"></i>Schedule
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
                                            <a href="/../HAPPYorSAD/ViewCV" class="nav-link">
                                                <i class="bx bxs-rocket"></i>Curriculum Vitae
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="/../HAPPYorSAD/viewRequest" class="nav-link">
                                                <i class="bx bxs-graduation"></i>Inviting Request
                                            </a>
                                        </li>
                                        <li class="nav-item active">
                                            <a href="/../HAPPYorSAD/Attendance" class="nav-link">
                                                <i class="bx bxs-graduation"></i>Attendance
                                            </a>
                                        </li>
                                    </ul>
                                    <h3>Account Settings</h3>
                                    <ul>
                                        <li class="nav-item">
                                            <a href="updatementorprofile?username=${sessionScope.usernameUser}" class="nav-link">
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
                                            <form action="/HAPPYorSAD/Attendance" method="get" style="display:inline;">
                                                <input type="hidden" name="weekOffset" value="${weekOffset - 1}">
                                                <input type="hidden" name="month" value="${selectedMonth}">
                                                <input type="hidden" name="year" value="${selectedYear}">
                                                <button type="submit" class="btn btn-primary me-2">Previous Week</button>
                                            </form>
                                            <span>Week of ${weekStartDate} - ${weekEndDate}</span>
                                            <form action="/HAPPYorSAD/Attendance" method="get" style="display:inline;">
                                                <input type="hidden" name="weekOffset" value="${weekOffset + 1}">
                                                <input type="hidden" name="month" value="${selectedMonth}">
                                                <input type="hidden" name="year" value="${selectedYear}">
                                                <button type="submit" class="btn btn-primary ms-2">Next Week</button>
                                            </form>
                                        </div>
                                    </div>

                                    <!-- Attendance Table -->
                                    <div class="row slot-row">
                                        <c:choose>
                                            <c:when test="${empty weekDates}">
                                                <div class="col-12"><p class="text-warning">No week dates available for this month.</p></div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="col-12">
                                                    <table class="table table-bordered text-center table-hover" id="attendanceTable">
                                                        <thead>
                                                            <tr>
                                                                <th class="sortable" data-sort="date">Date <i class="fas fa-sort"></i></th>
                                                                <th class="sortable" data-sort="day">Day of Week <i class="fas fa-sort"></i></th>
                                                                <th class="sortable" data-sort="slot">Slot Number <i class="fas fa-sort"></i></th>
                                                                <th>Start Time</th>
                                                                <th>End Time</th>
                                                                <th class="sortable" data-sort="status">Status <i class="fas fa-sort"></i></th>
                                                                <th>Action</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="day" items="${weekDates}" varStatus="status">
                                                                <c:forEach var="slot" items="${slotsByDay[day]}">
                                                                    <c:set var="validStatus" value="false"/>
                                                                    <c:choose>
                                                                        <c:when test="${slot.status == 'Studying' || slot.status == 'pending_present' || slot.status == 'pending_absent' || slot.status == 'present' || slot.status == 'absent' || slot.status == 'done' || slot.status == 'cancel'}">
                                                                            <c:set var="validStatus" value="true"/>
                                                                        </c:when>
                                                                    </c:choose>
                                                                    <c:if test="${validStatus}">
                                                                        <tr class="slot-clickable" onclick="showAttendanceModal('${day}', '${slot.slot_number_id}', '${selectedMonth}', '${selectedYear}', '${weekOffset}')">
                                                                            <td>${day}</td>
                                                                            <td>${weekDays[status.index]}</td>
                                                                            <td>${slot.slot_number_id}</td>
                                                                            <td>${slot.start_time}</td>
                                                                            <td>${slot.end_time}</td>
                                                                            <td>
                                                                                <c:choose>
                                                                                    <c:when test="${slot.status == 'present'}">
                                                                                        <span class="slot-present">Present</span>
                                                                                    </c:when>
                                                                                    <c:when test="${slot.status == 'absent'}">
                                                                                        <span class="slot-absent">Absent</span>
                                                                                    </c:when>
                                                                                    <c:when test="${slot.status == 'pending_present' || slot.status == 'pending_absent'}">
                                                                                        <span class="text-warning fw-bold">Pending Confirmation</span>
                                                                                    </c:when>
                                                                                    <c:when test="${slot.status == 'done'}">
                                                                                        <span class="text-info">Completed</span>
                                                                                    </c:when>
                                                                                    <c:when test="${slot.status == 'Studying'}">
                                                                                        <span class="text-info">Studying</span>
                                                                                    </c:when>
                                                                                    <c:when test="${slot.status == 'cancel'}">
                                                                                        <span class="text-danger">Canceled</span>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <form action="/HAPPYorSAD/Attendance" method="post" style="display:inline;">
                                                                                            <input type="hidden" name="action" value="getMentees">
                                                                                            <input type="hidden" name="date" value="${day}">
                                                                                            <input type="hidden" name="slot" value="${slot.slot_number_id}">
                                                                                            <input type="hidden" name="month" value="${selectedMonth}">
                                                                                            <input type="hidden" name="year" value="${selectedYear}">
                                                                                            <input type="hidden" name="weekOffset" value="${weekOffset}">
                                                                                            <button type="submit" class="slot-clickable btn btn-link p-0">Mark Attendance</button>
                                                                                        </form>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </td>
                                                                            <td>
                                                                                <c:if test="${slot.status == 'present' || slot.status == 'absent' || slot.status == 'pending_present' || slot.status == 'pending_absent'}">
                                                                                    <button onclick="showAttendanceModal('${day}', '${slot.slot_number_id}', '${selectedMonth}', '${selectedYear}', '${weekOffset}')" class="btn btn-info btn-sm">View</button>
                                                                                </c:if>
                                                                            </td>
                                                                        </tr>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Modal for Attendance -->
                    <div class="modal fade" id="attendanceModal" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-lg modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Attendance - Slot ${selectedSlot} on ${selectedDate} (${slot.start_time} - ${slot.end_time})</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <c:choose>
                                        <c:when test="${empty mentee}">
                                            <p class="text-muted">No mentee assigned to this slot.</p>
                                        </c:when>
                                        <c:otherwise>
                                            <form action="/HAPPYorSAD/Attendance" method="post" id="attendanceForm">
                                                <input type="hidden" name="action" value="saveAttendance">
                                                <input type="hidden" name="date" value="${selectedDate}">
                                                <input type="hidden" name="slot" value="${selectedSlot}">
                                                <input type="hidden" name="month" value="${selectedMonth}">
                                                <input type="hidden" name="year" value="${selectedYear}">
                                                <input type="hidden" name="weekOffset" value="${weekOffset}">
                                                <ul class="list-group">
                                                    <li class="list-group-item d-flex align-items-center">
                                                        <img src="${mentee.email}" alt="Avatar" class="rounded-circle me-3" width="200" height="200">
                                                        <div class="flex-grow-1">
                                                            <strong class="fs-3">${mentee.name}</strong><br>
                                                            <small class="text-muted">${mentee.image}</small>
                                                        </div>
                                                        <div class="d-flex align-items-center">
                                                            <c:choose>
                                                                <c:when test="${slot.status == 'pending_present' || slot.status == 'pending_absent'}">
                                                                    <span class="text-warning fw-bold">Pending Confirmation from Mentee</span>
                                                                </c:when>
                                                                <c:when test="${slot.status == 'present'}">
                                                                    <span class="slot-present">Present (Confirmed)</span>
                                                                </c:when>
                                                                <c:when test="${slot.status == 'absent'}">
                                                                    <span class="slot-absent">Absent (Confirmed)</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <div class="form-check me-3">
                                                                        <input type="radio" class="form-check-input" name="status" value="pending_present" id="presentRadio" required>
                                                                        <label class="form-check-label" for="presentRadio">Present</label>
                                                                    </div>
                                                                    <div class="form-check">
                                                                        <input type="radio" class="form-check-input" name="status" value="pending_absent" id="absentRadio" required>
                                                                        <label class="form-check-label" for="absentRadio">Absent</label>
                                                                    </div>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </li>
                                                </ul>
                                                <c:if test="${slot.status != 'present' && slot.status != 'absent'}">
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                        <c:if test="${slot.status != 'pending_present' && slot.status != 'pending_absent'}">
                                                            <button type="submit" class="btn btn-primary">Save</button>
                                                        </c:if>
                                                    </div>
                                                </c:if>
                                            </form>
                                            <c:if test="${slot.status == 'pending_present' || slot.status == 'pending_absent'}">
                                                <p class="text-muted mt-3">Waiting for mentee to confirm the attendance status.</p>
                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Rejection Notices Modal -->
                    <c:if test="${not empty rejectionNotices}">
                        <div class="modal fade" id="rejectionModal" tabindex="-1" aria-hidden="true">
                            <div class="modal-dialog modal-lg modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Rejected Attendance Notices</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <ul>
                                            <c:forEach var="notice" items="${rejectionNotices}">
                                                <li>${notice}</li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <script>
                            document.addEventListener("DOMContentLoaded", function () {
                                var rejectionModal = new bootstrap.Modal(document.getElementById("rejectionModal"));
                                rejectionModal.show();
                            });
                        </script>
                    </c:if>

                    <!-- Scripts -->
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

                            // Sorting functionality
                            $('.sortable').click(function () {
                                let table = $('#attendanceTable');
                                let rows = table.find('tbody tr').toArray();
                                let column = $(this).data('sort');

                                rows.sort(function (a, b) {
                                    let aValue = $(a).find('td').eq($(this).index()).text();
                                    let bValue = $(b).find('td').eq($(this).index()).text();
                                    return aValue.localeCompare(bValue);
                                }.bind(this));

                                $.each(rows, function (index, row) {
                                    table.children('tbody').append(row);
                                });
                            });
                        });

                        // Validation form
                        $('#attendanceForm').submit(function (e) {
                            if (!$('input[name="status"]:checked').length) {
                                e.preventDefault();
                                alert('Please select an attendance status');
                                return false;
                            }
                        });
                    </script>

                    <!-- Hidden Form for Month Selection -->
                    <form id="monthForm" action="/HAPPYorSAD/Attendance" method="get" style="display:none;">
                        <input type="hidden" name="month" id="hiddenMonth">
                        <input type="hidden" name="year" id="hiddenYear">
                        <input type="hidden" name="weekOffset" value="${weekOffset}">
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>