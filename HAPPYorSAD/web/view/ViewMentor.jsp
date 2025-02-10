<%-- 
    Document   : ViewMentor
    Created on : Feb 5, 2025, 12:26:05 PM
    Author     : Dell
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Mentor Management</title>
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

        <h2>Mentor Management</h2>

        <div class="search-container">
            <input type="text" id="search-box" placeholder="Search mentor...">
            <button onclick="searchMentor()">Search</button>
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

