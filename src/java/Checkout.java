
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/IssueBookServlet")
public class Checkout extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        HttpSession sess = request.getSession(false);
        // Retrieve form data
        String reg_no = sess.getAttribute("loggedInID").toString();
        String isbn = request.getParameter("isbn");
        String name = sess.getAttribute("loggedInUser").toString();

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Establish a connection to the Oracle database
            Class.forName("oracle.jdbc.driver.OracleDriver");
            String jdbcURL = "jdbc:oracle:thin:@LAPTOP-DBORBG65:1521:ORCLE";
            String dbUsername = "Hack";
            String dbPassword = "Athon";
            conn = DriverManager.getConnection(jdbcURL, dbUsername, dbPassword);
            // Update book quantity in the database after book issuance
            String updateQuery = "UPDATE book SET count = count - 1 WHERE isbn = ?";
            pstmt = conn.prepareStatement(updateQuery);
            pstmt.setString(1, isbn);
            int rowsAffected = pstmt.executeUpdate();
            String updateIssue = "insert into issued(isbn,reg_no,name,issue_date,last_date) values(?,?,?,?,?)";
            pstmt = conn.prepareStatement(updateIssue);
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");

               Date tdt=new Date();
                LocalDate dt=LocalDate.now();
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
                String formattedDate = dateFormat.format(tdt);
                dt=dt.plusDays(10);
                String lastDate = dt.format(formatter);
            pstmt.setString(1, isbn);
            pstmt.setString(2, reg_no);
            pstmt.setString(3, name);
            pstmt.setString(4, formattedDate);
            pstmt.setString(5, lastDate);
            rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("http://localhost:8080/LMS/WEBPAGES/dashboard.jsp?param=issued");
                // Perform other actions or display messages as needed upon successful issuance
            } else {
                out.println("<h3>Failed to issue book!</h3>");
                // Handle the case when the book issuance fails
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            out.println("<h3>An error occurred while issuing the book.</h3>");
        } finally {
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
