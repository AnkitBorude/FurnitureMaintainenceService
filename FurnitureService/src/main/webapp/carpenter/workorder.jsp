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
  <title>Carpenter Dashboard</title>
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
    <a class="navbar-brand" href="#">Carpenter Dashboard</a>
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
    		int carpenter = (int)session.getAttribute("carpenterId");
          %>
          <%=carpenter %></a>
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
              <a class="nav-link active" href="#">
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
              <a class="nav-link" href="#">
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
          <h1 class="h2">WorkOrders</h1>
         
        </div>
	  <h1 class="h3">New Services</h1>
        <table class="table table-bordered">
        <thead>
            <tr>
                <th>Service id</th>
                <th>Service Item Name</th>
                <th>Service Description</th>
                <th>Service Date</th>
                <th>customer id</th>
                <th>Customer name </th>
                <th>Customer contact</th>
                <th>Customer address</th>
            </tr>
        </thead>
        <tbody>
        
         <%
        
         try
         {
        Connection con=DbConnector.getConnection();
        String query = "select service_id,service_item_name,service_date,service.service_description,fk_customer_id,customer_name,customer_contact,customer_address from service inner join customer on service.fk_customer_id=customer.customer_id where service.fk_carpenter_id = "+carpenter+" and service.service_status='Assigned'";
        Statement statement = con.createStatement();
        ResultSet resultSet = statement.executeQuery(query);

        // Loop through the result set and populate the Bootstrap table
        while (resultSet.next()) {
        	int serviceid=resultSet.getInt("service_id");
            String serviceName = resultSet.getString("service_item_name");
           	java.sql.Date serviceDate = resultSet.getDate("service_date");
            String serviceDescription = resultSet.getString("service_description");
            String customer = resultSet.getString("customer_name");
          	int customerid=resultSet.getInt("fk_customer_id");
            String cuscontact = resultSet.getString("customer_contact");
            String cusaddr = resultSet.getString("customer_address");
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String formattedDate = dateFormat.format(serviceDate);
           
            out.println("<tr>");
            out.println("<td>" + serviceid + "</td>");
            out.println("<td>" + serviceName + "</td>");
            out.println("<td>" + serviceDescription + "</td>");
            out.println("<td>" + formattedDate + "</td>");
            out.println("<td>" + customerid + "</td>");
            out.println("<td>" + customer + "</td>");
            out.println("<td>" + cuscontact + "</td>");
            out.println("<td>" + cusaddr + "</td>");
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
     <div class="container mt-5 form-container"> 
      <h1 class="h3 mt-5">Create WorkOrder</h1>
    <form method="post" action="createworkorder">
        <div class="form-row">
            <div class="form-group col-md-12">
                <label for="materialName">Select Service Id</label>
                <select class="form-control" id="materialName" name="serviceId">
            <% 
             try
         {
        Connection con=DbConnector.getConnection();
        String query = "select service_id from service where service.fk_carpenter_id = "+carpenter+" and service.service_status='Assigned'";
        Statement statement = con.createStatement();
        ResultSet resultSet = statement.executeQuery(query);

        // Loop through the result set and populate the Bootstrap table
        while (resultSet.next()) {
        	int sid=resultSet.getInt("service_id");

            out.println("<option value='" + sid + "'>"+sid+"</option>");
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
            <div class="form-group col-md-12">
                <label for="workOrder">WorkOrder Description</label>
               <textarea class="form-control" id="workOrder" name="workorderDes" rows="4" required></textarea>
           </div>
            <div class="form-group col-md-6">
                <label for="materialRate">WorkOrder Status</label>
                <input type="text" class="form-control" id="materialRate" name="workorderStatus" placeholder="Status">
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
<h1 class="h3 mt-5">My WorkOrders</h1>
 <table class="table table-bordered">
        <thead>
            <tr>
                <th>Service id</th>
                <th>Service Item Name</th>
                <th>Service Description</th>
                <th>Service Date</th>
                <th>customer id</th>
                <th>Customer name </th>
                <th>Customer contact</th>
                <th>Customer address</th>
            </tr>
        </thead>
        <tbody>
        
         <%
        
         try
         {
        Connection con=DbConnector.getConnection();
        String query = "select service_id,service_item_name,service_date,service.service_description,fk_customer_id,customer_name,customer_contact,customer_address from service inner join customer on service.fk_customer_id=customer.customer_id where service.fk_carpenter_id = "+carpenter+" and service.service_status='Assigned'";
        Statement statement = con.createStatement();
        ResultSet resultSet = statement.executeQuery(query);

        // Loop through the result set and populate the Bootstrap table
        while (resultSet.next()) {
        	int serviceid=resultSet.getInt("service_id");
            String serviceName = resultSet.getString("service_item_name");
           	java.sql.Date serviceDate = resultSet.getDate("service_date");
            String serviceDescription = resultSet.getString("service_description");
            String customer = resultSet.getString("customer_name");
          	int customerid=resultSet.getInt("fk_customer_id");
            String cuscontact = resultSet.getString("customer_contact");
            String cusaddr = resultSet.getString("customer_address");
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String formattedDate = dateFormat.format(serviceDate);
           
            out.println("<tr>");
            out.println("<td>" + serviceid + "</td>");
            out.println("<td>" + serviceName + "</td>");
            out.println("<td>" + serviceDescription + "</td>");
            out.println("<td>" + formattedDate + "</td>");
            out.println("<td>" + customerid + "</td>");
            out.println("<td>" + customer + "</td>");
            out.println("<td>" + cuscontact + "</td>");
            out.println("<td>" + cusaddr + "</td>");
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
