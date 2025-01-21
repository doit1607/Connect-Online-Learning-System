<%-- 
    Document   : HomePage
    Created on : Jan 19, 2025, 4:50:17 PM
    Author     : Ann
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../css/cssHome/homeHeader.css">
        <link rel="stylesheet" href="../css/cssHome/homeFooter.css">
         <link rel="stylesheet" href="../css/cssHome/homeDetail.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">u

        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="../sourcesHome/homeHeader.jsp" %>
        <div class="all-container">
            <%@include file="../sourcesHome/homeDetail.jsp" %>
        </div>
        <%@include file="../sourcesHome/homeFooter.jsp" %>
    </body>
</html>
