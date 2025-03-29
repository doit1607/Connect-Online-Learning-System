<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html> 
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>Dreams LMS</title>

        <link rel="shortcut icon" type="image/x-icon" href="/HAPPYorSAD/assets/img/favicon.svg">
        <script src="/HAPPYorSAD/assets/js/theme-script.js" type="text/javascript"></script>
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/owl.carousel.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/owl.theme.default.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/feather/feather.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css">

        <style>
            .toggle-buttons {
                display: flex;
                gap: 10px;
                margin-bottom: 20px;
            }
            .toggle-buttons button {
                padding: 10px 20px;
                font-size: 16px;
                border: 2px solid #ff6677;
                cursor: pointer;
                background: white;
                color: #ff6677;
                border-radius: 5px;
                transition: all 0.3s;
            }
            .toggle-buttons button.active {
                background: #ff6677;
                color: white;
                border: none;
            }
        </style>
    </head>
    <body>
        <div class="main-wrapper log-wrap">
            <div class="row">
                <div class="col-md-6 login-bg">
                    <div class="owl-carousel login-slide owl-theme">
                        <div class="welcome-login">
                            <div class="login-banner">
                                <img src="/HAPPYorSAD/assets/img/login-img.png" class="img-fluid" alt="Logo">
                            </div>
                            <div class="mentor-course text-center">
                                <h2>Welcome to <br>DreamsLMS Courses.</h2>
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 login-wrap-bg">		
                    <div class="login-wrapper">
                        <div class="loginbox">
                            <div class="img-logo">
                                <img src="/HAPPYorSAD/assets/img/logo.svg" class="img-fluid" alt="Logo">
                                <div class="back-home">
                                    <a href="/../HAPPYorSAD/Home">Back to Home</a>
                                </div>
                            </div>
                            <h1>Sign up</h1>

                            <form action="/../HAPPYorSAD/LoginUser" method="post">
                                <input type="hidden" name="service" value="register">
                                <input type="hidden" id="roleRegis" name="roleRegis" value="${requestScope.roleRegis != null ? requestScope.roleRegis : 'mentor'}">                               
                                <div class="toggle-buttons">
                                    <button id="tutorBtn" type="button" class="${requestScope.roleRegis == 'mentor' || requestScope.roleRegis == null ? 'active' : ''}">Mentor</button>
                                    <button id="studentBtn" type="button" class="${requestScope.roleRegis == 'mentee' ? 'active' : ''}">Mentee</button>
                                </div>

                                <div class="input-block">
                                    <label class="form-control-label">Username</label>
                                    <input type="text" name="usernameRegis" class="form-control" placeholder="Enter your username" value="${requestScope.usernameRegis}" required>
                                    <c:if test="${requestScope.msgusername != null}">
                                        <span style="color: red;">${requestScope.msgusername}</span>
                                    </c:if>
                                </div>

                                <div class="input-block">
                                    <label class="form-control-label">Full Name</label>
                                    <input type="text" name="fullnameRegis" class="form-control" placeholder="Enter your Full Name" value="${requestScope.fullnameRegis}" required>
                                    <c:if test="${requestScope.msgfullname != null}">
                                        <span style="color: red;">${requestScope.msgfullname}</span>
                                    </c:if>
                                </div>

                                <div class="input-block">
                                    <label class="form-control-label">Email</label>
                                    <input type="email" name="emailRegis" class="form-control" placeholder="Enter your email address" value="${requestScope.emailRegis}" required>
                                    <c:if test="${requestScope.msgemail != null}">
                                        <span style="color: red;">${requestScope.msgemail}</span>
                                    </c:if>
                                </div>

                                <div class="input-block">  
                                    <label class="form-control-label">Phone Number</label>
                                    <input type="text" name="phoneRegis" class="form-control" placeholder="Enter your phone number" value="${requestScope.phoneRegis}" required>
                                    <c:if test="${requestScope.msgphone != null}">
                                        <span style="color: red;">${requestScope.msgphone}</span>
                                    </c:if>
                                </div>

                                <div class="input-block">
                                    <label class="form-control-label">Address</label>
                                    <input type="text" name="addressRegis" class="form-control" placeholder="Enter your address" value="${requestScope.addressRegis}" required>
                                    <c:if test="${requestScope.msgaddress != null}">
                                        <span style="color: red;">${requestScope.msgaddress}</span>
                                    </c:if>
                                </div>

                                <div class="input-block">
                                    <label class="form-control-label">Date of birth</label>
                                    <input type="date" name="dobRegis" class="form-control" value="${requestScope.dobRegis}" required>
                                </div>

                                <div class="input-group">
                                    <label class="form-control-label">Gender</label>
                                    <select name="genderRegis" id="genderRegis" required>
                                        <option value="">Choose Gender</option>
                                        <option value="male" ${requestScope.genderRegis == 'male' ? 'selected' : ''}>Male</option>
                                        <option value="female" ${requestScope.genderRegis == 'female' ? 'selected' : ''}>Female</option>
                                        <option value="other" ${requestScope.genderRegis == 'other' ? 'selected' : ''}>Other</option>
                                    </select>
                                </div>

                                <div class="input-block">
                                    <label class="form-control-label">Password</label>
                                    <div class="pass-group" id="passwordInput">																	
                                        <input type="password" name="passwordRegis" id="passwordRegis" class="form-control pass-input" placeholder="Enter your password" value="${requestScope.passwordRegis}" required>
                                        <span class="toggle-password feather-eye"></span>
                                        <span class="pass-checked"><i class="feather-check"></i></span>
                                    </div>
                                    <c:if test="${requestScope.msgpassword != null}">
                                        <span style="color: red;">${requestScope.msgpassword}</span>
                                    </c:if>
                                </div>

                                <div class="input-block">
                                    <label class="form-control-label">Confirm Password</label>
                                    <div class="pass-group" id="passwordInput">																	
                                        <input type="password" name="confirmpassword" id="confirmPassword" class="form-control pass-input" placeholder="Enter your confirm password" required>
                                        <span class="toggle-password feather-eye"></span>
                                        <span class="pass-checked"><i class="feather-check"></i></span>
                                    </div>
                                    <div id="passwordInfo"></div>
                                </div>

                                <div class="form-check remember-me">
                                    <label class="form-check-label mb-0">
                                        <input class="form-check-input" type="checkbox" name="remember"> I agree to the <a href="term-condition.html">Terms of Service</a> and <a href="privacy-policy.html">Privacy Policy.</a>
                                    </label>
                                </div>

                                <c:if test="${requestScope.msg != null}">
                                    <span style="color: green;">${requestScope.msg}</span>
                                </c:if>

                                <div class="d-grid">
                                    <button class="btn btn-primary btn-start" type="submit">Create Account</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js" type="text/javascript"></script>
        <script src="/HAPPYorSAD/assets/js/bootstrap.bundle.min.js" type="text/javascript"></script>
        <script src="/HAPPYorSAD/assets/js/owl.carousel.min.js" type="text/javascript"></script>	
        <script src="/HAPPYorSAD/assets/js/validation.js" type="text/javascript"></script>	
        <script src="/HAPPYorSAD/assets/js/script.js" type="text/javascript"></script>

        <script>
            document.getElementById("passwordRegis").addEventListener("input", checkPasswords);
            document.getElementById("confirmPassword").addEventListener("input", checkPasswords);

            function checkPasswords() {
                let password = document.getElementById("passwordRegis").value;
                let confirmPassword = document.getElementById("confirmPassword").value;
                let message = document.getElementById("passwordMessage");

                if (password !== confirmPassword) {
                    if (!message) {
                        message = document.createElement("p");
                        message.id = "passwordMessage";
                        message.style.color = "red";
                        message.textContent = "Passwords do not match!";
                        document.getElementById("confirmPassword").parentElement.after(message);
                    }
                } else {
                    if (message) {
                        message.remove();
                    }
                }
            }

            document.addEventListener("DOMContentLoaded", function () {
                const roleInput = document.getElementById("roleRegis");
                const tutorBtn = document.getElementById("tutorBtn");
                const studentBtn = document.getElementById("studentBtn");

                let selectedRole = roleInput.value || "mentor";
                roleInput.value = selectedRole;

                if (selectedRole === "mentor") {
                    tutorBtn.classList.add("active");
                    studentBtn.classList.remove("active");
                } else if (selectedRole === "mentee") {
                    studentBtn.classList.add("active");
                    tutorBtn.classList.remove("active");
                }

                tutorBtn.addEventListener("click", function () {
                    if (selectedRole !== "mentor") {
                        selectedRole = "mentor";
                        roleInput.value = "mentor";
                        tutorBtn.classList.add("active");
                        studentBtn.classList.remove("active");
                    }
                });

                studentBtn.addEventListener("click", function () {
                    if (selectedRole !== "mentee") {
                        selectedRole = "mentee";
                        roleInput.value = "mentee";
                        studentBtn.classList.add("active");
                        tutorBtn.classList.remove("active");
                    }
                });
            });
        </script>
    </body>
</html>