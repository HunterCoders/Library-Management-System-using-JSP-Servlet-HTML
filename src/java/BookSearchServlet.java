
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SearchServlet")
public class BookSearchServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchQuery = request.getParameter("searchQuery");

        try {
            // Set up Oracle JDBC driver, URL, username, and password
            Class.forName("oracle.jdbc.driver.OracleDriver");
            String url = "jdbc:oracle:thin:@LAPTOP-DBORBG65:1521:ORCLE"; // Replace with your Oracle DB URL
            String username = "Hack";
            String password = "Athon";

            Connection conn = DriverManager.getConnection(url, username, password);

            // Prepare SQL statement for searching books
            String sql = "SELECT * FROM book WHERE Book_Name LIKE ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + searchQuery + "%");

            // Execute query
            ResultSet rs = pstmt.executeQuery();

            response.setContentType("text/html");
            PrintWriter out = response.getWriter();

            out.println("<html><head><title>Search Results</title>");
             out.println("<style>");
            out.println("table { border-collapse: collapse; width: 100%; }");
            out.println("th, td { padding: 8px; text-align: left; border-bottom: 1px solid #ddd; }");
            out.println("th { background-color: #f2f2f2; color: #333; }");
            out.println(".table-header { background-color: #333; color: #fff; height: 50px; line-height: 50px; padding: 0 20px; font-size: 18px; }");
            out.println("tr:hover { background-color: #f5f5f5; }");
            out.println("tr:nth-child(even) { background-color: #f2f2f2; }");
            out.println("#home { background-color: #0069d9; color: white; display:block;  margin:auto; padding: 12px 20px; border: none; border-radius: 4px; cursor: pointer; font-size: 18px; color: #ffffff; }");
            out.println("#back { background-color: #4CAF50; color: white; padding: 12px 20px; border: none; border-radius: 4px; cursor: pointer; font-size: 18px; color: #ffffff; }");
            out.println("#btn { text-align: center; }");
            out.println("</style>");
            out.println("</head><body>");
            out.println("<h2>Search Results:</h2>");
            out.println("<table border='1'><tr><th>ISBN</th><th>Book Name</th><th>Author</th><th>Type</th><th>Count</th><th>Poster</th><th>Update</th><th>Remove</th></tr>");

            // Display results
            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getString("ISBN") + "</td>");
                out.println("<td>" + rs.getString("Book_Name") + "</td>");
                out.println("<td>" + rs.getString("Author") + "</td>");
                out.println("<td>" + rs.getString("Type") + "</td>");
                out.println("<td>" + rs.getString("Count") + "</td>");
                out.println("<td>");
                Blob imageBlob = rs.getBlob("poster");
                byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
                out.write("<img style='width:140px;height:235px'src=\"data:image/jpeg;base64," + new String(Base64.getEncoder().encode(imageBytes)) + "\"/>");
                out.println("</td>");
                out.println("</tr>");
            }
            
            out.println("</table></body></html>");
            out.println("<br> <br>");
            out.println("<form action='http://localhost:8080/LMS/WEBPAGES/LibrarianOptions.jsp' method='post'>");
            out.println("<button id='home'>Admin Home</button>");
            out.println("</form>");
            rs.close();
            pstmt.close();
            conn.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
