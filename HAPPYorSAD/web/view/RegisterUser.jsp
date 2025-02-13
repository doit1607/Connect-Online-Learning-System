<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sign Up</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #fff5f5;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }

            .container {
                display: flex;
                width: 100%;
                min-height: 100vh;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                background-color: white;
                border-radius: 0;
                overflow: hidden;
            }

            .info {
                flex: 1;
                background: linear-gradient(135deg, #ffcccc, #fff5f5);
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                padding: 3vh; /* Reduced padding for compactness */
                text-align: center;
            }

            .info h2 {
                margin-bottom: 1vh;
                color: #d32f2f;
                font-size: 2vw;
            }

            .form-container {
                flex: 1;
                padding: 3vh; /* Reduced padding for compactness */
                position: relative;
            }

            .form-container h2 {
                margin-bottom: 2vh;
                font-size: 2vw;
            }

            .back-home {
                position: absolute;
                top: 2vh;
                right: 2vw;
                font-size: 1.2vw;
            }

            .back-home a {
                text-decoration: none;
                color: #888;
            }

            .back-home a:hover {
                text-decoration: underline;
            }

            .input-group {
                margin-bottom: 1.5vh; /* Reduced margin for compactness */
            }

            .input-group label {
                display: block;
                margin-bottom: 0.5vh; /* Reduced margin for compactness */
                font-weight: bold;
                font-size: 1.3vw; /* Slightly smaller font for compactness */
            }

            .input-group input,
            .input-group select {
                width: 100%;
                padding: 1vh; /* Reduced padding for compactness */
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 1.5vw;
            }

            .terms {
                margin-top: 1.5vh; /* Reduced margin for compactness */
                display: flex;
                align-items: center;
                font-size: 1.2vw;
            }

            .terms input {
                margin-right: 1vw;
            }

            .submit-btn {
                background-color: #ff7043;
                color: white;
                padding: 1.5vh; /* Reduced padding for compactness */
                border: none;
                width: 100%;
                border-radius: 5px;
                cursor: pointer;
                font-size: 1.6vw; /* Slightly smaller font for compactness */
                font-weight: bold;
                margin-top: 2vh;
            }

            .submit-btn:hover {
                background-color: #e64a19;
            }

            .avatar-preview {
                margin-top: 2vh;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .avatar-preview img {
                max-width: 8vw; /* Reduced size of avatar preview */
                max-height: 8vw; /* Reduced size of avatar preview */
                border-radius: 50%;
                object-fit: cover;
            }

            button {
                background-color: #ff7043;
                color: white;
                padding: 1.5vh; /* Reduced padding for compactness */
                border: none;
                width: 100%;
                border-radius: 5px;
                cursor: pointer;
                font-size: 1.6vw; /* Slightly smaller font for compactness */
                font-weight: bold;
                margin-top: 2vh;
            }

            button:hover {
                background-color: #ff5733;
            }
        </style>
    </head>
    <body>


        <div class="container">
            <div class="info">
                <img src="../images/images.png" alt="HAPPYorSAD Logo"> 
                <h2>Welcome to HappyorSAD</h2>
            </div>
            <div class="form-container">
                <div class="back-home"><a href="/HAPPYorSAD/Home">Back to Home</a></div>
                <h2>Sign up</h2>
                <form action="/HAPPYorSAD/LoginUser" method="POST">
                    <input type="hidden" name="service" value="register">
                    <div class="input-group">
                        <label for="usernameRegis">Username</label>
                        <input type="text" name="usernameRegis" id="usernameRegis" required>
                    </div>
                    <c:if test="${requestScope.msgusername != null}">
                        ${requestScope.msgusername}
                    </c:if>
                    <div class="input-group">
                        <label for="fullnameRegis">Full Name</label>
                        <input type="text" name="fullnameRegis" id="fullnameRegis" required>
                    </div>
                    <div class="input-group">
                        <label for="emailRegis">Email</label>
                        <input type="email" name="emailRegis" id="emailRegis" required>
                    </div>
                    <c:if test="${requestScope.msgemail != null}">
                        ${requestScope.msgemail}
                    </c:if>
                    <div class="input-group">
                        <label for="phoneRegis">Phone Number</label>
                        <input type="tel" name="phoneRegis" id="phoneRegis" required>
                    </div>
                    <div class="input-group">
                        <label for="dobRegis">Date of Birth</label>
                        <input type="date" name="dobRegis" id="dobRegis" required>
                    </div>
                    <div class="input-group">
                        <label for="genderRegis">Sex</label>
                        <select name="genderRegis" id="genderRegis" required>
                            <option value="">Choose Gender</option>
                            <option value="male">Male</option>
                            <option value="female">Female</option>
                            <option value="other">Other</option>
                        </select>
                    </div>
                    <div class="input-group">
                        <label for="addressRegis">Address</label>
                        <input type="text" name="addressRegis" id="addressRegis" required>
                    </div>
                    <div class="input-group">
                        <label for="passwordRegis">Password</label>
                        <input type="password" name="passwordRegis" id="passwordRegis" required>
                    </div>
                    <div class="input-group">
                        <label for="confirmPassword">Confirm Password</label>
                        <input type="password" name="confirmPassword" id="confirmPassword" required>
                    </div>

                    <div class="terms">
                        <input type="checkbox" name="terms" id="terms" required>
                        <label for="terms">I agree to the <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a>.</label>
                    </div>
                    <button type="submit" class="submit-btn">Create Account</button>

                    <p>Already have an account? <a href="/HAPPYorSAD/view/LoginUser.jsp">Sign in</a></p>
                </form>

            </div>
        </div>

        <script>
            document.getElementById("passwordRegis").addEventListener("input", checkPasswords);
            document.getElementById("confirmPassword").addEventListener("input", checkPasswords);

            function checkPasswords() {
                let password = document.getElementById("passwordRegis").value;
                let confirmPassword = document.getElementById("confirmPassword").value;
                let message = document.getElementById("passwordMessage");

                if (password !== confirmPassword) {
                    if (!message) {
                        message = document.createElement("p");
                        message.id = "passwordMessage";
                        message.style.color = "red";
                        message.textContent = "Passwords do not match!";
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
