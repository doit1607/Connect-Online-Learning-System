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
            height: 100%;
        }
        .container {
            display: flex;
            max-width: 1000px;
            width: 100%;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
        }
        .info {
            flex: 1;
            background: linear-gradient(135deg, #ffcccc, #fff5f5);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 40px;
            text-align: center;
        }
        .info h2 {
            margin-bottom: 15px;
            color: #d32f2f;
        }
        .form-container {
            flex: 1;
            padding: 50px;
            position: relative;
        }
        .form-container h2 {
            margin-bottom: 20px;
            font-size: 24px;
        }
        .back-home {
            position: absolute;
            top: 10px;
            right: 20px;
            font-size: 14px;
        }
        .back-home a {
            text-decoration: none;
            color: #888;
        }
        .back-home a:hover {
            text-decoration: underline;
        }
        .input-group {
            margin-bottom: 15px;
        }
        .input-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .input-group input,
        .input-group select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }
        .terms {
            margin-top: 20px;
            display: flex;
            align-items: center;
        }
        .terms input {
            margin-right: 10px;
        }
        .submit-btn {
            background-color: #ff7043;
            color: white;
            padding: 14px;
            border: none;
            width: 100%;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            margin-top: 20px;
        }
        .submit-btn:hover {
            background-color: #e64a19;
        }
        .avatar-preview {
            margin-top: 15px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .avatar-preview img {
            max-width: 100px;
            max-height: 100px;
            border-radius: 50%;
            object-fit: cover;
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
            <div class="back-home"><a href="#">Back to Home</a></div>
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
