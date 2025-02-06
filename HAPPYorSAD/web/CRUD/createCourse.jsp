<%-- 
    Document   : createCourse
    Created on : Jan 24, 2025, 5:08:45 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/cssCRUD/createCourse.css">
        <link rel="stylesheet" href="css/cssHome/homeHeader.css">       
        <link rel="stylesheet" href="css/cssHome/homeFooter.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

        <title>Create Course</title>
    </head>
    <body>
        <%@include file="../sourcesHome/homeHeader.jsp" %>
        <table>
            <caption>Create Course</caption>
            <% String message = (String) request.getAttribute("message");
                if (message != null) { %>
            <p style="color: green;"><%= message %></p>
            <% } %>
            <form action="createcourse" method="post">
                <tr>
                    <td><label for="title">Course Name:</label></td>
                    <td><input type="text" name="title" id="title" required></td>
                </tr>
                <tr>
                    <td><label for="description">Description:</label></td>
                    <td><input type="text" name="description" id="description"></td>
                </tr>
                <input type="hidden" name="status" value="active">
                <tr>
                    <td><input type="submit" value="createcourse" name="submit"></td>
                    <td><input type="reset" value="Clear"></td>
                </tr>               
        </table>
        <%@include file="../sourcesHome/homeFooter.jsp" %>
    </form>

</body>
</html>
