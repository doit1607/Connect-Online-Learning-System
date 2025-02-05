<%-- 
    Document   : RightMenu.jsp
    Created on : Feb 5, 2025, 7:59:11 AM
    Author     : Ann
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../css/cssDashboard/DashboardMentor.css">
        <title>JSP Page</title>
    </head>
    <body>
<!--        <div class="right-content">
            <%
                // Lấy tham số "page" từ URL
                String page = request.getParameter("page");

                if (page == null || page.equals("")) {
                    page = "dashboard"; // Mặc định hiển thị trang Dashboard
                }

                // Điều hướng đến nội dung tương ứng
                switch (page) {
                    case "dashboard":
            %><jsp:include page="mentor/Dashboard.jsp" /><%
                        break;
                    case "profile":
            %><jsp:include page="mentor/Profile.jsp" /><%
                        break;
                    case "enrolled_courses":
            %><jsp:include page="mentor/EnrolledCourses.jsp" /><%
                        break;
                    case "reviews":
            %><jsp:include page="mentor/Reviews.jsp" /><%
                        break;
                    case "order_history":
            %><jsp:include page="mentor/OrderHistory.jsp" /><%
                        break;
                    case "referrals":
            %><jsp:include page="mentor/Referrals.jsp" /><%
                        break;
                    case "messages":
            %><jsp:include page="mentor/Messages.jsp" /><%
                        break;
                    case "notifications":
            %><jsp:include page="mentor/Notifications.jsp" /><%
                        break;
                    case "my_courses":
            %><jsp:include page="mentor/MyCourses.jsp" /><%
                        break;
                    case "announcements":
            %><jsp:include page="mentor/Announcements.jsp" /><%
                        break;
                    case "withdrawals":
            %><jsp:include page="mentor/Withdrawals.jsp" /><%
                        break;
                    case "earnings":
            %><jsp:include page="mentor/Earnings.jsp" /><%
                        break;
                    case "settings":
            %><jsp:include page="mentor/Settings.jsp" /><%
                        break;
                    default:
            %><jsp:include page="mentor/404.jsp" /><%  // Trang lỗi nếu không tìm thấy
                        break;
                }
            %>
        </div>-->
    </body>
</html>
