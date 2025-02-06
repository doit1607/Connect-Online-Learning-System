<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sign In</title>
        <link rel="stylesheet" href="../css/Login_Register.css">
    </head>
    <body>
        <div class="container">
            <div class="left-section">
                <div class="illustration">
                    <img src="../images/images.png" alt="Illustration">
                </div>
                <h2>Welcome to HappyOrSad Courses.</h2>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.</p>
            </div>
            <div class="right-section">
                <div class="logo">
                    <h1><span class="logo-highlight">Dreams</span>HOS</h1>
                </div>
                <div class="back-home"><a href="../Home/HomePage.jsp">Back to Home</a></div>
                <div class="signin-box">
                    <h2>Sign into Your Account</h2>
                    <form action="/HAPPYorSAD/LoginUser" method="POST">
                        <input type="hidden" name="service" value="login">
                        <label for="email">Email</label>
                        <input type="email" name="usernameLogin" placeholder="Enter your email address" required>
                        <label for="password">Password</label>
                        <input type="password" name="passwordLogin" placeholder="Enter your password" required>
                        <div class="forgot-password">
                            <a href="forgotPassword.jsp">Forgot Password?</a>
                        </div>
                        <div class="remember-me">
                            <input type="checkbox" name="rememberMe" id="rememberMe" value="on"> 
                            <label for="rememberMe">Remember me</label>
                        </div>
                        <button type="submit" name="login" value="login" class="signin-btn">Sign In</button>
                    </form>
                    <div class="or-signin">
                        <p>Or sign in with</p>
                        <button class="google-btn">Sign In using Google</button>
                        <button class="facebook-btn">Sign In using Facebook</button>
                    </div>
                    <div class="signup-link">
                        <p>New User? <a href="registerUser.jsp">Create an Account</a></p>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
