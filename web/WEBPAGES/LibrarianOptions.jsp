<!DOCTYPE html>
<html>
    <head>
        <title>Librarian Options</title>
        <link rel="stylesheet" type="text/css" href="..\CSS\AdminOptionsCSS.css">
    </head>
    <body>
        <h1>Libararian Options</h1>
        <div class="options">
           
            <form method="post" action="http://localhost:8080/LMS/WEBPAGES/AddBook.jsp">
                <button type="submit" name="">Add Books</button>
            </form>
             <form method="post" action="http://localhost:8080/LMS/WEBPAGES/SearchBooks.jsp">
                <button type="submit" name="reg">Search Books</button>
            </form>
             <form method="post" action="http://localhost:8080/LMS/WEBPAGES/ListAllStudent.jsp">
                <button type="submit" name="reg">List All Students</button>
            </form>
            <form method="post" action="http://localhost:8080/LMS/WEBPAGES/ListAllBooks.jsp">
                <button type="submit" name="book">List All Books</button>
            </form>
            <form method="post" action="http://localhost:8080/LMS/WEBPAGES/SearchStudent.jsp">
                <button type="submit" name="">List Issued Details</button>
            </form>
            <form action="http://localhost:8080/LMS/WEBPAGES/index.html" method="post">
                <button id="home">Logout</button>
            </form>

        </div>
    </body>
</html>