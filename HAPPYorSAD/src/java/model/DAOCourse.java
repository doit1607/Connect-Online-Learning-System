/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Course;
import entity.Mentor;
import entity.MentorCourse;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Acer
 */
public class DAOCourse extends DBConnection {

    public List<Course> getAllCourse() {
        ArrayList<Course> listCourse = new ArrayList<>();
        String query = "SELECT [id]\n"
                + "      ,[title]\n"
                + "      ,[description]\n"
                + "      ,[manager_id]\n"
                + "      ,[mentor_id]\n"
                + "      ,[status]\n"
                + "      ,[created_at]\n"
                + "      ,[updated_at]\n"
                + "      ,[course_major_id]\n"
                + "      ,[image]\n"
                + "      ,[price]\n"
                + "  FROM [SWP1].[dbo].[Course]";
        try {
            PreparedStatement connect = conn.prepareStatement(query);
            ResultSet result = connect.executeQuery();
            while (result.next()) {
                int id = result.getInt("id");
                String title = result.getString("title");
                String description = result.getString("description");
                int managerId = result.getInt("manager_id");
                int mentorId = result.getInt("mentor_id");
                LocalDateTime createdAt = result.getTimestamp("created_at").toLocalDateTime();
                LocalDateTime updatedAt = result.getTimestamp("updated_at").toLocalDateTime();
                int courseMajorId = result.getInt("course_major_id");
                String status = result.getString("status");
                String image = result.getString("image");
                Double price = result.getDouble("price");
                Course course = new Course(id, title, description, managerId, mentorId, status, createdAt, updatedAt, courseMajorId, image, price);
                listCourse.add(course);
            }
            result.close();
            connect.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listCourse;
    }

    public String getCourseName(int id) {
        String name = null;
        String sql = "Select * from Course where id = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                name = rs.getString("title");
                return name;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return name;
    }

    public void createCourse(String title, String description, int majorId, String image) {
        String sql = "INSERT INTO [dbo].[Course] ([title], [description], [status], [course_major_id], [image]) "
                + "VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, title);
            pre.setString(2, description);
            pre.setString(3, "active");
            pre.setInt(4, majorId);
            pre.setString(5, image);
            pre.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Course> getAllCourseOrderByName() {
        ArrayList<Course> listCourse = new ArrayList<>();
        String query = "SELECT [id]\n"
                + "      ,[title]\n"
                + "      ,[description]\n"
                + "      ,[manager_id]\n"
                + "      ,[mentor_id]\n"
                + "      ,[status]\n"
                + "      ,[created_at]\n"
                + "      ,[updated_at]\n"
                + "      ,[course_major_id]\n"
                + "      ,[image]\n"
                + "      ,[price]\n"
                + "  FROM [SWP1].[dbo].[Course]\n"
                + "  order by [title]";
        try {
            PreparedStatement connect = conn.prepareStatement(query);
            ResultSet result = connect.executeQuery();
            while (result.next()) {
                int id = result.getInt("id");
                String title = result.getString("title");
                String description = result.getString("description");
                int managerId = result.getInt("manager_id");
                int mentorId = result.getInt("mentor_id");
                LocalDateTime createdAt = result.getTimestamp("created_at").toLocalDateTime();
                LocalDateTime updatedAt = result.getTimestamp("updated_at").toLocalDateTime();
                int courseMajorId = result.getInt("course_major_id");
                String status = result.getString("status");
                String image = result.getString("image");
                Double price = result.getDouble("price");

                Course course = new Course(id, title, description, managerId, mentorId, status, createdAt, updatedAt, courseMajorId, image, price);
                listCourse.add(course);
            }
            result.close();
            connect.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listCourse;
    }

    public List<Course> getAllCourseHome() {
        ArrayList<Course> listCourseHome = new ArrayList<>();
        String query = "Select  c.id,c.title, cm.name as CourseMajor,c.image,\n"
                + "COUNT(DISTINCT u_mentor.id) AS total_Mentor,\n"
                + "COUNT(DISTINCT u_mentee.id) AS total_Mentee\n"
                + "From Course c\n"
                + "Join CourseMajor cm on c.course_major_id = cm.id\n"
                + "left join Users u_mentor on c.mentor_id = u_mentor.id AND u_mentor.role = 'mentor'\n"
                + "LEFT JOIN Users u_mentee ON c.mentor_id = u_mentee.id AND u_mentee.role = 'mentee'\n"
                + "GROUP BY c.title, c.image, cm.name,c.id";
        try {
            PreparedStatement connect = conn.prepareStatement(query);
            ResultSet result = connect.executeQuery();
            while (result.next()) {
                int id = result.getInt("id");
                String title = result.getString("title");
                String courseMajor = result.getString("CourseMajor");
                int total_Mentor = result.getInt("total_Mentor");
                int total_Mentee = result.getInt("total_Mentee");
                String image = result.getString("image");
                Course course = new Course(id, title, courseMajor, total_Mentor, total_Mentee, image);
                listCourseHome.add(course);
            }
            result.close();
            connect.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listCourseHome;
    }

    public double getPriceCourse(int id) {
        double price = 0;
        String sql = "Select * from Course where id = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                price = rs.getInt("price");
                return price;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return price;
    }

    public List<Course> getAllCourseHome2() {
        ArrayList<Course> listCourseHome = new ArrayList<>();
        String query = "SELECT TOP 4\n"
                + "    c.title,\n"
                + "	c.image, c.id,\n"
                + "    cm.name as CourseMajor,\n"
                + "    COUNT(DISTINCT CASE WHEN u_mentor.status = 'active' THEN u_mentor.id END) AS total_Mentor,\n"
                + "    COUNT(DISTINCT u_mentee.id) AS total_Mentee\n"
                + "FROM Course c\n"
                + "JOIN CourseMajor cm ON c.course_major_id = cm.id\n"
                + "LEFT JOIN Users u_mentor ON c.mentor_id = u_mentor.id AND u_mentor.role = 'mentor'\n"
                + "LEFT JOIN Users u_mentee ON c.mentor_id = u_mentee.id AND u_mentee.role = 'mentee'\n"
                + "GROUP BY c.title, c.image, cm.name, c.id\n"
                + "ORDER BY total_Mentee DESC;";
        try {
            PreparedStatement connect = conn.prepareStatement(query);
            ResultSet result = connect.executeQuery();
            while (result.next()) {
                int id = result.getInt("id");

                String title = result.getString("title");
                String courseMajor = result.getString("CourseMajor");
                int total_Mentor = result.getInt("total_Mentor");
                int total_Mentee = result.getInt("total_Mentee");
                String image = result.getString("image");
                Course course = new Course(id, title, courseMajor, total_Mentor, total_Mentee, image);
                listCourseHome.add(course);
            }
            result.close();
            connect.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listCourseHome;
    }

    public List<Course> getCountCourseHome() {
        ArrayList<Course> list = new ArrayList<>();
        String query = "SELECT  \n"
                + "    COUNT(DISTINCT c.id) AS total_Courses,  \n"
                + "    COUNT(DISTINCT m.id) AS total_Mentee  \n"
                + "FROM Course c  \n"
                + "LEFT JOIN Mentee m ON m.user_id IN (  \n"
                + "    SELECT id FROM Users WHERE role = 'mentee'  \n"
                + ")  \n"
                + "WHERE c.status = 'active'; ";
        try {
            PreparedStatement connect = conn.prepareStatement(query);
            ResultSet rs = connect.executeQuery();
            while (rs.next()) {
                list.add(new Course(rs.getInt("total_Mentee"), rs.getInt("total_Courses"))
                );
            }
            rs.close();
            connect.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateCourse(Course course) {
        String sql = "UPDATE Course SET title = ?, description = ?, status = ?, "
                + "updated_at = GETDATE(), course_major_id = ?, image = ? "
                + "WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, course.getTitle());
            ps.setString(2, course.getDescription());
            ps.setString(3, course.getStatus());
            ps.setInt(4, course.getCourseMajorId());
            ps.setString(5, course.getImage());
            ps.setInt(6, course.getId());

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Course getCourseById(int id) {
        String query = "SELECT [id]\n"
                + "      ,[title]\n"
                + "      ,[description]\n"
                + "      ,[manager_id]\n"
                + "      ,[mentor_id]\n"
                + "      ,[status]\n"
                + "      ,[created_at]\n"
                + "      ,[updated_at]\n"
                + "      ,[course_major_id]\n"
                + "      ,[image]\n"
                + "      ,[price]\n"
                + "  FROM [SWP1].[dbo].[Course]\n"
                + "  Where [id] = ?";
        try {
            PreparedStatement connect = conn.prepareStatement(query);
            connect.setInt(1, id);
            ResultSet result = connect.executeQuery();

            while (result.next()) {
                id = result.getInt("id");
                String title = result.getString("title");
                String description = result.getString("description");
                int managerId = result.getInt("manager_id");
                int mentorId = result.getInt("mentor_id");
                LocalDateTime createdAt = result.getTimestamp("created_at").toLocalDateTime();
                LocalDateTime updatedAt = result.getTimestamp("updated_at").toLocalDateTime();
                int courseMajorId = result.getInt("course_major_id");
                String status = result.getString("status");
                String image = result.getString("image");
                Double price = result.getDouble("price");

                return new Course(id, title, description, managerId, mentorId, status, createdAt, updatedAt, courseMajorId, image, price);

            }
            result.close();
            connect.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public ArrayList<Course> getCourseByMentorId(int mentorId) {
        ArrayList<Course> listCourse = new ArrayList<>();
        String query = "SELECT c.[id]\n"
                + "      ,c.[title]\n"
                + "      ,c.[description]\n"
                + "      ,c.[manager_id]\n"
                + "      ,c.[mentor_id]\n"
                + "      ,c.[status]\n"
                + "      ,c.[created_at]\n"
                + "      ,c.[updated_at]\n"
                + "      ,c.[course_major_id]\n"
                + "      ,c.[image]\n"
                + "      ,c.[price]\n"
                + "FROM [SWP1].[dbo].[Course] c\n"
                + "INNER JOIN [SWP1].[dbo].[mentorCourse] mc ON c.[id] = mc.[course_id]\n"
                + "WHERE mc.[mentor_id] = ?";
        try {
            PreparedStatement connect = conn.prepareStatement(query);
            connect.setInt(1, mentorId);
            ResultSet result = connect.executeQuery();

            while (result.next()) {
                Course course = new Course();
                course.setId(result.getInt("id"));
                course.setTitle(result.getString("title"));
                course.setDescription(result.getString("description"));
                course.setManagerId(result.getInt("manager_id"));
                course.setMentorId(result.getInt("mentor_id"));
                course.setStatus(result.getString("status"));
                course.setCourseMajorId(result.getInt("course_major_id"));
                course.setImage(result.getString("image"));
                course.setPrice(result.getDouble("price"));

                listCourse.add(course);

            }
            result.close();
            connect.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listCourse;

    }

    public Course getCourseByIdd(int id) {
        Course course = null;
        String sql = "SELECT Course.title, CourseMajor.name as name ,Course.image, Course.price "
                + "FROM Course JOIN CourseMajor ON CourseMajor.id = Course.course_major_id "
                + "WHERE Course.id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                course = new Course(
                        rs.getString("title"), // Course.title
                        rs.getString("name"), // Course.image
                        rs.getString("image"), // CourseMajor.name (aliased as 'major')
                        rs.getDouble("price") // Course.price
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return course;
    }

    public List<Mentor> getMentorByCourseId(int cid) {
        List<Mentor> mentors = new ArrayList<>();
        String sql = "SELECT m.id, m.name, m.email, m.rating, m.price_per_slot, m.image\n"
                + "FROM Mentor m\n"
                + "INNER JOIN MentorCourse mc ON m.id = mc.mentor_id\n"
                + "INNER JOIN Course c ON mc.course_id = c.id\n"
                + "INNER JOIN Users u ON m.user_id = u.id\n"
                + "INNER JOIN CV cv ON cv.username = u.username\n"
                + "WHERE c.id = ?\n"
                + "AND mc.status = 'approved'\n"
                + "AND cv.status = 'approved'\n"
                + "AND m.price_per_slot IS NOT NULL\n"
                + "AND EXISTS (\n"
                + "    SELECT 1\n"
                + "    FROM Mentor_Schedule ms\n"
                + "    WHERE ms.mentor_id = m.id\n"
                + ");";

        try {
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setInt(1, cid);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Mentor mentor = new Mentor();
                mentor.setMentorId(rs.getInt("id"));
                mentor.setName(rs.getString("name"));
                mentor.setEmail(rs.getString("email"));
                mentor.setRating(rs.getDouble("rating"));
                mentor.setPricePerSlot(rs.getDouble("price_per_slot"));
                mentor.setImage(rs.getString("image"));
                mentors.add(mentor);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return mentors;
    }

//    public int getTotalMenteesByCourse(int courseId) {
//        String sql = "SELECT COUNT(DISTINCT m.id) AS total_mentees "
//                + "FROM Mentee m "
//                + "JOIN CourseEnrollment ce ON m.id = ce.mentee_id "
//                + "WHERE ce.course_id = ?";
//        try {
//            PreparedStatement stmt = conn.prepareStatement(sql);
//
//            stmt.setInt(1, courseId);
//            ResultSet rs = stmt.executeQuery();
//            if (rs.next()) {
//                return rs.getInt("total_mentees");
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return 0;
//    }
    public int getTotalMentorsByCourse(int courseId) {
        String sql = "SELECT COUNT(DISTINCT m.id) AS mentor_count\n"
                + "FROM Mentor m\n"
                + "INNER JOIN MentorCourse mc ON m.id = mc.mentor_id\n"
                + "INNER JOIN Course c ON mc.course_id = c.id\n"
                + "INNER JOIN Users u ON m.user_id = u.id\n"
                + "INNER JOIN CV cv ON cv.username = u.username\n"
                + "WHERE mc.course_id = ?\n"
                + "AND mc.status = 'approved'\n"
                + "AND cv.status = 'approved'\n"
                + "AND m.price_per_slot IS NOT NULL\n"
                + "AND EXISTS (\n"
                + "    SELECT 1\n"
                + "    FROM Mentor_Schedule ms\n"
                + "    WHERE ms.mentor_id = m.id\n"
                + "    AND ms.schedule_id IS NOT NULL\n"
                + ");";
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setInt(1, courseId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("mentor_Count");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public String getCourseMajor(int courseId) {
        String sql = "SELECT cm.name AS course_major "
                + "FROM Course c "
                + "JOIN CourseMajor cm ON c.course_major_id = cm.id "
                + "WHERE c.id = ?";
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setInt(1, courseId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("course_major");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // hoang
    public List<Course> getTop3CoursesByMajor(int majorId) {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT top 3  [id]\n"
                + "      ,[title]\n"
                + "      ,[description]\n"
                + "      ,[manager_id]\n"
                + "      ,[mentor_id]\n"
                + "      ,[status]\n"
                + "      ,[created_at]\n"
                + "      ,[updated_at]\n"
                + "      ,[course_major_id]\n"
                + "      ,[image]\n"
                + "      ,[price]\n"
                + "  FROM [SWP1].[dbo].[Course]\n"
                + "  where [course_major_id] = ?";
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setInt(1, majorId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("id"));
                course.setTitle(rs.getString("title"));
                course.setDescription(rs.getString("description"));
                course.setManagerId(rs.getInt("manager_id"));
                course.setMentorId(rs.getInt("mentor_id"));
                course.setStatus(rs.getString("status"));
                course.setCourseMajorId(rs.getInt("course_major_id"));
                course.setImage(rs.getString("image"));
                course.setPrice(rs.getDouble("price"));

                courses.add(course);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }

    public List<Course> getCoursesByStatus(String username, String status) {
        List<Course> courses = new ArrayList<>();

        // SQL Query to join Request, Course, Mentee, and Users tables
        String sql = "SELECT c.id, c.title, c.description, c.manager_id, c.mentor_id, "
                + "c.status, c.created_at, c.updated_at, c.course_major_id, c.image, c.price "
                + "FROM Request r "
                + "JOIN Course c ON r.course_id = c.id "
                + "JOIN Mentee m ON r.mentee_id = m.id "
                + "JOIN Users u ON m.user_id = u.id "
                + "WHERE u.username = ? AND r.status = ?";

        try (PreparedStatement preparedStatement = conn.prepareStatement(sql)) {
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, status);

            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Course course = new Course();
                    course.setId(rs.getInt("id"));
                    course.setTitle(rs.getString("title"));
                    course.setDescription(rs.getString("description"));
                    course.setManagerId(rs.getInt("manager_id"));
                    course.setMentorId(rs.getInt("mentor_id"));
                    course.setStatus(rs.getString("status"));
                    course.setCourseMajorId(rs.getInt("course_major_id"));
                    course.setImage(rs.getString("image"));
                    course.setPrice(rs.getDouble("price"));

                    courses.add(course);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return courses;
    }

    public ArrayList<Course> getCourseByMentor(String username) {
        ArrayList<Course> listCourse = new ArrayList<>();
        String query = "SELECT c.[id], c.[title], c.[description], c.[manager_id], c.[mentor_id], "
                + "       u.[username] AS mentor_username, c.[status], c.[created_at], "
                + "       c.[updated_at], c.[course_major_id], c.[image], c.[price] "
                + "FROM [SWP1].[dbo].[Course] c "
                + "JOIN [SWP1].[dbo].[Mentor] m ON c.mentor_id = m.id "
                + "JOIN [SWP1].[dbo].[Users] u ON m.user_id = u.id "
                + "WHERE u.[username] = ?";
        try {
            PreparedStatement connect = conn.prepareStatement(query);
            connect.setString(1, username);
            ResultSet result = connect.executeQuery();

            while (result.next()) {
                Course course = new Course();
                course.setId(result.getInt("id"));
                course.setTitle(result.getString("title"));
                course.setDescription(result.getString("description"));
                course.setManagerId(result.getInt("manager_id"));
                course.setMentorId(result.getInt("mentor_id"));
                course.setStatus(result.getString("status"));
                course.setCourseMajorId(result.getInt("course_major_id"));
                course.setImage(result.getString("image"));
                course.setPrice(result.getDouble("price"));

                listCourse.add(course);

            }
            result.close();
            connect.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listCourse;

    }

    public int getTotalCourse() {
        String sql = "select count(*) from Course";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }
    // hoang

    public List<Course> pagingCourse(int index) {
        List<Course> list = new ArrayList<>();
        String sql = "	SELECT \n"
                + "    c.id AS CourseID,\n"
                + "    c.title AS CourseTitle,\n"
                + "    c.description AS CourseDescription,\n"
                + "    c.manager_id AS ManagerID,\n"
                + "    c.mentor_id AS MentorID,\n"
                + "    c.status AS CourseStatus,\n"
                + "    c.created_at AS CreatedAt,\n"
                + "    c.updated_at AS UpdatedAt,\n"
                + "    c.course_major_id AS CourseMajorID,\n"
                + "    c.image AS CourseImage\n"
                + "FROM \n"
                + "    Course c\n"
                + "LEFT JOIN \n"
                + "    CourseMajor cm ON c.course_major_id = cm.id\n"
                + "LEFT JOIN \n"
                + "    CV cv ON ',' + cv.courses + ',' LIKE '%,' + cm.name + ',%'\n"
                + "GROUP BY \n"
                + "    c.id, c.title, c.description, c.manager_id, c.mentor_id, \n"
                + "    c.status, c.created_at, c.updated_at, c.course_major_id, c.image \n"
                + "ORDER BY c.title ASC \n"
                + "offset ? rows fetch next 5 rows only";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, (index - 1) * 5);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("CourseID"));
                course.setTitle(rs.getString("CourseTitle"));
                course.setDescription(rs.getString("CourseDescription"));
                course.setManagerId(rs.getInt("ManagerID"));
                course.setMentorId(rs.getInt("MentorID"));
                course.setStatus(rs.getString("CourseStatus"));
                course.setCourseMajorId(rs.getInt("CourseMajorID"));
                course.setImage(rs.getString("CourseImage"));

                list.add(course);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Course> pagingCourseManager(int index) {
        List<Course> list = new ArrayList<>();
        String sql = "SELECT [id], [title], [description], [manager_id], [mentor_id], "
                + "[status], [created_at], [updated_at], [course_major_id], [image], [price] "
                + "FROM [SWP1].[dbo].[Course] "
                + "ORDER BY [id] "
                + "OFFSET ? ROWS FETCH NEXT 7 ROWS ONLY";
        try (PreparedStatement pre = conn.prepareStatement(sql)) {
            pre.setInt(1, (index - 1) * 7);
            try (ResultSet rs = pre.executeQuery()) {
                while (rs.next()) {
                    Course course = new Course();
                    course.setId(rs.getInt("id"));
                    course.setTitle(rs.getString("title"));
                    course.setDescription(rs.getString("description"));
                    course.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    course.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
                    course.setStatus(rs.getString("status"));
                    course.setCourseMajorId(rs.getInt("course_major_id"));
                    course.setImage(rs.getString("image"));
                    course.setPrice(rs.getDouble("price"));

                    list.add(course);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Course> searchCourseByTitle(String keyword) {
        List<Course> list = new ArrayList<>();
        String sql = "SELECT id, title, image\n"
                + "FROM Course\n"
                + "WHERE LOWER(title) LIKE LOWER(?);";

        try {
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, "%" + keyword + "%");
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("id"));
                course.setTitle(rs.getString("title"));

                course.setImage(rs.getString("image"));
                list.add(course);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countMenteeOfCourse(int courseId) {
        String sql = "SELECT \n"
                + "    COUNT(DISTINCT r.mentee_id) AS total_mentees\n"
                + "FROM \n"
                + "    [dbo].[Request] r\n"
                + "WHERE \n"
                + "    r.status = 'closed' AND \n"
                + "    r.course_id = ?;";
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, courseId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("total_mentees");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    // lay ra courseID de day
    public List<Course> getCoursesByMajor(String name) {
        List<Course> courseList = new ArrayList<>();
        String sql = "SELECT c.id, c.title FROM Course c \n"
                + "join CourseMajor cm on c.course_major_id = cm.id\n"
                + "where cm.name = ?";

        try (PreparedStatement pre = conn.prepareStatement(sql)) {
            pre.setString(1, name);
            ResultSet rs = pre.executeQuery();

            while (rs.next()) {
                courseList.add(new Course(rs.getInt("id"), rs.getString("title")));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return courseList;
    }

    // Lay course theo Major de day
    public void MentorCourses(int mentorId, int courseId) {
        String sql = "INSERT INTO MentorCourse (mentor_id, course_id) VALUES (?, ?)";
        try (PreparedStatement pre = conn.prepareStatement(sql)) {
            pre.setInt(1, mentorId);
            pre.setInt(2, courseId);
            pre.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    // dem so luong CV
    public int getTotalRequest() {
        String sql = "select count(*) from MentorCourse";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    // lay danh sach cac mentor course o trang thai la Pending
    public static List<MentorCourse> getPendingCourses(int index) {
        List<MentorCourse> courses = new ArrayList<>();
        String sql = "select mc.mentor_id, m.name, mc.course_id, c.title, mc.status from Mentor m join MentorCourse mc on m.id = mc.mentor_id\n"
                + "join Course c on mc.course_id = c.id where mc.status = 'pending'\n"
                + "order by status\n"
                + "offset ? rows fetch next 5 rows only";

        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, (index - 1) * 5);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                courses.add(new MentorCourse(
                        rs.getInt("mentor_id"),
                        rs.getString("name"),
                        rs.getInt("course_id"),
                        rs.getString("title"),
                        rs.getString("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return courses;
    }

    // cho manager duyet mentorcourse
    public static boolean updateCourseStatus(int mentorId, int courseId, String status) {
        String sql = "UPDATE MentorCourse SET status = ? WHERE mentor_id = ? AND course_id = ?";

        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, status);
            pre.setInt(2, mentorId);
            pre.setInt(3, courseId);

            return pre.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // lay ra tat ca MentorCourse
    public List<MentorCourse> getAllCourses() {
        List<MentorCourse> courses = new ArrayList<>();
        String sql = "select mc.mentor_id, m.name, mc.course_id, c.title, mc.status from Mentor m join MentorCourse mc on m.id = mc.mentor_id\n"
                + "join Course c on mc.course_id = c.id";

        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                courses.add(new MentorCourse(
                        rs.getInt("mentor_id"),
                        rs.getString("name"),
                        rs.getInt("course_id"),
                        rs.getString("title"),
                        rs.getString("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }

    // lay ra MentorCourse theo trang thai approved
    public List<MentorCourse> getApprovedCourses() {
        List<MentorCourse> courses = new ArrayList<>();
        String sql = "select mc.mentor_id, m.name, mc.course_id, c.title, mc.status from Mentor m join MentorCourse mc on m.id = mc.mentor_id\n"
                + "join Course c on mc.course_id = c.id where mc.status = 'approved'";

        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                courses.add(new MentorCourse(
                        rs.getInt("mentor_id"),
                        rs.getString("name"),
                        rs.getInt("course_id"),
                        rs.getString("title"),
                        rs.getString("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }

    // lay ra MentorCourse theo trang thai rejected
    public List<MentorCourse> getRejectedCourses() {
        List<MentorCourse> courses = new ArrayList<>();
        String sql = "select mc.mentor_id, m.name, mc.course_id, c.title, mc.status from Mentor m join MentorCourse mc on m.id = mc.mentor_id\n"
                + "join Course c on mc.course_id = c.id where mc.status = 'rejected'";

        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                courses.add(new MentorCourse(
                        rs.getInt("mentor_id"),
                        rs.getString("name"),
                        rs.getInt("course_id"),
                        rs.getString("title"),
                        rs.getString("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }

    // lay ra MentorCourse theo trang thai
    public List<MentorCourse> getCoursesByStatus(String status) {
        List<MentorCourse> courses = new ArrayList<>();
        String sql = "select mc.mentor_id, m.name, mc.course_id, c.title, mc.status from Mentor m join MentorCourse mc on m.id = mc.mentor_id\n"
                + "join Course c on mc.course_id = c.id where mc.status = ?";

        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, status);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                courses.add(new MentorCourse(
                        rs.getInt("mentor_id"),
                        rs.getString("name"),
                        rs.getInt("course_id"),
                        rs.getString("title"),
                        rs.getString("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }

    public static void main(String[] args) {
        DAOCourse dao = new DAOCourse();

//        dao.MentorCourses(2, 1);
        List<Course> listCourseHome = dao.getAllCourseHome();
        for (Course course : listCourseHome) {
            System.out.println(course);
        }
//
//        for (Course course : listCourseHome) {
//            System.out.println(course);
//        }
//        List<Course> listCourse1 = dao.getAllCourse();
//        System.out.println(listCourse1);
//        Course newCourse = new Course(0, "Java Programming", "Learn Java from basic to advanced", 1, 2, "active", LocalDateTime.now(), LocalDateTime.now(), 3);
//
//        boolean result = dao.createCourse("Java", "Basic");
//        if (result) {
//            System.out.println("Create course successfully");
//        } else {
//            System.out.println("Create failed!");
//        }
//        Course course = dao.getCourseById(1);
////        int a = dao.getTotalMenteesByCourse(2);
//        int b = dao.getTotalMentorsByCourse(2);
//        String str = dao.getCourseMajor(2);
////        System.out.println(a);
//        System.out.println(b);
//        System.out.println(str);
//        for (Course course : listCourseHome) {
//            System.out.println(course);
//        }
//        int a = dao.getTotalMentorsByCourse(1);
//        System.out.println(a);
    }
}
