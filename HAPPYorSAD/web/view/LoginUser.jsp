<!DOCTYPE iddtml> 
<html lang="en">       
    <head>          
        <meta charset="utf-8">         
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">         
        <title>Dreams LMS</title>          

        <!-- Favicon -->         
        <link rel="shortcut icon" type="image/x-icon" href="/HAPPYorSAD/assets/img/favicon.svg">          

        <!-- Theme Settings Js -->         
        <script src="/HAPPYorSAD/assets/js/theme-script.js" type="text/javascript"></script>          

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

        <!-- Main CSS (?ã s?a ???ng d?n) -->         
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
                            <div class="w-100">                                 
                                <div class="img-logo">                                     
                                    <img src="/HAPPYorSAD/assets/img/logo.svg" class="img-fluid" alt="Logo">                                     
                                    <div class="back-home">                                         
                                        <a href="/../HAPPYorSAD/Home">Back to Home</a>                                     
                                    </div>                                 
                                </div>                                 
                                <h1>Sign into Your Account</h1>                                 
                                <form action="/../HAPPYorSAD/LoginUser" method="POST">                                  
                                    <input type="hidden" name="service" value="login">                                     
                                    <div class="input-block">                                         
                                        <label class="form-control-label">Username</label>                                         
                                        <input type="text" class="form-control" name="usernameLogin" value ="${cookie.usernameUser_cookie.value}" placeholder="Enter your username">                                     
                                    </div>                                     
                                    <div class="input-block">                                         
                                        <label class="form-control-label">Password</label>                                         
                                        <div class="pass-group">                                             
                                            <input type="password" class="form-control pass-input" name="passwordLogin" placeholder="Enter your password">                                             
                                            <span class="feather-eye toggle-password"></span>                                         
                                        </div>                                     
                                    </div>                                     
                                    <div class="forgot">                                         
                                        <span><a class="forgot-link" href="/HAPPYorSAD/view/ResetPassword.jsp">Reset Password?</a></span>                                     
                                    </div>                                     
                                    <div class="remember-me">                                         
                                        <label class="custom_check mr-2 mb-0 d-inline-flex remember-me"> Remember me                                             
                                            <input type="checkbox" id="rememberMe" name="rememberMe">                                             
                                            <span class="checkmark"></span>                                         
                                        </label>                                         

                                        <c:if test="${requestScope.error != null}">                                             
                                            <span style="color: red;">${requestScope.error}</span>                                        
                                        </c:if> 


                                        <c:if test="${requestScope.msg != null}">                                             
                                            <span style="color: red;">${requestScope.msg}</span>                                        
                                        </c:if>                                      
                                    </div>                                     
                                    <div class="d-grid">                                         
                                        <button class="btn btn-primary btn-start" type="submit">Sign In</button>                                     
                                    </div>                                 
                                </form>                             
                            </div>                         
                        </div>                         
                        <div class="google-bg text-center">                             
                            <p class="mb-0">New User? <a href="/HAPPYorSAD/view/RegisterUser.jsp">Create an Account</a></p>                         
                        </div>                     
                    </div>                     
                    <!-- /Login -->                  
                </div>              
            </div>          
        </div>         
        <!-- /Main Wrapper -->          

        <!-- jQuery -->         
        <script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js" type="text/javascript"></script>          

        <!-- Bootstrap Core JS -->         
        <script src="/HAPPYorSAD/assets/js/bootstrap.bundle.min.js" type="text/javascript"></script>          

        <!-- Owl Carousel -->         
        <script src="/HAPPYorSAD/assets/js/owl.carousel.min.js" type="text/javascript"></script>          

        <!-- Custom JS -->         
        <script src="/HAPPYorSAD/assets/js/script.js" type="text/javascript"></script>      

    </body>       
</html>
