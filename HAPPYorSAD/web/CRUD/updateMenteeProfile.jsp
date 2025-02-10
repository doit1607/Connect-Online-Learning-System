<%-- 
    Document   : updateMenteeProfile
    Created on : Feb 5, 2025, 4:22:30 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/cssCRUD/updateProfile.css">
        <link rel="stylesheet" href="css/cssHome/homeHeader.css">       
        <link rel="stylesheet" href="css/cssHome/homeFooter.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <title>Update Mentee Profile</title>
    </head>
    <body>
        <%@include file="../sourcesHome/homeHeader.jsp" %>
        <h1>Update Your Profile</h1>
        <div class="form-container">
            <form action="/HAPPYorSAD/updatementeeprofile" method="post">
                <input type="hidden" name="id" value="${mentee.id}">
                
                <label for="avatar">Avatar (URL) <span class="required">*</span></label>
                <input type="text" id="avatar" name="avatar" value="${mentee.avatarPath}" required>

                <label for="username">Account Name <span class="required">*</span></label>
                <input type="text" id="username" name="username" value="${mentee.username}" required>

                <label for="fullname">Full Name <span class="required">*</span></label>
                <input type="text" id="fullname" name="fullname" value="${mentee.fullname}" required>

                <label for="dateOfBirth">Date of Birth <span class="required">*</span></label>
                <input type="date" id="dateOfBirth" name="dateOfBirth" value="${mentee.dateOfBirth}" required>

                <label for="email">Email (Read-Only)</label>
                <input type="email" id="email" name="email" value="${mentee.email}" readonly>

                <label for="gender">Gender <span class="required">*</span></label>
                <select id="gender" name="gender">
                    <option value="Male" ${mentee.gender == 'Male' ? 'selected' : ''}>Male</option>
                    <option value="Female" ${mentee.gender == 'Female' ? 'selected' : ''}>Female</option>
                    <option value="Other" ${mentee.gender == 'Other' ? 'selected' : ''}>Other</option>
                </select>

                <label for="address">Address <span class="required">*</span></label>
                <input type="text" id="address" name="address" value="${mentee.address}" required>

                <button type="submit">OK</button>
            </form>
        </div>
        <%@include file="../sourcesHome/homeFooter.jsp" %>
    </body>
    <script>
        window.onload = function() {
            // thông báo thành công
            <% if (request.getAttribute("successMessage") != null) { %>
                alert("<%= request.getAttribute("successMessage") %>");
                window.location.href = "Course.jsp"; // trở về trang Course
            <% } %>

            // thông báo lỗi
            <% if (request.getAttribute("error") != null) { %>
                alert("<%= request.getAttribute("error") %>");
            <% } %>
        };
    </script>
</html>

