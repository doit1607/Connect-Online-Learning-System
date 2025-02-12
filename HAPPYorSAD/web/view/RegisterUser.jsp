<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html> 
<html lang="en">

    <!-- Mirrored from dreamslms.dreamstechnologies.com/html/register.html by HTTrack Website Copier/3.x [XR&CO'2014], Tue, 11 Feb 2025 21:05:04 GMT -->
    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>Dreams LMS</title>

        <!-- Favicon -->
        <link rel="shortcut icon" type="image/x-icon" href="/HAPPYorSAD/assets/img/favicon.svg">

        <!-- Theme Settings Js -->
        <script src="/HAPPYorSAD/assets/js/theme-script.js" type="b11b5c5b2787092d89072727-text/javascript"></script>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap.min.css">

        <!-- Fontawesome CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/all.min.css">

        <!-- Owl Carousel CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/owl.carousel.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/owl.theme.default.min.css">

        <!-- Feathericon CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/feather/feather.css">

        <!-- Main CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css">

    </head>
    <body>

        <!-- Main Wrapper -->
        <div class="main-wrapper log-wrap">

            <div class="row">

                <!-- Login Banner -->
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
                <!-- /Login Banner -->

                <div class="col-md-6 login-wrap-bg">		

                    <!-- Login -->
                    <div class="login-wrapper">
                        <div class="loginbox">
                            <div class="img-logo">
                                <img src="/HAPPYorSAD/assets/img/logo.svg" class="img-fluid" alt="Logo">
                                <div class="back-home">
                                    <a href="/../HAPPYorSAD/Home">Back to Home</a>
                                </div>
                            </div>
                            <h1>Sign up</h1>
                            <form action="/../HAPPYorSAD/LoginUser" method = "post">
                                <input type="hidden" name="service" value="register">
                                <div class="input-block">
                                    <label class="form-control-label">Username</label>
                                    <input type="text" name="usernameRegis"  class="form-control" placeholder="Enter your username">
                                    <c:if test="${requestScope.msgusername != null}">                                             
                                            ${requestScope.msgusername}                                         
                                    </c:if> 
                                </div>

                                <div class="input-block">
                                    <label class="form-control-label">Full Name</label>
                                    <input type="text" name="fullnameRegis" class="form-control" placeholder="Enter your Full Name">
                                </div>

                                <div class="input-block">
                                    <label class="form-control-label">Email</label>
                                    <input type="email" name = "emailRegis" class="form-control" placeholder="Enter your email address">
                                    <c:if test="${requestScope.msgemail != null}">                                             
                                            ${requestScope.msgemail}                                         
                                    </c:if> 
                                </div>

                                <div class="input-block">
                                    <label class="form-control-label">Phone Number</label>
                                    <input type="text" name = "phoneRegis" class="form-control" placeholder="Enter your phone number">
                                </div>
                                <div class="input-block">
                                    <label class="form-control-label">Date of birth</label>
                                    <input type="date" name = "dobRegis" class="form-control">
                                </div>
                                <div class="input-group">
                                    <label class="form-control-label">Gender</label>
                                    <select name="genderRegis" id="genderRegis" required>
                                        <option value="">Choose Gender</option>
                                        <option value="male">Male</option>
                                        <option value="female">Female</option>
                                        <option value="other">Other</option>
                                    </select>
                                </div>
                                <span>&nbsp;</span>
                                <div class="input-block">
                                    <label class="form-control-label">Password</label>
                                    <div class="pass-group" id="passwordInput">																	
                                        <input type="password" name = "passwordRegis" id = "passwordRegis"class="form-control pass-input" placeholder="Enter your password">
                                        <span class="toggle-password feather-eye"></span>
                                        <span class="pass-checked"><i class="feather-check"></i></span>
                                    </div>
                                <span>&nbsp;</span>
                                <div class="input-block">
                                    <label class="form-control-label">Confirm Password</label>
                                    <div class="pass-group" id="passwordInput">																	
                                        <input type="password" name = "confirmpassword" id="confirmPassword"class="form-control pass-input" placeholder="Enter your confirm password">
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
                                <div class="d-grid">
                                    <button class="btn btn-primary btn-start" type="submit">Create Account</button>
                                </div>
                            </form>
                        </div>
<!--                        <div class="google-bg text-center">
                            <span><a href="#">Or sign in with</a></span>
                            <div class="sign-google">
                                <ul>
                                    <li><a href="#"><img src="assets/img/net-icon-01.png" class="img-fluid" alt="Logo"> Sign In using Google</a></li>
                                    <li><a href="#"><img src="assets/img/net-icon-02.png" class="img-fluid" alt="Logo">Sign In using Facebook</a></li>
                                </ul>
                            </div>
                            <p class="mb-0">Already have an account? <a href="login.html">Sign in</a></p>
                        </div>-->
                    </div>
                    <!-- /Login -->

                </div>

            </div>

        </div>
        <!-- /Main Wrapper -->

        <!-- jQuery -->
        <script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js" type="b11b5c5b2787092d89072727-text/javascript"></script>

        <!-- Bootstrap Core JS -->
        <script src="/HAPPYorSAD/assets/js/bootstrap.bundle.min.js" type="b11b5c5b2787092d89072727-text/javascript"></script>

        <!-- Owl Carousel -->
        <script src="/HAPPYorSAD/assets/js/owl.carousel.min.js" type="b11b5c5b2787092d89072727-text/javascript"></script>	

        <!-- Validation-->
        <script src="/HAPPYorSAD/assets/js/validation.js" type="b11b5c5b2787092d89072727-text/javascript"></script>	

        <!-- Custom JS -->
        <script src="/HAPPYorSAD/assets/js/script.js" type="b11b5c5b2787092d89072727-text/javascript"></script>


        
        <script src="../cdn-cgi/scripts/7d0fa10a/cloudflare-static/rocket-loader.min.js" data-cf-settings="b11b5c5b2787092d89072727-|49" defer></script><script defer src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015" integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ==" data-cf-beacon='{"rayId":"91074479e8f5e2ec","version":"2025.1.0","serverTiming":{"name":{"cfExtPri":true,"cfL4":true,"cfSpeedBrain":true,"cfCacheStatus":true}},"token":"3ca157e612a14eccbb30cf6db6691c29","b":1}' crossorigin="anonymous"></script>
        
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
                        document.getElementById("confirmPassword").after(message);
                    }
                } else {
                    if (message) {
                        message.remove();
                    }
                }
            }


        </script>
    </body>

    <!-- Mirrored from dreamslms.dreamstechnologies.com/html/register.html by HTTrack Website Copier/3.x [XR&CO'2014], Tue, 11 Feb 2025 21:05:05 GMT -->
</html>