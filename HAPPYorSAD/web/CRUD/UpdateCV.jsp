<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create CV - Update CV of Mentor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f4f9; }
        .cv-container { background: #fff; padding: 20px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); }
        .cv-container h2 { color: #333; }
        .input-block { margin-bottom: 20px; }
        .input-block label { font-weight: bold; }
        .input-block input, .input-block textarea, .input-block select { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="cv-container">
            <h2>Update CV of Mentor</h2>
            <form action="/HAPPYorSAD/createcv" method="post">
                <!-- Personal Information -->
                <div class="input-block">
                    <label>Account Name:</label>
                    <input type="text" name="accountName" readonly value="${sessionScope.username}">
                </div>
                <div class="input-block">
                    <label>Full Name:</label>
                    <input type="text" name="fullname" value="${mentor.fullname}" required>
                </div>
                <div class="input-block">
                    <label>Date of Birth:</label>
                    <input type="date" name="dateOfBirth" value="${mentor.dateOfBirth}" required>
                </div>
                <div class="input-block">
                    <label>Email:</label>
                    <input type="email" name="email" value="${mentor.email}" readonly>
                </div>
                <div class="input-block">
                    <label>Gender:</label>
                    <select name="gender">
                        <option value="Male" ${mentor.gender == 'Male' ? 'selected' : ''}>Male</option>
                        <option value="Female" ${mentor.gender == 'Female' ? 'selected' : ''}>Female</option>
                        <option value="Other" ${mentor.gender == 'Other' ? 'selected' : ''}>Other</option>
                    </select>
                </div>
                <div class="input-block">
                    <label>Address:</label>
                    <input type="text" name="address" value="${mentor.address}" required>
                </div>
                <!-- Profession and Courses -->
                <div class="input-block">
                    <label>Profession:</label>
                    <input type="text" name="profession" required>
                </div>
                <div class="input-block">
                    <label>Profession Introduction:</label>
                    <textarea name="professionIntro" rows="3"></textarea>
                </div>
                <div class="input-block">
                    <label>Courses you can teach:</label>
                    <div>
                        <input type="checkbox" name="courses" value="Java"> Java
                        <input type="checkbox" name="courses" value="C#"> C#
                        <input type="checkbox" name="courses" value="Python"> Python
                        <input type="checkbox" name="courses" value="Web Development"> Web Development
                    </div>
                </div>
                <div class="input-block">
                    <label>Service Description:</label>
                    <textarea name="serviceDescription" rows="3"></textarea>
                </div>
                <div class="input-block">
                    <label>Achievements:</label>
                    <textarea name="achievements" rows="3"></textarea>
                </div>
                <div class="input-block">
                    <label>Programming (Framework):</label>
                    <input type="text" name="frameworks" placeholder="Example: Spring, React, Angular">
                </div>
                <button type="submit" class="btn btn-primary">Update CV</button>
            </form>
        </div>
    </div>
</body>
</html>
