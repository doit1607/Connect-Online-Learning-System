<%-- 
    Document   : updateCV
    Created on : Jan 23, 2025, 3:29:52 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Vector, entity.CV"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%
        Vector<CV> vector = 
                (Vector<CV>) request.getAttribute("vector");
        String titlePage = (String) request.getAttribute("titlePage");
        CV cv = vector.get(0);
        %>
    </head>
    <body>
        <form action="CVURL" method="post">
            <input type="hidden" name="service" value="updateCV">
            <table>
                <caption>update CV</caption>
                <tr>
                    <td><label for="ID">CV_ID</label></td>
                    <td><input type="text" name="ID" id="ID" readonly value="<%=cv.getId()%>"></td>
                </tr>
                <tr>
                    <td><label for="UserID">UserID</label></td>
                    <td><input type="text" name="UserID" id="UserID" value="<%=cv.getUserId()%>"></td>
                </tr>
                <tr>
                    <td><label for="FilePath">File path</label></td>
                    <td><input type="text" name="FilePath" id="FilePath" value="<%=cv.getFilePath()%>"></td>
                </tr>
                <tr>
                    <td><label for="Status">Status</label></td>
                    <td><input type="number" name="Status" id="Status" value="<%=cv.getStatus()%>"></td>
                </tr>
                <tr>
                    <td><label for="ValidFrom">Valid from</label></td>
                    <td><input type="text" name="ValidFrom" id="ValidFrom" value="<%=cv.getValidFrom()%>"></td>
                </tr>
                <tr>
                    <td><label for="ValidUntil">ValidUntil</label></td>
                    <td><input type="text" name="ValidUntil" id="ValidUntil" value="<%=cv.getValidUntil()%>"></td>
                </tr>
                <tr>
                    <td><label for="CreateAt">Created at</label></td>
                    <td><input type="text" name="CreateAt" id="CreateAt" value="<%=cv.getCreatedAt()%>"></td>
                </tr>
                <tr>
                    <td><label for="UpdateAt">Updated at</label></td>
                    <td><input type="text" name="UpdateAt" id="UpdateAt" value="<%=cv.getUpdatedAt()%>"></td>
                </tr>
                <tr>
                    <td><input type="submit" value="updateCV" name="submit"></td>
                    <td><input type="reset" value="Clear"></td>
                </tr>
            </table>
        </form>
    </body>
</html>
