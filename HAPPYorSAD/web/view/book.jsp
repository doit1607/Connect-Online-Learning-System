<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Lịch Mentor</title>
        <style>
            table {
                width: 100%;
                border-collapse: collapse;
            }
            td {
                width: 14%;
                height: 50px;
                text-align: center;
                border: 1px solid #ccc;
            }
            .has-slot {
                background-color: #a0e7a0;
                font-weight: bold;
            }
            .no-slot {
                background-color: #f7f7f7;
            }
            .today {
                background-color: #4CAF50 !important;
                color: white;
                font-weight: bold;
                border: 2px solid #2E7D32;
            }
            .slot-section {
                margin-top: 20px;
            }
            .month-nav {
                display: flex;
                justify-content: space-between;
                margin: 20px 0;
            }
            .month-nav button {
                padding: 10px;
                cursor: pointer;
                background: #007bff;
                color: white;
                border: none;
                border-radius: 5px;
            }
            .month-nav button:hover {
                background: #0056b3;
            }
        </style>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            $(document).ready(function () {
                // Chuyển tháng bằng AJAX
                function changeMonth(offset) {
                    let month = ${currentMonth};
                    let year = ${currentYear};

                    month += offset;
                    if (month < 1) {
                        month = 12;
                        year--;
                    } else if (month > 12) {
                        month = 1;
                        year++;
                    }

                    $.ajax({
                        url: "Schedule",
                        type: "GET",
                        data: {month: month, year: year},
                        success: function (response) {
                            $("body").html(response); // Cập nhật nội dung trang
                        }
                    });
                }

                $(".month-nav button").on("click", function () {
                    let offset = $(this).text().includes("Tháng trước") ? -1 : 1;
                    changeMonth(offset);
                });

                // Load slot theo ngày bằng AJAX
                $(document).on("click", ".load-slots", function (e) {
                    e.preventDefault();
                    let slotDate = $(this).data("date");

                    $.ajax({
                        url: "Schedule",
                        type: "GET",
                        data: {slotDate: slotDate},
                        success: function (response) {
                            $(".slot-section").fadeOut(200, function () {
                                $(this).html($(response).find(".slot-section").html()).fadeIn(200);
                            });
                        }
                    });
                });

                // Gửi form đặt lịch bằng AJAX
                $(document).on("submit", "form[action='Schedule']", function (e) {
                    e.preventDefault();
                    let formData = $(this).serialize();

                    $.ajax({
                        url: "Schedule",
                        type: "POST",
                        data: formData,
                        success: function (response) {
                            alert("Đặt lịch thành công!");
                            $(".slot-section").fadeOut(200, function () {
                                $(this).html($(response).find(".slot-section").html()).fadeIn(200);
                            });
                        }
                    });
                });
            });
        </script>

    </head>
    <body>

        <h2>Lịch Mentor - ${monthName} ${currentYear}</h2>

        <div class="month-nav">
            <button onclick="changeMonth(-1)">⬅ Tháng trước</button>
            <button onclick="changeMonth(1)">Tháng sau ➡</button>
        </div>

        <table>
            <tr>
                <th>Sun</th><th>Mon</th><th>Tue</th><th>Wed</th><th>Thu</th><th>Fri</th><th>Sat</th>
            </tr>
            <tr>
                <c:forEach var="date" items="${dates}" varStatus="status">
                    <c:if test="${status.index % 7 == 0 && status.index != 0}">
                    </tr><tr>
                    </c:if>
                    <c:choose>
                        <c:when test="${empty date}">
                            <td class="no-slot"></td>
                        </c:when>
                        <c:otherwise>
                            <c:set var="formattedDate" value="${currentMonth}-${date}-${currentYear}" />
                            <td class="has-slot ${date == currentDay ? 'today' : ''}">
                                <a href="Schedule?slotDate=${formattedDate}&mentorId=${mentorId}&month=${currentMonth}&year=${currentYear}">
                                    ${date}
                                </a>
                            </td>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </tr>
        </table>

        <c:if test="${not empty param.slotDate}">
            <div class="slot-section">
                <h3>Slot khả dụng cho ngày ${param.slotDate}</h3>
                <form action="Schedule" method="post">
                    <input type="hidden" name="action" value="book">
                    <input type="hidden" name="slotDate" value="${param.slotDate}">
                    <c:choose>
                        <c:when test="${empty morningSlots and empty afternoonSlots and empty eveningSlots}">
                            <p>Không có Slot nào khả dụng.</p>
                        </c:when>
                        <c:otherwise>
                            <h4>🌞 Morning Slots</h4>
                            <ul>
                                <c:forEach var="slot" items="${morningSlots}">
                                    <li>
                                        <input type="checkbox" name="startTimes" value="${slot.startTime}"> ${slot.startTime}
                                    </li>
                                </c:forEach>
                            </ul>
                            <h4>🌆 Afternoon Slots</h4>
                            <ul>
                                <c:forEach var="slot" items="${afternoonSlots}">
                                    <li>
                                        <input type="checkbox" name="startTimes" value="${slot.startTime}"> ${slot.startTime}
                                    </li>
                                </c:forEach>
                            </ul>
                            <h4>🌙 Evening Slots</h4>
                            <ul>
                                <c:forEach var="slot" items="${eveningSlots}">
                                    <li>
                                        <input type="checkbox" name="startTimes" value="${slot.startTime}"> ${slot.startTime}
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:otherwise>
                    </c:choose>
                    <button type="submit">Đặt lịch</button>
                </form>
            </div>
        </c:if>
    </body>
</html>
