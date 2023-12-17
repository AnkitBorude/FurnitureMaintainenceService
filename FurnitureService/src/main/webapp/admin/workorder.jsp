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
      background-color: #563d7c;
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
    #navbar
    {
    	 background-color: #563d7c;
    }
  </style>
</head>
<body>

  <nav class="navbar navbar-expand-lg navbar-dark" id="navbar">
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
      <nav id="sidebar" class="col-md-3 col-lg-2 d-md-block sidebar">
        <div class="sidebar-sticky">
          <ul class="nav flex-column">
            <li class="nav-item">
              <a class="nav-link active" href="/FurnitureService/admin/dashboard.jsp">
                Dashboard
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href=#>
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
          <h1 class="h2">Service Requests</h1>
         
        </div>
	 
        <!-- Page content goes here -->
       <div class="card mt-5" id="card-form">
        <div class="card-header">
<h1 class="h3">My WorkOrders</h1>
        </div>
        <div class="card-body">
     <div class="container mt-5 form-container"> 
     
   <table class="table table-striped data-table" style="width: 100%">
        <thead>
            <tr>
                <th>Work id</th>
                <th> Service ID</th>
                 <th>Service Date</th>
                <th>Service Name</th>
                <th>workorder Status</th>
            	<th>workorder cost</th>
            	<th>workorder date</th>
                <th>Customer name & contact </th>
                <th>Carpenter Name & Contact</th>
                <th>Approve</th>
                <th>Decline</th>
            </tr>
        </thead>
        <tbody>
        
         <%
        
         try
         {
        Connection con=DbConnector.getConnection();
        String query = "select workorder_id,fk_service_id,service_item_name,service_date,service_status,workorder_status,carpenter_name,carpenter_contact,workorder_description,workorder_cost,workorder_date,customer_name,customer_contact from workorder inner join carpenter on workorder.fk_carpenter_id=carpenter.carpenter_id inner join service on workorder.fk_service_id=service.service_id inner join customer on service.fk_customer_id=customer.customer_id where service.service_status='Workorder'";
        Statement statement = con.createStatement();
        ResultSet resultSet = statement.executeQuery(query);

        // Loop through the result set and populate the Bootstrap table
        while (resultSet.next()) {
        	
        	
        	int serviceid=resultSet.getInt("fk_service_id");
            String serviceName = resultSet.getString("service_item_name");
           	java.sql.Date serviceDate = resultSet.getDate("service_date");
            
            int workorderid=resultSet.getInt("workorder_id");
            String workorderStatus = resultSet.getString("workorder_status");
            String workorderDescription = resultSet.getString("workorder_description");
            int workordercost=resultSet.getInt("workorder_cost");
        	java.sql.Date workDate = resultSet.getDate("workorder_date");
        	
            String customer = resultSet.getString("customer_name");
            String cuscontact = resultSet.getString("customer_contact");
            
            String carpentername = resultSet.getString("carpenter_name");
            String carcontact = resultSet.getString("carpenter_contact");
            
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String sformattedDate = dateFormat.format(serviceDate);
            String wformattedDate= dateFormat.format(workDate);
           //changing the following data value
           
            out.println("<tr>");
            out.println("<td>" + workorderid + "</td>");
            out.println("<td>" + serviceid + "</td>");
            out.println("<td>" + sformattedDate + "</td>");
            out.println("<td>" + serviceName + "</td>");
            out.println("<td>" + workorderStatus + "</td>");
            out.println("<td>" + workordercost + "</td>");
            out.println("<td>" + wformattedDate + "</td>");
            out.println("<td>" + customer +" "+cuscontact+"</td>");
            out.println("<td>" + carpentername +" "+carcontact+"</td>");
            out.println("<td><form action='apprvdeclworkorder' method='post'><input type='text' name='workorderid' value='"+workorderid+"'  hidden><input type='text' name='serviceid' value='"+serviceid+"'  hidden><input type='text' name='type' value='accept'  hidden><input type='submit' value ='Accept' class='btn btn-success'></form></td>");
            out.println("<td><form action='apprvdeclworkorder' method='post'><input type='text' name='workorderid' value='"+workorderid+"'  hidden><input type='text' name='serviceid' value='"+serviceid+"'  hidden><input type='text' name='type' value='decline'  hidden><input type='submit' value ='Decline' class='btn btn-danger'></form></td>");
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
    </div>
    </div>
    </div>
     <div class="card mt-5" id="card-form">
        <div class="card-header">
<h1 class="h3">My WorkOrders</h1>
        </div>
        <div class="card-body">
     <div class="container mt-5 form-container"> 
     
   <table class="table table-striped data-table" style="width: 100%">
        <thead>
            <tr>
                <th>Workorder Id</th>
                <th> Service ID</th>
                 <th>Service Date</th>
                <th>Service Name</th>
                <th>Service Status</th>
                <th>Date</th>
                <th>Status</th>
            	<th>Cost</th>
                <th>Customer name & contact </th>
                <th>Carpenter Name & Contact</th>
            </tr>
        </thead>
        <tbody>
        
         <%
        
         try
         {
        Connection con=DbConnector.getConnection();
        String query = "select workorder_id,fk_service_id,service_item_name,service_date,service_status,workorder_status,carpenter_name,carpenter_contact,workorder_description,workorder_cost,workorder_date,customer_name,customer_contact from workorder inner join carpenter on workorder.fk_carpenter_id=carpenter.carpenter_id inner join service on workorder.fk_service_id=service.service_id inner join customer on service.fk_customer_id=customer.customer_id";
        Statement statement = con.createStatement();
        ResultSet resultSet = statement.executeQuery(query);

        // Loop through the result set and populate the Bootstrap table
        while (resultSet.next()) {
        	
        	
        	int serviceid=resultSet.getInt("fk_service_id");
            String serviceName = resultSet.getString("service_item_name");
           	java.sql.Date serviceDate = resultSet.getDate("service_date");
           	String serviceStatus=resultSet.getString("service_status");
            
            int workorderid=resultSet.getInt("workorder_id");
            String workorderStatus = resultSet.getString("workorder_status");
            String workorderDescription = resultSet.getString("workorder_description");
            int workordercost=resultSet.getInt("workorder_cost");
        	java.sql.Date workDate = resultSet.getDate("workorder_date");
        	
            String customer = resultSet.getString("customer_name");
            String cuscontact = resultSet.getString("customer_contact");
            
            String carpentername = resultSet.getString("carpenter_name");
            String carcontact = resultSet.getString("carpenter_contact");
            
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String sformattedDate = dateFormat.format(serviceDate);
            String wformattedDate= dateFormat.format(workDate);
           //changing the following data value
           
            out.println("<tr>");
            out.println("<td>" + workorderid + "</td>");
            out.println("<td>" + serviceid + "</td>");
            out.println("<td>" + sformattedDate + "</td>");
            out.println("<td>" + serviceName + "</td>");
            out.println("<td>" + serviceStatus + "</td>");
            out.println("<td>" + wformattedDate + "</td>");
            out.println("<td>" + workorderStatus + "</td>");
            out.println("<td>" + workordercost + "</td>");
            out.println("<td>" + customer +" "+cuscontact+"</td>");
            out.println("<td>" + carpentername +" "+carcontact+"</td>");
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
    </div>
    </div>
    </div>
      </main>
    </div>
  </div>

  <!-- Bootstrap and JavaScript libraries -->
  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

</body>
</html>
    