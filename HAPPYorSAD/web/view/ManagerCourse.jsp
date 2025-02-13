<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Course Manager</title>
        <<link rel="stylesheet" href="css/cssCourseManager/CourseManager.css"/>
        <link rel="stylesheet" href="css/cssHome/homeHeader.css">       
        <link rel="stylesheet" href="css/cssHome/homeFooter.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    </head>
    <body>
        <%@include file="../sourcesHome/homeHeader.jsp" %>
        <div class="container">
            <h1>Course List</h1>
            <button class="btn-add" ><a href="CreateCourses">Add New</a> </button>
            <table>
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Course ID</th>
                        <th>Course Name</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${sessionScope.listAllCourse}" var="o" varStatus="status1">
                        <tr>
                            <td><div class="STT text-center"> <h6>${status1.index + 1}</h6></div></td>
                            <td>${o.id}</td>
                            <td>${o.title}</td>
                            <td class="${o.status == 'active' ? 'status-active' : 'status-Inactive'}">
                                <button id="toggleButton${o.id}" class="toggle-btn ${o.status == 'active' ? 'active' : 'Inactive'}" 
                                        onclick="showEditForm1('${o.id}', '${o.title}', '${o.status}')">
                                    ${o.status}
                                </button>
                            </td>
                            <td>
                                <button class="btn-edit" onclick="showEditForm('${o.id}', '${o.title}', '${o.status}')">Edit</button>
                            </td>
                        </tr>
                    </c:forEach>


                </tbody>
            </table>
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

<<<<<<< HEAD

                    <select id="editStatus1" name="status"> 
                        <option value="active" selected>Active</option>
                        <option value="Inactive" selected>Inactive</option>
                    </select>

=======
>>>>>>> 31769565b00d063ad4b528560148867133299d69
                    <button type="submit" class="btn-save">OK</button>
                    <button type="button" class="btn-delete" onclick="hideEditForm()">Cancel</button>
                </form>
            </div>
        </div>
<<<<<<< HEAD
=======
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
>>>>>>> 31769565b00d063ad4b528560148867133299d69
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
        <%@include file="../sourcesHome/homeFooter.jsp" %>
    </body>
</html>