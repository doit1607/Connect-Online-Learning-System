<%-- 
    Document   : createCourse
    Created on : Jan 24, 2025, 5:08:45 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Course</title>
    </head>
    <body>
        <form action="CourseURL" method="post">
            <input type="hidden" name="service" value="createCourse">
            <table>
                <caption>Create Course</caption>
                <tr>
                    <td><label for="title">title</label></td>
                    <td><input type="text" name="title" id="title" required></td>
                </tr>
                <tr>
                    <td><label for="description">description</label></td>
                    <td><input type="text" name="description" id="description"></td>
                </tr>
                <tr>
                    <td><label for="courseMajorId">Major ID</label></td>
                    <td><input type="text" name="courseMajorId" id="courseMajorId"></td>
                </tr>
                <tr>
                    <td><input type="submit" value="createCourse" name="submit"></td>
                    <td><input type="reset" value="Clear"></td>
                </tr>
            </table>
        </form>
    </body>
</html>
