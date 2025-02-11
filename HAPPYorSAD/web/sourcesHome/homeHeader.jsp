<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
        <link rel="stylesheet" href="css/cssHome/homeHeader.css">
        <title>JSP Page</title>
    </head>
    <body>
        <header class="navbar">
            <div class="logo">
                <img src="images/images.png" alt="HAPPYorSAD Logo"> 
                <span>HAPPYor<strong>SAD</strong></span>
            </div>
            <ul class="menu">
                <li><a href="Home">Home</a></li>
                <li><a href="ViewMentor_Mentee">Mentor</a></li>
                <li><a href="#">Mentee</a></li>
                <li><a href="#">Pages</a></li>
                <li><a href="#">Blog</a></li>
            </ul>
            <div class="auth-buttons">
                <span class="theme-toggle">&#9788;</span> 
                <c:if test="${sessionScope.usernameUser == null}">

                    <button class="signin" onclick="redirectToLogin()">Sign in</button>
                    <button class="signup" onclick="redirectToSignup()">Sign up</button>
                </c:if>

                <c:if test="${sessionScope.usernameUser != null}">
                    <button class="changepass" onclick="redirectToChangepass()">Changepass</button>
                    <span class="username">Welcome, ${sessionScope.usernameUser}!</span>
                    <button class="logout" onclick="redirectToLogout()">Logout</button>
                </c:if>
            </div>
        </header>
        <script>
            function redirectToSignup() {
                window.location.href = "/HAPPYorSAD/view/RegisterUser.jsp";
            }
            function redirectToLogin() {
                window.location.href = "/HAPPYorSAD/view/LoginUser.jsp";
            }
            function redirectToLogout() {
                window.location.href = "/HAPPYorSAD/LoginUser?service=logout";
            }
            function redirectToChangepass() {
                window.location.href = "/HAPPYorSAD/sourcesHome/ChangePass.jsp";
            }
        </script>
    </body>
</html>
