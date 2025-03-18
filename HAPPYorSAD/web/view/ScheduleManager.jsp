<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manager - Confirm Mentor Schedules</title>

    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon" href="/HAPPYorSAD/assets/img/favicon.svg">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap.min.css">

    <!-- Fontawesome CSS -->
    <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/fontawesome.min.css">
    <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/all.min.css">

    <!-- Feather CSS -->
    <link rel="stylesheet" href="/HAPPYorSAD/assets/css/feather.css">

    <!-- Select2 CSS -->
    <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/select2/css/select2.min.css">

    <!-- Main CSS -->
    <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css">

    <!-- Custom CSS -->
    <style>
        .filter-section {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .slot-table {
            width: 100%;
            margin: 20px 0;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .slot-table th, .slot-table td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }
        .slot-table th {
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
            .slot-table {
                font-size: 12px;
            }
            .slot-table th, .slot-table td {
                padding: 8px;
            }
            .btn-custom {
                padding: 5px 10px;
                font-size: 12px;
            }
            .filter-section {
                padding: 15px;
            }
        }
    </style>
</head>

<body>
    <%@include file="../sourcesHome/headerManager.jsp" %>  
    <div class="main-wrapper">
        <!-- Breadcrumb -->
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
        <!-- /Breadcrumb -->

        <!-- Page Content -->
        <div class="page-content">
            <div class="container-custom">
                <div class="row">
                    <!-- Sidebar -->
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
                                            <i class="bx bxs-graduation"></i>Manage Courses
                                        </a>
                                    </li>
                                    <li class="nav-item active">
                                        <a href="ConfirmSchedule" class="nav-link">
                                            <i class="bx bxs-graduation"></i>Manage Schedule
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="ShowAllRequest" class="nav-link">
                                            <i class="bx bxs-heart"></i>Manage Request Mentee
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="menteestatistic" class="nav-link">
                                            <i class="bx bxs-user-plus"></i>Manage Static Mentee
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
                    <!-- /Sidebar -->

                    <!-- Main Content -->
                    <div class="col-xl-9 col-lg-9">
                        <c:if test="${not empty message}">
                            <p class="message text-success">${message}</p>
                        </c:if>

                        <!-- Filter Section -->
                        <div class="filter-section">
                            <form action="ConfirmSchedule" method="get">
                                <div class="row">
                                    <div class="col-md-3">
                                        <label for="mentorSearch">Mentor Name/ID</label>
                                        <input type="text" name="mentorSearch" id="mentorSearch" value="${param.mentorSearch}" placeholder="Enter mentor name or ID">
                                    </div>
                                    <div class="col-md-2">
                                        <label for="month">Month</label>
                                        <select name="month" id="month">
                                            <option value="">All</option>
                                            <c:forEach var="i" begin="1" end="12">
                                                <option value="${i}" ${param.month == i ? 'selected' : ''}>${i}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <label for="status">Status</label>
                                        <select name="status" id="status">
                                            <option value="">All</option>
                                            <option value="Pending" ${param.status == 'Pending' ? 'selected' : ''}>Pending</option>
                                            <option value="Accepted" ${param.status == 'Accepted' ? 'selected' : ''}>Accepted</option>
                                            <option value="Rejected" ${param.status == 'Rejected' ? 'selected' : ''}>Rejected</option>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        <label for="requestTime">Request Date</label>
                                        <input type="date" name="requestTime" id="requestTime" value="${param.requestTime}">
                                    </div>
                                    <div class="col-md-2 d-flex align-items-end">
                                        <input type="submit" value="Search" class="btn-custom btn-accept w-100">
                                    </div>
                                </div>
                            </form>
                        </div>

                        <!-- Slots Display -->
                        <c:if test="${not empty filteredSlots}">
                            <h3 class="text-center mb-4">Schedule Slots</h3>
                            <div class="action-buttons">
                                <form action="ConfirmSchedule" method="post" style="display:inline;">
                                    <input type="hidden" name="action" value="acceptAllSlots">
                                    <c:forEach var="slot" items="${filteredSlots}">
                                        <input type="hidden" name="slotIds" value="${slot.slot_id}">
                                        <input type="hidden" name="mentorId" value="${slot.mentorId}">
                                    </c:forEach>
                                    <input type="submit" value="Accept All" class="btn-custom btn-accept">
                                </form>
                                <form action="ConfirmSchedule" method="post" style="display:inline;">
                                    <input type="hidden" name="action" value="rejectAllSlots">
                                    <c:forEach var="slot" items="${filteredSlots}">
                                        <input type="hidden" name="slotIds" value="${slot.slot_id}">
                                        <input type="hidden" name="mentorId" value="${slot.mentorId}">
                                    </c:forEach>
                                    <input type="submit" value="Reject All" class="btn-custom btn-reject">
                                </form>
                            </div>
                            <table class="slot-table">
                                <thead>
                                    <tr>
                                        <th>Slot ID</th>
                                        <th>Mentor Name</th>
                                        <th>Date</th>
                                        <th>Slot Number</th>
                                        <th>Start Time</th>
                                        <th>Request Time</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="slot" items="${filteredSlots}">
                                        <tr>
                                            <td>${slot.slot_id}</td>
                                            <td>${slot.mentorName}</td> <!-- Gi? ??nh có tr??ng mentorName t? backend -->
                                            <td>${slot.slot_date}</td>
                                            <td>${slot.slot_number_id}</td>
                                            <td>${slot.start_time}</td>
                                            <td>${slot.request_time}</td>
                                            <td>${slot.status}</td>
                                            <td>
                                                <c:if test="${slot.status == 'Pending'}">
                                                    <form action="ConfirmSchedule" method="post" style="display:inline;">
                                                        <input type="hidden" name="mentorId" value="${slot.mentorId}">
                                                        <input type="hidden" name="slotId" value="${slot.slot_id}">
                                                        <input type="hidden" name="action" value="acceptSlot">
                                                        <input type="submit" value="Accept" class="btn-custom btn-accept">
                                                    </form>
                                                    <form action="ConfirmSchedule" method="post" style="display:inline;">
                                                        <input type="hidden" name="mentorId" value="${slot.mentorId}">
                                                        <input type="hidden" name="slotId" value="${slot.slot_id}">
                                                        <input type="hidden" name="action" value="rejectSlot">
                                                        <input type="submit" value="Reject" class="btn-custom btn-reject">
                                                    </form>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                        <c:if test="${empty filteredSlots && not empty param.mentorSearch}">
                            <p class="message text-danger">No slots found matching your criteria.</p>
                        </c:if>
                    </div>
                    <!-- /Main Content -->
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript -->
    <script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js"></script>
    <script src="/HAPPYorSAD/assets/js/bootstrap.bundle.min.js"></script>
    <script src="/HAPPYorSAD/assets/plugins/select2/js/select2.min.js"></script>
    <script src="/HAPPYorSAD/assets/js/script.js"></script>
</body>
</html>