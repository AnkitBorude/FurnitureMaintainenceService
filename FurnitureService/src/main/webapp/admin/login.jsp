<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopkeeper's Login</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 400px;
            margin-top: 100px;
        }
        .btn-login {
            background-color: #007bff;
            color: #fff;
        }
        .btn-submit {
            background-color: #28a745;
            color: #fff;
        }
    </style>
</head>
<body>
<div class="row">
<div class="col">
<div class="container">
<%
	if(request.getAttribute("registrationMessage")!=null)
	{
		out.println("<div class='alert alert-success' role='alert'>");
        out.println(request.getAttribute("registrationMessage"));
        out.println("</div>");
    }%>
    <h2 class="mb-4">Shopkeeper's Login</h2>
    <form id="loginForm" method="post" action="login">
        <div class="form-group">
            <label for="contactNumber">Contact Number</label>
            <input type="tel" class="form-control" id="contactNumber" name="contactNumber" placeholder="Enter contact number" required>
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="Enter password" required>
        </div>
        <button type="submit" class="btn btn-login">Login</button>
        <button type="button" class="btn btn-submit ml-2" onclick="clearForm()">Clear</button>
    </form>
     <%
	if(request.getAttribute("loginfailed")!=null )
	{
		out.println("<div class='alert alert-warning' role='alert'>");
        out.println(request.getAttribute("loginfailed"));
        out.println("</div>");
    }%>
</div>
</div>
<div class="col">
<img  class ="img-fluid img-thumbnail" src="https://cdn.vectorstock.com/i/1000x1000/35/25/furniture-shop-manager-icon-outline-vector-33243525.webp"/>
</div>
</div>
<!-- Bootstrap JS and dependencies (jQuery and Popper.js) -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.7/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    // JavaScript function to clear the form
    function clearForm() {
        document.getElementById("loginForm").reset();
    }
</script>

</body>
</html>
    