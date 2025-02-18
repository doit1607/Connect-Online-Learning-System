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
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.svg">

        <!-- Theme Settings Js -->
        <script src="assets/js/theme-script.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">

        <!-- Fontawesome CSS -->
        <link rel="stylesheet" href="assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="assets/plugins/fontawesome/css/all.min.css">

        <!-- Feather CSS -->
        <link rel="stylesheet" href="assets/css/feather.css">

        <!-- Select2 CSS -->
        <link rel="stylesheet" href="assets/plugins/select2/css/select2.min.css">

        <!-- Dropzone -->
        <link rel="stylesheet" href="assets/plugins/dropzone/dropzone.min.css">

        <!-- Boxioons CSS -->
        <link rel="stylesheet" href="assets/plugins/boxicons/css/boxicons.min.css">

        <!-- Main CSS -->
        <link rel="stylesheet" href="assets/css/style.css"> 

        <link href="css/cssCRUD/createCV.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="../sourcesHome/homeHeader.jsp" %>  
        <div class="container mt-5">
            <div class="cv-container">
                <h2>Create CV of Mentor</h2>

                <form action="CreateCV" method="post">
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
                        <label>Profession:</label>
                        <input type="text" name="profession" required>
                    </div>
                    <div class="input-block">
                        <label>Profession Introduction:</label>
                        <textarea name="professionIntro" rows="3"></textarea>
                    </div>
                    <div class="input-block">
                        <label>Courses you can teach:</label>
                        <div>
                            <input type="checkbox" id="course1" name="courses" value="Computer Science">
                            <label for="course1">Computer Science</label>

                            <input type="checkbox" id="course2" name="courses" value="Data Science">
                            <label for="course2">Data Science</label>

                            <input type="checkbox" id="course3" name="courses" value="Cybersecurity">
                            <label for="course3">Cybersecurity</label>

                            <input type="checkbox" id="course4" name="courses" value="Computer Cloud">
                            <label for="course4">Computer Cloud</label>

                            <input type="checkbox" id="course5" name="courses" value="Business Administration">
                            <label for="course5">Business Administration</label>

                            <input type="checkbox" id="course6" name="courses" value="Mechanical Engineering">
                            <label for="course6">Mechanical Engineering</label>

                            <input type="checkbox" id="course7" name="courses" value="Psychology">
                            <label for="course7">Psychology</label>

                            <input type="checkbox" id="course8" name="courses" value="Graphic Design">
                            <label for="course8">Graphic Design</label>

                            <input type="checkbox" id="course9" name="courses" value="Other" onclick="toggleOtherInput()">
                            <label for="course9">Other</label>
                            <input type="text" id="otherCourseInput" name="otherCourse" placeholder="Please specify" style="display: none; margin-top: 5px;">

                        </div>
                    </div>

                    <div class="input-block">
                        <label>Service Description:</label>
                        <textarea name="serviceDescription" rows="3"></textarea>
                    </div>
                    <div class="input-block">
                        <label>Achievements:</label>
                        <textarea name="achievementDescription" rows="3"></textarea>
                    </div>

                    <input type="hidden" name="username" value="${sessionScope.usernameUser}">

                    <button type="submit" class="btn btn-primary">Create CV</button>
                </form>
            </div>
        </div>
        <%@include file="../sourcesHome/homeFooter.jsp" %>
        <script>

            function toggleOtherInput() {
                var otherCheckbox = document.getElementById("course9");
                var otherInput = document.getElementById("otherCourseInput");

                if (otherCheckbox.checked) {
                    otherInput.style.display = "block";
                    otherInput.required = true;
                } else {
                    otherInput.style.display = "none";
                    otherInput.required = false;
                    otherInput.value = "";
                }
            }
        </script>

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
