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
        <link rel="stylesheet" href="css/cssHome/homeDetail.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                padding: 20px;
            }

            .mentor-list {
                display: flex;
                flex-direction: column;
                gap: 20px;
            }

            .mentor-card {
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                padding: 20px;
                padding-left: 20px;
                display: flex;
                width: 100%;
                box-sizing: border-box;
                max-width: 1200px;
            }

            .mentor-card-image {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                overflow: hidden;
                margin-right: 30px;
                flex-shrink: 0;
            }

            .mentor-card-image img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .mentor-card-info {
                flex: 1;
                display: flex;
                flex-direction: row;
                align-items: center;
                justify-content: space-between;
            }

            .mentor-name-area {
                flex: 2;
                margin-right: 20px;
            }

            .mentor-name {
                font-size: 1.4em;
                font-weight: bold;
                margin-bottom: 5px;
            }

            .account-name {
                color: #777;
                font-size: 1em;
                margin-bottom: 10px;
            }

            .mentor-details {
                flex: 3;
                display: flex;
                justify-content: flex-start;
                align-items: center;
                margin-right: 20px;
            }

            .mentor-stats {
                display: flex;
                align-items: center;
                color: #555;
                font-size: 1em;
                margin-right: 30px;
            }

            .mentor-stats > span {
                margin-right: 15px;
            }

            .rating {
                display: flex;
                align-items: center;
            }

            .star {
                color: gold;
                margin-right: 2px;
            }

            .skill-tags {
                flex: 4;
                display: flex;
                flex-wrap: wrap;
                gap: 5px;
                margin-bottom: 0;
                justify-content: flex-start;
            }

            .skill-tag {
                background-color: #e0e0e0;
                color: #333;
                padding: 7px 12px;
                border-radius: 20px;
                font-size: 0.9em;
                margin-right: 5px;
            }

            .price-per-slot {
                font-weight: bold;
                color: #FF69B4;
                font-size: 1.1em;
                margin-right: 30px;
                position: relative;
                top: -35px;
                margin-left: auto;
            }

            .original-price {
                color: #999;
                font-size: 0.85em;
                text-decoration: line-through;
                position: absolute;
                top: 100%;
                left: 0;
                margin-top: 3px;
            }


            .invite-button {
                background-color: #ff9900;
                color: white;
                border: none;
                padding: 12px 20px;
                border-radius: 8px;
                cursor: pointer;
                font-weight: bold;
                font-size: 1em;
                align-self: end;
            }
            .invite-button:hover {
                background-color: #e68a00;
            }
        </style>
    </head>
    <body>
        <%@include file="../sourcesHome/homeHeader.jsp" %>


        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
        <div class="mentor-list">
            <c:forEach var="mentor" items="${listAllMentorSuggestion}"> 
                <div class="mentor-card">
                    <div class="mentor-card-image">
                        <img src="<c:out value='${mentor.image}'/>" alt="<c:out value='${mentor.name}'/>"> 
                    </div>
                    <div class="mentor-card-info">
                        <div>
                            <h2 class="mentor-name"><c:out value="${mentor.name}"/></h2> 
                            <p class="account-name">@<c:out value="${mentor.username}"/></p> 
                        </div>
                        <div class="mentor-details">

                            <div class="mentor-stats">
                                <span><i class="fas fa-users"></i> 50 Requests</span>
                                <span class="rating">

                                    <c:set var="ratingValue" value="${mentor.rating}"/>
                                    <c:set var="numReviews" value="15"/> 
                                    <c:set var="fullStars" value="${ratingValue}"/>
                                    <c:set var="decimalPart" value="${ratingValue - fullStars}"/>
                                    <c:forEach begin="1" end="${fullStars}" varStatus="loop">
                                        <i class="fas fa-star star"></i>
                                    </c:forEach>
                                    <c:if test="${decimalPart >= 0.5}">
                                        <i class="fas fa-star-half-alt star"></i>
                                    </c:if>
                                    <c:forEach begin="${fullStars + (decimalPart >= 0.5 ? 1 : 0) + 1}" end="5">
                                        <i class="far fa-star star"></i>
                                    </c:forEach>
                                    <c:out value="${ratingValue}"/> (<c:out value="${numReviews}"/>)
                                </span>
                            </div>
                        </div>
                        <div class="skill-tags">
                            <c:forEach var="skill" items="${listAllMentorSuggestion}">
                                <span class="skill-tag"><c:out value="${skill.expertise}"/></span> 
                            </c:forEach>
                        </div>
                        <p class="price-per-slot">
                            $<c:out value="${mentor.pricePerSlot}"/>/slot
                            <span class="original-price">$99.00</span> 
                        </p>
                        <button class="invite-button">Invinte</button>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty mentorList}"> 
                <p>END.</p>
            </c:if>
        </div>

        <%@include file="../sourcesHome/homeFooter.jsp" %>
    </body>
</html>
