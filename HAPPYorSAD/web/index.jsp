<%-- 
    Document   : index
    Created on : Feb 6, 2025, 5:00:26 AM
    Author     : Ann
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard</title>
        <link rel="stylesheet" href="../Dashboard/DashboardMentor.jsp">
        <link rel="stylesheet" href="../css/cssDashboard/DashboardMentor.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>
    </head>
    <body>
        <div class="container">
            <%@ include file="sourcesDashboard/LeftMenuMentor.jsp" %>

            <main class="content">
                <% 
                    String currentPage = request.getParameter("page");
                    if (currentPage == null || currentPage.isEmpty()) {
                        currentPage = "dashboard"; // Trang mặc định
                    }
                    String pagePath = "../Dashboard" + currentPage + ".jsp";
                %>

                <jsp:include page="<%= pagePath %>" flush="true" />
            </main>
        </div>
    </body>
</html>

