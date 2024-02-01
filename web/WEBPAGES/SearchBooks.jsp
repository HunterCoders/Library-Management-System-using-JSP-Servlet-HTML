<!DOCTYPE html>
<html>
    <head>
        <title>Book Search</title>
        <style>
            body
            {
                display: flex;
                flex-direction: column;
                align-items: center;
                margin-top: 50px;
            }
            /* Some basic styling for demonstration purposes */
            input[type="text"] {
                padding: 8px;
                font-size: 16px;
            }
            input[type="submit"] {
                font-size: 18px;
                padding: 10px 20px;
                margin-bottom: 20px;
                background-color: #4CAF50;
                color: white;
                border: none;
                cursor: pointer;
                border-radius: 5px;
            }
            #home
            {
                display: block;
                margin: auto;
                background-color: #0069d9;
                color: white;
                padding: 12px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 18px;
                color: #ffffff;
                
            }
            .error-message{
                text-align: center;
                color:red;
            }
           .success-msg
            {   
                text-align: center;
                font-size:20px;
                display: block;
                margin: auto;
                text-align: center;
                color: green;
            }
        </style>
    </head>
    <body>
        <h2>Search Books</h2>
        <form action="http://localhost:8080/LMS/WEBPAGES/BookServlet.jsp" method="get">
            <label for="search">Search:</label>
            <input type="text" id="search" name="searchQuery" placeholder="Enter book name">
            <input type="submit" value="Search">
        </form>
        <form action="http://localhost:8080/LMS/WEBPAGES/LibrarianOptions.jsp" method="post">
            <button id="home">Admin Home</button>
            <br>
            <%
                            String error = request.getParameter("param");
                            if (error != null && error.equals("del")) {
                                out.println("<span class=\"success-msg\">Delete Success</span>");
                            } else if (error != null && error.equals("update")) {
                                out.println("<span class=\"success-msg\">Count Update Success</span>");
                            } else if (error != null && error.equals("empty")) {
                                out.println("<span class=\"error-msg\">Field(s) Is Empty</span>");
                            } else {
                                out.println("<span class=\"error-msg\"></span>");
                            }
                        %>
        </form>
    </body>
</html>
