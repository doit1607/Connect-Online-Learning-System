<%-- 
    Document   : ViewMentor_Mentee
    Created on : Feb 6, 2025, 11:00:49 AM
    Author     : Ann
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
        
        <title>Course Listing Alternative</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body {
                background: #e0e0e0;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                padding: 20px;
            }
            .container {
                max-width: 1200px;
                margin: 0 auto;
            }
            .card {
                background: #fff;
                border-radius: 8px;
                margin-bottom: 20px;
                overflow: hidden;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                display: flex;
                flex-wrap: wrap;
            }
            .card img {
                width: 200px;
                object-fit: cover;
            }
            .card-content {
                padding: 20px;
                flex: 1;
            }
            .card-title {
                font-size: 22px;
                font-weight: bold;
                margin-bottom: 10px;
            }
            .card-meta {
                color: #777;
                font-size: 14px;
                margin-bottom: 10px;
            }
            .card-rating {
                margin-bottom: 10px;
            }
            .card-tags span {
                background: #f0f0f0;
                padding: 5px 10px;
                border-radius: 5px;
                margin-right: 5px;
                font-size: 12px;
            }
            .card-price {
                font-size: 20px;
                font-weight: bold;
                color: #D32F2F;
                margin-bottom: 10px;
            }
            .card-price del {
                font-size: 16px;
                color: #999;
                margin-left: 10px;
            }
            .invite-btn {
                background: #FFA000;
                border: none;
                padding: 10px 20px;
                color: white;
                font-size: 16px;
                border-radius: 5px;
                cursor: pointer;
                transition: background 0.3s ease;
            }
            .invite-btn:hover {
                background: #FB8C00;
            }
            @media(max-width: 768px) {
                .card {
                    flex-direction: column;
                }
                .card img {
                    width: 100%;
                    height: auto;
                }
            }
            .header {
                display: flex;
                align-items: center;
                justify-content: space-between;
                background: white;
                padding: 15px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
            }
            .header .search-box {
                border: 1px solid #ddd;
                padding: 5px 10px;
                border-radius: 5px;
            }
            .header .filter {
                padding: 5px 10px;
                border-radius: 5px;
                background-color: #ff4d4d;
                color: white;
                border: none;
                cursor: pointer;
            }
        </style>
    </head>
    <body>

        <div class="header">
            <button class="filter">☰</button>
            <span>Showing 1-9 of 50 results</span>
            <input type="text" class="search-box" placeholder="Search our courses">
            <select>
                <option>Newly published</option>
            </select>
        </div>

        <div class="container">
            <% for (int i = 0; i < 3; i++) { %>
            <div class="card">
                <img src="https://via.placeholder.com/200" alt="Course Image">
                <div class="card-content">
                    <div class="card-title">Full name - Course Title</div>
                    <div class="card-meta">account_name | 15+ Lessons | 10hr 00min | 30 Requests</div>
                    <div class="card-rating">⭐️⭐️⭐️⭐️☆ (20)</div>
                    <div class="card-tags">
                        <span>Web Design</span>
                        <span>UI/UX</span>
                        <span>Development</span>
                    </div>
                    <div class="card-price">$400 / slot <del>$150.00</del></div>
                    <button class="invite-btn" onclick="inviteCourse('<%= i %>')">Invite</button>
                </div>
            </div>
            <% } %>
        </div>
        <script>
            function inviteCourse(courseId) {
                alert('Send Successful ' + courseId);
            }
        </script>
    </body>
</html>

