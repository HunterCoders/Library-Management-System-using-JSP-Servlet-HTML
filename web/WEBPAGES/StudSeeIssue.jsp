<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Fetch Data from DB</title>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.7/dist/tailwind.min.css" rel="stylesheet">
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
                position: relative;
                display: block;
                margin-left: 350px;
                text-align: center;
            }
              #home
            {
                text-align: center;
                justify-content: center;
                margin: auto;
                display: block;
                width: 150px;
                background-color: #0069d9;
                color: white;
                padding: 12px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 18px;
                color: #ffffff;
            }
        </style>
    </head>
    <body class="bg-gradient-to-br from-gray-700 to-gray-900 p-8 rounded-lg shadow-lg">
        <div class="container mx-auto py-8">
            <h1 class="text-4xl font-bold text-white mb-8">Issued Books Data</h1>


            <div class="w-full p-8 bg-gradient-to-br from-gray-600 to-gray-700 p-8 rounded-lg shadow-xl backdrop-blur-lg bg-opacity-10 rounded-lg shadow-lg">
                <%-- Display fetched data here --%>
                <%
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;

                    try {
                        // Establish the database connection
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        conn = DriverManager.getConnection("jdbc:oracle:thin:@LAPTOP-DBORBG65:1521:ORCLE", "Hack", "Athon");
                        HttpSession sess = request.getSession(false);
                        // Prepare and execute the SQL query
                        String sql = "SELECT * FROM issued WHERE reg_no = ?";
                        stmt = conn.prepareStatement(sql);
                        String reg_no = sess.getAttribute("loggedInID").toString();
                        System.out.println(reg_no);
                        stmt.setString(1, reg_no);
                        rs = stmt.executeQuery();
                %>
                <div class="table">
                    <table class="border border-gray-300 table-fixed">
                        <th>ISBN</th>
                        <th>Issue Date</th>
                        <th>Last Date</th>
                        <th>Fine</th>
                        <th>Return</th>
                            <%
                                // Display the fetched data
                                while (rs.next()) {
                                    String isbn = rs.getString("isbn");
                                    Date issueDate = rs.getDate("issue_date");
                                    Date lastDate = rs.getDate("last_date");%>
                        <tr>
                            <td><%=isbn%></td>
                            <td><%=issueDate%></td>

                            <td><%=lastDate%></td>

                            <%
                                LocalDate dbDate = rs.getDate("last_date").toLocalDate();
                                LocalDate currentDate = LocalDate.now();
                                long daysDifference = currentDate.toEpochDay() - dbDate.toEpochDay();
                                double fine;
                                if (daysDifference < 0) {
                                    fine = 0.0;%>
                            <td style="color:yellowgreen"><%=fine%></td>
                            <%
                            } else {
                                int days = (int) Math.abs(daysDifference);
                                fine = new Fine.Fine().calculateFine(days);%>
                            <td style="color:red;font-weight: 100"><%=fine%></td>

                            <%

                                }
                            %>
                            <td ><form action="http://localhost:8080/LMS/submitBook?isbn=<%=rs.getString("isbn")%>" method="post"><input type="submit" class="text-white bg-green-500 hover:bg-green-600 font-bold py-2 px-4 rounded" value="Submit Book"></form></td>
                                    <%
                                        }
                                    %>

                        </tr>
                    </table>
                </div>
               
                <%} catch (ClassNotFoundException e) {
                        e.printStackTrace();
                    }
                %>
            </div>
            <br>
             <form id="" action='dashboard.jsp' method='post'>
                    <button id="home" class="w-full bg-teal-600 text-white px-4 py-2 rounded-lg hover:bg-teal-400">Dashboard</button>
                </form>
        </div>
    </body>
</html>