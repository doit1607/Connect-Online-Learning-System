<%-- 
    Document   : MenteeStatistic
    Created on : Jan 25, 2025, 12:02:18 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/cssStatistic/MenteeStatistic.css">
        <link rel="stylesheet" href="css/cssHome/homeHeader.css">       
        <link rel="stylesheet" href="css/cssHome/homeFooter.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <title>Statistic of all Mentee</title>
    </head>
    <body>
        <%@include file="../sourcesHome/homeHeader.jsp" %>
        <h1>Statistic of all Mentee</h1>
        <form action="menteestatistic" method="get">
            <table border = 1>
                <tr>
                    <th>Name</th>
                    <th>Account Name</th>
                    <th>Number of Mentees</th>
                    <th>Total Hours</th>
                    <th>Total Skills</th>
                </tr>
                <c:forEach var="mentee" items="${listMentee}">
                    <tr>
                        <td>${mentee.name}</td>
                        <td>${mentee.account_name}</td>
                        <td>${mentee.numberOfMentee}</td>
                        <td>${mentee.totalHours}</td>
                        <td>${mentee.totalCourses}</td>
                    </tr>
                </c:forEach>
            </table>
        </form>
        <%@include file="../sourcesHome/homeFooter.jsp" %>
    </body>
</html>
