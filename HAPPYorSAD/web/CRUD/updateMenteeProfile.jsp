<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../css/cssCRUD/updateProfile.css">
        <title>Update Mentee Profile</title>
    </head>
    <body>
        <%@include file="../sourcesHome/homeHeader.jsp" %>
        <h1>Update Your Profile</h1>
        <div class="form-container">
            <form action="updatementeeprofile" method="post" enctype="multipart/form-data">

                <label for="username">Account Name:</label>
                <input type="text" id="username" name="username" value="${mentee.username}" required>

                <label for="fullname">Full Name:</label>
                <input type="text" id="fullname" name="fullname" value="${mentee.fullname}" required>

                <label for="dateOfBirth">Date of Birth:</label>
                <input type="date" id="dateOfBirth" name="dateOfBirth" value="${mentee.dateOfBirth}" required>

                <label for="email">Email (Read-Only):</label>
                <input type="email" id="email" name="email" value="${mentee.email}" readonly>

                <label for="gender">Gender:</label>
                <select id="gender" name="gender">
                    <option value="Male" ${mentee.gender == 'Male' ? 'selected' : ''}>Male</option>
                    <option value="Female" ${mentee.gender == 'Female' ? 'selected' : ''}>Female</option>
                    <option value="Other" ${mentee.gender == 'Other' ? 'selected' : ''}>Other</option>
                </select>

                <label for="address">Address:</label>
                <input type="text" id="address" name="address" value="${mentee.address}" required>

                <label for="avatar">Profile Picture:</label>
                <input type="file" id="avatar" name="avatar" accept="image/*">

                <button type="submit">OK</button>
            </form>
        </div>
        <%@include file="../sourcesHome/homeFooter.jsp" %>
    </body>
</html>
