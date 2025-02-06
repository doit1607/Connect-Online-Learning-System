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
                height: 90%;
                width: 100%;
            }

            .container {
                display: flex;
                width: 100%;
                height: 90%;
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
                padding: 5vh;
                text-align: center;
            }

            .info h2 {
                margin-bottom: 1vh;
                color: #d32f2f;
                font-size: 2.5vw;
            }

            .form-container {
                flex: 1;
                padding: 5vh;
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
                margin-bottom: 2vh;
            }

            .input-group label {
                display: block;
                margin-bottom: 1vh;
                font-weight: bold;
                font-size: 1.5vw;
            }

            .input-group input,
            .input-group select {
                width: 100%;
                padding: 1.5vh;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 1.5vw;
            }

            .terms {
                margin-top: 2vh;
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
                padding: 2vh;
                border: none;
                width: 100%;
                border-radius: 5px;
                cursor: pointer;
                font-size: 1.8vw;
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
                max-width: 10vw;
                max-height: 10vw;
                border-radius: 50%;
                object-fit: cover;
            }

            button {
                background-color: #ff7043;
                color: white;
                padding: 2vh;
                border: none;
                width: 100%;
                border-radius: 5px;
                cursor: pointer;
                font-size: 1.8vw;
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
                <div class="back-home"><a href="/HAPPYorSAD/Home/HomePage.jsp">Back to Home</a></div>
                <h2>Sign up</h2>
                <form id="signupForm">
                    <div class="input-group">
                        <label for="username">User Name</label>
                        <input type="text" id="username" required>
                    </div>
                    <div class="input-group">
                        <label for="fullname">Full Name</label>
                        <input type="text" id="fullname" required>
                    </div>
                    <div class="input-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" required>
                    </div>
                    <div class="input-group">
                        <label for="phone">Phone Number</label>
                        <input type="tel" id="phone" required>
                    </div>
                    <div class="input-group">
                        <label for="dob">Date of Birth</label>
                        <input type="date" id="dob" required>
                    </div>
                    <div class="input-group">
                        <label for="gender">Sex</label>
                        <select id="gender" required>
                            <option value="">Choose Gender</option>
                            <option value="male">Male</option>
                            <option value="female">Female</option>
                            <option value="other">Other</option>
                        </select>
                    </div>
                    <div class="input-group">
                        <label for="address">Address</label>
                        <input type="text" id="address" required>
                    </div>
                    <div class="input-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" required>
                    </div>
                    <div class="input-group">
                        <label for="confirmPassword">Confirm Password</label>
                        <input type="password" id="confirmPassword" required>
                    </div>
                    <!-- Avatar selection section -->


                    <div class="terms">
                        <input type="checkbox" id="terms" required>
                        <label for="terms">I agree to the <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a>.</label>
                    </div>
                    <button type="submit" class="submit-btn">Create Account</button>
                    <p>Or sign in with</p>
                    <button class="google">Sign in using Google</button>
                    <button class="facebook">Sign in using Facebook</button>
                    <p>Already have an account? <a href="#">Sign in</a></p>
                </form>
            </div>
        </div>

        <script>
            document.getElementById("password").addEventListener("input", checkPasswords);
            document.getElementById("confirmPassword").addEventListener("input", checkPasswords);

            function checkPasswords() {
                let password = document.getElementById("password").value;
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

            function previewAvatar(event) {
                const previewContainer = document.getElementById("avatarPreview");
                previewContainer.innerHTML = "";
                const file = event.target.files[0];
                if (file) {
                    const img = document.createElement("img");
                    img.src = URL.createObjectURL(file);
                    previewContainer.appendChild(img);
                }
            }
        </script>


    </body>
</html>
