<%@ page import="java.io.IOException,java.io.PrintWriter,java.sql.Blob,java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,java.sql.SQLException,java.util.Base64" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Search Results</title>
        <style>
            table { border-collapse: collapse; width: 100%; }
            th, td { padding: 8px; text-align: left; border-bottom: 1px solid #ddd; }
            th { background-color: #f2f2f2; color: #333; }
            .table-header { background-color: #333; color: #fff; height: 50px; line-height: 50px; padding: 0 20px; font-size: 18px; }
            tr:hover { background-color: #f5f5f5; }
            tr:nth-child(even) { background-color: #f2f2f2; }
            #home { background-color: #0069d9; color: white; display:block; margin:auto; padding: 12px 20px; border: none; border-radius: 4px; cursor: pointer; font-size: 18px; color: #ffffff; }
            #back { background-color: #4CAF50; color: white; padding: 12px 20px; border: none; border-radius: 4px; cursor: pointer; font-size: 18px; color: #ffffff; }
            #btn { text-align: center; }
        </style>
    </head>
    <body>
        <h2>Search Results:</h2>
        <table border='1'>
            <tr>
                <th>ISBN</th>
                <th>Book Name</th>
                <th>Author</th>
                <th>Type</th>
                <th>Count</th>
                <th>Poster</th>
                <th>Update</th>
                <th>Remove</th>
            </tr>

            <%
                String searchQuery = request.getParameter("searchQuery");

                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    String url = "jdbc:oracle:thin:@LAPTOP-DBORBG65:1521:ORCLE";
                    String username = "Hack";
                    String password = "Athon";
                    Connection conn = DriverManager.getConnection(url, username, password);
                    String sql = "SELECT * FROM book WHERE Book_Name LIKE ?";
                    PreparedStatement pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, "%" + searchQuery + "%");
                    ResultSet rs = pstmt.executeQuery();

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
            %>
            <td>
                <form method="post" action="http://localhost:8080/LMS/WEBPAGES/UpdateQuant.jsp?para=<%=rs.getString("ISBN")%>">
                <button type="submit" name="delete_reco_movie">Update Books</button>
            </form>
            
            </td>
            <td>
                 <form method="post" action="http://localhost:8080/LMS/RemoveServlet?para=<%=rs.getString("ISBN")%>">
                <button type="submit" name="reg">Remove Books</button>
            </form>
            </td>
            <%
                        out.println("</tr>");
                    }

                    rs.close();
                    pstmt.close();
                    conn.close();
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }
            %>
        </table>
        <br><br>
        <form action='http://localhost:8080/LMS/WEBPAGES/LibrarianOptions.jsp' method='post'>
            <button id='home'>Admin Home</button>
        </form>
    </body>
</html>
