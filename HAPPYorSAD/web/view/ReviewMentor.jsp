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
        <title>Review Mentor Page</title>
    </head>
    <body>
        <div class="container">
        <h1>Rate & Comment Mentor</h1>
        
        <!-- Rating Form -->
        <form action="RateMentor" method="post">
            <input type="hidden" name="mentorId" value="${param.mentorId}">
            <input type="hidden" name="userId" value="1"> <!-- Replace with dynamic user session -->

            <div class="rating">
                <input type="radio" id="star5" name="rating" value="5"><label for="star5">&#9733;</label>
                <input type="radio" id="star4" name="rating" value="4"><label for="star4">&#9733;</label>
                <input type="radio" id="star3" name="rating" value="3"><label for="star3">&#9733;</label>
                <input type="radio" id="star2" name="rating" value="2"><label for="star2">&#9733;</label>
                <input type="radio" id="star1" name="rating" value="1"><label for="star1">&#9733;</label>
            </div>

            <label for="comment">Comment:</label>
            <textarea name="comment" required></textarea>

            <button type="submit">OK</button>
        </form>

        <!-- Display Reviews -->
        <h2>Reviews</h2>
        <c:forEach var="review" items="${reviews}">
            <div class="review-box">
                <strong>Rating: ${review.rating} Stars</strong>
                <p>${review.comment}</p>
            </div>
        </c:forEach>
    </div>
    </body>
</html>
