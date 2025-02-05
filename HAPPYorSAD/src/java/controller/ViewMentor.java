package controller;

import model.DAOMentor;
import entity.Mentor;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.List;

@WebServlet("/viewMentors")
public class ViewMentor extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String search = request.getParameter("search");
        if (search == null) search = "";

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection conn = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=HappyProgramming", "sa", "123456");

            DAOMentor DAOmentor = new DAOMentor(conn);
            List<Mentor> mentors = DAOmentor.getMentors(search);

            request.setAttribute("mentors", mentors);
            request.getRequestDispatcher("view/ViewMentor.jsp").forward(request, response);

            conn.close();
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
