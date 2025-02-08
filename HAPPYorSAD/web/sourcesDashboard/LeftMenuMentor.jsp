<%-- 
    Document   : LeftMenu.jsp
    Created on : Feb 5, 2025, 7:59:29 AM
    Author     : Ann
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Left Menu</title>
        <link rel="stylesheet" href="../css/cssDashboard/DashboardMentor.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    </head>
    <body>
        <aside class="left-menu">
            <div class="profile">
                <img src="images/profile.jpg" alt="Instructor Profile">
                <h3>Name</h3>
                <p>Instructor</p>
                <button class="cv-btn">My Curriculum Vitae</button>
            </div>

            <nav>
                <h4>Dashboard</h4>
                <ul>
                    <li><i class="fas fa-tachometer-alt"></i> <a href="#">Dashboard</a></li>
                    <li><i class="fas fa-user"></i> <a href="/HAPPYorSAD/updatementeeprofile">My Profile</a></li>
                    <li><i class="fas fa-book"></i> <a href="index.jsp?page=enrolled_courses">Enrolled Courses</a></li>
                    <li><i class="fas fa-star"></i> <a href="/HAPPYorSAD/reviewmentor">Reviews</a></li>
                    <li><i class="fas fa-shopping-cart"></i> <a href="index.jsp?page=order_history">Order History</a></li>
                    <li><i class="fas fa-users"></i> <a href="index.jsp?page=referrals">Referrals</a></li>
                    <li><i class="fas fa-comment"></i> <a href="index.jsp?page=messages">Messages</a></li>
                    <li><i class="fas fa-bell"></i> <a href="index.jsp?page=notifications">Notifications</a></li>
                </ul>

                <h4>Instructor</h4>
                <ul>
                    <li><i class="fas fa-graduation-cap"></i> <a href="index.jsp?page=my_courses">My Courses</a></li>
                    <li><i class="fas fa-bullhorn"></i> <a href="index.jsp?page=announcements">Announcements</a></li>
                    <li><i class="fas fa-wallet"></i> <a href="index.jsp?page=withdrawals">Withdrawals</a></li>
                    <li><i class="fas fa-money-bill"></i> <a href="index.jsp?page=earnings">Earnings</a></li>
                </ul>

                <h4>Account Settings</h4>
                <ul>
                    <li><i class="fas fa-cog"></i> <a href="index.jsp?page=settings" class="active">Settings</a></li>
                    <li><i class="fas fa-sign-out-alt"></i> <a href="logout.jsp">Logout</a></li>
                </ul>
            </nav>
        </aside>
    </body>
</html>
