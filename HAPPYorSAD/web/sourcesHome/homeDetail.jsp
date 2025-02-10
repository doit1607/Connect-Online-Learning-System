<%-- 
    Document   : homeBody
    Created on : Jan 19, 2025, 4:17:49 PM
    Author     : Ann
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/cssHome/homeDetail.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <title>JSP Page</title>
    </head>

    <body>


        <section class="hero">
            <div class="hero-text">
                <h1>Engaging &amp; Accessible Online Courses For All</h1>
                <p>Own your future by learning new skills online.</p>
                <div class="search-bar">
                    <div class="search-container">
                        <input type="text" placeholder="Search Course, Mentor, School, etc">
                        <select name="category">
                            <option value="">Category</option>
                            <c:forEach var="category" items="${sessionScope.listMajor}">
                                <option value="${category.id}">${category.name}</option>
                            </c:forEach>
                        </select>

                        <button><i class="fas fa-arrow-right"></i></button>
                    </div>
                </div>
                <div class="stats">
                    <p>Trusted by over <strong>15K Users</strong> worldwide since 2024</p>
                    <div class="rating">
                        39+
                        4.4
                        <span class="stars">★★★★☆</span>
                    </div>
                </div>

            </div>

            <div class="hero-image">
                <img src="images/student.jpg" alt="Student holding a book">
            </div>
        </section>

        <!-- Danh mục khóa học -->
        <section id="categories" class="container top-category">
            <div class="header">
                <div class="text-content">
                    <span class="highlight">Favourite Course</span>
                    <h2>Top Major</h2>
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget aenean accumsan bibendum gravida.</p>
                </div>
                <a href="ShowAllCourse" class="all-categories-btn">All Major Courses</a>
            </div>

            <div class="categories-grid">
                <c:forEach var="category" items="${sessionScope.listMajor}" varStatus="loop">
                    <c:if test="${loop.index < 4}">
                        <div class="category-card">
                            <img src="${category.image}" alt="${category.name}">
                            <h3>${category.name}</h3>
                            <p>${category.total_courses} Courses</p>
                        </div>
                    </c:if>
                </c:forEach>

            </div>
        </section>
        <!-- Các khóa học -->


        <section id="categories" class="container top-category">
            <div class="header">
                <div class="text-content">
                    <span class="highlight">What's New</span>
                    <h2>Featured Courses</h2>
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget aenean accumsan bibendum gravida.</p>
                </div>
                <a href="ShowAllCourse" class="all-categories-btn">All Course</a>
            </div>


            <div class="categories-grid">
                <c:forEach var="course" items="${sessionScope.listFCourse}" varStatus="loop">
                    <c:if test="${loop.index < 4}"> 
                        <div class="category-card" data-index="${loop.index}">
                            <img src="${course.image}" alt="${course.title}">
                            <h5>${course.title}</h5>
                            <h4>${course.courseMajor}</h4>
                            <div>
                                <span>${course.total_Mentee} Mentee</span>
                                <span>${course.total_Mentor} Mentor</span>
                            </div>
                            <a href="ShowAllCourse" class="all-categories-btn-details">More Details</a>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </section>



        <!-- Khóa học nổi bật -->
        <section id="categories" class="container top-category">
            <div class="header">
                <div class="text-content">
                    <span class="highlight">What's New</span>
                    <h2>Top Courses</h2>
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget aenean accumsan bibendum gravida.</p>
                </div>
                <a href="ShowAllCourse" class="all-categories-btn">All Course</a>
            </div>

            <div class="categories-grid">
                <c:forEach var="course" items="${sessionScope.listTCourse}" varStatus="loop">

                    <div class="category-card" data-index="${loop.index}">
                        <img src="${course.image}" alt="${course.title}">
                        <h5>${course.title}</h5>
                        <h4>${course.courseMajor}</h4>
                        <div>
                            <span>${course.total_Mentee} Mentee</span>
                            <span>${course.total_Mentor} Mentor</span>
                        </div>
                        <a href="ShowAllCourse" class="all-categories-btn-details">More Details</a>
                    </div>
                </c:forEach>
            </div>
        </section>


        <section class="featured-mentor">
            <h2>Featured Mentor</h2>
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget aenean accumsan bibendum gravida maecenas augue
                elementum et neque. Suspendisse imperdiet.</p>



            <div class="mentor-container">
                <c:forEach var="mentor" items="${sessionScope.listMentor}" varStatus="loop">
                    <c:if test="${loop.index < 1}"> <div class="mentor-card">
                            <div class="mentor-image" style="background-color: #FF6B6B;">
                                <img src="${mentor.image}" alt="${mentor.name}">
                            </div>
                            <div class="mentor-info">
                                <h3>${mentor.name}</h3>
                                <p>${mentor.expertise}</p>
                                <span class="students">👥 ${mentor.total_mentees} Mentees</span>
                                <div class="rating">                              
                                    <c:forEach var="i" begin="1" end="5">
                                        <span class="fa fa-star ${i <= mentor.rating ? 'active' : ''}"></span>
                                    </c:forEach>
                                    <span>${mentor.rating} (${mentor.rating_count})</span>
                                </div>
                                <button class="all-categories-btn-details">Invite</button>
                            </div>
                        </div></c:if>
                </c:forEach>

                <c:forEach var="mentor" items="${sessionScope.listMentor}" varStatus="loop">
                    <c:if test="${loop.index >2}"> <div class="mentor-card">
                            <div class="mentor-image" style="background-color: #FFC75F;">
                                <img src="${mentor.image}" alt="${mentor.name}">
                            </div>
                            <div class="mentor-info">
                                <h3>${mentor.name}</h3>
                                <p>${mentor.expertise}</p>
                                <span class="students">👥 ${mentor.total_mentees} Mentees</span>
                                <div class="rating">

                                    <c:forEach var="i" begin="1" end="5">
                                        <span class="fa fa-star ${i <= mentor.rating ? 'active' : ''}"></span>
                                    </c:forEach>
                                    <span>${mentor.rating} (${mentor.rating_count})</span>
                                </div>
                                <button class="all-categories-btn-details">Invite</button>
                            </div>
                        </div></c:if>
                </c:forEach>


            </div>

        </section>

        <!-- Join as Mentor -->
        <section class="trusted-by">
            <p class="trusted-text">Trusted By</p>
            <h2>500+ Leading Universities And Companies</h2>
            <div class="logos">
                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/640px-Google_%22G%22_logo.svg.png" alt="Google">
                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/Logo_Colruyt.svg/2560px-Logo_Colruyt.svg.png" alt="Colruyt">
                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Oxford-University-Circlet.svg/1636px-Oxford-University-Circlet.svg.png" alt="Oxford">
            </div>
        </section>


        <section class="mentor-call">
            <div class="mentor-content">
                <div class="mentor-image">
                    <img src="https://st3.depositphotos.com/2801893/13369/v/450/depositphotos_133699472-stock-illustration-mentoring-and-coaching.jpg" alt="Mentor Illustration">
                </div>
                <div class="mentor-text">
                    <h2>Want to share your knowledge?<br>Join us a Mentor</h2>
                    <p>High-definition video is video of higher resolution and quality than standard-definition.</p>
                    <ul>
                        <li>✅ Best Courses</li>
                        <li>✅ Top rated Instructors</li>
                    </ul>
                    <button>Read More</button>
                </div>
            </div>
        </section>

        <section class="testimonial">
            <h2>Users-love-us Don't take it from us.</h2>
            <div class="testimonial-container">
                <p class="testimonial-quote">“Everyone needs a coach. It doesn't matter whether you're a basketball player, a tennis player, a gymnast, or a bridge player.”
                </p>
                <div class="mentor-image" style="max-width: 100%">
                    <img src="https://cdn.tgdd.vn/Files/2022/02/21/1416573/bill-gates-la-ai_1280x860-800-resize.jpg" alt="Mentor Illustration">
                </div>
                <p class="testimonial-author">Bill Gates, The co-founder and former chairman of Microsoft</p>
                <div class="testimonial-navigation">
                    <button>← Prev</button>
                    <button>Next →</button>
                </div>
            </div>
        </section>

        <section class="instructor-education">
            <div class="instructor-box">
                <div class="instructor-text">
                    <h3>Become An Mentor</h3>
                    <p>Top Mentors from around the world teach millions of mentees on Mentoring.</p>
                </div>
                <div class="instructor-image">
                    <img src="https://dreamslms.dreamstechnologies.com/html/assets/img/icon/become-02.svg" alt="Instructor Illustration">
                </div>
            </div>
            <div class="education-box">
                <div class="education-text">
                    <h3>Transform Access To Education</h3>
                    <p>Create an account to receive our newsletter, course recommendations and promotions.</p>
                </div>
                <div class="education-image">
                    <img src="https://dreamslms.dreamstechnologies.com/html/assets/img/icon/become-01.svg" alt="Education Illustration">
                </div>
            </div>
        </section>




        <!-- Unlimited Access -->
        <section class="stats-section">
            <div class="stats-container">
                <div class="stat-box">
                    <div class="stat-icon">
                        <img src="https://dreamslms.dreamstechnologies.com/html/assets/img/icon/icon-07.svg
                             " alt="Students Enrolled">
                    </div>
                    <div class="stat-info">
                        <c:forEach var="count" items="${sessionScope.listCountC}">
                            <h3>${count.total_Mentee}</h3>
                        </c:forEach>
                        <p>MENTEES ENROLLED</p>
                    </div>
                </div>
                <div class="stat-box">
                    <div class="stat-icon">
                        <img src="https://dreamslms.dreamstechnologies.com/html/assets/img/icon/icon-08.svg" alt="Total Courses">
                    </div>
                    <div class="stat-info">
                        <c:forEach var="count" items="${sessionScope.listCountC}">
                            <h3>${count.total_Courses}</h3>
                        </c:forEach>
                        <p>TOTAL COURSES</p>
                    </div>
                </div>
                <div class="stat-box">
                    <div class="stat-icon">
                        <img src="https://dreamslms.dreamstechnologies.com/html/assets/img/icon/icon-09.svg" alt="Countries">
                    </div>
                    <div class="stat-info">
                        <h3>24</h3>
                        <p>COUNTRIES</p>
                    </div>
                </div>
            </div>
            <div class="stats-description">
                <h2>Enjoy unlimited access to more than 360 courses and over 1,600 hands-on labs.</h2>
                <div class="stats-logos">
                    <img src="https://dreamslms.dreamstechnologies.com/html/assets/img/icon/icon-13.svg" alt="Tech Logo 1">
                    <img src="https://dreamslms.dreamstechnologies.com/html/assets/img/icon/icon-14.svg" alt="Tech Logo 2">
                    <img src="https://dreamslms.dreamstechnologies.com/html/assets/img/icon/icon-17.svg" alt="Tech Logo 3">
                    <img src="https://dreamslms.dreamstechnologies.com/html/assets/img/icon/icon-15.svg" alt="Tech Logo 4">
                    <img src="https://dreamslms.dreamstechnologies.com/html/assets/img/icon/icon-16.svg" alt="Tech Logo 5">
                </div>
            </div>
        </section>
    </body>

</html>