<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="itemsPerPage" value="5" /> <%-- Number of items per page --%>
<c:set var="currentPage" value="${param.page != null ? param.page : 1}" />
<c:set var="totalItems" value="${mentorsWithPendingSchedules != null ? mentorsWithPendingSchedules.size() : (monthsWithPendingSchedules != null ? monthsWithPendingSchedules.size() : (monthsWithAcceptedSchedules != null ? monthsWithAcceptedSchedules.size() : 0))}" />
<c:set var="totalPages" value="${totalItems > 0 ? ((totalItems + itemsPerPage - 1) / itemsPerPage) : 1}" />
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Manager - Confirm Mentor Schedules</title>
        <link rel="shortcut icon" type="image/x-icon" href="/HAPPYorSAD/assets/img/favicon.svg">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/feather.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/select2/css/select2.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css">
        <style>
            .filter-section {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 8px;
                margin-bottom: 20px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            .schedule-table {
                width: 100%;
                margin: 20px 0;
                border-collapse: collapse;
                background-color: #fff;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            .schedule-table th, .schedule-table td {
                border: 1px solid #ddd;
                padding: 12px;
                text-align: center;
            }
            .schedule-table th {
                background-color: #f8f9fa;
                font-weight: 600;
                color: #333;
            }
            .btn-custom {
                padding: 6px 12px;
                margin: 2px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 13px;
                transition: background-color 0.3s ease;
            }
            .btn-accept {
                background-color: #4CAF50;
                color: white;
            }
            .btn-accept:hover {
                background-color: #45a049;
            }
            .btn-reject {
                background-color: #f44336;
                color: white;
            }
            .btn-reject:hover {
                background-color: #da190b;
            }
            .filter-section select, .filter-section input {
                width: 100%;
                padding: 8px;
                margin-top: 5px;
                border-radius: 4px;
                border: 1px solid #ddd;
            }
            .action-buttons {
                display: flex;
                justify-content: center;
                gap: 10px;
                margin: 15px 0;
            }
            .container-custom {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }
            .message {
                text-align: center;
                margin: 10px 0;
                font-size: 16px;
            }
            @media (max-width: 768px) {
                .schedule-table {
                    font-size: 12px;
                }
                .schedule-table th, .schedule-table td {
                    padding: 8px;
                }
                .btn-custom {
                    padding: 5px 10px;
                    font-size: 12px;
                }
            }
            .pagination {
                display: flex;
                justify-content: center;
                margin: 20px 0;
                gap: 5px;
            }
            .pagination a {
                padding: 8px 12px;
                text-decoration: none;
                color: #333;
                border: 1px solid #ddd;
                border-radius: 4px;
                transition: all 0.3s ease;
            }
            .pagination a:hover {
                background-color: #f0f0f0;
            }
            .pagination a.active {
                background-color: #4CAF50;
                color: white;
                border-color: #4CAF50;
            }
            .pagination a.disabled {
                color: #999;
                pointer-events: none;
            }
        </style>
    </head>

    <body>
        <%@include file="../sourcesHome/headerManager.jsp" %>
        <div class="main-wrapper">
            <div class="breadcrumb-bar breadcrumb-bar-info">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 col-12">
                            <div class="breadcrumb-list">
                                <h2 class="breadcrumb-title">Manager - Schedule Confirmation</h2>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="page-content">
                <div class="container-custom">
                    <div class="row">
                        <div class="col-xl-3 col-lg-3 theiaStickySidebar">
                            <div class="settings-widget account-settings">
                                <div class="settings-menu">
                                    <h3>Dashboard</h3>
                                    <ul>
                                        <li class="nav-item"><a href="/../HAPPYorSAD/AcceptCV"><i class="fas fa-user"></i>Manage CV</a></li>
                                        <li class="nav-item"><a href="CourseManager"><i class="bx bxs-graduation"></i>Manage Courses</a></li>
                                        <li class="nav-item active"><a href="ConfirmSchedule"><i class="bx bxs-graduation"></i>Manage Schedule</a></li>
                                        <li class="nav-item"><a href="ShowAllRequest"><i class="bx bxs-heart"></i>Manage Request Mentee</a></li>
                                        <li class="nav-item"><a href="menteestatistic"><i class="bx bxs-user-plus"></i>Manage Static Mentee</a></li>
                                    </ul>
                                    <ul><li class="nav-item"><a href="LoginUser?service=logout"><i class="bx bxs-log-out"></i>Logout</a></li></ul>
                                </div>
                            </div>
                        </div>

                        <div class="col-xl-9 col-lg-9">
                            <!-- Thông báo nh?c nh? v? slot pending -->
                            <c:if test="${not empty mentorsWithPendingSchedules and empty param.mentorSearch}">
                                <div class="message text-info">
                                    <strong>Reminder:</strong> There are ${mentorsWithPendingSchedules.size()} mentors with pending schedules.
                                </div>
                            </c:if>

                            <!-- Filter Section -->
                            <div class="filter-section">
                                <form action="ConfirmSchedule" method="get">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <label>Mentor Name/ID</label>
                                            <input type="text" name="mentorSearch" value="${param.mentorSearch}" placeholder="Enter mentor name or ID">
                                        </div>
                                        <div class="col-md-2">
                                            <label>Month</label>
                                            <select name="month">
                                                <option value="">All</option>
                                                <c:forEach var="i" begin="1" end="12">
                                                    <option value="${i}" ${param.month == i ? 'selected' : ''}>${i}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="col-md-2">
                                            <label>Status</label>
                                            <select name="status">
                                                <option value="">All</option>
                                                <option value="nonAvailable" ${param.status == 'nonAvailable' ? 'selected' : ''}>Not confirmed yet</option>
                                                <option value="Available" ${param.status == 'Available' ? 'selected' : ''}>Confirmed</option>
                                                <option value="Rejected" ${param.status == 'Rejected' ? 'selected' : ''}>Rejected</option>
                                            </select>
                                        </div>
                                        <div class="col-md-2 d-flex align-items-end">
                                            <input type="submit" value="Search" class="btn-custom btn-accept w-100">
                                        </div>
                                    </div>
                                </form>
                            </div>

                            <!-- Danh sách mentor có l?ch trình pending -->
                            <%-- For Mentors with Pending Schedules --%>
                            <c:if test="${not empty mentorsWithPendingSchedules and empty param.mentorSearch}">
                                <h3>Mentors with Pending Schedules</h3>
                                <table class="schedule-table">
                                    <thead>
                                        <tr>
                                            <th>Mentor ID</th>
                                            <th>Mentor Name</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="mentor" items="${mentorsWithPendingSchedules}" 
                                                   begin="${(currentPage - 1) * itemsPerPage}" 
                                                   end="${currentPage * itemsPerPage - 1}">
                                            <tr>
                                                <td>${mentor.mentorId}</td>
                                                <td>${mentor.name}</td>
                                                <td><a href="ConfirmSchedule?mentorSearch=${mentor.mentorId}" class="btn-custom btn-accept">View Schedule</a></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                                <%-- Pagination Controls --%>
                                <div class="pagination">
                                    <c:if test="${currentPage > 1}">
                                        <a href="ConfirmSchedule?page=${currentPage - 1}">&laquo; Previous</a>
                                    </c:if>
                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                        <a href="ConfirmSchedule?page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
                                    </c:forEach>
                                    <c:if test="${currentPage < totalPages}">
                                        <a href="ConfirmSchedule?page=${currentPage + 1}">Next &raquo;</a>
                                    </c:if>
                                </div>
                            </c:if>

                            <%-- For Months with Pending Schedules --%>
                            <c:if test="${not empty monthsWithPendingSchedules and not empty param.mentorSearch and empty param.month and param.status != 'Available'}">
                                <h3>Months with Pending Schedules for ${selectedMentorName}</h3>
                                <table class="schedule-table">
                                    <thead>
                                        <tr>
                                            <th>Month</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="month" items="${monthsWithPendingSchedules}" 
                                                   begin="${(currentPage - 1) * itemsPerPage}" 
                                                   end="${currentPage * itemsPerPage - 1}">
                                            <tr>
                                                <td>Month ${month}</td>
                                                <td><a href="ConfirmSchedule?mentorSearch=${param.mentorSearch}&month=${month}" class="btn-custom btn-accept">View Schedule</a></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <div class="action-buttons">
                                    <a href="ConfirmSchedule?mentorSearch=${param.mentorSearch}&status=Available" class="btn-custom btn-accept">Back to List Accepted</a>
                                </div>

                                <%-- Pagination Controls --%>
                                <div class="pagination">
                                    <c:if test="${currentPage > 1}">
                                        <a href="ConfirmSchedule?mentorSearch=${param.mentorSearch}&page=${currentPage - 1}">&laquo; Previous</a>
                                    </c:if>
                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                        <a href="ConfirmSchedule?mentorSearch=${param.mentorSearch}&page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
                                    </c:forEach>
                                    <c:if test="${currentPage < totalPages}">
                                        <a href="ConfirmSchedule?mentorSearch=${param.mentorSearch}&page=${currentPage + 1}">Next &raquo;</a>
                                    </c:if>
                                </div>
                            </c:if>

                            <%-- For Months with Accepted Schedules --%>
                            <c:if test="${not empty monthsWithAcceptedSchedules and not empty param.mentorSearch and empty param.month and param.status == 'Available'}">
                                <h3>Months with Accepted Schedules for ${selectedMentorName}</h3>
                                <table class="schedule-table">
                                    <thead>
                                        <tr>
                                            <th>Month</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="month" items="${monthsWithAcceptedSchedules}" 
                                                   begin="${(currentPage - 1) * itemsPerPage}" 
                                                   end="${currentPage * itemsPerPage - 1}">
                                            <tr>
                                                <td>Month ${month}</td>
                                                <td><a href="ConfirmSchedule?mentorSearch=${param.mentorSearch}&month=${month}&status=Available" class="btn-custom btn-accept">View Schedule</a></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <div class="action-buttons">
                                    <a href="ConfirmSchedule?mentorSearch=${param.mentorSearch}&status=nonAvailable" class="btn-custom btn-accept">Back to List Pending Accept</a>
                                </div>

                                <%-- Pagination Controls --%>
                                <div class="pagination">
                                    <c:if test="${currentPage > 1}">
                                        <a href="ConfirmSchedule?mentorSearch=${param.mentorSearch}&status=Available&page=${currentPage - 1}">&laquo; Previous</a>
                                    </c:if>
                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                        <a href="ConfirmSchedule?mentorSearch=${param.mentorSearch}&status=Available&page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
                                    </c:forEach>
                                    <c:if test="${currentPage < totalPages}">
                                        <a href="ConfirmSchedule?mentorSearch=${param.mentorSearch}&status=Available&page=${currentPage + 1}">Next &raquo;</a>
                                    </c:if>
                                </div>
                            </c:if>

                            <!-- Hi?n th? l?ch trình -->
                            <c:if test="${not empty scheduleMatrix}">
                                <h3 class="text-center mb-4">Weekly Schedule for ${selectedMentorName} - Month ${param.month}</h3>
                                <c:if test="${param.status != 'Available'}">
                                    <div class="action-buttons">
                                        <form action="ConfirmSchedule" method="post" style="display:inline;">
                                            <input type="hidden" name="action" value="acceptAllSlots">
                                            <input type="hidden" name="mentorId" value="${selectedMentorId}">
                                            <c:forEach var="slot" items="${allSlots}">
                                                <input type="hidden" name="slotIds" value="${slot.slot_id}">
                                            </c:forEach>
                                            <input type="submit" value="Confirm All" class="btn-custom btn-accept">
                                        </form>
                                        <form action="ConfirmSchedule" method="post" style="display:inline;">
                                            <input type="hidden" name="action" value="rejectAllSlots">
                                            <input type="hidden" name="mentorId" value="${selectedMentorId}">
                                            <c:forEach var="slot" items="${allSlots}">
                                                <input type="hidden" name="slotIds" value="${slot.slot_id}">
                                            </c:forEach>
                                            <input type="submit" value="Reject All" class="btn-custom btn-reject">
                                        </form>
                                    </div>
                                </c:if>
                                <table class="schedule-table">
                                    <thead>
                                        <tr>
                                            <th>Slot</th>
                                            <th>Monday</th>
                                            <th>Tuesday</th>
                                            <th>Wednesday</th>
                                            <th>Thursday</th>
                                            <th>Friday</th>
                                            <th>Saturday</th>
                                            <th>Sunday</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="slotNumber" begin="1" end="5">
                                            <tr>
                                                <td>Slot ${slotNumber}</td>
                                                <c:forEach var="day" begin="0" end="6">
                                                    <td>
                                                        <c:set var="slot" value="${scheduleMatrix[slotNumber-1][day]}" />
                                                        <c:choose>
                                                            <c:when test="${not empty slot}">
                                                                <%-- ${slot.start_time} <br> --%>
                                                                <c:choose>
                                                                    <c:when test="${slot.status == 'nonAvailable'}">Not confirmed yet</c:when>
                                                                    <c:when test="${slot.status == 'Available'}">Confirmed</c:when>
                                                                    <c:otherwise>${slot.status}</c:otherwise>
                                                                </c:choose>
                                                            </c:when>
                                                            <c:otherwise>-</c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </c:forEach>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:if>
                            <c:if test="${empty scheduleMatrix and not empty param.mentorSearch and not empty param.month}">
                                <p class="message text-danger">No schedule found for this mentor in this month.</p>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js"></script>
        <script src="/HAPPYorSAD/assets/js/bootstrap.bundle.min.js"></script>
        <script src="/HAPPYorSAD/assets/plugins/select2/js/select2.min.js"></script>
        <script src="/HAPPYorSAD/assets/js/script.js"></script>
    </body>
</html>