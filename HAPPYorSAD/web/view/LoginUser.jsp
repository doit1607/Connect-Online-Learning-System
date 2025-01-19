<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Login</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
                animation: fadeIn 1s ease-in-out;
            }

            .login-container {
                background-color: white;
                padding: 40px;
                width: 350px;
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1); /* Bóng ?? m?m */
                border-radius: 10px;
                border: 2px solid #007BFF; /* Vi?n xanh lá */
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .login-container:hover {
                transform: translateY(-5px); /* Hi?u ?ng nâng nh? lên khi hover */
                box-shadow: 0 12px 25px rgba(0, 0, 0, 0.15); /* Bóng ?? sâu h?n khi hover */
            }

            .login-container h2 {
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

            .input-group input {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 14px;
            }

            .remember-me {
                margin-bottom: 20px;
                display: flex;
                align-items: center;
            }

            .remember-me input {
                margin-right: 10px;
            }

            .login-btn {
                width: 100%;
                padding: 10px;
                background-color: #007BFF; 
                color: white;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.3s ease;
            }

            .login-btn:hover {
                background-color: #007BFF; /* ??i màu khi hover */
                transform: translateY(-3px); /* Nâng nh? nút khi hover */
            }

            .forgot-password {
                text-align: right;
                font-size: 0.9em;
                margin-bottom: 15px;
            }

            .forgot-password a {
                color: #007BFF; /* ??i màu xanh d??ng */
                text-decoration: none;
            }

            .forgot-password a:hover {
                text-decoration: underline;
            }

            .signup-link {
                text-align: center;
                margin-top: 20px;
                font-size: 0.9em;
            }

            .signup-link a {
                color: #007BFF; /* ??i màu xanh d??ng */
                text-decoration: none;
            }

            .signup-link a:hover {
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
        <div class="login-container">
            <h2>Login User</h2>
            <form action="LoginUser" method="POST">
                <div class="input-group">
                    <label for="username">Username:</label>
                    <input type="text" name="usernameLogin" value="${cookie.usernameUser_cookie.value}" required>
                </div>
                <div class="input-group">
                    <label for="password">Password:</label>
                    <input type="password" name="passwordLogin" required>
                </div>
                <c:if test="${requestScope.error != null}">
                    ${requestScope.error}
                </c:if>
                <c:if test="${requestScope.msg != null}">
                    ${requestScope.msg}
                </c:if>
                <div class="remember-me">
                    <input type="checkbox" name="rememberMe" id="rememberMe" value="on">
                    <label for="rememberMe">RememberMe</label>
                </div>
                
                <button type="submit" name="login" value="login" class="login-btn">Login</button>
                <div class="forgot-password">
                    <a href="forgotPassword.jsp">Forgot Password?</a>
                </div>
                <div class="signup-link">
                    <p>Don't have an account? <a href="registerUser.jsp">Sign up</a></p>
                </div>
            </form>
        </div>
    </body>
</html>
