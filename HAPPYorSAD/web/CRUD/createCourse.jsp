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
        <link rel="stylesheet" href="css/cssCRUD/createCourse.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

        <title>Create Course</title>
    </head>
    <body>
        <% 
            String message = (String) request.getAttribute("message"); 
            String messageType = (String) request.getAttribute("messageType"); 
        %>

        <% if (message != null) { %>
            <div class="alert-message <%= messageType %>">
                <p><%= message %></p>
            </div>
        <% } %>

        <div class="form-container">
            <h1>Create Course</h1>
            <form>
                <label for="title">Course Name <span class="required">*</span></label>
                <input type="text" name="title" id="title" placeholder="Enter name" required>

                <label for="description">Description <span class="required">*</span></label>
                <input type="text" name="description" id="description" placeholder="Enter description" required="">

                <input type="hidden" name="status" value="active">

                <div class="button-group">
                    <button type="submit">Create Course</button>
                    <button type="reset">Clear</button>
                    <button type="button" onclick="goBack()">Back</button>
                </div>

            </form>
        </div>  

        <script>
            function goBack() {
                window.location.href = "<%= request.getContextPath() %>/CourseManager";
            }
        </script>

    </body>
</html>
