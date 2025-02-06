<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sign In</title>
<!--        <link rel="stylesheet" href="../css/Login_Register.css">-->
        <style>
            body {
                font-family: Arial, sans-serif;
                background: linear-gradient(to right, #fff5f5, #ffffff);
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                width: 100vw;
            }

            .container {
                display: flex;
                width: 100%;
                height: 100vh;
                max-width: 100%;
                background: white;
                border-radius: 0;
                box-shadow: none;
                text-align: center;
            }

            .left-section {
                flex: 1;
                background: linear-gradient(to right, #ffe5d9, #ffcad4);
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                padding: 60px;
                height: 100%;
            }

            .illustration img {
                width: 80%;
                max-width: 400px;
            }

            .right-section {
                flex: 1;
                padding: 60px;
                position: relative;
                height: 100%;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            h2 {
                margin-bottom: 20px;
                font-size: 24px;
                color: #333;
                text-align: left;
            }

            .input-group label, form label {
                display: block;
                margin: 5px 0;
                font-weight: bold;
                text-align: left;
            }

            .input-group input, form input {
                width: 100%;
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 14px;
                margin-top: 10px;
            }

            .terms {
                margin-top: 10px;
                display: flex;
                align-items: center;
            }

            .terms input {
                margin-right: 10px;
            }

            button, .submit-btn, .signin-btn {
                background-color: #ff7043;
                color: white;
                border: none;
                cursor: pointer;
                font-size: 16px;
                font-weight: bold;
                margin-top: 20px;
                padding: 14px;
                border-radius: 5px;
                width: 100%;
            }

            button:hover, .submit-btn:hover, .signin-btn:hover {
                background-color: #ff5733;
            }

            .forgot-password {
                text-align: left;
            }

            .forgot-password a {
                color: #ff7043;
                text-decoration: none;
                font-weight: bold;
            }

            .google-btn, .facebook-btn {
                background-color: #f0f0f0;
                color: black;
                border: none;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 12px;
                border-radius: 5px;
                margin-top: 10px;
                width: 100%;
                font-size: 14px;
            }

            .google-btn:hover, .facebook-btn:hover {
                background-color: #e0e0e0;
            }
            .back-home {
                position: absolute;
                top: 2vh;
                right: 2vw;
                font-size: 1.2vw;
            }

            .back-home a {
                text-decoration: none;
                color: #888;
            }

            .back-home a:hover {
                text-decoration: underline;
            }
        </style>
    </head>

    <body>
        <div class="container">
            <div class="left-section">
                <div class="illustration">
                    <img src="/HAPPYorSAD/images/images.png" alt="Illustration">
                </div>
                <h2>Welcome to HappyOrSad Courses.</h2>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.</p>
            </div>
            <div class="right-section">
                <div class="logo">
                    <h1><span class="logo-highlight">Dreams</span>HOS</h1>
                </div>
                <div class="back-home"><a href="/HAPPYorSAD/Home/HomePage.jsp">Back to Home</a></div>
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
                        <p>New User? <a href="/HAPPYorSAD/LoginUser?service=register">Create an Account</a></p>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
