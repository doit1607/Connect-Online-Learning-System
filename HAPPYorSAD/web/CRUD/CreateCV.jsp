<%-- 
    Document   : AddCV
    Created on : Feb 15, 2025, 12:09:35 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>Dreams LMS</title>

        <!-- Favicon -->
        <!-- Favicon -->
        <link rel="shortcut icon" type="image/x-icon" href="/HAPPYorSAD/assets/img/favicon.svg">


        <!-- Theme Settings Js -->
        <script src="/HAPPYorSAD/assets/js/theme-script.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap.min.css">

        <!-- Fontawesome CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/all.min.css">

        <!-- Feather CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/feather.css">

        <!-- Select2 CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/select2/css/select2.min.css">

        <!-- Dropzone -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/dropzone/dropzone.min.css">

        <!-- Boxioons CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/boxicons/css/boxicons.min.css">

        <!-- Main CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css">






        <script data-cfasync="false" src="/HAPPYorSAD/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script><script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

        <!-- Bootstrap Core JS -->
        <script src="/HAPPYorSAD/assets/js/bootstrap.bundle.min.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

        <!-- Select2 JS -->
        <script src="/HAPPYorSAD/assets/plugins/select2/js/select2.min.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

        <!-- Ckeditor JS -->
        <script src="/HAPPYorSAD/assets/js/ckeditor.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

        <!-- Dropzone JS -->
        <script src="/HAPPYorSAD/assets/plugins/dropzone/dropzone.min.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

        <!-- Sticky Sidebar JS -->
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/ResizeSensor.js" type="d693b69077856eb34d3f2643-text/javascript"></script>
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

        <!-- Custom JS -->
        <script src="/HAPPYorSAD/assets/js/script.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

        <script src="/HAPPYorSAD/cdn-cgi/scripts/7d0fa10a/cloudflare-static/rocket-loader.min.js" 
        data-cf-settings="d693b69077856eb34d3f2643-|49" defer></script>
        <script defer src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015" integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ==" data-cf-beacon='{"rayId":"91074a70ad7f06b9","version":"2025.1.0","serverTiming":{"name":{"cfExtPri":true,"cfL4":true,"cfSpeedBrain":true,"cfCacheStatus":true}},"token":"3ca157e612a14eccbb30cf6db6691c29","b":1}' crossorigin="anonymous"></script>


        <link href="css/cssCRUD/createCV.css" rel="stylesheet" type="text/css"/>

    </head>
    <body>

        <%@include file="../sourcesHome/homeHeader.jsp" %>  
        <div class="container mt-5">
            <div class="cv-container">
                <h2>Create CV of Mentor</h2>

                <form action="CreateCV" method="post">
                    <c:set var="cvStatus" value="${sessionScope.cvStatus}"/>
                    <!-- Personal Information -->
                    <div class="contact-info">
                        <c:if test="${not empty sessionScope.successMessage}">
                            <div class="alert alert-success">
                                ${sessionScope.successMessage}
                            </div>
                            <c:remove var="successMessage" scope="session"/>
                        </c:if>

                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger">
                                ${errorMessage}
                            </div>
                        </c:if>
                        <h3>Information</h3>
                        <hr>
                        <ul>
                            <li>
                                <span class="icon">Account name 👤:</span>
                                <span class="text">${sessionScope.usernameUser}</span>
                            </li>
                            <li>
                                <span class="icon">Full name 📛:</span>
                                <span class="text">${mentor.fullname}</span>
                            </li>
                            <li>
                                <span class="icon">Phone 📱:</span>
                                <span class="text">${mentor.phoneNumber}</span>
                            </li>
                            <li>
                                <span class="icon">Date of Birth 🎂:</span>
                                <span class="text">${mentor.dateOfBirth}</span>
                            </li>
                            <li>
                                <span class="icon">Gmail 📧:</span>
                                <span class="text">${mentor.email}</span>
                            </li>
                            <li>
                                <span class="icon">Gender ⚧:</span>
                                <span class="text">${mentor.gender}</span>
                            </li>
                            <li>
                                <span class="icon">Address 📍:</span>
                                <span class="text">${mentor.address}</span>
                            </li>
                        </ul>
                    </div>
                    <!-- Profession and Courses -->
                    <div class="input-block">
                        <label>Summary of Myself</label>
                        <textarea name="profession" rows="3"></textarea>
                    </div>
                    <div class="input-block">
                        <label>Skills</label>
                        <textarea name="professionIntro" rows="3"></textarea>
                    </div>

                    <div class="input-block">
                        <label>Experience</label>
                        <textarea name="serviceDescription" rows="3"></textarea>
                    </div>
                    <div class="input-block">
                        <label>Education</label>
                        <textarea name="achievementDescription" rows="3"></textarea>
                    </div>

                    <div class="input-block">
                        <label>Courses I Can Teach</label>
                        <div class="checkbox-group">
                            <input type="checkbox" id="cs" name="courses" value="Computer Science">
                            <label for="cs">Computer Science</label>

                            <input type="checkbox" id="ds" name="courses" value="Data Science">
                            <label for="ds">Data Science</label>

                            <input type="checkbox" id="ba" name="courses" value="Business Administration">
                            <label for="ba">Business Administration</label>

                            <input type="checkbox" id="gd" name="courses" value="Graphic Design">
                            <label for="gd">Graphic Design</label>

                            <input type="checkbox" id="me" name="courses" value="Mechanical Engineering">
                            <label for="me">Mechanical Engineering</label>
                        </div>
                    </div>

                    <input type="hidden" name="username" value="${sessionScope.usernameUser}">

                    <button type="submit" class="btn btn-primary">Create CV</button>
                </form>
            </div>
        </div>
        <%@include file="../sourcesHome/homeFooter.jsp" %>

    </footer>
    <!-- /Footer -->

</div>
<!-- /Main Wrapper -->

<!-- jQuery -->
<script data-cfasync="false" src="../cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script><script src="assets/js/jquery-3.7.1.min.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

<!-- Bootstrap Core JS -->
<script src="assets/js/bootstrap.bundle.min.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

<!-- Select2 JS -->
<script src="assets/plugins/select2/js/select2.min.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

<!-- Ckeditor JS -->
<script src="assets/js/ckeditor.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

<!-- Dropzone JS -->
<script src="assets/plugins/dropzone/dropzone.min.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

<!-- Sticky Sidebar JS -->
<script src="assets/plugins/theia-sticky-sidebar/ResizeSensor.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>
<script src="assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

<!-- Custom JS -->
<script src="assets/js/script.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

<script src="../cdn-cgi/scripts/7d0fa10a/cloudflare-static/rocket-loader.min.js" data-cf-settings="27bb6e11b88bb1c6a1b7b5ff-|49" defer></script><script defer src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015" integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ==" data-cf-beacon='{"rayId":"9107445c681fe2ec","version":"2025.1.0","serverTiming":{"name":{"cfExtPri":true,"cfL4":true,"cfSpeedBrain":true,"cfCacheStatus":true}},"token":"3ca157e612a14eccbb30cf6db6691c29","b":1}' crossorigin="anonymous"></script>

</body>
</html>
