<%-- 
    Document   : Register
    Created on : 24 Nov, 2023, 10:56:14 PM
    Author     : Anurag Sinha
--%>

<%-- 
    Document   : sregister
    Created on : 24 Nov, 2023, 10:40:50 PM
    Author     : ARPITA
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script>
            function validateConfirmPass(idval)
            {
                if (idval.value === "")
                {
                    document.getElementById("confpasserr").innerHTML = "Password is Empty";
                    return false;
                } else
                {
                    x = document.getElementById("password").value;
                    if (idval.value.match(x))
                    {
                        document.getElementById("confpasserr").innerHTML = "";
                        return true;
                    } else
                    {
                        document.getElementById("confpasserr").innerHTML = "Passwords don't match";
                        return false;
                    }
                }

            }
        </script>
        <style>
            #home
            {
                align-content: center;
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

        <meta charset="UTF-8">
        <title>Registration Page</title> 
        <link href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css" rel="stylesheet">

    </style>
</head>
<body class="flex justify-center items-center min-h-screen bg-gradient-to-br from-gray-700 to-gray-900 p-8 rounded-lg shadow-lg">
    <div class="w-1/3 p-8 bg-gradient-to-br from-gray-600 to-gray-700 p-8 rounded-lg shadow-xl backdrop-blur-lg bg-opacity-10 rounded-lg shadow-lg">
        <h2 class="text-2xl text-center text-white mb-8">Register Student</h2>

        <% String error = request.getParameter("error");
            if ("invalidEmail".equals(error)) { %>
        <p class="text-red-500 text-center mb-4">Invalid email address. Please use an email ending with '@vitstudent.ac.in'.</p>
        <% } else if ("passwordMismatch".equals(error)) { %>
        <p class="text-red-500 text-center mb-4">Password and Confirm Password do not match.</p>
        <% } else if ("registrationFailed".equals(error)) { %>
        <p class="text-red-500 text-center mb-4">Registration failed. Please try again.</p>
        <% } else if ("databaseError".equals(error)) { %>
        <p class="text-red-500 text-center mb-4">Database error. Please try again later.</p>
        <% } %>

        <form class="max-w-sm mx-auto" action="http://localhost:8080/LMS/RegisterServlet" method="post">
            <div class="mb-4">
                <label for="email" class="block text-white mb-1">Email:</label>
                <input type="text" id="email" name="email" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-indigo-500">
            </div>

            <div class="mb-4">
                <label for="name" class="block text-white mb-1">Name:</label>
                <input type="text" id="name" name="name" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-indigo-500">
            </div>

            <div class="mb-4">
                <label for="registerNumber" class="block text-white mb-1">Register No:</label>
                <input type="text" id="regno" name="regno" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-indigo-500">
            </div>

            <div class="mb-4">
                <label for="password" class="block text-white mb-1">Password:</label>
                <input type="password" id="password" name="pass" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-indigo-500">
            </div>

            <div class="mb-4">
                <label for="confirmPassword" class="block text-white mb-1">Confirm Password:</label>
                <input type="password" id="confirmPassword" onblur="validateConfirmPass(this)" name="confirmPassword" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-indigo-500">
                <span id="confpasserr" style="color:red"></span>
            </div>

            <% String err = request.getParameter("error");
                if (err != null && err.equals("invalid")) {
                    out.println("<div class='text-red-500 text-center mb-4'>RegNo. Already Exists. Login</div>");
                }
            %>

            <button type="submit" class="w-full bg-teal-600 text-white px-4 py-2 rounded-lg hover:bg-teal-400">Create Account</button>
        </form>
        <div class="mt-4 text-center">
            <a class="text-white font-bold  hover:underline" href="http://localhost:8080/LMS/WEBPAGES/StudentLogin.jsp">Registered?Login Here</a>
        </div>
        <br>
        <a href="http://localhost:8080/LMS/WEBPAGES/index.html">
            <button id="home" style="display: block;margin: auto"  type="button">Home</button>
        </a>
    </div>
</body>

</html>