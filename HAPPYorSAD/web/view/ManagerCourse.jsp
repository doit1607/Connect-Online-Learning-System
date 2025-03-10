<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>Dreams LMS</title>

        <!-- Favicon -->
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
        <<link rel="stylesheet" href="/HAPPYorSAD/css/cssCourseManager/CourseManager.css"/>
        <script data-cfasync="false" src="/HAPPYorSAD/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script><script src="/HAPPYorSAD/assets/js/jquery-3.7.1.min.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

        <!-- Bootstrap Core JS -->
        <script src="/HAPPYorSAD/assets/js/bootstrap.bundle.min.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

        <!-- Select2 JS -->
        <script src="/HAPPYorSAD/assets/plugins/select2/js/select2.min.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

        <!-- Ckeditor JS -->
        <script src="/HAPPYorSAD/assets/js/ckeditor.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

        <!-- Dropzone JS -->
        <script src="/HAPPYorSAD/assets/plugins/dropzone/dropzone.min.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

        <!-- Sticky Sidebar JS -->
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/ResizeSensor.js" type="d693b69077856eb34d3f2643-text/javascript"></script>
        <script src="/HAPPYorSAD/assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js" type="d693b69077856eb34d3f2643-text/javascript"></script>

        <!-- Custom JS -->
        <script src="/HAPPYorSAD/assets/js/script.js" type="d693b69077856eb34d3f2643-text/javascript"></script>
        <script src="/HAPPYorSAD/cdn-cgi/scripts/7d0fa10a/cloudflare-static/rocket-loader.min.js" 
        data-cf-settings="d693b69077856eb34d3f2643-|49" defer></script>
        <script defer src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015" integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ==" data-cf-beacon='{"rayId":"91074a70ad7f06b9","version":"2025.1.0","serverTiming":{"name":{"cfExtPri":true,"cfL4":true,"cfSpeedBrain":true,"cfCacheStatus":true}},"token":"3ca157e612a14eccbb30cf6db6691c29","b":1}' crossorigin="anonymous"></script>
        <style>
            /* Overlay background */
            .overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5); /* Làm m? n?n */
                display: flex;
                align-items: center;
                justify-content: center;
                z-index: 9999;
            }

            /* Form container */
            .form-container {
                background-color: #ffffff;
                padding: 20px;
                width: 50%;
                border-radius: 8px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            }

            /* Tiêu ?? form */
            .form-container h2 {
                text-align: center;
                font-size: 20px;
                margin-bottom: 15px;
                color: #333;
            }

            /* Label */
            .form-container label {
                font-size: 14px;
                color: #555;
                margin-bottom: 5px;
                display: block;
            }

            /* Input fields và select */
            .form-container input[type="text"],
            .form-container input[type="number"],
            .form-container input[type="file"],
            .form-container textarea,
            .form-container select {
                width: 100%;
                padding: 8px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 14px;
                box-sizing: border-box;
                transition: border-color 0.2s ease;
            }

            /* Focus effect */
            .form-container input:focus,
            .form-container textarea:focus,
            .form-container select:focus {
                border-color: #007bff;
            }

            /* Nút b?m */
            .form-container button {
                width: 100%;
                padding: 10px;
                font-size: 14px;
                color: #fff;
                border: none;
                border-radius: 4px;
                margin-top: 10px;
                cursor: pointer;
                transition: background-color 0.2s ease;
            }

            /* Nút L?u */
            .form-container button[type="submit"] {
                background-color: #28a745;
            }

            .form-container button[type="submit"]:hover {
                background-color: #218838;
            }

            /* Nút H?y */
            .form-container .btn-cancel {
                background-color: #dc3545;
            }

            .form-container .btn-cancel:hover {
                background-color: #c82333;
            }

        </style>
    </head>
    <body>

        <!-- Main Wrapper -->
        <div class="main-wrapper">
            <!-- Header -->
            <%@include file="/../sourcesHome/headerManager.jsp" %>
            <!-- /Header -->
            <!-- Breadcrumb -->
            <div class="breadcrumb-bar breadcrumb-bar-info">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 col-12">
                            <div class="breadcrumb-list">
                                <h2 class="breadcrumb-title">Manager</h2>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /Breadcrumb -->	

            <!-- Page Content -->
            <div class="page-content">
                <div class="container">
                    <div class="row">

                        <div class="col-xl-3 col-lg-3 theiaStickySidebar">
                            <div class="settings-widget account-settings">
                                <div class="settings-menu">
                                    <h3>Dashboard</h3>
                                    <ul>
                                        <li class="nav-item ">
                                            <a href="/../HAPPYorSAD/AcceptCV" class="accept-cv">
                                                <i class="fas fa-user"></i>Manage CV
                                            </a>
                                        <li class="nav-item active">
                                            <a href="CourseManager" class="nav-link">
                                                <i class="bx bxs-graduation"></i>Manage Course
                                            </a>
                                        </li>

                                        <li class="nav-item">
                                            <a href="ShowAllRequest" class="nav-link">
                                                <i class="bx bxs-heart"></i>Request of Mentee
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="instructor-reviews.html" class="nav-link">
                                                <i class="bx bxs-star"></i>Reviews
                                            </a>
                                        </li>

                                        <li class="nav-item">
                                            <a href="menteestatistic" class="nav-link">
                                                <i class="bx bxs-user-plus"></i>Static Mentee
                                            </a>
                                        </li>

                                        <li class="nav-item">
                                            <a href="instructor-notifications.html" class="nav-link">
                                                <i class="bx bxs-bell"></i>Notifications
                                            </a>
                                        </li>

                                    </ul>

                                    <ul>
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
                            <h1>Course List</h1>

                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <form action="SearchCourse" method="get" class="d-flex "> 
                                    <input name="txt" type="text" id="searchInput" class="form-control me-2" style="max-width: 250px;" placeholder="Enter Course Name...">
                                     <button type="submit" class="btn btn-primary px-4">Search</button>
                                </form>                             
                               
                            
                                <a href="CreateCourses" class="btn btn-success">Add New Course</a>
                            </div>
                            <div class="checkout-form">
                                <div class="table-responsive custom-table">
                                    <table class="table table-nowrap mb-0">
                                        <tr>
                                            <th>No.</th>
                                            <th>Image</th>
                                            <th>Course Name</th>
                                            <th>Update At</th>
                                            <th>Price</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                        <c:forEach items="${sessionScope.listAllCourse}" var="o" varStatus="status1">
                                            <tr>
                                                <td><div class="STT text-center"> <h6>${status1.index + 1}</h6></div></td>
                                                <td><img  class="img-fluid" alt="Img" src="${o.image}"></td>
                                                <td> 
                                                    <a href="DetailCourseManager?Cid=${o.id}">${o.title}</a>
                                                </td>
                                                <td>${o.updatedAt}</td>
                                                <td>${o.price}</td>
                                                <td>
                                                    <div style="background-color: ${o.status == 'active' ? '#28a745' : '#dc3545'};
                                                         color: white; padding: 8px 12px; border-radius: 5px; display: inline-block;">
                                                        ${o.status}
                                                    </div>
                                                </td>
                                                <td>
                                                    <button onclick="showEditForm('${o.id}', '${o.title}', '${o.description}', '${o.status}', '${o.courseMajorId}', '${o.price}', '${o.image}')" 
                                                            class="resut-badge badge-light-danger approve">Edit</button>

                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </table>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <!-- Pagination -->
                                    <div class="pagination">
                                        <c:if test="${tag > 1}">
                                            <li class="page-item">
                                                <a href="CourseManager?index=${tag-1}" class="page-link">Previous</a>
                                            </li>
                                        </c:if>

                                        <c:forEach begin="1" end="${endPage}" var="i">
                                            <a class="page-link ${tag == i?'active':''}" href="CourseManager?index=${i}">${i}</a>
                                        </c:forEach>

                                        <c:if test="${tag < endPage}">
                                            <li class="page-item">
                                                <a href="CourseManager?index=${tag+1}" class="page-link">Next</a>
                                            </li>
                                        </c:if>
                                    </div>
                                    <!-- /Pagination -->                              
                                </div>
                            </div>
                        </div>
                        <!-- Overlay for Edit Form -->
                        <div class="overlay" id="editFormOverlay" style="display: none;">
                            <div class="form-container">
                                <h2>Update Course</h2>

                                <form action="UpdateCourse" method="post" enctype="multipart/form-data">
                                    <input type="hidden" name="id" >

                                    <label>Title:</label>
                                    <input type="text" name="title" required>

                                    <label>Description:</label>
                                    <textarea name="description" required></textarea>

                                    <label>Status:</label>
                                    <select id="editStatus" name="status"> 
                                        <option value="active" selected>Active</option>
                                        <option value="inactive">Inactive</option>
                                    </select>

                                    <label>Major:</label>
                                    <select name="course_major_id" required>
                                        <c:forEach var="major" items="${listAllMaojor}">
                                            <option value="${major.id}">${major.name}</option>
                                        </c:forEach>
                                    </select>

                                    <label>Price:</label>
                                    <input type="number" name="price" step="0.01" required>

                                    <label>Upload Image:</label>
                                    <input type="file" name="image">

                                    <button type="submit">Update</button>
                                    <button type="button" class="btn-cancel" onclick="hideEditForm()">Cancel</button>
                                </form>

                            </div>
                        </div>
                        <!-- Overlay for Edit Form -->                    
                    </div>
                </div>
            </div>
            <script>

                function showEditForm(id, title, description, status, courseMajorId, price, image) {
                    document.getElementById("editFormOverlay").style.display = "flex";
                    document.body.classList.add("overlay-active");

                    // Gán giá tr? cho các tr??ng trong form
                    document.querySelector("input[name='id']").value = id;
                    document.querySelector("input[name='title']").value = title;
                    document.querySelector("textarea[name='description']").value = description;
                    document.querySelector("select[name='status']").value = status;
                    document.querySelector("select[name='course_major_id']").value = courseMajorId;
                    document.querySelector("input[name='price']").value = price;

                }



                function hideEditForm() {
                    document.getElementById("editFormOverlay").style.display = "none";
                    document.body.classList.remove("overlay-active");
                }

            </script>
        </div>
    </body>
</html>
