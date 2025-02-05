<%-- 
    Document   : DashboardMentor
    Created on : Feb 5, 2025, 8:00:37 AM
    Author     : Ann
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../css/cssDashboard/DashboardMentor.css">
        <link rel="stylesheet" href="../css/cssHome/homeHeader.css">
        <link rel="stylesheet" href="../css/cssHome/homeFooter.css">
        <title>JSP Page</title>
        <style>
            
        </style>
    </head>
    <body>
        <%@include file="../sourcesHome/homeHeader.jsp" %>
        <div class="all-container">
           <%@include file="../sourcesDashboard/LeftMenuMentor.jsp" %>
           <%@include file="../sourcesDashboard/RightContentMentor.jsp" %>
        </div>
        <%@include file="../sourcesHome/homeFooter.jsp" %>
    </body>
</html>
