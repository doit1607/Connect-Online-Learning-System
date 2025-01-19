<%-- 
    Document   : homeBody
    Created on : Jan 19, 2025, 4:17:49 PM
    Author     : Ann
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../css/cssHome/homeDetail.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <title>JSP Page</title>
    </head>
    <body>


        <section class="hero">
            <div class="hero-text">
                <h1>Engaging & Accessible Online Courses For All</h1>
                <p>Own your future by learning new skills online.</p>
                <div class="search-bar">
                    <div class="search-container">
                        <input type="text" placeholder="Search Course, Mentor, School, etc">
                        <select>
                            <option value="">Category</option>
                            <option value="technology">Technology</option>
                            <option value="business">Business</option>
                            <option value="design">Design</option>
                        </select>
                        <button><i class="fas fa-arrow-right"></i></button>
                    </div>
                </div>
                <div class="stats">
                    <p>Trusted by over <strong>15K Users</strong> worldwide since 2024</p>
                    <div class="rating">
                        <span>39+</span>
                        <span>4.4</span>
                        <span class="stars">★★★★☆</span>
                    </div>
                </div>

            </div>

            <div class="hero-image">
                <img src="../images/student.jpg" alt="Student holding a book">
            </div>
        </section>
    </body>
</html>
