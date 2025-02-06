<%-- 
    Document   : CreateCourses
    Created on : Feb 6, 2025, 1:46:49 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <form action="createcourse" method="post">
            <%@include file="../sourcesHome/homeHeader.jsp" %>
            <table>
                <caption>Create Course</caption>
                <% String message = (String) request.getAttribute("message");
                if (message != null) { %>
                <p style="color: green;"><%= message %></p>
                <% } %>

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
                    <td><input type="submit" value="CreateCourse"></td>
                    <td><input type="reset" value="Clear"></td>
                </tr>
            </table>    
            <%@include file="../sourcesHome/homeFooter.jsp" %> 
        </form>

    </body>
</html>
