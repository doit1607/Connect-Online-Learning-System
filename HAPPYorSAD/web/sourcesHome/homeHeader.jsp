<%-- 
    Document   : homeHeader
    Created on : Jan 19, 2025, 4:17:41 PM
    Author     : Ann
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../css/cssHome/homeHeader.css">
        <title>JSP Page</title>
    </head>
    <!DOCTYPE html>
    <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>HAPPYorSAD Navbar</title>
            <link rel="stylesheet" href="styles.css">
        </head>
        <body>
            <header class="navbar">
                <div class="logo">
                    <img src="images/images.png" alt="HAPPYorSAD Logo"> 
                    <span>HAPPYor<strong>SAD</strong></span>
                </div>
                <ul class="menu">
                    <li><a href="#">Home</a></li>
                    <li><a href="#">Instructor</a></li>
                    <li><a href="#">Student</a></li>
                    <li><a href="#">Pages</a></li>
                    <li><a href="#">Blog</a></li>
                </ul>
                <div class="auth-buttons">
                    <span class="theme-toggle">&#9788;</span> 
                    <button class="signin" onclick="redirectToLogin()">Sign in</button>
                    <button class="signup" onclick="redirectToSignup()">Sign up</button>
                </div>
            </header>
            <script>
                function redirectToSignup() {
                    window.location.href = "RegisterUser.jsp"; // Redirect to the signup page
                }
                function redirectToLogin() {
                    window.location.href = "LoginUser.jsp"; // Redirect to the signup page
                }
            </script>
        </body>
    </html>



</html>
