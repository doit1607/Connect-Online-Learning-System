<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Register</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #007BFF; /* N?n xanh d??ng */
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
                animation: fadeIn 1s ease-in-out;
            }

            .register-container {
                background-color: white;
                padding: 40px;
                width: 400px;
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1); /* Bóng ?? m?m */
                border-radius: 10px;
                border: 2px solid #4CAF50; /* Vi?n xanh lá */
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .register-container:hover {
                transform: translateY(-5px); /* Hi?u ?ng nâng nh? lên khi hover */
                box-shadow: 0 12px 25px rgba(0, 0, 0, 0.15); /* Bóng ?? sâu h?n khi hover */
            }

            .register-container h2 {
                text-align: center;
                color: #333;
                margin-bottom: 30px;
            }

            .input-group {
                margin-bottom: 20px;
            }

            .input-group label {
                display: block;
                font-size: 14px;
                color: #555;
                margin-bottom: 5px;
            }

            .input-group input,
            .input-group select {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 14px;
            }

            .register-btn {
                width: 100%;
                padding: 10px;
                background-color: #4CAF50; /* Nút xanh lá */
                color: white;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.3s ease;
            }

            .register-btn:hover {
                background-color: #45a049; /* ??i màu khi hover */
                transform: translateY(-3px); /* Nâng nh? nút khi hover */
            }

            .login-link {
                text-align: center;
                margin-top: 20px;
                font-size: 0.9em;
            }

            .login-link a {
                color: #007BFF; /* ??i màu xanh d??ng */
                text-decoration: none;
            }

            .login-link a:hover {
                text-decoration: underline;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: scale(0.8);
                }
                to {
                    opacity: 1;
                    transform: scale(1);
                }
            }
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
