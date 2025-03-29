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
                padding: 10px 15px; /* Tăng padding để ô to hơn */
                font-weight: bold;
                display: inline-flex;
                align-items: center;
                font-size: 16px; /* Tăng kích thước chữ */
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
            .slot-body td {
                padding: 10px; /* Tăng padding cho ô trong bảng */
                font-size: 16px; /* Tăng kích thước chữ trong ô */
                height: 50px; /* Tăng chiều cao tối thiểu của ô */
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
                padding: 10px 15px; /* Tăng padding để ô to hơn */
                border-radius: 4px;
                color: green;
                font-size: 16px; /* Tăng kích thước chữ */
            }
            .add-temp-slot {
                margin-left: 5px;
                font-size: 14px; /* Giữ nút nhỏ gọn */
                padding: 5px 10px;
            }
            .loading {
                opacity: 0.5;
                pointer-events: none;
            }
            .week-navigation {
                display: flex;
                justify-content: space-between;
                align-items: center;
                width: 100%;
                max-width: 600px;
                margin: 0 auto;
            }
            .week-navigation span {
                font-size: 16px;
                font-weight: bold;
            }
            .week-navigation button {
                font-size: 14px;
                padding: 6px 12px;
            }
            .week-navigation button.disabled {
                opacity: 0.5;
                pointer-events: none;
            }
            #rejectedSlotsModal .modal-body {
                font-size: 16px;
            }

            #rejectedSlotsModal .modal-footer .btn {
                min-width: 100px;
            }
            .remove-temp-slot {
                margin-left: 5px;
                font-size: 14px;
                padding: 2px 8px;
                background-color: #dc3545;
                color: white;
                border: none;
                border-radius: 3px;
                cursor: pointer;
            }
            .remove-temp-slot:hover {
                background-color: #c82333;
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
                                <h2 class="breadcrumb-title">Dashboard Mentor</h2>
                                <nav aria-label="breadcrumb" class="page-breadcrumb">

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
                            <div class="card custom-card">
                                <div class="card-body">
                                    <div class="card-header"><h3>Set Your Schedule</h3></div>
                                    <div class="row align-items-center mb-3">
                                        <div class="col-12 d-flex justify-content-center">
                                            <div class="week-navigation text-center">
                                                <form id="prevForm" action="/HAPPYorSAD/SetSlot" method="post" style="display:inline;">
                                                    <input type="hidden" name="action" value="changeMonth">
                                                    <input type="hidden" name="direction" value="previous">
                                                    <input type="hidden" name="currentScheduleId" value="${nextScheduleId}">
                                                    <button type="submit" class="btn btn-primary" id="prevButton">Previous</button>
                                                </form>
                                                <span id="currentMonthYear" class="mx-3">${nextMonth} ${nextYear}</span>
                                                <form id="nextForm" action="/HAPPYorSAD/SetSlot" method="post" style="display:inline;">
                                                    <input type="hidden" name="action" value="changeMonth">
                                                    <input type="hidden" name="direction" value="next">
                                                    <input type="hidden" name="currentScheduleId" value="${nextScheduleId}">
                                                    <button type="submit" class="btn btn-primary" id="nextButton">Next</button>
                                                </form>
                                            </div>
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
                                                                                                Slot ${temp.slotNumber}
                                                                                                <button type="button" class="remove-temp-slot" 
                                                                                                        data-date="${day}" 
                                                                                                        data-slot="${i}" 
                                                                                                        data-schedule="${nextScheduleId}">-</button>
                                                                                            </span>
                                                                                            <c:set var="slotFound" value="true"/>
                                                                                        </c:if>
                                                                                    </c:forEach>
                                                                                    <c:if test="${not slotFound}">
                                                                                        <span class="text-muted">Non set</span>
                                                                                        <button type="button" class="btn btn-sm btn-success add-temp-slot" 
                                                                                                data-date="${day}" data-slot="${i}" data-schedule="${nextScheduleId}">+</button>
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
                                    <form id="saveForm" action="/HAPPYorSAD/SetSlot?action=save" method="post">
                                        <input type="hidden" name="scheduleId" value="${nextScheduleId}">
                                        <button type="button" class="btn btn-gray" onclick="window.location.reload()">Clear</button>
                                        <button type="button" class="btn btn-primary prime-btn" data-bs-toggle="modal" data-bs-target="#confirmModal">Save Changes</button>
                                    </form>
                                </div>

                                <!-- Modal -->
                                <div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="confirmModalLabel">Confirm save</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                Are you sure? Once saved it cannot be edited.
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancle</button>
                                                <button type="button" class="btn btn-primary" onclick="document.getElementById('saveForm').submit();">Confirm</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>



        <div class="modal fade" id="messageModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Notification</h5>
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

        <!-- Add this modal after the existing messageModal -->
        <div class="modal fade" id="rejectedSlotsModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Rejected Slots Detected</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p>Some of your slots for ${nextMonth} ${nextYear} have been rejected. Would you like to clear them and set new slots?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <form action="/HAPPYorSAD/SetSlot" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="resetRejectedSlots">
                            <input type="hidden" name="scheduleId" value="${nextScheduleId}">
                            <button type="submit" class="btn btn-primary">Set Slots Again</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>



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

                const message = "${message}";
                const errorMessage = "${errorMessage}";
                if (message || errorMessage) {
                    const messageModal = new bootstrap.Modal(document.getElementById("messageModal"));
                    messageModal.show();
                    setTimeout(() => messageModal.hide(), 3000);
                }

                // Show rejected slots modal if applicable
                const hasRejectedSlots = "${hasRejectedSlots}" === "true"; // Chuyển chuỗi thành boolean
                const scheduleId = "${nextScheduleId}";
                console.log("hasRejectedSlots:", hasRejectedSlots);
                console.log("scheduleId:", scheduleId);

                if (hasRejectedSlots && scheduleId !== "-1") {
                    const modalElement = document.getElementById("rejectedSlotsModal");
                    if (modalElement) {
                        console.log("Modal found, showing...");
                        const rejectedModal = new bootstrap.Modal(modalElement);
                        rejectedModal.show();
                    } else {
                        console.error("Modal element #rejectedSlotsModal not found in DOM");
                    }
                } else {
                    console.log("Conditions not met: hasRejectedSlots =", hasRejectedSlots, "scheduleId =", scheduleId);
                }

                console.log("nextWeekDates from JSP:", "${nextWeekDates}");

                const isValidSchedule = scheduleId && scheduleId !== "-1";
                if (!isValidSchedule) {
                    document.querySelectorAll(".add-temp-slot, .remove-temp-slot").forEach(button => {
                        button.disabled = true;
                        button.classList.add("disabled");
                        button.title = "No valid schedule selected";
                    });
                }
                // Function to attach event listeners to add buttons
                function attachAddSlotListeners() {
                    const addSlotButtons = document.querySelectorAll(".add-temp-slot");
                    console.log("Attaching listeners to", addSlotButtons.length, "add buttons");
                    addSlotButtons.forEach(button => {
                        button.removeEventListener("click", handleAddSlot); // Prevent duplicates
                        button.addEventListener("click", handleAddSlot);
                        console.log("Listener attached to button with date:", button.dataset.date, "slot:", button.dataset.slot);
                    });
                }

                // Function to attach event listeners to remove buttons
                function attachRemoveSlotListeners() {
                    const removeSlotButtons = document.querySelectorAll(".remove-temp-slot");
                    removeSlotButtons.forEach(button => {
                        button.removeEventListener("click", handleRemoveSlot);
                        button.addEventListener("click", handleRemoveSlot);
                    });
                }

                // Handle add slot
                async function handleAddSlot() {
                    const date = this.dataset.date;
                    const slotNumber = this.dataset.slot;
                    const scheduleId = "${nextScheduleId}";
                    console.log("Add slot - date:", date, "slotNumber:", slotNumber, "scheduleId:", scheduleId);
                    if (!date) {
                        alert("Invalid date for this slot");
                        return;
                    }
                    if (!slotNumber) {
                        alert("Invalid slot number");
                        return;
                    }
                    if (!scheduleId || scheduleId === "-1") {
                        alert("No valid schedule selected. Please select or add a schedule.");
                        return;
                    }
                    this.classList.add("loading");
                    try {
                        const response = await fetch("/HAPPYorSAD/SetSlot?action=add", {
                            method: "POST",
                            headers: {"Content-Type": "application/x-www-form-urlencoded"},
                            body: new URLSearchParams({scheduleId, slot_date: date, slotNumber})
                        });
                        if (response.ok) {
                            updateSlotUI(date, slotNumber, this);
                        } else {
                            alert("Failed to add slot: " + await response.text());
                        }
                    } catch (error) {
                        alert("Error adding slot: " + error.message);
                    } finally {
                        this.classList.remove("loading");
                    }
                }

                // Handle remove slot
                async function handleRemoveSlot() {
                    const date = this.dataset.date;
                    const slotNumber = this.dataset.slot;
                    const scheduleId = "${nextScheduleId}";
                    if (!date) {
                        alert("Invalid date for this slot");
                        return;
                    }
                    if (!slotNumber) {
                        alert("Invalid slot number");
                        return;
                    }
                    if (!scheduleId || scheduleId === "-1") {
                        alert("No valid schedule selected. Please select or add a schedule.");
                        return;
                    }
                    this.classList.add("loading");
                    try {
                        const response = await fetch("/HAPPYorSAD/SetSlot?action=deleteTemp", {
                            method: "POST",
                            headers: {"Content-Type": "application/x-www-form-urlencoded"},
                            body: new URLSearchParams({scheduleId, slot_date: date, slotNumber})
                        });
                        if (response.ok) {
                            updateRemoveSlotUI(date, slotNumber, this);
                        } else {
                            alert("Failed to remove slot: " + await response.text());
                        }
                    } catch (error) {
                        alert("Error removing slot: " + error.message);
                    } finally {
                        this.classList.remove("loading");
                    }
                }

                function updateSlotUI(date, slotNumber, button) {
                    console.log("updateSlotUI called - date:", date, "slotNumber:", slotNumber, "button:", button);
                    const slotCell = button.closest("td");
                    console.log("slotCell found:", slotCell ? "Yes" : "No", "slotCell:", slotCell);
                    if (slotCell) {
                        var htmlContent = '<span class="temp-slot-item temp-slot-highlight">';
                        htmlContent += 'Slot ' + slotNumber;
                        htmlContent += '<button type="button" class="remove-temp-slot" ';
                        htmlContent += 'data-date="' + date + '" ';
                        htmlContent += 'data-slot="' + slotNumber + '" ';
                        htmlContent += 'data-schedule="' + "${nextScheduleId}" + '">-</button>';
                        htmlContent += '</span>';

                        console.log("Setting slotCell HTML - scheduleId:", "${nextScheduleId}", "HTML:", htmlContent);
                        slotCell.innerHTML = htmlContent;
                        console.log("slotCell updated, attaching remove listeners...");
                        attachRemoveSlotListeners();
                        console.log("Remove listeners attached");
                    } else {
                        console.warn("No slotCell found for button:", button);
                    }
                }

                // Update UI after removing a slot (reverts to empty with add button)
                function updateRemoveSlotUI(date, slotNumber, button) {
                    console.log("updateRemoveSlotUI called - date:", date, "slotNumber:", slotNumber, "button:", button);
                    const slotCell = button.closest("td");
                    console.log("slotCell found:", slotCell ? "Yes" : "No", "slotCell:", slotCell);
                    if (slotCell) {
                        // Clear existing content
                        slotCell.innerHTML = "";

                        // Create span for "Empty"
                        const span = document.createElement("span");
                        span.className = "text-muted";
                        span.textContent = "Non set";

                        // Create new add button
                        const addButton = document.createElement("button");
                        addButton.type = "button";
                        addButton.className = "btn btn-sm btn-success add-temp-slot";
                        addButton.textContent = "+";
                        addButton.setAttribute("data-date", date);
                        addButton.setAttribute("data-slot", slotNumber);
                        addButton.setAttribute("data-schedule", "${nextScheduleId}");

                        // Append elements
                        slotCell.appendChild(span);
                        slotCell.appendChild(addButton);

                        console.log("New add button created - date:", date, "slot:", slotNumber, "schedule:", "${nextScheduleId}");

                        // Re-attach listeners to all add buttons, ensuring the new one is included
                        attachAddSlotListeners();
                        console.log("Add listeners re-attached");
                    } else {
                        console.warn("No slotCell found for button:", button);
                    }
                }

                // Handle "Add Schedule" button
                const addScheduleBtn = document.getElementById("addSchedule");
                if (addScheduleBtn) {
                    addScheduleBtn.addEventListener("click", (e) => {
                        e.preventDefault();
                        fetch("/HAPPYorSAD/SetSlot?action=addSchedule", {method: "POST"})
                                .then(() => location.reload());
                    });
                }

                // Disable Previous button if current month/year is displayed
                const currentMonth = <%= currentMonth %>;
                const currentYear = <%= currentYear %>;
                const displayedMonth = "${nextMonth}";
                const displayedYear = "${nextYear}";
                const monthNames = ["January", "February", "March", "April", "May", "June",
                    "July", "August", "September", "October", "November", "December"];
                const displayedMonthNum = monthNames.indexOf(displayedMonth) + 1;
                const prevButton = document.getElementById("prevButton");
                if ((displayedYear == currentYear && displayedMonthNum <= currentMonth) || (displayedYear < currentYear)) {
                    prevButton.disabled = true;
                    prevButton.classList.add("disabled");
                }

                // Initial attachment of event listeners
                if (isValidSchedule) {
                    attachAddSlotListeners();
                    attachRemoveSlotListeners();
                }
            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>