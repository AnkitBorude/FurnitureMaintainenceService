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
          <a class="nav-link" href="/FurnitureService/admin/logout">Logout</a>
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
              <a class="nav-link" href="/FurnitureService/admin/workorder.jsp">
                WorkOrder
              </a>
            </li>
            <li class="nav-item">
            	<ul class="nav flex-column">
            		<li class="nav-item">
            		 <a class="nav-link" href="/FurnitureService/admin/bill.jsp">
                		Bill
              		</a>
            		</li>
             		 <li class="nav-item">
            		 <a class="nav-link" href="/FurnitureService/admin/billmaterial.jsp">
               		 Material
              		</a>
            		</li>
            </ul> 
            </li>
          </ul>
        </div>
      </nav>

      <!-- Main content -->
      <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4" id="content">
        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
          <h1 class="h2">Service Requests</h1>
         
        </div>
	 
        <!-- Page content goes here -->
        <div class="card">
        <div class="card-header">
        <h1 class="h3">New Service Request</h1>
        </div>
        <div class="card-body">
      <div class="table-responsive">
      <table id="example" class="table table-striped data-table" style="width: 100%">
        
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
        String query = "select service_id,service_item_name,service_date,service.service_description,fk_customer_id,customer_name,customer_contact,customer_address from service inner join customer on service.fk_customer_id=customer.customer_id where service.fk_carpenter_id is null";
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
            // Format the date as needed (adjust the pattern accordingly)
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
    </div>
    </div>
    </div>
    <div class="card mt-5">
        <div class="card-header">
         <h2 class="mb-4">Assign Carpenter</h2>
        </div>
        <div class="card-body">
    <div class="container form-container">
    <form action="assigncarpenter" method="get">
        <div class="form-group">
        	<label for="carpenterSelect">Select Service Id:</label>
            <select class="form-control" id="carpenterSelect" name="serviceId" id ="serviceId" required>
            <% 
             try
         {
        Connection con=DbConnector.getConnection();
        String query = "select service_id from service where service.fk_carpenter_id is null";
        Statement statement = con.createStatement();
        ResultSet resultSet = statement.executeQuery(query);

        // Loop through the result set and populate the Bootstrap table
        while (resultSet.next()) {
        	int serviceid=resultSet.getInt("service_id");
            out.println("<option value='" + serviceid + "'>"+serviceid+"</option>");
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
        <div class="form-group">
            <label for="carpenterSelect">Select Carpenter:</label>
            <select class="form-control" id="carpenterSelect" name="carid" required>
           <% 
             try
         {
        Connection con=DbConnector.getConnection();
        String query = "select carpenter_id,carpenter_name from carpenter;";
        Statement statement = con.createStatement();
        ResultSet resultSet = statement.executeQuery(query);

        // Loop through the result set and populate the Bootstrap table
        while (resultSet.next()) {
        	int carpenterid=resultSet.getInt("carpenter_id");
            String carpenterName = resultSet.getString("carpenter_name");

            out.println("<option value='" + carpenterid + "'>"+carpenterName+"</option>");
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

        <button type="submit" class="btn btn-primary btn-block">Assign</button>
    </form>
</div>
</div>
</div>
<div class="card mt-5">
        <div class="card-header">
        <h1 class="h3">Service Request Status</h1>
        </div>
        <div class="card-body">
      <div class="table-responsive">
      <table id="example" class="table table-striped data-table" style="width: 100%">
        
        <thead>
            <tr>
                <th>Service id</th>
                <th>Service Item Name</th>
                <th>Service Description</th>
                <th>Service Date</th>
                <th>Customer name </th>
                <th>Customer contact</th>
             	<th>Carpenter Name</th>
             	<th>Carpenter Contact</th>
             	<th>service status</th>
            </tr>
        </thead>
        <tbody>
        
         <%
        
         try
         {
        Connection con=DbConnector.getConnection();
        String query = "SELECT service_id,service_item_name, service_date, service_description,customer_name,customer_contact,carpenter_name,carpenter_contact,service_status FROM service left join carpenter on service.fk_carpenter_id=carpenter.carpenter_id inner join customer on service.fk_customer_id= customer.customer_id";
        Statement statement = con.createStatement();
        ResultSet resultSet = statement.executeQuery(query);
	
        // Loop through the result set and populate the Bootstrap table
        while (resultSet.next()) {
        	int serviceid=resultSet.getInt("service_id");
            String serviceName = resultSet.getString("service_item_name");
           	java.sql.Date serviceDate = resultSet.getDate("service_date");
            String serviceDescription = resultSet.getString("service_description");
            String service_status = resultSet.getString("service_status");
            
            String customer = resultSet.getString("customer_name");
            String cuscontact = resultSet.getString("customer_contact");
            
            String carpenterName = resultSet.getString("carpenter_name");
            String carpenterContact = resultSet.getString("carpenter_contact");
            
            // Format the date as needed (adjust the pattern accordingly)
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String formattedDate = dateFormat.format(serviceDate);
           
            out.println("<tr>");
            out.println("<td>" + serviceid + "</td>");
            out.println("<td>" + serviceName + "</td>");
            out.println("<td>" + serviceDescription + "</td>");
            out.println("<td>" + formattedDate + "</td>");
           
            out.println("<td>" + customer + "</td>");
            out.println("<td>" + cuscontact + "</td>");
            
            out.println("<td>" + carpenterName + "</td>");
            out.println("<td>" + carpenterContact + "</td>");
            if(service_status.equals("Assigned"))
            {
            	  out.println("<td><div class='alert alert-primary' role='alert'>" + service_status + "</td>");
            } else if(service_status.equals("Approved"))
            {
            	  out.println("<td><div class='alert alert-success' role='alert'>" + service_status + "</td>");
            }
            else if(service_status.equals("Workorder"))
            {
            	  out.println("<td><div class='alert alert-info' role='alert'>" + service_status + "</td>");
            }
            else
            {
            	out.println("<td><div class='alert alert-warning' role='alert'>" + service_status + "</td>");
            }
            
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
    
    <div class="card mt-5">
        <div class="card-header">
        <h1 class="h3">Service Request Under Working</h1>
        </div>
        <div class="card-body">
      <div class="table-responsive">
      <table id="example" class="table table-striped data-table" style="width: 100%">
        
        <thead>
            <tr>
                <th>Service id</th>
                <th>Service Item Name</th>
                <th>Service Description</th>
                <th>Service Date</th>
                <th>Customer name & Contact </th>
                <th>Carpenter name & contact</th>
             	<th>Total W/O</th>
             	<th>Completed W/O</th>
             	<th>Total Material Cost</th>
             	<th>Mark Completed</th>
            </tr>
        </thead>
        <tbody>
        
         <%
        
         try
         {
        Connection con=DbConnector.getConnection();
        String query = "SELECT service_id,service_item_name,service_status,service_date,service_description,COUNT(workorder_id) AS total_count,SUM(workorder_cost) AS total_sum,customer_name,customer_contact,carpenter_name,carpenter_contact,sum(CASE WHEN workorder_status = 'Completed' THEN 1 ELSE 0 END) as completed_workorders from service left join workorder on service.service_id = workorder.fk_service_id left join customer on service.fk_customer_id = customer.customer_id LEFT JOIN carpenter ON service.fk_carpenter_id = carpenter.carpenter_id where service_status = 'Approved' GROUP BY service_id,customer_name, customer_contact,carpenter_name,carpenter_contact;";
        Statement statement = con.createStatement();
        ResultSet resultSet = statement.executeQuery(query);
	
        // Loop through the result set and populate the Bootstrap table
        while (resultSet.next()) {
        	int serviceid=resultSet.getInt("service_id");
            String serviceName = resultSet.getString("service_item_name");
           	java.sql.Date serviceDate = resultSet.getDate("service_date");
            String serviceDescription = resultSet.getString("service_description");
            String service_status = resultSet.getString("service_status");
            
            String customer = resultSet.getString("customer_name");
            String cuscontact = resultSet.getString("customer_contact");
            
            String carpenterName = resultSet.getString("carpenter_name");
            String carpenterContact = resultSet.getString("carpenter_contact");
           
            int total_count=resultSet.getInt("total_count");
            int total_sum=resultSet.getInt("total_sum");
            int total_completed=resultSet.getInt("completed_workorders");
            
            // Format the date as needed (adjust the pattern accordingly)
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String formattedDate = dateFormat.format(serviceDate);
           
            out.println("<tr>");
            out.println("<td>" + serviceid + "</td>");
            out.println("<td>" + serviceName + "</td>");
            out.println("<td>" + serviceDescription + "</td>");
            out.println("<td>" + formattedDate + "</td>");
           
            out.println("<td>" + customer + " "+ cuscontact+"</td>");
            out.println("<td>" + carpenterName + " "+carpenterContact+"</td>");
            out.println("<td>" + total_count + "</td>");
            out.println("<td>" + total_completed + "</td>");
            out.println("<td>" + total_sum + "</td>");
            if(total_completed==total_count)
            {
                out.println("<td><form action='servicecompleted' method='post'><input type='text' name='serviceid' value='"+serviceid+"'  hidden><input type='submit' value ='Mark Completed' class='btn btn-success'></form></td>");
            }
            else
            {
       		 out.println("<td><div class='alert alert-warning' role='alert'>Under Working</td>");
            }
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
    