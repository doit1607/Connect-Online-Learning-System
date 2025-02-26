<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Doccure</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="/HAPPYorSAD/assets/img/favicon.png" type="image/x-icon">

        <!-- CSS Files -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/iconsax.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/feather.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/select2/css/select2.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap-datetimepicker.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/custom.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css">

        <!-- Custom Style -->

    </head>
    <body>
        <div class="main-wrapper">
            <div class="page-content">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-9 col-xl-9">
                            <div class="tab-content pt-0 timing-content">
                                <div class="tab-pane fade show active" id="general-availability">
                                    <div class="card custom-card">
                                        <div class="card-body">
                                            <div class="available-tab">
                                                <label class="form-label">Select Available days</label>
                                                <ul class="nav">
                                                    <c:forEach var="day" items="${weekDays}">
                                                        <li>
                                                            <a href="Slot?scheduleId=${scheduleId}&day=${day}" class="${selectedDay eq day ? 'active' : ''}">
                                                                ${day}
                                                            </a>
                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                            </div>
                                            <div class="tab-content pt-0">
                                                <c:forEach var="date" items="${weekDates}">
                                                    <div class="tab-pane fade show active" id="${date}">
                                                        <div class="slot-box">
                                                            <div class="slot-header"><h5>${date}</h5></div>
                                                            <div class="slot-body">
                                                                <div class="row">
                                                                    <div class="col-md-8">
                                                                        <c:choose>
                                                                            <c:when test="${not empty slotsByDay[date]}">
                                                                                <ul class="time-slots">
                                                                                    <c:forEach var="slot" items="${slotsByDay[date]}">
                                                                                        <li class="slot-item"
                                                                                            data-day="${date}"
                                                                                            data-date="${slotDate}"
                                                                                            data-slot-number="${slot.slotNumber}">

                                                                                            <i class="isax isax-clock"></i> ${slotTimeMap[slot.slotNumber]}
                                                                                        </li>
                                                                                    </c:forEach>
                                                                                </ul>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <p>No slots available.</p>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                        <c:forEach var="tempSlot" items="${sessionScope.tempSlots[date]}">
                                                                            <li class="slot-item temp-slot-item"
                                                                                data-day="${date}"
                                                                                data-slot-date="${slotDate}"
                                                                                data-slot-number="${slotNumber}"
                                                                                onclick="selectSlot(this)">
                                                                                <i class="isax isax-clock"></i> ${slotTimeMap[tempSlot.slotNumber]}
                                                                                <c:out value="slotDate=${slotDate}, slotNumber=${slotNumber}" />

                                                                            </li>
                                                                            <c:out value="slotDate=${slotDate}, slotNumber=${slotNumber}" />

                                                                        </c:forEach>


                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-btn text-end">
                                    <form action="Slot?action=confirmBook" method="post">
                                        <a href="#" class="btn btn-gray" data-bs-toggle="modal" data-bs-dismiss="modal">Cancel</a>
                                        <input type="hidden" name="scheduleId" value="${scheduleId}"> 
                                        <button type="submit" class="btn btn-primary prime-btn">Confirm</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- JS Scripts -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="/HAPPYorSAD/assets/js/bootstrap.bundle.min.js"></script>
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js"></script>
        <script src="/HAPPYorSAD/assets/plugins/select2/js/select2.min.js"></script>
        <script src="/HAPPYorSAD/assets/js/moment.min.js"></script>
        <script src="/HAPPYorSAD/assets/js/bootstrap-datetimepicker.min.js"></script>
        <script src="/HAPPYorSAD/assets/js/script.js"></script>
    </body>
</html>
