<%-- 
    Document   : addCV
    Created on : Jan 22, 2025, 5:24:55 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../css/cssCRUD/addCV.css">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="CVURL" method="post">
            <input type="hidden" name="service" value="addCV">
            <table>
                <caption>Add CV</caption>
                <tr>
                    <td><label for="ID">CV_ID</label></td>
                    <td><input type="text" name="ID" id="ID" required></td>
                </tr>
                <tr>
                    <td><label for="UserID">User_ID</label></td>
                    <td><input type="text" name="UserID" id="UserID"></td>
                </tr>
                <tr>
                    <td><label for="FilePath">File path</label></td>
                    <td><input type="text" name="FilePath" id="FilePath"></td>
                </tr>
                <tr>
                    <td><label for="Status">Status</label></td>
                    <td><input type="text" name="Status" id="Status"></td>
                </tr>
                <tr>
                    <td><label for="ValidFrom">Valid from</label></td>
                    <td><input type="text" name="ValidFrom" id="ValidFrom"></td>
                </tr>
                <tr>
                    <td><label for="ValidUntil">Valid until</label></td>
                    <td><input type="text" name="ValidUntil" id="ValidUntil"></td>
                </tr>
                <tr>
                    <td><label for="CreateAt">Created at</label></td>
                    <td><input type="text" name="CreateAt" id="CreateAt"></td>
                </tr>
                <tr>
                    <td><label for="UpdateAt">Updated at</label></td>
                    <td><input type="text" name="UpdateAt" id="UpdateAt"></td>
                </tr>
                <tr>
                    <td><input type="submit" value="addCV" name="submit"></td>
                    <td><input type="reset" value="Clear"></td>
                </tr>
            </table>
        </form>
    </body>
</html>
