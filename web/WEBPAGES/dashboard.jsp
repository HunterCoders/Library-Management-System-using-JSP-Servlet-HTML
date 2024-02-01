<!DOCTYPE html>
<html>
    <head>
        <title>Book Search</title>
        <link href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css" rel="stylesheet">
        <style>
            form .success-message
            {   
                display: block;
                margin: auto;
                text-align: center;
                color: greenyellow;
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
    <body class="flex flex-col space-y-10 justify-center items-center min-h-screen bg-gradient-to-br from-gray-700 to-gray-900 p-8 rounded-lg shadow-lg">
        <p class=" text-bold text-5xl text-white">Welcome
            <%
                HttpSession sess = request.getSession(false);
                if (sess.getAttribute("loggedInUser") == null) {

                } else {
                    out.println(sess.getAttribute("loggedInUser"));
                }
            %>!
        </p>
        <div class="w-1/3 p-8 bg-gradient-to-br from-gray-600 to-gray-700 p-8 rounded-lg shadow-xl backdrop-blur-lg bg-opacity-10 rounded-lg shadow-lg">
            <h2 class="text-2xl text-center mb-8 text-white">Search Books</h2>

            <form class="max-w-sm flex space-y-5 flex-col mx-auto" action="http://localhost:8080/LMS/WEBPAGES/search.jsp" method="post">
                <label for="search" class="text-white">Search:</label>
                <input type="text" id="search" name="searchQuery" placeholder="Enter book name" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-indigo-500">
                <input type="submit" value="Search" class="w-full bg-teal-600 text-white px-4 py-2 rounded-lg hover:bg-teal-400">
                <%
                    String error = request.getParameter("param");
                    if (error != null && error.equals("issued")) {
                        out.println("<span class=\"success-message\" id=\"er\">Book Issued!!!!!</span>");
                    }
                    if (error != null && error.equals("bookSubmit")) {
                        out.println("<span class=\"success-message\" id=\"er\">Book Submitted!!!!!</span>");
                    }
                %>
            </form>
            <br>
            
            <form action="http://localhost:8080/LMS/WEBPAGES/StudSeeIssue.jsp" method="post">
            <input type="submit" value="See Issued Books" class="w-full bg-teal-600 text-white px-4 py-2 rounded-lg hover:bg-teal-400">
            </form>
            </div>
            <a href="http://localhost:8080/LMS/WEBPAGES/index.html">
            <input type="submit"  value="Home" id="home">
            </a>
    </body>
</html>