<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
                width: 100%;
                min-width: 120px;
                text-align: center;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .slot-header {
                font-size: 16px;
                font-weight: bold;
                padding: 10px;
                background: #f8f9fa;
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
                        <!-- Sidebar -->
                        <div class="col-xl-3 col-lg-3 theiaStickySidebar">
                            <div class="settings-widget account-settings">
                                <div class="settings-menu">
                                    <h3>Dashboard</h3>
                                    <ul>
                                        <li class="nav-item"><a href="/HAPPYorSAD/ProfileServlet" class="nav-link"><i class="bx bxs-tachometer"></i>My Profile</a></li>
                                        <li class="nav-item"><a href="instructor-enrolled-course.html" class="nav-link"><i class="bx bxs-graduation"></i>Enrolled Courses</a></li>
                                        <li class="nav-item active"><a href="/HAPPYorSAD/Slot" class="nav-link"><i class="bx bxs-graduation"></i>Available Timings</a></li>
                                        <li class="nav-item"><a href="instructor-reviews.html" class="nav-link"><i class="bx bxs-star"></i>Reviews</a></li>
                                    </ul>
                                    <h3>Instructor</h3>
                                    <ul>
                                        <li class="nav-item"><a href="instructor-course.html" class="nav-link"><i class="bx bxs-rocket"></i>My Courses</a></li>
                                        <li class="nav-item"><a href="instructor-course.html" class="nav-link"><i class="bx bxs-rocket"></i>My Curriculum Vitae</a></li>
                                        <li class="nav-item"><a href="viewRequest" class="nav-link"><i class="bx bxs-graduation"></i>Inviting Request</a></li>
                                    </ul>
                                    <h3>Account Settings</h3>
                                    <ul>
                                        <li class="nav-item"><a href="updatementorprofile?username=${sessionScope.usernameUser}" class="nav-link"><i class="bx bxs-cog"></i>Settings</a></li>
                                        <li class="nav-item"><a href="LoginUser?service=logout" class="nav-link"><i class="bx bxs-log-out"></i>Logout</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <!-- Modal -->
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

                                    // Tự động ẩn sau 3 giây
                                    setTimeout(function () {
                                        modal.hide();
                                    }, 3000);
                                }
                            });
                        </script>


                        <!-- Main Content -->
                        <div class="col-lg-9 col-xl-9">
                            <div class="dashboard-header"><h3>Available Timings</h3></div>
                            <div class="appointment-tabs">
                                <ul class="nav available-nav">
                                    <li class="nav-item"><a class="nav-link active" href="#" data-bs-toggle="tab" data-bs-target="#general-availability">General Availability</a></li>
                                    <li class="nav-item"><a class="nav-link" href="#" data-bs-toggle="tab" data-bs-target="#your-schedule">Your Schedule</a></li>
                                </ul>
                            </div>

                            <div class="tab-content pt-0 timing-content">
                                <div class="tab-pane fade show active" id="general-availability">
                                    <div class="card custom-card">
                                        <div class="card-body">
                                            <div class="card-header"><h3>Select Available Slots</h3></div>
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
                                                            <c:forEach var="i" begin="1" end="12">
                                                                <li><a class="dropdown-item month-item" href="#" data-month="${i} ${selectedYear}">${i} ${selectedYear}</a></li>
                                                                </c:forEach>
                                                        </ul>
                                                    </div>
                                                    <!-- Tách nút Add Schedule ra ngoài -->
                                                    <a href="#" class="text-primary ms-3" id="addSchedule">+ Add Schedule</a>
                                                </div>
                                            </div>

                                            <div class="row slot-row">
                                                <c:choose>
                                                    <c:when test="${empty weekDates}">
                                                        <div class="col-12"><p class="text-warning">No week dates available. Please select a schedule.</p></div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:forEach var="day" items="${weekDates}" varStatus="status">
                                                            <div class="col-md slot-column">
                                                                <div class="slot-box">
                                                                    <div class="slot-header">
                                                                        <h5>${weekDays[status.index]} </h5>
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
                                                                    <div class="slot-footer">
                                                                        <form action="/HAPPYorSAD/Slot?action=delete" method="post" 
                                                                              onsubmit="return confirm('Are you sure you want to delete all slots?');">
                                                                            <input type="hidden" name="formattedDay" value="${day}">
                                                                            <input type="hidden" name="scheduleId" value="${scheduleId}">
                                                                            <button type="submit" class="btn btn-link text-danger">Delete All</button>
                                                                        </form>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:forEach>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <div class="card-footer text-end">
                                            <form action="/HAPPYorSAD/Slot?action=save" method="post">
                                                <input type="hidden" name="scheduleId" value="${scheduleId}">
                                                <button type="button" class="btn btn-gray" onclick="window.location.reload()">Cancel</button>
                                                <button type="submit" class="btn btn-primary prime-btn">Save Changes</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="your-schedule">
                                    <div class="card custom-card">
                                        <div class="card-body">
                                            <h3>Your Schedule</h3>
                                            <p>Content for Your Schedule tab goes here.</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Hidden Forms -->
                    <form id="tempSlotForm" action="/HAPPYorSAD/Slot?action=add" method="post" style="display:none;">
                        <input type="hidden" name="scheduleId" id="scheduleIdInput" value="${scheduleId}">
                        <input type="hidden" name="slot_date" id="slotDateInput">
                        <input type="hidden" name="slotNumber" id="slotNumberInput">
                    </form>
                    <form id="monthForm" action="/HAPPYorSAD/Slot" method="get" style="display:none;">
                        <input type="hidden" name="month" id="hiddenMonth">
                        <input type="hidden" name="year" id="hiddenYear">
                    </form>
                    <form id="selectScheduleForm" action="/HAPPYorSAD/Slot" method="post" style="display:none;">
                        <input type="hidden" name="action" value="selectSchedule">
                        <input type="hidden" name="scheduleId" id="selectedScheduleId">
                    </form>

                    <!-- Scripts -->
                    <script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js"></script>
                    <script src="/HAPPYorSAD/assets/js/bootstrap.bundle.min.js"></script>
                    <script>
                                                    document.addEventListener("DOMContentLoaded", () => {
                                                        let scheduleId = "${scheduleId}";
                                                        const addScheduleBtn = document.getElementById("addSchedule");
                                                        const monthItems = document.querySelectorAll(".month-item");
                                                        const addSlotButtons = document.querySelectorAll(".add-temp-slot");
                                                        const scheduleItems = document.querySelectorAll(".schedule-item");

                                                        addScheduleBtn.addEventListener("click", (e) => {
                                                            e.preventDefault();
                                                            if (!scheduleId || scheduleId === "-1") {
                                                                alert("Please select a valid schedule first.");
                                                                return;
                                                            }
                                                            const form = document.createElement("form");
                                                            form.method = "POST";
                                                            form.action = "/HAPPYorSAD/Slot";
                                                            form.innerHTML = `
                                    <input type="hidden" name="action" value="addSchedule">
                                    <input type="hidden" name="scheduleId" value="${scheduleId}">
                                    <input type="hidden" name="month" value="${"${selectedMonth}"}">
                                    <input type="hidden" name="year" value="${"${selectedYear}"}">
                                `;
                                                            document.body.appendChild(form);
                                                            form.submit();
                                                        });

                                                        scheduleItems.forEach(item => {
                                                            item.addEventListener("click", () => {
                                                                const newScheduleId = item.dataset.scheduleId;
                                                                scheduleId = newScheduleId;
                                                                document.getElementById("scheduleIdInput").value = scheduleId;
                                                                document.getElementById("selectedScheduleId").value = newScheduleId;
                                                                scheduleItems.forEach(i => i.classList.remove("text-primary"));
                                                                item.classList.add("text-primary");
                                                                document.getElementById("selectScheduleForm").submit();
                                                            });
                                                        });

                                                        addSlotButtons.forEach(button => {
                                                            button.addEventListener("click", async () => {
                                                                const date = button.dataset.date;
                                                                const slotNumber = parseInt(button.dataset.slot);
                                                                if (!date || !slotNumber || !scheduleId || scheduleId === "-1") {
                                                                    alert("Invalid slot data or no schedule selected");
                                                                    return;
                                                                }
                                                                button.classList.add("loading");
                                                                try {
                                                                    const response = await fetch("/HAPPYorSAD/Slot?action=add", {
                                                                        method: "POST",
                                                                        headers: {"Content-Type": "application/x-www-form-urlencoded"},
                                                                        body: new URLSearchParams({
                                                                            scheduleId: scheduleId,
                                                                            slot_date: date,
                                                                            slotNumber: slotNumber
                                                                        })
                                                                    });
                                                                    if (response.ok) {
                                                                        updateSlotUI(date, slotNumber, button);
                                                                    } else {
                                                                        alert("Failed to add slot: " + await response.text());
                                                                    }
                                                                } catch (error) {
                                                                    alert("Error adding slot: " + error.message);
                                                                } finally {
                                                                    button.classList.remove("loading");
                                                                }
                                                            });
                                                        });

                                                        function updateSlotUI(date, slotNumber, button) {
                                                            const slotCell = button.closest("td");
                                                            slotCell.innerHTML = `<span class="temp-slot-item temp-slot-highlight"><i class="isax isax-clock"></i> Slot ${slotNumber}</span>`;
                                                        }

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

                    <script>
                        document.getElementById("addSchedule").addEventListener("click", function (event) {
                            event.preventDefault(); // Ngăn tải lại trang

                            // Lấy giá trị tháng và năm từ giao diện
                            const selectedMonth = document.getElementById("hiddenMonth").value;
                            const selectedYear = document.getElementById("hiddenYear").value;

                            fetch(`/HAPPYorSAD/Slot?action=addSchedule&month=${selectedMonth}&year=${selectedYear}`, {
                                method: "POST"
                            })
                                    .then(response => response.text())
                                    .then(data => {
                                        alert("Schedule added successfully!");
                                        location.reload(); // Tải lại trang để cập nhật lịch mới
                                    })
                                    .catch(error => console.error("Error:", error));
                        });

                    </script>
                    </body>
                    </html>