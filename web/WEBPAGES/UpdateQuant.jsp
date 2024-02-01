<%-- 
    Document   : UpdateQuant
    Created on : 24 Nov, 2023, 8:57:06 PM
    Author     : Anurag Sinha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html>
<head>
    <title>Update Book Quantity</title>
</head>
<body>
    <h2>Update Book Quantity</h2>
     <% String isbn=request.getParameter("para");%>
    <form action="http://localhost:8080/LMS/UpdateQuant?isbn=<%=isbn%>" method="post">

        <label for="newQuantity">New Quantity:</label>
        <input type="number" id="newQuantity" name="newQuantity" required><br><br>
       
        <input type="submit" value="Update Quantity">
    </form>
</body>
</html>
