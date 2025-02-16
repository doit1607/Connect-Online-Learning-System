<%-- 
    Document   : Set Schedule
    Created on : Feb 16, 2025, 12:46:26 AM
    Author     : Ann
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Set Schedule</title>
    </head>
    <body>
        <h2>Set Your Available Days</h2>
        <form action="SetSchedule" method="get">
            Date: <input type="date" name="scheduleDate" required><br>
            <button type="submit">Save Schedule</button>
        </form>

        <h3>Your Scheduled Days</h3>
        <ul>
            <c:forEach var="schedule" items="${schedules}">
                <li>${schedule.scheduleDate}</li>
                </c:forEach>
        </ul>

        <c:if test="${param.msg == 'success'}"><p style="color: green;">Schedule added successfully!</p></c:if>
        <c:if test="${param.msg == 'error'}"><p style="color: red;">Failed to add schedule!</p></c:if>
    </body>
</html>


