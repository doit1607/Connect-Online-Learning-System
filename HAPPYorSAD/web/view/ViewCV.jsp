<%-- 
    Document   : ViewCV
    Created on : Feb 20, 2025, 1:42:58 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>Dreams LMS</title>
        <!-- Favicon -->
        <link rel="shortcut icon" type="image/x-icon" href="/HAPPYorSAD/assets/img/favicon.svg">


        <!-- Theme Settings Js -->
        <script src="/HAPPYorSAD/assets/js/theme-script.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/bootstrap.min.css">

        <!-- Fontawesome CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/fontawesome/css/all.min.css">

        <!-- Feather CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/feather.css">

        <!-- Select2 CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/select2/css/select2.min.css">

        <!-- Dropzone -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/dropzone/dropzone.min.css">

        <!-- Boxioons CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/plugins/boxicons/css/boxicons.min.css">

        <!-- Main CSS -->
        <link rel="stylesheet" href="/HAPPYorSAD/assets/css/style.css">
        <link href="css/cssCRUD/createCV.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div class="main-wrapper">
            <%@include file="../sourcesHome/homeHeader.jsp" %>  
            <div class="breadcrumb-bar breadcrumb-bar-info">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 col-12">
                            <div class="breadcrumb-list">
                                <h2 class="breadcrumb-title">ViewCV</h2>
                                <nav aria-label="breadcrumb" class="page-breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="index-2.html">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">ViewCV</li>
                                    </ol>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="page-content">
                <div class="container">
                    <div class="row">

                        <!-- sidebar -->
                        <div class="col-xl-3 col-lg-3 theiaStickySidebar">

                            <div class="settings-widget account-settings">
                                <div class="settings-menu">
                                    <h3>Dashboard</h3>
                                    <ul>
                                        <li class="nav-item">
                                            <a href="/../HAPPYorSAD/ProfileServlet" class="nav-link">
                                                <i class="bx bxs-tachometer"></i>Profile
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="/../HAPPYorSAD/SetSlot" class="nav-link">
                                                <i class="bx bxs-tachometer"></i>Schedule
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="Notifications" class="nav-link">
                                                <i class="bx bxs-bell"></i>Notifications
                                            </a>
                                        </li>
                                    </ul>
                                    <h3>Instructor</h3>
                                    <ul>
                                        <li class="nav-item active">
                                            <a href="/../HAPPYorSAD/ViewCV" class="nav-link ">
                                                <i class="bx bxs-rocket"></i>Curriculum Vitae
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="/../HAPPYorSAD/viewRequest" class="nav-link">
                                                <i class="bx bxs-graduation"></i>Inviting Request
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="/../HAPPYorSAD/Attendance" class="nav-link">
                                                <i class="bx bxs-graduation"></i>Attendance
                                            </a>
                                        </li>
                                    </ul>
                                    <h3>Account Settings</h3>
                                    <ul>
                                        <li class="nav-item">
                                            <a href="updatementorprofile?username=${sessionScope.usernameUser}" class="nav-link ">
                                                <i class="bx bxs-cog"></i>Settings
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="LoginUser?service=logout" class="nav-link">
                                                <i class="bx bxs-log-out"></i>Logout
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-9 col-lg-9">	

                            <div class="settings-widget card-details mb-0">
                                <div class="settings-menu p-0">

                                    <div class="checkout-form personal-address">
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <c:set var="cvStatus" value="${sessionScope.cvStatus}"/>
                                                <c:choose>
                                                    <c:when test="${sessionScope.cvStatus eq 'Pending'}">
                                                        <button type="button" class="btn btn-warning">Status: Pending</button>
                                                    </c:when>
                                                    <c:when test="${sessionScope.cvStatus eq 'approved'}">
                                                        <button type="button" class="btn btn-success">Status: Approved</button>
                                                    </c:when>
                                                    <c:when test="${sessionScope.cvStatus eq 'rejected'}">
                                                        <button type="button" class="btn btn-danger">Status: Rejected</button>
                                                    </c:when>
                                                    <c:when test="${sessionScope.cvStatus eq 'draft'}">
                                                        <button type="button" class="btn btn-secondary">Status: Draft</button>
                                                    </c:when>
                                                </c:choose>
                                                <form action="ViewCV" method="get">
                                                    <!-- Personal Information -->
                                                    <div class="contact-info">

                                                        <h3>Information</h3>
                                                        <hr>
                                                        <ul>
                                                            <li>
                                                                <span class="icon">Account name 👤:</span>
                                                                <span class="text">${sessionScope.usernameUser}</span>
                                                            </li>
                                                            <li>
                                                                <span class="icon">Full name 📛:</span>
                                                                <span class="text">${mentor.fullname}</span>
                                                            </li>
                                                            <li>
                                                                <span class="icon">Phone 📱:</span>
                                                                <span class="text">${mentor.phoneNumber}</span>
                                                            </li>
                                                            <li>
                                                                <span class="icon">Date of Birth 🎂:</span>
                                                                <span class="text">${mentor.dateOfBirth}</span>
                                                            </li>
                                                            <li>
                                                                <span class="icon">Gmail 📧:</span>
                                                                <span class="text">${mentor.email}</span>
                                                            </li>
                                                            <li>
                                                                <span class="icon">Gender ⚧:</span>
                                                                <span class="text">${mentor.gender}</span>
                                                            </li>
                                                            <li>
                                                                <span class="icon">Address 📍:</span>
                                                                <span class="text">${mentor.address}</span>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                    <!-- Profession and Courses -->
                                                    <div class="input-block">
                                                        <label>Summary  of Myself</label>
                                                        <textarea name="profession" rows="3" readonly>${cv.profession}</textarea>
                                                    </div>
                                                    <div class="input-block">
                                                        <label>Skills</label>
                                                        <textarea name="professionIntro" rows="3" readonly>${cv.professionIntro}</textarea>
                                                    </div>
                                                    <div class="input-block">
                                                        <label>Experience</label>
                                                        <textarea name="serviceDescription" rows="3" readonly>${cv.serviceDescription}</textarea>
                                                    </div>
                                                    <div class="input-block">
                                                        <label>Education</label>
                                                        <textarea name="achievementDescription" rows="3" readonly>${cv.achievementDescription}</textarea>
                                                    </div>

                                                    <c:set var="cvStatus" value="${sessionScope.cvStatus}" />
                                                    <div class="input-block">
                                                        <label>Major I Can Teach</label>
                                                        <div class="checkbox-group">
                                                            <c:set var="selectedCourses" value="${requestScope.selectedCourses}" />
                                                            <c:set var="coursesList" value="Computer Science,Data Science,Business Administration,Graphic Design,Mechanical Engineering"/>

                                                            <c:forEach var="course" items="${fn:split(coursesList, ',')}">
                                                                <c:set var="isChecked" value="${selectedCourses.contains(course)}" />

                                                                <input type="checkbox" id="${course}" name="courses" value="${course}" 
                                                                       <c:if test="${cvStatus ne 'approved'}">disabled</c:if> 
                                                                       <c:if test="${isChecked}">checked</c:if> >

                                                                       <label for="${course}" style="
                                                                       <c:if test='${cvStatus ne "approved"}'>pointer-events: none; opacity: 0.5;</c:if>"
                                                                       onclick="<c:if test='${cvStatus eq "approved"}'>loadCourses('${course}')</c:if>">
                                                                    ${course}
                                                                </label>
                                                            </c:forEach>
                                                        </div>
                                                    </div>
                                                    <input type="hidden" name="username" value="${sessionScope.usernameUser}">

                                                </form>
                                                <div id="coursePopup" class="popup">
                                                    <div class="popup-content">
                                                        <span class="close-btn" onclick="closePopup()">&times;</span>
                                                        <h3>Select Courses to Teach</h3>
                                                        <form action="ViewCV" method="get">
                                                            <div id="courseList"></div> <!-- Danh sách các khóa học sẽ được AJAX điền vào đây -->
                                                            <button type="submit">Save</button>
                                                        </form>
                                                    </div>
                                                </div>
                                                <c:if test="${not empty requestScope.successMessage}">
                                                    <div class="alert success">
                                                        ${requestScope.successMessage}
                                                    </div>
                                                </c:if>

                                                <c:if test="${not empty requestScope.errorMessage}">
                                                    <div class="alert error">
                                                        ${requestScope.errorMessage}
                                                    </div>
                                                </c:if>
                                                <style>
                                                    /* Style cho popup container */
                                                    .popup {
                                                        display: none; /* Ẩn mặc định */
                                                        position: fixed;
                                                        top: 0;
                                                        left: 0;
                                                        width: 100%;
                                                        height: 100%;
                                                        background-color: rgba(0, 0, 0, 0.5); /* Nền mờ */
                                                        z-index: 1000;
                                                        justify-content: center;
                                                        align-items: center;
                                                    }

                                                    /* Style cho nội dung popup */
                                                    .popup-content {
                                                        background-color: white;
                                                        padding: 20px;
                                                        border-radius: 8px;
                                                        width: 90%;
                                                        max-width: 500px;
                                                        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                                                        position: relative;
                                                        animation: popupFadeIn 0.3s ease-in-out;
                                                    }

                                                    /* Hiệu ứng xuất hiện */
                                                    @keyframes popupFadeIn {
                                                        from {
                                                            opacity: 0;
                                                            transform: translateY(-20px);
                                                        }
                                                        to {
                                                            opacity: 1;
                                                            transform: translateY(0);
                                                        }
                                                    }

                                                    /* Style cho nút đóng */
                                                    .close-btn {
                                                        position: absolute;
                                                        top: 10px;
                                                        right: 15px;
                                                        font-size: 24px;
                                                        color: #666;
                                                        cursor: pointer;
                                                        transition: color 0.3s;
                                                    }

                                                    .close-btn:hover {
                                                        color: #000;
                                                    }

                                                    /* Style cho tiêu đề */
                                                    h3 {
                                                        margin: 0 0 20px 0;
                                                        color: #333;
                                                        font-size: 24px;
                                                        font-weight: 600;
                                                    }

                                                    /* Style cho danh sách khóa học */
                                                    #courseList {
                                                        max-height: 300px;
                                                        overflow-y: auto;
                                                        margin-bottom: 20px;
                                                        padding: 10px;
                                                        border: 1px solid #ddd;
                                                        border-radius: 4px;
                                                    }

                                                    /* Style cho form */
                                                    form {
                                                        display: flex;
                                                        flex-direction: column;
                                                        gap: 15px;
                                                    }

                                                    /* Style cho nút Save */
                                                    button[type="submit"] {
                                                        background-color: #007bff;
                                                        color: white;
                                                        padding: 10px 20px;
                                                        border: none;
                                                        border-radius: 4px;
                                                        cursor: pointer;
                                                        font-size: 16px;
                                                        transition: background-color 0.3s;
                                                    }

                                                    button[type="submit"]:hover {
                                                        background-color: #0056b3;
                                                    }

                                                    /* Style cho thông báo */
                                                    .alert {
                                                        padding: 10px;
                                                        margin: 10px 0;
                                                        border-radius: 4px;
                                                        font-size: 16px;
                                                        text-align: center;
                                                    }

                                                    /* Style cho thông báo thành công */
                                                    .alert.success {
                                                        background-color: #28a745; /* Màu xanh lá */
                                                        color: white;
                                                    }

                                                    /* Style cho thông báo lỗi */
                                                    .alert.error {
                                                        background-color: #dc3545; /* Màu đỏ */
                                                        color: white;
                                                    }

                                                    /* Responsive design */
                                                    @media (max-width: 480px) {
                                                        .popup-content {
                                                            width: 95%;
                                                            padding: 15px;
                                                        }

                                                        h3 {
                                                            font-size: 20px;
                                                        }

                                                        button[type="submit"] {
                                                            padding: 8px 15px;
                                                            font-size: 14px;
                                                        }

                                                        .alert {
                                                            font-size: 14px;
                                                            padding: 8px;
                                                        }
                                                    }
                                                </style>

                                                <script>
                                                    function loadCourses(majorName) {
                                                        console.log("Clicked major:", majorName); // Kiểm tra sự kiện click có chạy không

                                                        let xhr = new XMLHttpRequest();
                                                        xhr.open("GET", "getCoursesByMajorServlet?major=" + encodeURIComponent(majorName), true);

                                                        xhr.onreadystatechange = function () {
                                                            if (xhr.readyState == 4) {
                                                                console.log("Server response:", xhr.responseText); // Xem server có trả về gì không
                                                                if (xhr.status == 200) {
                                                                    document.getElementById("courseList").innerHTML = xhr.responseText;
                                                                    document.getElementById("coursePopup").style.display = "block";
                                                                } else {
                                                                    console.error("Error fetching courses");
                                                                }
                                                            }
                                                        };

                                                        xhr.send();
                                                    }
                                                    document.addEventListener("DOMContentLoaded", function () {
                                                        let closeBtn = document.querySelector(".close-btn");
                                                        let modal = document.getElementById("coursePopup");

                                                        if (closeBtn && modal) {
                                                            closeBtn.addEventListener("click", function () {
                                                                modal.style.display = "none";
                                                            });
                                                        }
                                                    });
                                                </script>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%@include file="../sourcesHome/homeFooter.jsp" %>

            </div>
        </div>
        <!-- /Footer -->

        <!-- /Main Wrapper -->

        <!-- jQuery -->
        <script data-cfasync="false" src="../cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script><script src="assets/js/jquery-3.7.1.min.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

        <!-- Bootstrap Core JS -->
        <script src="assets/js/bootstrap.bundle.min.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

        <!-- Select2 JS -->
        <script src="assets/plugins/select2/js/select2.min.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

        <!-- Ckeditor JS -->
        <script src="assets/js/ckeditor.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

        <!-- Dropzone JS -->
        <script src="assets/plugins/dropzone/dropzone.min.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

        <!-- Sticky Sidebar JS -->
        <script src="assets/plugins/theia-sticky-sidebar/ResizeSensor.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>
        <script src="assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

        <!-- Custom JS -->
        <script src="assets/js/script.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

        <script src="../cdn-cgi/scripts/7d0fa10a/cloudflare-static/rocket-loader.min.js" data-cf-settings="27bb6e11b88bb1c6a1b7b5ff-|49" defer></script><script defer src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015" integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ==" data-cf-beacon='{"rayId":"9107445c681fe2ec","version":"2025.1.0","serverTiming":{"name":{"cfExtPri":true,"cfL4":true,"cfSpeedBrain":true,"cfCacheStatus":true}},"token":"3ca157e612a14eccbb30cf6db6691c29","b":1}' crossorigin="anonymous"></script>

    </body>
</html>
