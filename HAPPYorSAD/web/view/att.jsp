<%-- 
    Document   : att
    Created on : Mar 6, 2025, 6:55:29 AM
    Author     : Ann
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Mentor Attendance</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
                background-color: #f4f4f4;
            }
            .container {
                max-width: 800px;
                margin: auto;
                background: white;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            h2 {
                color: #333;
                text-align: center;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                padding: 12px;
                border: 1px solid #ddd;
                text-align: left;
            }
            th {
                background-color: #4CAF50;
                color: white;
            }
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
            .btn {
                padding: 6px 12px;
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 3px;
                cursor: pointer;
            }
            .btn:disabled {
                background-color: #cccccc;
                cursor: not-allowed;
            }
            .btn:hover:not(:disabled) {
                background-color: #45a049;
            }
            .success, .error {
                text-align: center;
                margin: 10px 0;
                padding: 10px;
                border-radius: 3px;
            }
            .success {
                color: #155724;
                background-color: #d4edda;
                border: 1px solid #c3e6cb;
            }
            .error {
                color: #721c24;
                background-color: #f8d7da;
                border: 1px solid #f5c6cb;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Mentor Attendance for Request #${requestId}</h2>

            <%-- Success/Error Messages --%>
            <c:if test="${not empty param.success}">
                <div class="success">Attendance marked successfully!</div>
            </c:if>
            <c:if test="${not empty param.error}">
                <div class="error">Error marking attendance: ${param.errorMsg}</div>
            </c:if>

            <%-- Check if slots exist --%>
            <c:choose>
                <c:when test="${empty slots}">
                    <div class="error">No slots found for this request.</div>
                </c:when>
                <c:otherwise>
                    <table>
                        <thead>
                            <tr>
                                <th>Slot ID</th>
                                <th>Date</th>
                                <th>Time Slot</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="slot" items="${slots}">
                                <tr>
                                    <td>${slot.id}</td>
                                    <td>
                            <fmt:formatDate value="${slot.slotDate}" pattern="dd/MM/yyyy"/>
                            </td>
                            <td>Slot ${slot.slotNumber}</td>
                            <td>${slot.status}</td>
                            <td>
                                <form action="att" method="post">
                                    <input type="hidden" name="slotId" value="${slot.id}">
                                    <input type="hidden" name="requestId" value="${requestId}">
                                    <input type="hidden" name="isDone" value="true">
                                    <button type="submit" class="btn"
                                            <c:if test="${slot.status == 'Complete'}">disabled</c:if>>
                                                Mark Done
                                            </button>
                                    </form>
                                </td>
                                </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>

        <script>
            // Optional: Add confirmation before marking attendance
            document.querySelectorAll('form').forEach(form => {
                form.addEventListener('submit', function (e) {
                    if (!confirm('Are you sure you want to mark this slot as done?')) {
                        e.preventDefault();
                    }
                });
            });
        </script>
    </body>
</html>