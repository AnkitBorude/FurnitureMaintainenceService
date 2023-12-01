<%@page import="com.furnitureservice.con.DbConnector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.furnitureservice.*" %> 
<%@ page import="java.time.*" %>
<%@ page import="java.text.*" %> 
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Dashboard</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
  <style>
    body {
      font-family: 'Arial', sans-serif;
    }

    #sidebar {
      background-color: #343a40;
      color: #fff;
      height: auto;
    }

    #content {
      padding: 20px;
    }

    #sidebar a {
      color: #fff; /* Change link color to white */
    }

    #sidebar a:hover {
      background-color: #555; /* Add hover effect */
    }
  </style>
</head>
<body>

  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="#">Admin Dashboard</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ml-auto">
       <li class="nav-item">
          <a class="nav-link" href="#">Logout</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">
           <%
    		int shopkeeper = (int)session.getAttribute("adminId");
          %>
          <%=shopkeeper %></a>
        </li>
      </ul>
    </div>
  </nav>

  <div class="container-fluid">
    <div class="row">
      <!-- Sidebar -->
      <nav id="sidebar" class="col-md-3 col-lg-2 d-md-block bg-dark sidebar">
        <div class="sidebar">
          <ul class="nav flex-column">
            <li class="nav-item">
              <a class="nav-link active" href="/FurnitureService/admin/dashboard.jsp">
                Dashboard
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">
                Service Request
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">
                WorkOrder
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="/FurnitureService/admin/billmaterial.jsp">
                Bill And Material
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">
                Profile
              </a>
            </li>
            <!-- Add more menu items as needed -->
          </ul>
        </div>
      </nav>

      <!-- Main content -->
      <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4" id="content">
        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
          <h1 class="h2">Bills And Material</h1>
         
        </div>
	 
        <div class="container mt-5 form-container">
        <h1 class="h3">Add New Material</h1>
    <form method="post" action="addmaterial">
        <div class="form-group">
            <label for="materialName">Material Name:</label>
            <input type="text" class="form-control" id="materialName" name="materialName" placeholder="Enter Material Name">
        </div>

        <div class="form-group">
            <label for="materialQuantity">Material Quantity:</label>
            <input type="number" class="form-control" id="materialQuantity" name="materialQuantity" placeholder="Enter Material Quantity">
        </div>

        <div class="form-group">
            <label for="materialRate">Material Rate:</label>
            <input type="number" class="form-control" id="materialRate" name="materialRate" placeholder="Enter Material Rate">
        </div>

        <div class="row">
            <div class="col-md-3">
                <button type="submit" class="btn btn-primary btn-block">Submit</button>
            </div>
            <div class="col-md-3">
                <button type="button" class="btn btn-secondary btn-block" onclick="clearForm()">Clear Form</button>
            </div>
        </div>
    </form>
</div>
   
     <div class="container mt-5 form-container"> 
      <h1 class="h3 mt-5">Update Material and Stock</h1>
    <form method="post" action="updatematerial">
        <div class="form-row">
            <div class="form-group col-md-12">
                <label for="materialName">Material Name:</label>
                <select class="form-control" id="materialName" name="materialId">
            <% 
             try
         {
        Connection con=DbConnector.getConnection();
        String query = "select material_id,material_name from material;";
        Statement statement = con.createStatement();
        ResultSet resultSet = statement.executeQuery(query);

        // Loop through the result set and populate the Bootstrap table
        while (resultSet.next()) {
        	int mid=resultSet.getInt("material_id");
            String mName = resultSet.getString("material_name");

            out.println("<option value='" + mid + "'>"+mName+"</option>");
        }

        // Close resources
        resultSet.close();
        statement.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    %>
                </select>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="materialQuantity">Material Quantity:</label>
                <input type="number" class="form-control" id="materialQuantity" name="materialQuantity" placeholder="Enter Material Quantity">
            </div>
            <div class="form-group col-md-6">
                <label for="materialRate">Material Rate:</label>
                <input type="number" class="form-control" id="materialRate" name="materialRate" placeholder="Enter Material Rate">
            </div>
        </div>

        <div class="form-row">
            <div class="col-md-6">
                <button type="submit" class="btn btn-primary btn-block">Submit</button>
            </div>
            <div class="col-md-6">
                <button type="button" class="btn btn-secondary btn-block" onclick="clearForm()">Clear Form</button>
            </div>
        </div>
    </form>
</div>
 <h1 class="h3 mt-5">Current Stock</h1>
<table class="table table-bordered table-hover">
        <thead class="thead-light">
            <tr>
                <th>Material id</th>
                <th>Material Name</th>
                <th>Material Quantity</th>
                <th>Material Rate</th>
            </tr>
        </thead>
        <tbody>
        <%
        
         try
         {
        Connection con=DbConnector.getConnection();
        String query = " select material_id,material_name,material_quantity,material_rate from material order by material_id";
        Statement statement = con.createStatement();
        ResultSet resultSet = statement.executeQuery(query);

        // Loop through the result set and populate the Bootstrap table
        while (resultSet.next()) {
        	int mid=resultSet.getInt("material_id");
            String mName = resultSet.getString("material_name");
        	 String mQuantity = resultSet.getString("material_quantity");
            String mRate= resultSet.getString("material_rate");
            
            out.println("<tr>");
            out.println("<td>" + mid + "</td>");
            out.println("<td>" + mName + "</td>");
            out.println("<td>" + mQuantity + "</td>");
            out.println("<td>" + mRate + "</td>");
            out.println("</tr>");
        }

        // Close resources
        resultSet.close();
        statement.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
        %>
		</tbody>
    </table>
      </main>
    </div>
  </div>
  <!-- Bootstrap and JavaScript libraries -->
  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

</body>
</html>
    