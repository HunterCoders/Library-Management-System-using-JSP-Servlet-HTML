<%-- 
    Document   : search
    Created on : 24 Nov, 2023, 11:17:20 PM
    Author     : Anurag Sinha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.io.IOException,java.io.PrintWriter,java.sql.Blob,java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,java.sql.SQLException,java.util.Base64" %>
<html>
    <head>
        <title>Search Results</title>
        <style>
            th
            {
                padding: 20px;
                font-size: 22px;
                border: 1px solid darkgrey;
                background-color: rgba(255,255,255,0.2);
                color:oldlace;
            }
            td
            {
                border: 1px solid white;
                text-align: center;
                padding: 20px;
                color:white;
            }
            .table
            {
                display: block;
                margin: auto;
                text-align: center;
            }
        </style>
        <link href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css" rel="stylesheet">

    </head>
    <body class="flex justify-center items-center min-h-screen bg-gradient-to-br from-gray-700 to-gray-900 p-8 rounded-lg shadow-lg">
        <div class="w-full p-8 bg-gradient-to-br from-gray-600 to-gray-700 p-8 rounded-lg shadow-xl backdrop-blur-lg bg-opacity-10 rounded-lg shadow-lg">
            <h2 class="text-2xl text-center mb-8 text-white">Search Results:</h2>
            <div class="table">
                <table class="border border-gray-300 table-fixed">

                    <tr>
                        <th >ISBN</th>
                        <th >Book Name</th>
                        <th >Author</th>
                        <th >Count</th>
                        <th>Type</th>
                        <th >Poster</th>
                        <th >Issue</th>
                    </tr>


                    <%
                        String searchQuery = request.getParameter("searchQuery");
                        String reg_no = request.getSession(false).getAttribute("loggedInID").toString();
                        try {
                            Class.forName("oracle.jdbc.driver.OracleDriver");
                            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@LAPTOP-DBORBG65:1521:ORCLE", "Hack", "Athon");
                            String sql = "SELECT * FROM book WHERE Book_Name LIKE ? OR Author LIKE ?";
                            PreparedStatement ps = con.prepareStatement(sql);
                            ps.setString(1, "%" + searchQuery + "%");
                            ps.setString(2, "%" + searchQuery + "%");
                            ResultSet rs = ps.executeQuery();
                            ResultSet r = null;

                            while (rs.next()) {
                                out.println("<tr>");
                                out.println("<td>" + rs.getString("ISBN") + "</td>");
                                out.println("<td>" + rs.getString("Book_Name") + "</td>");
                                out.println("<td>" + rs.getString("Author") + "</td>");
                                out.println("<td>" + rs.getString("Count") + "</td>");
                                out.println("<td>" + rs.getString("Type") + "</td>");
                                out.println("<td>");

                                String s = rs.getString("ISBN");
                                PreparedStatement p = con.prepareStatement("SELECT * FROM issued WHERE reg_no ='" + reg_no + "' and isbn='" + s + "'");
                                System.out.println();
                                r = p.executeQuery();
                                int n = Integer.parseInt(rs.getString("Count"));
                                Blob imageBlob = rs.getBlob("poster");
                                byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
                                out.write("<img style='width:140px;height:235px'src=\"data:image/jpeg;base64," + new String(Base64.getEncoder().encode(imageBytes)) + "\"/>");
                                out.println("</td>");
                                if (n != 0) {
                                    if (!r.next()) {
                    %>
                    <td>
                        <form method="post" action="http://localhost:8080/LMS/WEBPAGES/issue.jsp?para=<%=rs.getString("ISBN")%>&para2=<%=rs.getString("book_name")%>">
                            <button type="submit" id="enbtn" class="text-white bg-green-500 hover:bg-green-600 font-bold py-2 px-4 rounded" name="reg">Issue Book</button>
                        </form>
                    </td>
                    <%
                        out.println("</tr>");
                    } else {%>
                    <td>
                        <button type="submit" id="disbtn" name="reg" style="background-color: brown" class="text-white bg-red-500 hover:bg-green-600 font-bold py-2 px-4 rounded" disabled>Can't Issue Book</button>
                    </td>
                    <%}
                    } else {%>
                    <td>
                        <button type="submit" id="disbtn" name="reg" style="background-color: brown" class="text-white bg-red-500 hover:bg-green-600 font-bold py-2 px-4 rounded" disabled>Can't Issue Book</button>
                    </td>
                    <%
                                }
                            }

                            rs.close();
                            ps.close();
                            con.close();
                        } catch (ClassNotFoundException e) {
                            e.printStackTrace();
                        }
                    %>
                </table>
            </div>
            <br><br>

            <form id="" action='dashboard.jsp' method='post'>
                <button id="home" class="w-full bg-teal-600 text-white px-4 py-2 rounded-lg hover:bg-teal-400">Dashboard</button>
            </form>
        </div>
    </body>
</html>