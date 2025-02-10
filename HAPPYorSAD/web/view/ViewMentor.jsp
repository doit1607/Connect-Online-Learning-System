<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách Mentor</title>

        <!-- Bootstrap 5 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome (Icons) -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <!-- Custom CSS -->
        <style>
            body {
                background-color: #f8f9fa;
            }
            .container {
                max-width: 1200px;
                margin-top: 30px;
            }
            .mentor-card {
                border-radius: 10px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
                transition: transform 0.2s;
            }
            .mentor-card:hover {
                transform: scale(1.02);
            }
            .mentor-card .card-body {
                padding: 15px;
            }
            .mentor-avatar {
                width: 80px;
                height: 80px;
                border-radius: 50%;
                object-fit: cover;
                border: 3px solid #007bff;
            }
            .mentor-name {
                font-size: 18px;
                font-weight: bold;
            }
            .mentor-expertise {
                color: #6c757d;
                font-size: 14px;
            }
            .pagination {
                justify-content: center;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <h2 class="text-center mb-4">Danh Sách Mentor</h2>

            <!-- Search Form -->
            <form id="searchForm" action="viewMentor" method="GET" class="mb-4">
                <div class="input-group">
                    <input type="text" id="searchInput" name="search" class="form-control" placeholder="Tìm kiếm mentor..." value="${param.search}">
                    <button class="btn btn-primary" type="submit"><i class="fas fa-search"></i> Tìm kiếm</button>
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
                                    <th>STT</th>
                                    <th>ID</th>
                                    <th>Họ và tên</th>
                                    <th>Tên tài khoản</th>
                                    <th>Nghề nghiệp</th>
                                    <th>Yêu cầu chấp nhận</th>
                                    <th>% Hoàn thành</th>
                                    <th>Đánh giá</th>
                                    <th>Trạng thái</th>
                                    <th>Hành động</th>
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
                                                ${mentor.getUser().getStatus().equals('active') ? 'Hoạt động' : 'Không hoạt động'}
                                            </span>
                                        </td>
                                        <td>
                                            <form method="post" action="viewMentor" onsubmit="return confirmAction(this);">
                                                <input type="hidden" name="username" value="${mentor.getUser().getUsername()}">

                                                <c:if test="${mentor.getUser().getStatus().equals('active')}">
                                                    <input type="hidden" name="status" value="inactive">
                                                    <button type="submit" class="btn btn-sm btn-danger">Vô hiệu hóa</button>
                                                </c:if>

                                                <c:if test="${!mentor.getUser().getStatus().equals('active')}">
                                                    <input type="hidden" name="status" value="active">
                                                    <button type="submit" class="btn btn-sm btn-success">Kích hoạt</button>
                                                </c:if>
                                            </form>
                                        </td>



                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <p class="text-center text-muted">Không tìm thấy Mentor nào.</p>
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
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                                document.getElementById("searchInput").addEventListener("input", function () {
                                                    let searchValue = this.value.trim();
                                                    let url = "viewMentor?search=" + encodeURIComponent(searchValue);

                                                    fetch(url)
                                                            .then(response => response.text())
                                                            .then(data => {
                                                                // Cập nhật danh sách mentor
                                                                let parser = new DOMParser();
                                                                let doc = parser.parseFromString(data, "text/html");
                                                                let newTable = doc.querySelector("table");

                                                                if (newTable) {
                                                                    document.querySelector("table").innerHTML = newTable.innerHTML;
                                                                }
                                                            })
                                                            .catch(error => console.error("Error:", error));
                                                });
                                                function confirmAction(form) {
                                                    let actionText = form.querySelector("button").textContent.trim();
                                                    return confirm("Bạn có chắc chắn muốn " + actionText.toLowerCase() + " mentor này không?");
                                                }

        </script>


    </body>
</html>
