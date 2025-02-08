<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Course Manager</title>

        <link rel="stylesheet" href="css/cssCourseManager/CourseManager.css">
        <link rel="stylesheet" href="css/cssHome/homeHeader.css">       
        <link rel="stylesheet" href="css/cssHome/homeFooter.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    </head>
    <body>
         <%@include file="../sourcesHome/homeHeader.jsp" %>
        <div class="container">
            <h1>Course List</h1>
            <button class="btn-add" onclick="">Add New</button>
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
                            <td>${status1.index + 1}</td>
                            <td>${o.id}</td>
                            <td>${o.title}</td>
                            <td>
                                <button id="toggleButton${o.id}" class="toggle-btn" onclick="toggleState('${o.id}')">Enable</button>
                            </td>
                            <td>
                                <button class="btn-edit" onclick="showEditForm('${o.title}')">Edit</button>
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
                <form>
                    <label for="editName">Title</label>
                    <input type="text" id="editName" name="name" placeholder="Course Name" required>

                    <label for="status">Status</label>
                    <select id="status" class="status-select">
                        <option value="enable">Enable</option>
                        <option value="disable">Disable</option>
                    </select>

                    <button type="submit" class="btn-save">OK</button>
                    <button type="button" class="btn-delete" onclick="hideEditForm()">Cancel</button>
                </form>
            </div>
        </div>

        <script>

            function showEditForm(name) {

                document.getElementById("editFormOverlay").style.display = "flex";
                document.body.classList.add("overlay-active");


                document.getElementById("editName").value = name;
                const statusSelect = document.getElementById("status");
                statusSelect.value = status;

            }

            function hideEditForm() {
                document.getElementById("editFormOverlay").style.display = "none";
                document.body.classList.remove("overlay-active");
            }
            function toggleState(courseId) {
                var button = document.getElementById("toggleButton" + courseId);
                if (button.innerText === "Enable") {
                    button.innerText = "Disable";
                    button.classList.add("disabled");
                } else {
                    button.innerText = "Enable";
                    button.classList.remove("disabled");
                }
            }

        </script>
         <%@include file="../sourcesHome/homeFooter.jsp" %>
    </body>
</html>
