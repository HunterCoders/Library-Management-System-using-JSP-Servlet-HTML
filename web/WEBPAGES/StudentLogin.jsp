<%-- 
    Document   : slogin
    Created on : 10 May, 2023, 7:12:55 PM
    Author     : ARPITA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head><title>Student Login</title>
        <link rel="icon" href="../img/logo.ico" type="image/x-icon">
        <link href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css" rel="stylesheet">
        <style>
            .error-message{
                text-align: center;
                color:red;
            }
            form .success-message
            {   
                display: block;
                margin: auto;
                text-align: center;
                color: greenyellow;
            }
        </style>
        <script>
            function funBack()
            {
                if (window.parent)
                {
                    if (confirm("Do you want to Exit") === true)
                    {

                        window.parent.window.close();
                    }
                } else
                {
                    if (confirm("Do you want to Exit") === true)

                    {

                        alert("Closing window......");
                        window.close();
                    }
                }
            }
            function validate() {
                if (document.loginform.temail.value === "")
                {
                    document.getElementById("te").innerHTML = "Email is empty";
                    return false;
                } else
                    document.getElementById("te").innerHTML = "";
                if (document.loginform.tpass.value === "")
                {
                    document.getElementById("tp").innerHTML = "password is empty";
                    return false;
                }
                document.getElementById("tp").innerHTML = "";
            }
        </script>
    </head>

    <body class="bg-gradient-to-br from-gray-700 to-gray-900 p-8 rounded-lg shadow-lg">
        <div class="flex justify-center items-center h-screen">
            <div class="bg-gradient-to-br from-gray-600 to-gray-700 p-8 rounded-lg shadow-xl backdrop-blur-lg bg-opacity-10">
                <div class="text-center">
                    <h1 class="text-2xl font-bold text-white">STUDENT LOGIN</h1>
                </div>
                <form class="" name="loginform" onsubmit="return validate()" method="POST" action="http://localhost:8080/LMS/Login">
                    <div class="mt-4">
                        <input type="text" name="Regno" placeholder="Reg No" class="w-full px-4 py-2 text-black rounded-lg border border-gray-300 focus:outline-none focus:border-indigo-500" />
                    </div>
                    <div class="mt-4">
                        <input type="password" name="pass" placeholder="Password" class="w-full px-4 text-black py-2 rounded-lg border border-gray-300 focus:outline-none focus:border-indigo-500" />
                    </div>
                    <div class="mt-8 flex justify-center">
                        <button class=" text-white bg-teal-600 px-4 py-2 hover:bg-teal-400 rounded-lg mr-4" type="submit" value="login" name="button">Login</button>
                        <a href="http://localhost:8080/LMS/WEBPAGES/index.html">
                        <button class="text-white bg-teal-600 px-4 py-2 hover:bg-teal-400 rounded-lg" type="button">Home</button>
                        </a>
                    </div>
                    <div class="mt-4 text-center">
                        <a class="text-white font-bold  hover:underline" href="http://localhost:8080/LMS/WEBPAGES/Register.jsp">Not Registered? Click Here</a>
                    </div>
                    <br>
                    <%
                        String error = request.getParameter("param");
                        if (error != null && error.equals("invalid")) {
                            out.println("<span class=\"error-message\" id=\"er\">Invalid username or password</span>");
                        } else if (error != null && error.equals("login")) {
                            out.println("<span class=\"error-message\" id=\"er\">Login Yourself First</span>");
                        } else if (error != null && error.equals("reset")) {
                            out.println("<span class=\"success-message\" id=\"er\">Reset Password Success</span>");
                        } else if (error != null && error.equals("login-success")) {
                            out.println("<span class=\"success-message\" id=\"er\">Registration Success</span>");
                        }
                    %>
                </form>
            </div>
        </div>
    </body>
</html>