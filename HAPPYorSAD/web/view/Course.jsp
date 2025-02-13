<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Course - Courses</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="Course Project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/cssCourse/cssCourse.css"/>
        <link rel="stylesheet" href="css/cssHome/homeHeader.css">       
        <link rel="stylesheet" href="css/cssHome/homeFooter.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    </head>
    <body>
        <%@include file="../sourcesHome/homeHeader.jsp" %>
        <div class="container text-center mt-5">
            <h2>Courses</h2>
            <div class="row mt-4">
                <c:forEach items="${sessionScope.listAllCousre}" var="o" varStatus="status1">
                    <div class="col-md-4">
                        <div class="card course-card">
                            <div class="STT text-center"> <h6>STT: ${status1.index + 1}</h6></div>
                            <img class="card-img-top" src="${o.image}" >
                            <div class="card-body text-center">
                                        <div class="card-title">${o.title}</div>
                                        <div class="card-text">Course ID: ${o.id}</div>

                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <%@include file="../sourcesHome/homeFooter.jsp" %>


    </body>
</html>