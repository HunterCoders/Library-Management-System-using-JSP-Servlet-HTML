
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/AddMovieServlet")
@MultipartConfig(maxFileSize = 16177215) // 16 MB

public class AddBook extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String isbn = request.getParameter("isbn");
        String type = request.getParameter("type");
        String desc = request.getParameter("desc");
        String author = request.getParameter("author");
        String count = request.getParameter("count");
        Connection conn = null;
        String message = null;
        ResultSet rs = null;

        try {
            // Register JDBC driver
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // Open a connection
            conn = DriverManager.getConnection("jdbc:oracle:thin:@LAPTOP-DBORBG65:1521:ORCLE", "Hack", "Athon");

            // Insert the movie into the database
            String q = "Select * from book where isbn='" + isbn + "'";
            PreparedStatement st = conn.prepareStatement(q);
            rs = st.executeQuery();
            if (rs.next()) {
                response.sendRedirect("http://localhost:8080/LMS/WEBPAGES/AddBook.jsp?status=exists");
            } else {

                String sql = "INSERT INTO book (isbn,book_name,author, type,count,descr,poster) values (?,?,?,?,?,?,?)";
                PreparedStatement statement = conn.prepareStatement(sql);
                statement.setString(1, isbn);
                statement.setString(2, name);
                statement.setString(3, author);
                statement.setString(4, type);
                statement.setString(5, count);
                statement.setString(6, desc);

                Part filePart = request.getPart("Poster");
                InputStream fileContent = filePart.getInputStream();
                String fileName = filePart.getSubmittedFileName();
                long fileSize = filePart.getSize();
                System.out.println(fileName);
                statement.setBinaryStream(7, fileContent, (int) fileSize);

                if ("".equals(name) || "".equals(type)) {
                    response.sendRedirect("http://localhost:8080/LMS/WEBPAGES/AddBook.jsp?status=empty");

                    conn.close();
                } else if (name.length() > 50) {
                    response.sendRedirect("http://localhost:8080/LMS/WEBPAGES/AddBook.jsp?status=failed");
                    message = "Failed to add book!";
                } else {
                    int row = statement.executeUpdate();

                    if (row > 0) {
                        message = "Book added successfully!";
                        System.out.println(name);
                        response.sendRedirect("http://localhost:8080/LMS/WEBPAGES/AddBook.jsp?status=success");

                    }
                }
            }
            }catch (SQLException | ClassNotFoundException e) {
            message = "Error: " + e.getMessage();
            e.printStackTrace();
        }finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
            request.setAttribute("message", message);

        }
    }
