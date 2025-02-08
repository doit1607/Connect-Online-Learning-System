<%-- 
    Document   : ViewMentor_Mentee
    Created on : Feb 6, 2025, 11:00:49 AM
    Author     : Ann
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Mentor & Mentee Listing</title>
        <link rel="stylesheet" href="css/cssStatistic/MenteeStatistic.css">
        <link rel="stylesheet" href="css/cssHome/homeHeader.css">       
        <link rel="stylesheet" href="css/cssHome/homeFooter.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            /* Your existing styles */
        </style>
    </head>
    <body>
        <%@include file="../sourcesHome/homeHeader.jsp" %>
        
        <div class="container">
            <h1>Mentor & Mentee Listing</h1>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Rating</th>
                        <th>Reviews</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${sessionScope.listAllMentorSuggestion}">
                        <tr>
                            <td>${user.id}</td>
                            <td>${user.name}</td>
                            <td>${user.email}</td>
                            <td>${user.rating}</td>
                            <td>${user.reviews}</td>
                        </tr>
                    </c:forEach>
                    
                </tbody>
            </table>
        </div>

        <%@include file="../sourcesHome/homeFooter.jsp" %>
    </body>
</html>
