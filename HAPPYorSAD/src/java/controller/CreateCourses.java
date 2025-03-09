package controller;

import entity.Major;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.sql.ResultSet;
import java.util.List;
import model.DAOCourse;
import model.DAOmajor;

@MultipartConfig(
        fileSizeThreshold = 2 * 1024 * 1024, // 2MB
        maxFileSize = 10 * 1024 * 1024, // 10MB
        maxRequestSize = 50 * 1024 * 1024 // 50MB
)
public class CreateCourses extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAOmajor dao1 = new DAOmajor();
        List<Major> list = dao1.getMajorHome();
        request.setAttribute("listMajor", list);
        request.getRequestDispatcher("/CRUD/createCourse.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOCourse dao = new DAOCourse();
        // Kiểm tra nếu request không phải multipart
        if (!request.getContentType().toLowerCase().startsWith("multipart/")) {
            request.setAttribute("error", "Form must have enctype=multipart/form-data.");
            request.getRequestDispatcher("/CRUD/createCourse.jsp").forward(request, response);
            return;
        }

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String majorStr = request.getParameter("majorID");

        if (isEmpty(title) || isEmpty(description) || isEmpty(majorStr)) {
            request.setAttribute("error", "Missing required fields.");
            request.getRequestDispatcher("/CRUD/createCourse.jsp").forward(request, response);
            return;
        }

        int majorId;
        try {
            majorId = Integer.parseInt(majorStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid major ID.");
            request.getRequestDispatcher("/CRUD/createCourse.jsp").forward(request, response);
            return;
        }

        // Xử lý upload file
        Part filePart = request.getPart("imageFile");

        if (filePart == null || filePart.getSize() == 0) {
            request.setAttribute("error", "No image file uploaded.");
            request.getRequestDispatcher("/CRUD/createCourse.jsp").forward(request, response);
            return;
        }

        // Kiểm tra tên file
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        if (fileName.isEmpty()) {
            request.setAttribute("error", "No file selected.");
            request.getRequestDispatcher("/CRUD/createCourse.jsp").forward(request, response);
            return;
        }

        // Đường dẫn lưu file
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        // URL để lưu vào DB
        String fileUrl = "/HAPPYorSAD/uploads/" + fileName;

        String priceStr = request.getParameter("price");
        double price;
        try {
            if (isEmpty(priceStr)) {
                request.setAttribute("error", "Price is required.");
                request.getRequestDispatcher("/CRUD/createCourse.jsp").forward(request, response);
                return;
            }
            price = Double.parseDouble(priceStr);
            if (price < 0) {
                request.setAttribute("error", "Price must be a positive number.");
                request.getRequestDispatcher("/CRUD/createCourse.jsp").forward(request, response);
                return;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid price format.");
            request.getRequestDispatcher("/CRUD/createCourse.jsp").forward(request, response);
            return;
        }

        // Lưu vào DB
        dao.createCourse(title, description, majorId, fileUrl, price);

        request.setAttribute("successMessage", "Course created successfully!");
        response.sendRedirect("CreateCourses?success=true");
    }

    private boolean isEmpty(String str) {
        return str == null || str.trim().isEmpty();
    }

    @Override
    public String getServletInfo() {
        return "Handles course creation and file upload";
    }
}
