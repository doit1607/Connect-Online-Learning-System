<%-- 
    Document   : MenteeStatistic
    Created on : Jan 25, 2025, 12:02:18 AM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <table>
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Goals</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="mentee" items="${sessionScope.listAllMentee}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>${mentee.id}</td>
                        <td>${mentee.name}</td>
                        <td>${mentee.email}</td>
                        <td>${mentee.goals}</td>                        
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </form>
        <%@include file="../sourcesHome/homeFooter.jsp" %>
    </body>
</html>
