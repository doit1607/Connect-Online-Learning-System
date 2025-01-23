<%-- 
    Document   : listCV
    Created on : Jan 23, 2025, 10:46:52 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector, entity.CV"%>
<!DOCTYPE html>
<html>
    <%
        Vector<CV> vector = 
                (Vector<CV>) request.getAttribute("listCV");
        String titlePage = (String)request.getAttribute("titlePage");
    %>  
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=titlePage%></title>
    </head>
    <body>
        <form action="CVURL" method="get">
            <input type="hidden" name="service" value="listAllCV">            
        </form>
        <p><!--<a href = "view/insertCV.jsp">insertCV</a>-->
            <a class="add" href="CVURL?service=addCV">add CV</a></p>
<!--          <a align="right" href="CartURL?service=showCart">show Cart</a>-->
        <table border = 1> 
            <tr>
                <th>CV_ID</th>
                <th>User_ID</th>
                <th>File path</th>
                <th>Status</th>
                <th>Valid from</th>
                <th>Valid Until</th>
                <th>Created at</th>
                <th>Updated at</th>
                <th>update</th>
<!--                <th>add to Cart</th>-->
            </tr>
            <%for (CV cv : vector) {%>
            <tr>
                <td><%=cv.getId()%></td>  
                <td><%=cv.getUserId()%></td>                
                <td><%=cv.getFilePath()%></td>                
                <td><%=cv.getStatus()%></td>                
                <td><%=cv.getValidFrom()%></td>                
                <td><%=cv.getValidUntil()%></td>                
                <td><%=cv.getCreatedAt()%></td>                
                <td><%=cv.getUpdatedAt()%></td>                
                <td><a class="update" href="CVURL?service=updateCV&pid=<%=cv.getId()%>">update</a></td>
            </tr>
            <%}%>
        </table>
    </body>
</html>
