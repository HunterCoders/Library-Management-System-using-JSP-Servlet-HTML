<%-- 
    Document   : issue
    Created on : 24 Nov, 2023, 11:21:25 PM
    Author     : Anurag Sinha
--%>

<%@page import="java.util.Base64"%>
<%@page import="java.sql.Blob"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.sql.Connection" %>

<%
    String bookNumber = request.getParameter("para");
    String book_name=request.getParameter("para2");
    ResultSet bookResultSet = null;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@LAPTOP-DBORBG65:1521:ORCLE", "Hack", "Athon");

        String sql = "SELECT * FROM book WHERE ISBN = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, bookNumber);

        bookResultSet = statement.executeQuery();
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css" rel="stylesheet">

        <title>Book Details and Issue</title>
        <style>
            h1{
                width: 100%;
                font-size: 50px;
                position: relative;
                text-align: center;
                color: white;
            }
            .main 
            {

                color:white;
                background-color: #4b5669;

                max-width: 1200px;
                height:780px;
                position: relative;
                margin: auto;
                border-radius:10px;
                backdrop-filter: blur(10px);
                box-shadow: 2px 2px 15px rgba(0,0,0,0.5);
                box-shadow: 1px 1px 20px rgba(255,255,255,0.2) inset;

            }
            .main .left{
                box-shadow: 2px 2px 15px rgba(0,0,0,0.5);
                float: left;
                height: 100%;
                width:40%;
            }
            .main .right
            { 
                box-shadow: 2px 2px 15px rgba(0,0,0,0.5);
                min-height: 100%;
                float:left;
                width:60%;
            }
            
            .main .right label{
                display:inline;
                color: oldlace;
                margin-left: 10%;
                margin-top: 25px;
                font-size: 25px;
                font-weight: 500;
            }
            .main .right input[disabled],input[type=text]
            {   
                display:
                background:rgba(0,0,0,.2);
                color: white;
                margin-left:10%;
                height: 40px;
                width: 60%;
                background-color: rgba(255,255,255,0.07);
                border-radius: 3px;
                padding: 15px;
                margin-top: 25px;
                font-size: 20px;
                font-weight: 300;
                border: 1px solid red;
                border-bottom-width: 2px;
            </style>
        </head>
        <body class="bg-gradient-to-br from-gray-700 to-gray-900 p-8 rounded-lg shadow-lg">
            <h1>ISSUE DETAILS</h1>
            <div class="main">
                <div class="left">
                    <%
                        HttpSession sess = request.getSession(false);

                        if (bookResultSet != null && bookResultSet.next()) {
                            // Set the content type of the response

                            // Get the image data from the result set
                            Blob imageBlob = bookResultSet.getBlob("poster");
                            byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
                            out.write("<img class='poster' style='width:100%;height:100%;border-radius:10px;'src=\"data:image/jpeg;base64," + new String(Base64.getEncoder().encode(imageBytes)) + "\"/>");

                    %>
                </div>
                <div class="right">
                    <form action="http://localhost:8080/LMS/Checkout?isbn=<%= bookResultSet.getString("ISBN")%>" method="post">
                        <div class="book-details-container">
                            

                            <table style="width:100%;margin-top: 80px">
                                    <tr><td><label for="issue">Issuer: </label></td>
                                        <td><input type="text" disabled value= <%= sess.getAttribute("loggedInUser")%>>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td> <label>Reg No:</label></td>
                                        <td> <input type="text" disabled value= "<%= sess.getAttribute("loggedInID")%>">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><label>Title:</label> </td>
                                        <td><input type="text" disabled value="<%= book_name%>"</td>
                                    </tr>
                                    <tr>
                                        <td><label>Author:</label></td>
                                        <td> <input type="text" disabled value= "<%= bookResultSet.getString("Author")%>"></td>
                                    </tr>
                                    <tr><td>
                                            <label for="">ISBN:</label> </td>
                                        <td><input type="text" disabled value= "<%= bookResultSet.getString("ISBN")%>">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><label>Type: </label> </td>
                                        <td><input type="" disabled value="<%= bookResultSet.getString("Type")%>"></td>
                                    </tr>
                                    <tr><td>
                                            <label>Description: </label></td>
                                        <td>  <input type="textarea" disabled value="<%= bookResultSet.getString("descr")%>"></td>

                                        <%
                                            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

                                            // Get today's date
                                            Date currentDate = new Date();
                                            String formattedDate = dateFormat.format(currentDate);
                                        %>
                                    <tr>
                                        <td>
                                            <label>Issue Date: </label></td>
                                        <td> <input type="text" disabled value=<%= formattedDate%>></td>
                                            <%
                                                }
                                            %>
                                    </tr>

                                    <tr>
                                    <input type="hidden" name="bookId" value="<%= (bookResultSet != null) ? bookResultSet.getString("ISBN") : 0%>">
                                    <td colspan="2" > <button style="width: 80%;display: block;margin: auto;padding: 10px;margin-top: 28px" class="w-full bg-teal-600 text-white px-4 py-2 rounded-lg hover:bg-teal-400" type="submit">Checkout</button></td>
                                    </form>
                                    </tr>


                                </table>
                            </div>
                    </div>
                </div>     
            </body>
        </html>