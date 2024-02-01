import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SubmitBookServlet")
public class submitBook extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookISBN = request.getParameter("isbn");
        // Assuming you have some way of identifying the specific issued book entry, for example, an issue ID
        HttpSession sess=request.getSession(false);
        String reg_no=sess.getAttribute("loggedInID").toString();

        // Update count of books in book table
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            // Update book count in the book table
            try (Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@LAPTOP-DBORBG65:1521:ORCLE", "Hack", "Athon")) {
                // Update book count in the book table
                String updateBookQuery = "UPDATE book SET Count = Count + 1 WHERE ISBN = ?";
                PreparedStatement removeIssuedStmt;
                try (PreparedStatement updateBookStmt = conn.prepareStatement(updateBookQuery)) {
                    updateBookStmt.setString(1, bookISBN);
                    updateBookStmt.executeUpdate();
                    // Remove record from the issued table
                    String removeIssuedQuery = "DELETE FROM issued WHERE reg_no = ? and isbn=?";
                    removeIssuedStmt = conn.prepareStatement(removeIssuedQuery);
                    removeIssuedStmt.setString(1, reg_no);
                    removeIssuedStmt.setString(2, bookISBN);
                    removeIssuedStmt.executeUpdate();
                    // Close connections
                }
                removeIssuedStmt.close();
            }

            // Redirect to a success page or display a success message
            response.sendRedirect("http://localhost:8080/LMS/WEBPAGES/dashboard.jsp?param=bookSubmit");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            // Handle exceptions appropriately
        } catch (SQLException ex) {
            
        }
    }
}
