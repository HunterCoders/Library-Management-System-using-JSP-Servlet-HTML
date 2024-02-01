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
    <body>
        <h2>Search Books or Students</h2>
        <form action="http://localhost:8080/LMS/WEBPAGES/SeeIssuedData.jsp" method="get">
            <label for="search">Name or ISBN:</label>
            <input type="text" id="search" name="searchQuery" placeholder="Enter Student Name or ISBN">
            <input type="submit" value="Search">
        </form>
        <form action="http://localhost:8080/LMS/WEBPAGES/LibrarianOptions.jsp" method="post">
            <button id="home">Admin Home</button>
        </form>
    </body>
</html>
