package controller;

import model.DAOMentor;
import entity.Mentor;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.DBConnection;

@WebServlet("/viewMentors")
public class ViewMentor extends DBConnection {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String search = request.getParameter("search");
        if (search == null) search = "";

        try {

            DAOMentor DAOmentor = new DAOMentor();
            List<Mentor> mentors = DAOmentor.getMentors(search);

            request.setAttribute("mentors", mentors);
            request.getRequestDispatcher("view/ViewMentor.jsp").forward(request, response);

            conn.close();
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
