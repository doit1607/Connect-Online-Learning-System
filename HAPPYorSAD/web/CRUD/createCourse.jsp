<%-- 
    Document   : createCourse
    Created on : Jan 24, 2025, 5:08:45 PM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../css/cssCRUD/createCourse.css">
        
        <title>Create Course</title>
    </head>
    <body>
        <% String message = (String) request.getAttribute("message"); %>
        <% if (message != null) { %>
        <div class="alert-message">
            <p><%= message %></p>
        </div>
        <% } %>

        <div class="form-container">
            <h1>Create Course</h1>
            <form>
                <label for="title">Course Name:</label>
                <input type="text" name="title" id="title" required>

                <label for="description">Description:</label>
                <input type="text" name="description" id="description">

                <input type="hidden" name="status" value="active">

                <div class="button-group">
                    <button type="submit">Create Course</button>
                    <button type="reset">Clear</button>
                </div>
            </form>
        </div>  

    </body>
</html>
