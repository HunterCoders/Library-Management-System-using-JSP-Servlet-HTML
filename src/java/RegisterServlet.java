/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig(maxFileSize = 16177215) // for max 16 MB images

public class RegisterServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("pass");
        String name = request.getParameter("name");
        String regno = request.getParameter("regno");
        System.out.println(name);
        
        Connection conn = null;

        try {
            // Register JDBC driver
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // Open a connection
            conn = DriverManager.getConnection("jdbc:oracle:thin:@LAPTOP-DBORBG65:1521:ORCLE","Hack","Athon");
            conn.setAutoCommit(true);
            // Insert the details into the database
            PreparedStatement stmt = conn.prepareStatement("Select * from student where reg_no='" + regno + "'");
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                response.sendRedirect("http://localhost:8080/LMS/WEBPAGES/Register.jsp?error=invalid");
            } else {
            String sql = "INSERT INTO student (reg_no,name,email,password) values (?,?,?,?)";
            PreparedStatement statement = conn.prepareStatement(sql);

            statement.setString(1,regno);
            statement.setString(2,name);
            statement.setString(3,email);
            statement.setString(4,password);

                int row = statement.executeUpdate();
                conn.commit();
                
                if (row > 0) {
                    System.out.println(name);
                    response.sendRedirect("http://localhost:8080/LMS/WEBPAGES/StudentLogin.jsp?param=login-success");

                }
            } 
        }catch (SQLException ex) {
            Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}