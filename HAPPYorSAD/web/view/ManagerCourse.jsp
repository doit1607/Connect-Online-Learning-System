<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Course Manager</title>

        <link rel="stylesheet" href="../css/cssCourseManager/CourseManager.css">
    </head>
    <body>
        <div class="container">
            <h1>Course List</h1>
            <button class="btn-add" onclick="showAddForm()">Add New</button>
            <table>
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Course ID</th>
                        <th>Course Title</th>
                        <th>Description</th>
                        <th>Manager ID</th>
                        <th>Mentor ID</th>
                        <th>Created At</th>
                        <th>Updated At</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Dynamic rows will be inserted here -->
                    <tr>
                        <td>1</td>
                        <td>COURSE1</td>
                        <td>Java Basics</td>
                        <td>Introduction to Java</td>
                        <td>101</td>
                        <td>201</td>
                        <td>2025-01-01 10:00:00</td>
                        <td>2025-01-15 14:00:00</td>
                        <td>
                            <button class="btn-edit" onclick="showEditForm(1, 'Course 1', 'Sample description', 101, 201, 301)">Edit</button>
                            <button class="btn-delete">Delete</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!--         Hidden Form 
                <div class="form-container" id="addForm" style="display: none;">
                    <form>
                        <label for="title">Title</label>
                        <input type="text" id="title" name="title" placeholder="Course Title" required>
        
                        <label for="description">Description</label>
                        <textarea id="description" name="description" rows="4" placeholder="Course Description" required></textarea>
        
                        <label for="manager">Manager ID</label>
                        <input type="number" id="manager" name="manager" placeholder="Manager ID" required>
        
                        <label for="mentor">Mentor ID</label>
                        <input type="number" id="mentor" name="mentor" placeholder="Mentor ID" required>
        
                        <label for="courseMajor">Course Major ID</label>
                        <input type="number" id="courseMajor" name="courseMajor" placeholder="Course Major ID" required>
        
                        <button type="submit" class="btn-save">Save</button>
                        <button type="button" class="btn-delete" onclick="hideForm()">Cancel</button>
                    </form>
                </div>
        
                 Edit Form 
                <div class="form-container" id="editForm" style="display: none;">
                    <h3>Edit Course</h3>
                    <form>
                        <label for="editTitle">Title</label>
                        <input type="text" id="editTitle" name="title" placeholder="Course Title" required>
        
                        <label for="editDescription">Description</label>
                        <textarea id="editDescription" name="description" rows="4" placeholder="Course Description" required></textarea>
        
                        <label for="editManager">Manager ID</label>
                        <input type="number" id="editManager" name="manager" placeholder="Manager ID" required>
        
                        <label for="editMentor">Mentor ID</label>
                        <input type="number" id="editMentor" name="mentor" placeholder="Mentor ID" required>
        
                        <label for="editCourseMajor">Course Major ID</label>
                        <input type="number" id="editCourseMajor" name="courseMajor" placeholder="Course Major ID" required>
        
                        <button type="submit" class="btn-save">Save</button>
                        <button type="button" class="btn-delete" onclick="hideEditForm()">Cancel</button>
                    </form>
                </div>-->
        <!-- Overlay for Add Form -->
        <div class="overlay" id="addFormOverlay" style="display: none;">
            <div class="form-container">
                <h3>Add New Course</h3>
                <form>
                    <label for="addTitle">Title</label>
                    <input type="text" id="addTitle" name="title" placeholder="Course Title" required>

                    <label for="addDescription">Description</label>
                    <textarea id="addDescription" name="description" rows="4" placeholder="Course Description" required></textarea>

                    <label for="addManager">Manager ID</label>
                    <input type="number" id="addManager" name="manager" placeholder="Manager ID" required>

                    <label for="addMentor">Mentor ID</label>
                    <input type="number" id="addMentor" name="mentor" placeholder="Mentor ID" required>

                    <label for="addCourseMajor">Course Major ID</label>
                    <input type="number" id="addCourseMajor" name="courseMajor" placeholder="Course Major ID" required>

                    <button type="submit" class="btn-save">Save</button>
                    <button type="button" class="btn-delete" onclick="hideAddForm()">Cancel</button>
                </form>
            </div>
        </div>

        <!-- Overlay for Edit Form -->
        <div class="overlay" id="editFormOverlay" style="display: none;">
            <div class="form-container">
                <h3>Edit Course</h3>
                <form>
                    <label for="editTitle">Title</label>
                    <input type="text" id="editTitle" name="title" placeholder="Course Title" required>

                    <label for="editDescription">Description</label>
                    <textarea id="editDescription" name="description" rows="4" placeholder="Course Description" required></textarea>

                    <label for="editManager">Manager ID</label>
                    <input type="number" id="editManager" name="manager" placeholder="Manager ID" required>

                    <label for="editMentor">Mentor ID</label>
                    <input type="number" id="editMentor" name="mentor" placeholder="Mentor ID" required>

                    <label for="editCourseMajor">Course Major ID</label>
                    <input type="number" id="editCourseMajor" name="courseMajor" placeholder="Course Major ID" required>

                    <button type="submit" class="btn-save">Save</button>
                    <button type="button" class="btn-delete" onclick="hideEditForm()">Cancel</button>
                </form>
            </div>
        </div>

        <script>
            function showAddForm() {
                document.getElementById("addFormOverlay").style.display = "flex";
                document.body.classList.add("overlay-active");
            }

            function hideAddForm() {
                document.getElementById("addFormOverlay").style.display = "none";
                document.body.classList.remove("overlay-active");
            }

            function showEditForm(id, title, description, managerId, mentorId, courseMajorId) {
                
                document.getElementById("editFormOverlay").style.display = "flex";
                document.body.classList.add("overlay-active");

               
                document.getElementById("editTitle").value = title;
                document.getElementById("editDescription").value = description;
                document.getElementById("editManager").value = managerId;
                document.getElementById("editMentor").value = mentorId;
                document.getElementById("editCourseMajor").value = courseMajorId;
            }

            function hideEditForm() {
                document.getElementById("editFormOverlay").style.display = "none";
                document.body.classList.remove("overlay-active");
            }
        </script>



    </body>
</html>
