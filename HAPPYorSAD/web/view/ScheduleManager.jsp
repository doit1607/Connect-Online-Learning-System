<%-- 
    Document   : ScheduleManager
    Created on : Mar 11, 2025, 3:07:32 PM
    Author     : Ann
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Manager - Confirm Mentor Slots</title>

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

        <!-- Dropzone -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/dropzone/dropzone.min.css">

        <!-- Boxicons CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/boxicons/css/boxicons.min.css">

        <!-- Main CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css">

        <!-- Custom CSS -->
        <style>
            .mentor-table, .slot-table {
                width: 100%;
                margin: 20px 0;
                border-collapse: collapse;
                background-color: #fff;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            .mentor-table th, .mentor-table td, .slot-table th, .slot-table td {
                border: 1px solid #ddd;
                padding: 12px;
                text-align: center;
            }
            .mentor-table th, .slot-table th {
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
            .modal-custom {
                display: none;
                position: fixed;
                z-index: 1050;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0, 0, 0, 0.5);
            }
            .modal-content-custom {
                background-color: #fff;
                margin: 10% auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 8px;
                width: 90%;
                max-width: 800px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            }
            .modal-close {
                color: #666;
                float: right;
                font-size: 28px;
                font-weight: bold;
                cursor: pointer;
            }
            .modal-close:hover {
                color: #000;
            }
            .action-buttons {
                display: flex;
                justify-content: center;
                gap: 10px;
                margin-bottom: 15px;
            }
            @media (max-width: 768px) {
                .mentor-table, .slot-table {
                    font-size: 12px;
                }
                .mentor-table th, .mentor-table td, .slot-table th, .slot-table td {
                    padding: 8px;
                }
                .btn-custom {
                    padding: 5px 10px;
                    font-size: 12px;
                }
            }
        </style>
    </head>
    <body>
        <div class="main-wrapper">
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
                        <!-- Sidebar -->
                        <div class="col-xl-3 col-lg-4 theiaStickySidebar">
                            <div class="settings-widget account-settings">
                                <div class="settings-menu">
                                    <h3>Dashboard</h3>
                                    <ul>
                                        <li class="nav-item">
                                            <a href="/HAPPYorSAD/AcceptCV" class="nav-link"><i class="fas fa-user"></i> Manage CV</a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="CourseManager" class="nav-link"><i class="bx bxs-graduation"></i> Manage Courses</a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="ShowAllRequest" class="nav-link"><i class="bx bxs-heart"></i> Request of Mentee</a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="ConfirmSchedule" class="nav-link"><i class="bx bxs-star"></i> Request Schedule</a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="menteestatistic" class="nav-link"><i class="bx bxs-user-plus"></i> Static Mentee</a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="instructor-notifications.html" class="nav-link"><i class="bx bxs-bell"></i> Notifications</a>
                                        </li>
                                    </ul>
                                    <ul>
                                        <li class="nav-item">
                                            <a href="LoginUser?service=logout" class="nav-link"><i class="bx bxs-log-out"></i> Logout</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <!-- /Sidebar -->

                        <!-- Main Content -->
                        <div class="col-xl-9 col-lg-8">
                            <c:if test="${not empty message}">
                                <p class="text-center text-success">${message}</p>
                            </c:if>

                            <h2 class="text-center mb-4">List of Mentors</h2>
                            <table class="mentor-table">
                                <thead>
                                    <tr>
                                        <th>Mentor ID</th>
                                        <th>Mentor Name</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="mentor" items="${mentors}">
                                    <tr>
                                        <td>${mentor.mentorId}</td>
                                        <td>${mentor.name}</td>
                                        <td>
                                            <form action="ConfirmSchedule" method="post">
                                                <input type="hidden" name="mentorId" value="${mentor.mentorId}">
                                                <input type="hidden" name="action" value="viewSlots">
                                                <input type="submit" value="View Slots" class="btn-custom">
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>

                            <!-- Modal -->
                            <div id="slotModal" class="modal-custom">
                                <div class="modal-content-custom">
                                    <span class="modal-close" onclick="closeModal()">×</span>
                                    <c:if test="${not empty selectedMentorSlots}">
                                        <h2 class="text-center mb-4">Slots for Mentor: ${selectedMentorName} (ID: ${selectedMentorId})</h2>
                                        <div class="action-buttons">
                                            <!-- Accept All Slots -->
                                            <form action="ConfirmSchedule" method="post" style="display:inline;">
                                                <input type="hidden" name="mentorId" value="${selectedMentorId}">
                                                <input type="hidden" name="action" value="acceptAllSlots">
                                                <c:forEach var="slot" items="${selectedMentorSlots}">
                                                    <input type="hidden" name="slotIds" value="${slot.slot_id}">
                                                </c:forEach>
                                                <input type="submit" value="Accept" class="btn-custom btn-accept">
                                            </form>
                                            <!-- Reject All Slots -->
                                            <form action="ConfirmSchedule" method="post" style="display:inline;">
                                                <input type="hidden" name="mentorId" value="${selectedMentorId}">
                                                <input type="hidden" name="action" value="rejectAllSlots">
                                                <c:forEach var="slot" items="${selectedMentorSlots}">
                                                    <input type="hidden" name="slotIds" value="${slot.slot_id}">
                                                </c:forEach>
                                                <input type="submit" value="Reject" class="btn-custom btn-reject">
                                            </form>
                                        </div>
                                        <table class="slot-table">
                                            <thead>
                                                <tr>
                                                    <th>Slot ID</th>
                                                    <th>Date</th>
                                                    <th>Slot Number</th>
                                                    <th>Start Time</th>
                                                    <th>Status</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach var="slot" items="${selectedMentorSlots}">
                                                <tr>
                                                    <td>${slot.slot_id}</td>
                                                    <td>${slot.slot_date}</td>
                                                    <td>${slot.slot_number_id}</td>
                                                    <td>${slot.start_time}</td>
                                                    <td>${slot.status}</td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:if>
                                </div>
                            </div>
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
        <script src="/HAPPYorSAD/assets/js/ckeditor.js"></script>
        <script src="/HAPPYorSAD/assets/plugins/dropzone/dropzone.min.js"></script>
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/ResizeSensor.js"></script>
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js"></script>
        <script src="/HAPPYorSAD/assets/js/script.js"></script>

        <script>
                                        function showModal() {
                                            const modal = document.getElementById("slotModal");
                                            <c:if test="${not empty selectedMentorSlots}">
            modal.style.display = "block";
        </c:if>
                                            return true;
                                        }

                                        function closeModal() {
                                            document.getElementById("slotModal").style.display = "none";
                                        }

                                        window.onclick = function (event) {
                                            const modal = document.getElementById("slotModal");
                                            if (event.target === modal) {
                                                modal.style.display = "none";
                                            }
                                        };

                                        window.onload = function () {
        <c:if test="${not empty selectedMentorSlots}">
            document.getElementById("slotModal").style.display = "block";
        </c:if>
                                        };
    </script>
</body>
</html>