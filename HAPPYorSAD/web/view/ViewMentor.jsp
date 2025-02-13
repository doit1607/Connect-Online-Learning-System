<%-- 
    Document   : ViewMentor
    Created on : Feb 5, 2025, 12:26:05 PM
    Author     : Dell
--%>
<<<<<<< HEAD
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

=======
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
>>>>>>> 31769565b00d063ad4b528560148867133299d69
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
<<<<<<< HEAD
        <title>Mentor List</title>

        <!-- Bootstrap 5 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome (Icons) -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <!-- Custom CSS -->
=======
        <title>Mentor Management</title>
>>>>>>> 31769565b00d063ad4b528560148867133299d69
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
                text-align: center;
            }

            h2 {
                margin-bottom: 20px;
            }

            .search-container {
                margin-bottom: 20px;
            }

            input {
                padding: 8px;
                width: 250px;
            }

            button {
                padding: 8px 15px;
                margin-left: 5px;
                cursor: pointer;
                background-color: #007bff;
                color: white;
                border: none;
            }

            table {
                width: 90%;
                margin: auto;
                border-collapse: collapse;
                margin-bottom: 20px;
            }

            table, th, td {
                border: 1px solid #ddd;
                padding: 8px;
            }

            th {
                background-color: #007bff;
                color: white;
            }

            .pagination {
                margin-top: 10px;
            }

            button:hover {
                opacity: 0.8;
            }
        </style>
    </head>
    <body>

<<<<<<< HEAD
        <div class="container">
            <h2 class="text-center mb-4">Mentor List</h2>

            <!-- Search Form -->
            <form id="searchForm" action="viewMentor" method="GET" class="mb-4">
                <div class="input-group">
                    <input type="text" id="searchInput" name="search" class="form-control" placeholder="TÃ¬m kiáº¿m mentor..." value="${param.search}">
                    <button class="btn btn-primary" type="submit"><i class="fas fa-search"></i> Search</button>
                </div>
            </form>
            <% 
                String message = (String) session.getAttribute("message");
                String error = (String) session.getAttribute("error");
                if (message != null) { 
            %>
            <div class="alert alert-success"><%= message %></div>
            <%
                session.removeAttribute("message");
                }
                if (error != null) {
            %>
            <div class="alert alert-danger"><%= error %></div>
            <%
                session.removeAttribute("error");
                }
            %>

            <!-- Mentor List -->
            <div class="row">

                <c:choose>
                    <c:when test="${not empty listMentor}">
                        <table class="table table-bordered">
                            <thead class="table-light">
                                <tr>
                                    <th>Number</th>
                                    <th>ID</th>
                                    <th>Full Name</th>
                                    <th>User name</th>
                                    <th>Expertise</th>
                                    <th>Current Request</th>
                                    <th>% Completion</th>
                                    <th>Rate</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="mentor" items="${listMentor}" varStatus="status">
                                    <tr>
                                        <td>${status.index + 1}</td>
                                        <td>${mentor.id}</td>
                                        <td>${mentor.name}</td>
                                        <td>${mentor.getUser().getUsername()}</td>
                                        <td>${mentor.expertise}</td>
                                        <td>${mentor.getBaseRate()}</td>
                                        <td>${mentor.getMultiplier()}%</td>
                                        <td class="text-warning">
                                            <i class="fas fa-star"></i> ${mentor.rating}
                                        </td>
                                        <td>
                                            <span class="${mentor.getUser().getStatus().equals('active') ? 'text-success' : 'text-danger'}">
                                                ${mentor.getUser().getStatus().equals('active') ? 'Active' : 'Inactive'}
                                            </span>
                                        </td>
                                        <td>
                                            <form method="post" action="viewMentor" onsubmit="return confirmAction(this);">
                                                <input type="hidden" name="username" value="${mentor.getUser().getUsername()}">

                                                <c:if test="${mentor.getUser().getStatus().equals('active')}">
                                                    <input type="hidden" name="status" value="inactive">
                                                    <button type="submit" class="btn btn-sm btn-danger">Disable</button>
                                                </c:if>

                                                <c:if test="${!mentor.getUser().getStatus().equals('active')}">
                                                    <input type="hidden" name="status" value="active">
                                                    <button type="submit" class="btn btn-sm btn-success">Active</button>
                                                </c:if>
                                            </form>
                                        </td>



                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <p class="text-center text-muted">Cannot find this mentor.</p>
                    </c:otherwise>
                </c:choose>
            </div>


            <!-- Pagination -->
            <nav>
                <ul class="pagination">
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="viewMentor?search=${param.search}&limit=${limit}&page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>
=======
        <h2>Mentor Management</h2>

        <div class="search-container">
            <input type="text" id="search-box" placeholder="Search mentor...">
            <button onclick="searchMentor()">Search</button>
