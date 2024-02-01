<%-- 
    Document   : DeAllocate
    Created on : 12 Apr, 2023, 1:04:17 AM
    Author     : Anurag Sinha
--%>

<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html>
    <head>
        <title>See Students</title>
        <style>
            /* Set styles for the table */
            table {
                border-collapse: collapse;
                width: 100%;
            }

            th, td {
                padding: 8px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #f2f2f2;
                color: #333;
            }

            /* Set styles for the table header */
            .table-header {
                background-color: #333;
                color: #fff;
                height: 50px;
                line-height: 50px;
                padding: 0 20px;
                font-size: 18px;
            }

            /* Set styles for table rows */
            tr:hover {
                background-color: #f5f5f5;
            }

            /* Set styles for alternating table rows */
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
            #home
            {
                background-color: #0069d9;
                color: white;
                padding: 12px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 18px;
                color: #ffffff;
            }
            #back
            {
                background-color: #4CAF50;;;
                color: white;
                padding: 12px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 18px;
                color: #ffffff;
            }
            #btn
            {
                text-align: center;
            }

        </style>
        <meta charset="UTF-8">
        <title>Students Registered</title>
        <link rel="stylesheet" type="text/css" href="">
        <script> function funSub()
            {
                if (confirm("Are you sure to remove this account???") === true)
                    return true;
                else
                    return false;
            }
        </script>
    </head>
    <body>
        <header>
            <h1>Students</h1>
        </header>

        <table>
            <thead>
                <tr>
                    <th>ISBN</th>
                    <th>Reg. No</th>
                    <th>Name</th>
                    <th>Issue Date</th>
                    <th>Last Date</th>
                    <th>Fine</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    // Connect to the database
                    Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcle", "Hack", "Athon");

                    // Retrieve movies for the selected city from the database
                    String searchInput = request.getParameter("searchQuery");
                    String query = "SELECT * FROM issued WHERE name like ? or isbn like ? or reg_no like ?";
                    PreparedStatement stmt = conn.prepareStatement(query);
                    stmt.setString(1, "%" + searchInput + "%");
                    stmt.setString(2, "%" + searchInput + "%");
                    stmt.setString(3, "%" + searchInput + "%");
                    ResultSet rs = stmt.executeQuery();

                    // Loop through the results and display each movie in a table row
                    while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getString(1)%></td>
                    <td><%= rs.getString(2)%></td>
                    <td><%= rs.getString(3)%></td>
                    <td><%= rs.getString(4).substring(0, rs.getString(4).indexOf(' '))%></td>
                    <td><%= rs.getString(5).substring(0, rs.getString(5).indexOf(' '))%></td>
                    <%
                        LocalDate dbDate = rs.getDate("last_date").toLocalDate();
                        LocalDate currentDate = LocalDate.now();
                        long daysDifference = currentDate.toEpochDay() - dbDate.toEpochDay();
                        double fine;
                        if (daysDifference < 0) {
                            fine = 0.0;%>
                            <td style="color:green"><%=fine%></td>
                            <%
                        } else {
                            int days = (int) Math.abs(daysDifference);
                            fine = new Fine.Fine().calculateFine(days);%>
                            <td style="color:red;font-weight: 100"><%=fine%></td>
                <%
                        }
                    %>
                    
                    
                </tr>

                </form>
                <%
                    }

                    // Close the database connection
                    conn.close();
                %>

            </tbody>
        </table>
        <br>
        <div id="btn">

            <br>
            <form action="http://localhost:8080/LMS/WEBPAGES/LibrarianOptions.jsp" method="post">
                <button id="home">Admin Home</button>
            </form>
        </div>
    </body>
</html>
