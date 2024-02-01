/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Login")
public class Login extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String registerNumber = request.getParameter("Regno");
        String password = request.getParameter("pass");
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
        }
        String jdbcUrl = "jdbc:oracle:thin:@LAPTOP-DBORBG65:1521:ORCLE";
        String dbUser = "Hack";
        String dbPassword = "Athon";
        try (Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
            String sql = "SELECT * FROM student WHERE reg_no = ? AND password = ?";
            System.out.println("SELECT * FROM student WHERE reg_no ='" + registerNumber + "' AND password = '" + password + "'");
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, registerNumber);
                statement.setString(2, password);

                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        HttpSession sess = request.getSession(true);
                        sess.setAttribute("loggedInUser", resultSet.getString("Name"));
                        sess.setAttribute("loggedInID", resultSet.getString("reg_no"));
                        response.sendRedirect("http://localhost:8080/LMS/WEBPAGES/dashboard.jsp");
                    } else {
                        response.sendRedirect("http://localhost:8080/LMS/WEBPAGES/StudentLogin.jsp?param=invalid");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
