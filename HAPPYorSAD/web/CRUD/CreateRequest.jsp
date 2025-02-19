<%-- 
    Document   : CreateRequest
    Created on : 16 Feb 2025, 8:51:27 pm
    Author     : Acer
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Request</title>
        <link rel="shortcut icon" type="image/x-icon" href="/HAPPYorSAD/assets/img/favicon.svg">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/owl.carousel.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/owl.theme.default.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/slick/slick.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/slick/slick-theme.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/select2/css/select2.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/aos/aos.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css">
    </head>
    <body>
        <%@include file="../sourcesHome/homeHeader.jsp" %>
        <div class="main-wrapper">
            <div class="all-container">
                <div class="modal-dialog modal-dialog-centered modal-lg">
                    <div class="modal-content">

                        <div class="content">

                            <div class="page-title">
                                <h4>Add New Request</h4>
                            </div>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                <i class="feather-x"></i>
                            </button>
                        </div>
                        <div class="modal-body custom-modal-body">
                            <form action="CreateRequest" method="POST">
                                <input type="hidden" name="mentee_id" value="${sessionScope.menteeId}">
                                <div class="tickets-add-list">
                                    <div class="settings-inner-blk add-course-info p-0">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="input-block">
                                                    <label class="form-label">Title</label>
                                                    <input type="text" name="title" class="form-control" required>
                                                </div>
                                            </div>                                                                                                     
                                            <div class="col-md-12">
                                                <div class="input-block">
                                                    <label class="form-label">Deadline Date:</label>
                                                    <input type="date" name="deadline_date" class="form-control" required>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="input-block ">
                                                    <label class="form-label">Deadline Hour:</label>
                                                    <input type="time" name="deadline_hour" class="form-control" required>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="input-block ">
                                                    <label class="form-label">Content:</label>
                                                    <textarea name="content" required></textarea>
                                                </div>
                                            </div>                                              
                                            <label class="form-label">Select Courses:</label>
                                            <c:forEach items="${sessionScope.listAllCourse}" var="o">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" name="courseIds" value="${o.id}" id="course_${o.id}">
                                                    <label class="form-check-label" for="course_${o.id}">
                                                        ${o.title}
                                                    </label>
                                                </div>
                                            </c:forEach>
                                        </div>	
                                    </div>
                                </div>									
                                <div class="modal-footer-btn">
                                    <button type="submit" class="btn btn-primary">Submit</button>
                                    <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">Cancel</button>
                                </div>
                            </form>
                        </div>

                    </div>
                </div>
            </div>
        </div>                               
        <%@include file="../sourcesHome/homeFooter.jsp" %>                           
        <script src="/HAPPYorSAD/assets/js/theme-script.js"></script>
        <script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="/HAPPYorSAD/assets/js/jquery.waypoints.js"></script>
        <script src="/HAPPYorSAD/assets/js/jquery.counterup.min.js"></script>
        <script src="/HAPPYorSAD/assets/plugins/select2/js/select2.min.js"></script>
        <script src="/HAPPYorSAD/assets/js/owl.carousel.min.js"></script>
        <script src="/HAPPYorSAD/assets/plugins/slick/slick.js"></script>
        <script src="/HAPPYorSAD/assets/plugins/aos/aos.js"></script>
        <script src="/HAPPYorSAD/assets/js/script.js"></script>
    </body>

</html>
