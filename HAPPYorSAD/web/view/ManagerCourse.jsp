<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>Dreams LMS</title>
        <!-- Favicon -->
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.svg">

        <!-- Theme Settings Js -->
        <script src="assets/js/theme-script.js" type="27bb6e11b88bb1c6a1b7b5ff-text/javascript"></script>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">

        <!-- Fontawesome CSS -->
        <link rel="stylesheet" href="assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="assets/plugins/fontawesome/css/all.min.css">

        <!-- Feather CSS -->
        <link rel="stylesheet" href="assets/css/feather.css">

        <!-- Select2 CSS -->
        <link rel="stylesheet" href="assets/plugins/select2/css/select2.min.css">

        <!-- Dropzone -->
        <link rel="stylesheet" href="assets/plugins/dropzone/dropzone.min.css">

        <!-- Boxioons CSS -->
        <link rel="stylesheet" href="assets/plugins/boxicons/css/boxicons.min.css">

        <link href="../css/cssCourseManager/CourseManager.css" rel="stylesheet" type="text/css"/>
        <!-- Main CSS -->
        <link rel="stylesheet" href="assets/css/style.css">
    </head>
    <body>

        <!-- Main Wrapper -->
        <div class="main-wrapper">
            <!-- Header -->
            <%@include file="/../sourcesHome/homeHeader.jsp" %>
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

                        <!-- sidebar -->
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
                                            <a href="instructor-wishlist.html" class="nav-link">
                                                <i class="bx bxs-heart"></i>Wishlist
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="instructor-reviews.html" class="nav-link">
                                                <i class="bx bxs-star"></i>Reviews
                                            </a>
                                        </li>

                                        <li class="nav-item">
                                            <a href="instructor-referral.html" class="nav-link">
                                                <i class="bx bxs-user-plus"></i>Referrals
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
                            <div class="d-flex justify-content-end">
                                <a href="CreateCourses" class="btn btn-success">Add New Course</a>
                            </div>
                            <div class="checkout-form">
                                <div class="table-responsive custom-table">

                                    <table class="table table-nowrap mb-0">
                                        <tr>
                                            <th>No.</th>
                                            <th>Course ID</th>
                                            <th>Course Name</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>


                                        <c:forEach items="${sessionScope.listAllCourse}" var="o" varStatus="status1">
                                            <tr>
                                                <td><div class="STT text-center"> <h6>${status1.index + 1}</h6></div></td>
                                                <td>${o.id}</td>
                                                <td>${o.title}</td>
                                                <td>
                                                    <div style="background-color: ${o.status == 'active' ? '#28a745' : '#dc3545'};
                                                         color: white; padding: 8px 12px; border-radius: 5px; display: inline-block;">
                                                        ${o.status}
                                                    </div>
                                                </td>
                                                <td>
                                                    <button onclick="showEditForm('${o.id}', '${o.title}', '${o.status}')" class="resut-badge badge-light-danger approve">Edit</button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <!-- Overlay for Edit Form -->
                        <div class="overlay" id="editFormOverlay" style="display: none;">
                            <div class="form-container">
                                <h3>Edit Course</h3>
                                <form action="UpdateCourse" method="post">
                                    <input type="hidden" id="editId" name="id">

                                    <label for="editName">Title</label>
                                    <input type="text" id="editName" name="title" placeholder="Course Name" required>

                                    <select id="editStatus" name="status"> 
                                        <option value="active" selected>Active</option>
                                        <option value="Inactive" selected>Inactive</option>
                                    </select>

                                    <button type="submit" class="btn-save">OK</button>
                                    <button type="button" class="btn-delete" onclick="hideEditForm()">Cancel</button>
                                </form>
                            </div>
                        </div>
                        <!-- Overlay for Edit Form -->
                        <div class="overlay" id="editFormOverlay1" style="display: none;">
                            <div class="form-container">
                                <h3>Edit Course</h3>
                                <form action="UpdateCourse" method="post">
                                    <input type="hidden" id="editId1" name="id">

                                    <label for="editName">Title</label>
                                    <input type="text" id="editName1" name="title" placeholder="Course Name" required readonly>


                                    <select id="editStatus1" name="status"> 
                                        <option value="active" selected>Active</option>
                                        <option value="Inactive" selected>Inactive</option>
                                    </select>

                                    <button type="submit" class="btn-save">OK</button>
                                    <button type="button" class="btn-delete" onclick="hideEditForm()">Cancel</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <script>

                function showEditForm(id, name, status) {
                    document.getElementById("editFormOverlay").style.display = "flex";
                    document.body.classList.add("overlay-active");

                    document.getElementById("editId").value = id;
                    document.getElementById("editName").value = name;

                    let statusSelect = document.getElementById("editStatus");
                    statusSelect.value = status.toLowerCase();
                }

                function showEditForm1(id, name, status) {
                    document.getElementById("editFormOverlay1").style.display = "flex";
                    document.body.classList.add("overlay-active");

                    document.getElementById("editId1").value = id;
                    document.getElementById("editName1").value = name;

                    let statusSelect = document.getElementById("editStatus1");
                    statusSelect.value = status.toLowerCase();
                }

                function hideEditForm() {
                    document.getElementById("editFormOverlay").style.display = "none";
                    document.body.classList.remove("overlay-active");
                }
                function toggleState(courseId) {
                    var button = document.getElementById("toggleButton" + courseId);
                    if (button.innerText === "active") {
                        button.innerText = "Inactive";
                        button.classList.add("Inactive");
                    } else {
                        button.innerText = "active";
                        button.classList.remove("Inactive");
                    }
                }

            </script>
        </div>
    </body>
</html>