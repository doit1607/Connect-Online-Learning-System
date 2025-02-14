<%-- 
    Document   : createCourse
    Created on : Jan 24, 2025, 5:08:45 PM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>Dreams LMS</title>

        <!-- Favicon -->
        <link rel="shortcut icon" type="image/x-icon" href="/HAPPYorSAD/assets/img/favicon.svg">

        <!-- Theme Settings Js -->
        <script src="/HAPPYorSAD/assets/js/theme-script.js" type="5be7c2d885a91220a5e99031-text/javascript"></script>


        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap.min.css">

        <!-- Fontawesome CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/all.min.css">

        <!-- Feather CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/feather.css">

        <!-- Select2 CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/select2/css/select2.min.css">

        <!-- Bootstrap Tagsinput CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/bootstrap-tagsinput/css/bootstrap-tagsinput.css">

        <!-- Main CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css">

    </head>
    <body>        
        <%@include file="../sourcesHome/homeHeader.jsp" %>  
        <!-- Main Wrapper -->
        <div class="main-wrapper">
            <!-- New Course -->
            <% ResultSet rsMajor = (ResultSet) request.getAttribute("rsMajor");%>

            <section class="page-content course-sec">

                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-md-12">
                            <div class="add-course-header">
                                <h1>Add New Course</h1>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <!-- Course Wizard -->
                                <div class="widget-set">
                                    <div class="widget-setcount">
                                        <ul id="progressbar">
                                            <li class="progress-active">
                                                <p><span></span> Basic Information</p>                                              
                                            </li>

                                        </ul>
                                    </div>
                                    <c:if test="${param.success == 'true'}">
                                        <div class="alert alert-success">Course created successfully!</div>
                                    </c:if>
                                    <div class="widget-content multistep-form">
                                        <fieldset id="first">
                                            <div class="add-course-info">
                                                <div class="add-course-inner-header">
                                                    <h4>Create Course</h4>
                                                </div>
                                                <div class="add-course-form">
                                                    <form action="CreateCourses" method="get" id="createCourseForm">
                                                        <div class="input-block">
                                                            <label class="add-course-label">Course cover image</label>
                                                            <div class="relative-form">
                                                                <span id="file-name">No File Selected</span>
                                                                <label class="relative-file-upload">
                                                                    Upload File <input type="file" name="image" id="image-upload" onchange="previewImage(event)">
                                                                </label>
                                                            </div>
                                                            <img id="image-preview" src="#" alt="Image Preview" class="img-fluid" style="display:none; margin-top: 10px; max-width: 150px; height: auto; border: 1px solid #ccc; padding: 5px; border-radius: 5px;">
                                                        </div>
                                                        <div class="input-block">
                                                            <label class="add-course-label">Course Name</label>
                                                            <input type="text" name="title" id="title" class="form-control" placeholder="Course Title" required>
                                                        </div>
                                                        <div class="input-block">
                                                            <label class="add-course-label">Major Name</label>                                                                                                                        
                                                            <select class="form-control" name="majorID" id="majorID">
                                                                <%while(rsMajor.next()){%>
                                                                <option value="<%=rsMajor.getInt(1)%>"><%=rsMajor.getString(2)%></option>
                                                                <%}%>
                                                            </select>
                                                        </div>

                                                        <div class="input-block mb-0">
                                                            <label class="add-course-label">Course Description</label>
                                                            <textarea name="description" id="description" class="form-control" placeholder="Course Description" required></textarea>
                                                        </div>
                                                        <div class="add-course-btns">
                                                            <ul class="nav">
                                                                <li>
                                                                    <a href="instructor-dashboard.html" class="btn btn-black">Back to Course</a>
                                                                </li>
                                                                <li>
                                                                    <button type="submit" form="createCourseForm" class="btn btn-success-dark">Save</button>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                </div>
                                <!-- /Course Wizard -->

                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- /New Course -->

            <script>
                function previewImage(event) {
                    var input = event.target;
                    var reader = new FileReader();

                    reader.onload = function () {
                        var imagePreview = document.getElementById('image-preview');
                        imagePreview.src = reader.result;
                        imagePreview.style.display = 'block';
                    };

                    reader.readAsDataURL(input.files[0]);

                    // Display the file name
                    document.getElementById('file-name').textContent = input.files[0].name;
                }
            </script>

            <footer class="footer">
                <%@include file="../sourcesHome/homeFooter.jsp" %>
            </footer>
            <!-- /Footer -->
        </div>
        <!-- jQuery -->
        <script data-cfasync="false" src="/HAPPYorSAD/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script><script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js" type="1d433aff6b2b8dd82abe2a72-text/javascript"></script>

        <!-- Bootstrap Core JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <!-- counterup JS -->
        <script src="/HAPPYorSAD/assets/js/jquery.waypoints.js" type="1d433aff6b2b8dd82abe2a72-text/javascript"></script>
        <script src="/HAPPYorSAD/assets/js/jquery.counterup.min.js" type="1d433aff6b2b8dd82abe2a72-text/javascript"></script>

        <!-- Select2 JS -->
        <script src="/HAPPYorSAD/assets/plugins/select2/js/select2.min.js" type="1d433aff6b2b8dd82abe2a72-text/javascript"></script>

        <!-- Owl Carousel -->
        <script src="/HAPPYorSAD/assets/js/owl.carousel.min.js" type="1d433aff6b2b8dd82abe2a72-text/javascript"></script>

        <!-- Slick Slider -->
        <script src="/HAPPYorSAD/assets/plugins/slick/slick.js" type="1d433aff6b2b8dd82abe2a72-text/javascript"></script>

        <!-- Aos -->
        <script src="/HAPPYorSAD/assets/plugins/aos/aos.js" type="1d433aff6b2b8dd82abe2a72-text/javascript"></script>

        <!-- Custom JS -->
        <script src="/HAPPYorSAD/assets/js/script.js" type="1d433aff6b2b8dd82abe2a72-text/javascript"></script>


        <script src="/HAPPYorSAD/cdn-cgi/scripts/7d0fa10a/cloudflare-static/rocket-loader.min.js" data-cf-settings="1d433aff6b2b8dd82abe2a72-|49" defer></script><script defer src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015" integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ==" data-cf-beacon='{"rayId":"910743f1baeee2ec","version":"2025.1.0","serverTiming":{"name":{"cfExtPri":true,"cfL4":true,"cfSpeedBrain":true,"cfCacheStatus":true}},"token":"3ca157e612a14eccbb30cf6db6691c29","b":1}' crossorigin="anonymous"></script>
    </body>

</html>