>>>>>>> 31769565b00d063ad4b528560148867133299d69
        </div>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Full Name</th>
                    <th>Username</th>
                    <th>Expertise</th>
                    <th>Currently Requests</th>
                    <th>Completion % </th>
                    <th>?Rating</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody id="mentor-table-body">
            <c:forEach var="mentor" items="${sessionScope.listMentor}">
                <tr>
                    <td>${mentor.id}</td>
                    <td>${mentor.name}</td>
                    <td>${mentor.username}</td>
                    <td>${mentor.expertise}</td>
                    <td>5</td>
                    <td>70%</td>
                    <td>${user.rating}</td>
                    <td>${user.reviews}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div class="pagination">
        <button onclick="prevPage()">« </button>
        <span id="page-info">Page 1</span>
        <button onclick="nextPage()"> »</button>
    </div>

    <script>
        let mentors = [];
        let currentPage = 1;
        const rowsPerPage = 5;

        document.addEventListener("DOMContentLoaded", function () {
            loadMentors();
        });

        function loadMentors() {
            fetch("http://localhost:8080/api/mentors") // Backend API
                    .then(response => response.json())
                    .then(data => {
                        mentors = data;
                        displayTable();
                    })
                    .catch(error => console.error("L?i t?i d? li?u:", error));
        }

        function displayTable() {
            const tbody = document.getElementById("mentor-table-body");
            tbody.innerHTML = "";

            let start = (currentPage - 1) * rowsPerPage;
            let end = start + rowsPerPage;
            let pageData = mentors.slice(start, end);

            pageData.forEach((mentor, index) => {
                let row = `<tr>
                    <td>${start + index + 1}</td>
                    <td>${mentor.id}</td>
                    <td>${mentor.name}</td>
                    <td>${mentor.accountName}</td>
                    <td>${mentor.profession}</td>
                    <td>${mentor.currentRequests}</td>
                    <td>${mentor.completionRate}%</td>
                    <td>? ${mentor.rating}</td>
                    <td>
                        <button onclick="toggleStatus(${mentor.id})">${mentor.isActive ? "? Active" : "? Inactive"}</button>
                    </td>
                </tr>`;
                tbody.innerHTML += row;
            });

            document.getElementById("page-info").innerText = `Page ${currentPage}`;
        }

        function prevPage() {
            if (currentPage > 1) {
                currentPage--;
                displayTable();
            }
        }

        function nextPage() {
            if (currentPage * rowsPerPage < mentors.length) {
                currentPage++;
                displayTable();
            }
        }

        function searchMentor() {
            let query = document.getElementById("search-box").value.toLowerCase();
            let filteredMentors = mentors.filter(mentor =>
                mentor.name.toLowerCase().includes(query) ||
                        mentor.accountName.toLowerCase().includes(query)
            );

            mentors = filteredMentors;
            currentPage = 1;
            displayTable();
        }

        function toggleStatus(id) {
            let mentor = mentors.find(m => m.id === id);
            if (mentor) {
                mentor.isActive = !mentor.isActive;
                displayTable();
            }
        }
    </script>

</body>
</html>

