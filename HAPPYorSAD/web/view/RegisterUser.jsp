<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Register</title>
        <style>

        </style>
    </head>
    <body>
        <div class="register-container">
            <h2>Register User</h2>
            <form action="LoginUser?out=register" method="POST" enctype="multipart/form-data">
                <div class="input-group">
                    <label for="username">Username:</label>
                    <input type="text" name="usernameRegis" id="username" required>
                </div>
                <div class="input-group">
                    <label for="password">Password:</label>
                    <input type="password" name="passwordRegis" id="password" required>
                </div>
                <div class="input-group">
                    <label for="email">Email:</label>
                    <input type="email" name="emailRegis" id="email" required>
                </div>
                <div class="input-group">
                    <label for="phone">Phone Number:</label>
                    <input type="text" name="phoneRegis" id="phone" required>
                </div>
                <div class="input-group">
                    <label for="avatar">Avatar:</label>
                    <input type="file" name="avatarRegis" id="avatar" accept="image/*" required>
                </div>
                <div class="input-group">
                    <label for="dob">Date of Birth:</label>
                    <input type="date" name="dateofbirthRegis" id="dob" required>
                </div>
                <div class="input-group">
                    <label for="gender">Gender:</label>
                    <select name="genderRegis" id="gender" required>
                        <option value="Male">Male</option>
                        <option value="Female">Female</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
                <button type="submit" class="register-btn">Register</button>
                <div class="login-link">
                    <p>Already have an account? <a href="LoginUser.jsp">Login</a></p>
                </div>
            </form>
        </div>
    </body>
</html>
