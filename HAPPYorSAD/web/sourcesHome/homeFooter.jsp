<%-- 
    Document   : homeFooter
    Created on : Jan 19, 2025, 4:17:32 PM
    Author     : Ann
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/cssHome/homeFooter.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

        <title>JSP Page</title>
    </head>
    <body>

        <div class="footer">
            <div class="footer-container">
                <div class="footer-logo">
                    <img src="images/images.png" alt="HAPPYorSAD Logo"> 
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut consequat mauris Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut consequat mauris</p>
                </div>

                <div class="footer-links">
                    <div>
                        <h4>For Instructor</h4>
                        <ul>
                            <li><a href="#">Profile</a></li>
                            <li><a href="view/LoginUser.jsp">Login</a></li>
                            <li><a href="view/RegisterUser.jsp">Register</a></li>
                            <li><a href="ViewMentor_Mentee">Mentor</a></li>
                            <li><a href="#">Dashboard</a></li>
                        </ul>
                    </div>
                    <div>
                        <h4>For Student</h4>
                        <ul>
                            <li><a href="#">Profile</a></li>
                            <li><a href="view/LoginUser.jsp">Login</a></li>
                            <li><a href="view/RegisterUser.jsp">Register</a></li>
                            <li><a href="menteestatistic">Mentee</a></li>
                            <li><a href="#">Dashboard</a></li>
                        </ul>
                    </div>
                </div>

                <div class="footer-newsletter">
                    <h4>News Letter</h4>
                    <input type="email" placeholder="Enter your email address" class="newsletter-input">
                    <div class="contact-info">
                        <p><i class="fa-solid fa-location-dot"  style="color: #9e77e6;"></i> Education and Training Area, Hoa Lac High-Tech Park, Km29 Thang Long Avenue, Thach Hoa, Thach That, Hanoi 13100</p>
                        <p><i class="fa-solid fa-envelope" style="color: #f28b82;"></i> happyorsad@gmail.com</p>
                        <p><i class="fa-solid fa-phone" style="color: #f4b400;"></i> +19 123-456-7890</p>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <p>© 2025 HAPPYorSAD. All rights reserved.</p>
                <div class="footer-links-bottom">
                    <a href="#">Terms</a> | <a href="#">Privacy</a>
                </div>
            </div>
        </div>

    </body>
</html>
