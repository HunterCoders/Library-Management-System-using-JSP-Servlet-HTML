<!DOCTYPE html>
<html>
    <head>
        <title>Add Book</title>
        <link rel="stylesheet" type="text/css" href="..\CSS\AddBookCSS.css">
        <script>
            function validateTitle(idval)
            {
            if (idval.value === "")
            {
            document.getElementById("nmerr").innerHTML = "Enter a Name";
            return false;
            } else
            {
            document.getElementById("nmerr").innerHTML = "";
            return true;
            }
            }
            function imgLoad(event)
            {

            var image = document.getElementById('imgout');
            fname = event.target.files[0].name;
            ext = fname.replace(/^.*\./, '');
            if (ext === 'png' || ext === 'jpg' || ext === 'jpeg')
            {
            image.src = URL.createObjectURL(event.target.files[0]);
            document.getElementById("err").innerHTML = "";
            return true;
            } else
            {
            document.getElementById("err").innerHTML = "Only png, jpg, jpeg types allowed";
            image.src = "null/";
            return false;
            }
            }
            ;
            function validateHobby()
            {
            var x = document.getElementsByName("movtype");
            okay = false;
            for (var i = 0; i < x.length; i++)
            {
            if (x[i].checked)
            {
            okay = true;
            break;
            }
            }
            if (okay)
            {
            document.getElementById("typeerr").innerHTML = "";
            return true;
            } else
            {
            document.getElementById("typeerr").innerHTML = "Select Atleast One Type";
            return false;
            }
            }
            function checkImg()
            {
            if (document.getElementById('imgout').src === "http://localhost:8080/TestProject/Pages/HTML%20Pages/null")
            {
            document.getElementById("err").innerHTML = "Select an Image";
            return false;
            } else
            {
            document.getElementById("err").innerHTML = "";
            return true;
            }
            }
            function validate()
            {
            a = validateHobby();
            b = validateTitle(document.getElementById("title"));
            c = checkImg();
            if (a && b && c)
            {
            return true;
            } else
            {
            return false;
            }
            }

            function validateISBN(idval)
            {
            let isbn = idval.value;
            isbn = isbn.replace(/[-\s]/g, '');
            // Check if the provided ISBN is 13 characters long after removing hyphens and spaces
            if (isbn.length !== 13) {
                 document.getElementById("isbnerr").innerHTML = "Check ISBN Length";
            return false;
            }

            // Validate using the ISBN-13 algorithm
            let sum = 0;
            for (let i = 0; i < 12; i++) {
            sum += parseInt(isbn[i]) * ((i % 2 === 0) ? 1 : 3);
            }

            const checkDigit = (10 - (sum % 10)) % 10;
            if( parseInt(isbn[12]) !== checkDigit)
            {
                document.getElementById("isbnerr").innerHTML = "Ivalid ISBN-13";
                return false;
            }
            else
            {
                document.getElementById("isbnerr").innerHTML = "";
                return true;
            }
            }

        </script>
    </head>
    <body>
        <form onsubmit="return validate()" method="POST" action="http://localhost:8080/LMS/AddBook" enctype="multipart/form-data">
            <div class="container">
                <h1>Add Book</h1>

                <label for="name">ISBN:</label>
                <input type="text" id="title" name="isbn" onblur="validateISBN(this)">
                <span id="isbnerr" style="color:red"></span><br>

                <label for="name">Book Name:</label>
                <input type="text" id="title" name="name" onblur="validateTitle(this)">
                <span id="nmerr" style="color:red"></span><br>

                <label for="name">Book Author:</label>
                <input type="text" id="author" name="author" onblur="validateAuthor(this)">
                <span id="auerr" style="color:red"></span><br>

                <label for="type">Book Type:</label>
                <select id="type" name="type">
                    <option value="">---</option>s
                    <option value="Book">Book</option>
                    <option value="Journal">Journal</option>
                </select>
                <span id="terr" style="color:red"></span><br>
                <br>
                <div >

                    <label for="desc">Give a description:</label><br>
                    <textarea id="desc" name="desc" onchange ="validateDesc(this)" style="width:100%; height:50px"></textarea>
                    <br>
                    <br>
                    <label for="count">Number of Books Recieved:</label><br>
                    <input type="number" id="count" name="count">
                    <br>
                    <br>
                    <label for="Poster">Book Poster</label>
                    <input type="file" id="image" name="Poster" onchange ="imgLoad(event)">
                    <img id="imgout" width="140" height="235" src=null disabled/>
                    <span id="imgerr" style="color:red"></span> 
                    <br>
                    <br>
                    <span id="err" style="color:red"></span><br>
                    <button  type="submit" name="submit" id="done">Add Book</button>
                    <br>
                    <br>
                    <div class="error">
                        <%
                            String error = request.getParameter("status");
                            if (error != null && error.equals("success")) {
                                out.println("<span class=\"success-msg\">ADDED SUCCESFULLY</span>");
                            } else if (error != null && error.equals("exists")) {
                                out.println("<span class=\"error-msg\">Failed To Add. Book Already Exists</span>");
                            } else if (error != null && error.equals("empty")) {
                                out.println("<span class=\"error-msg\">Field(s) Is Empty</span>");
                            } else {
                                out.println("<span class=\"error-msg\"></span>");
                            }
                        %>
                    </div>
                </div>
            </div>
            <br>
        </form>
        <div class='homediv'>
            <form action="http://localhost:8080/LMS/WEBPAGES/LibrarianOptions.jsp" method="post">
                <button id="home">Admin Home</button>
            </form>
        </div>
    </body>
</html>
