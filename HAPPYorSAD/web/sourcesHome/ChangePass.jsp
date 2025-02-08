<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 
    Document   : ChangePass
    Created on : Jan 19, 2025, 2:03:49 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password Page</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f5f5f5;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            .container {
                background-color: #ffffff;
                padding: 20px 30px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 400px;
            }

            h2 {
                text-align: center;
                margin-bottom: 20px;
                color: #333;
            }

            .form-group {
                margin-bottom: 15px;
            }

            label {
                display: block;
                font-weight: bold;
                margin-bottom: 5px;
                color: #555;
            }

            input {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 14px;
            }

            input:focus {
                outline: none;
                border-color: #007bff;
                box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
            }

            .btn {
                width: 100%;
                background-color: #007bff;
                color: #ffffff;
                border: none;
                padding: 10px;
                border-radius: 4px;
                font-size: 16px;
                cursor: pointer;
            }

            .btn:hover {
                background-color: #0056b3;
            }

            .error-message {
                color: red;
                font-size: 14px;
                text-align: center;
                margin-top: 10px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Change Password</h2>
            <form action="LoginUser" method="post">
                <input type="hidden" name="service" value="changepass">

                <div class="form-group">
                    <label for="currentPassword">Current Password:</label>
                    <input type="password" id="currentPassword" name="currentpassword" placeholder="Enter current password" required>
                </div>
                <div class="form-group">
                    <label for="newPassword">New Password:</label>
                    <input type="password" id="newPassword" name="newpassword" placeholder="Enter new password" required>
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Confirm New Password:</label>
                    <input type="password" id="confirmPassword" name="confirmpassword" placeholder="Re-enter new password" required>
                </div>
                <button type="submit" class="btn">Change Password</button>
            </form>
            <c:if test="${requestScope.error != null}">
                ${requestScope.error}
            </c:if>

        </div>
        <script>
            document.getElementById("newPassword").addEventListener("input", checkPasswords);
            document.getElementById("confirmPassword").addEventListener("input", checkPasswords);

            function checkPasswords() {
                let password = document.getElementById("newPassword").value;
                let confirmPassword = document.getElementById("confirmPassword").value;
                let message = document.getElementById("passwordMessage");

                if (password !== confirmPassword) {
                    if (!message) {
                        message = document.createElement("p");
                        message.id = "passwordMessage";
                        message.style.color = "red";
                        message.style.textAlign = "center";
                        message.textContent = "New password and confirm password do not match!";
                        document.getElementById("confirmPassword").after(message);
                    }
                } else {
                    if (message) {
                        message.remove();
                    }
                }
            }
        </script>
    </body>
</html>
