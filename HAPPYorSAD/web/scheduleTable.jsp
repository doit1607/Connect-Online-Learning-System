<%-- 
    Document   : scheduleTable
    Created on : Mar 7, 2025, 2:30:42 PM
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
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <table class="table">
            <thead>
                <tr>
                    <th>Slot ID</th>
                    <th>Date</th>
                    <th>Time</th>
                    <!-- Add more columns based on your Slot entity -->
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${slots}" var="slot">
                    <tr>
                        <td>${slot.id}</td>
                        <td>${slot.date}</td>
                        <td>${slot.time}</td>
                        <!-- Adjust these fields based on your Slot entity -->
                    </tr>
                </c:forEach>
                <c:if test="${empty slots}">
                    <tr>
                        <td colspan="3">No slots available for this request.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </body>
</html>
