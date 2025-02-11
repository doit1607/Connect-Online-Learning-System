<%-- 
    Document   : ReviewMentor
    Created on : Feb 3, 2025, 11:38:35 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/cssReview/ReviewMentor.css">
        <link rel="stylesheet" href="../css/cssReview/ReviewMentor.css">
        <link rel="stylesheet" href="css/cssHome/homeHeader.css">       
        <link rel="stylesheet" href="css/cssHome/homeFooter.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <title>Review Mentor Page</title>
    </head>
    <body>

        <div class="container">
            <%@include file="../sourcesHome/homeHeader.jsp" %>
            <h1>Rate & Comment Mentor</h1>

            <!-- Rating Form -->
            <form action="/HAPPYorSAD/reviewmentor" method="get">
                <input type="hidden" name="mentorId" value="${param.mentorId}">
                <input type="hidden" name="menteeId" value="1"> <!-- Replace with dynamic user session -->

                <div class="rating">
                    <input type="radio" id="star1" name="rating" value="1"><label for="star1">&#9733;</label>
                    <input type="radio" id="star2" name="rating" value="2"><label for="star2">&#9733;</label>
                    <input type="radio" id="star3" name="rating" value="3"><label for="star3">&#9733;</label>
                    <input type="radio" id="star4" name="rating" value="4"><label for="star4">&#9733;</label>
                    <input type="radio" id="star5" name="rating" value="5"><label for="star5">&#9733;</label>
                </div>

                <label for="comment">Comment <span class="required">*</span></label>
                <input type="text" name="comment" required>

                <input type="hidden" name="mentorId" value="${mentorId}">
                <input type="hidden" name="menteeId" value="${menteeId}">

                <button type="submit">OK</button>
            </form>

            <%@include file="../sourcesHome/homeFooter.jsp" %>
        </div>    
        <script>
            window.onload = function () {
            <% String successMessage = (String) request.getAttribute("success"); %>
            <% if (successMessage != null) { %>
                alert("<%= successMessage %>");
            <% } %>

            <% String errorMessage = (String) request.getAttribute("error"); %>
            <% if (errorMessage != null) { %>
                alert("<%= errorMessage %>");
            <% } %>
            };
        </script>
    </body>
</html>
