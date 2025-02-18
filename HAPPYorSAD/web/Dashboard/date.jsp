<%-- 
    Document   : date
    Created on : Feb 16, 2025, 2:49:11 PM
    Author     : Ann
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
