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
            	<ul class="nav flex-column">
            		<li class="nav-item">
            		 <a class="nav-link" href="#">
                		Bill
              		</a>
            		</li>
             		 <li class="nav-item">
            		 <a class="nav-link" href="#">
               		 Material
              		</a>
            		</li>
            </ul> 
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
          <h1 class="h2">Bills</h1>      
        </div>
	 
        <!-- Page content goes here -->
       
    <div class="card mt-5">
        <div class="card-header">
        	<h1 class="h3">Completed Service Request</h1>
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
            </tr>
        </thead>
        <tbody>
        
         <%
        
         try
         {
        Connection con=DbConnector.getConnection();
        String query = "SELECT service_id,service_item_name,service_status,service_date,service_description,COUNT(workorder_id) AS total_count,SUM(workorder_cost) AS total_sum,customer_name,customer_contact,carpenter_name,carpenter_contact,sum(CASE WHEN workorder_status = 'Completed' THEN 1 ELSE 0 END) as completed_workorders from service left join workorder on service.service_id = workorder.fk_service_id left join customer on service.fk_customer_id = customer.customer_id LEFT JOIN carpenter ON service.fk_carpenter_id = carpenter.carpenter_id where service_status = 'Completed' GROUP BY service_id,customer_name, customer_contact,carpenter_name,carpenter_contact;";
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
 <h1 class="h3">Create Bill</h1>
        </div>
        <div class="card-body">
        <div class="container">
    <form id="costForm" method="get" action="createbill">
        <div class="form-group">
            <label for="serviceId">Service ID</label>
            <select class="form-control" id="serviceId" name ="serviceId" onchange="updateCosts()" onclick='updateCosts()'>
               <% 
        try
         {
        Connection con=DbConnector.getConnection();
        String query = "select service_id,SUM(workorder_cost) AS total_sum from service left join workorder on workorder.fk_service_id=service.service_id where service_Status ='Completed' group by service_id;";
        Statement statement = con.createStatement();
        ResultSet resultSet = statement.executeQuery(query);

        // Loop through the result set and populate the Bootstrap table
        while (resultSet.next()) {
        	int sid=resultSet.getInt("service_id");
            int materialcost = resultSet.getInt("total_sum");

            out.println("<option value='" + sid+ "' data-cost='"+materialcost+"'>"+sid+"</option>");
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
		<div class="row">
        <div class="col-md-3">
            <label for="materialCost">Material Cost</label>
            <input type="text" class="form-control" id="materialCost" name="materialCost">
        </div>

        <div class="col-md">
            <label for="labourCost">Labour Cost i.e 30% of Material Cost</label>
            <input type="text" class="form-control" id="labourCost" name="labourCost">
        </div>
	
        <div class="col-md-3">
            <label for="tax">Tax @ 5%</label>
            <input type="text" class="form-control" id="tax" name="tax">
        </div>
        	</div>
		 <div class="form-group">
            <label for="tax">Additional Costs</label>
            <input type="text" class="form-control" id="additionalc" value="0">
        </div>
        
        <div class="form-group">
            <label for="totalCost">Total Cost</label>
            <input type="text" class="form-control" id="totalCost" name="totalAmount">
        </div>

        <button type="button" class="btn btn-primary ml-2 mb-2" onclick="calculateCost()">Calculate</button>
        <button type="button" class="btn btn-secondary ml-2 mb-2" onclick="clearForm()">Clear Form</button>
        <input type="submit" class="btn btn-success ml-2 mb-2" value="submit">
    </form>
</div>
        
        </div>
        </div>
        
        <div class="card mt-5">
        <div class="card-header">
 <h1 class="h3"> Bill</h1>
        </div>
        <div class="card-body">
      <div class="table-responsive">
      <table id="example" class="table table-striped data-table" style="width: 100%">
        
        <thead>
            <tr>
                <th>Service id</th>
                <th>Service Item Name</th>
                <th>Service Date</th>
                <th>Customer name & Contact </th>
                <th>Carpenter name & contact</th>
             	<th>Bill Id</th>
             	<th>Bill Date</th>
             	<th>Material Cost</th>
             	<th>Total Bill</th>
             	<th>View Bill</th>
            </tr>
        </thead>
        <tbody>
        
         <%
        
         try
         {
        Connection con=DbConnector.getConnection();
        String query = "SELECT service_id,service_item_name,service_status,service_date,bill.*,customer_name,customer_contact,carpenter_name,carpenter_contact from service left join bill on service.service_id = bill.fk_service_id left join customer on service.fk_customer_id = customer.customer_id LEFT JOIN carpenter ON service.fk_carpenter_id = carpenter.carpenter_id where service_status = 'Billed';";
        Statement statement = con.createStatement();
        ResultSet resultSet = statement.executeQuery(query);
	
        // Loop through the result set and populate the Bootstrap table
        while (resultSet.next()) {
        	int serviceid=resultSet.getInt("service_id");
            String serviceName = resultSet.getString("service_item_name");
           	java.sql.Date serviceDate = resultSet.getDate("service_date");
            
            String customer = resultSet.getString("customer_name");
            String cuscontact = resultSet.getString("customer_contact");
            
            String carpenterName = resultSet.getString("carpenter_name");
            String carpenterContact = resultSet.getString("carpenter_contact");
            
            int billid= resultSet.getInt("bill_id");
            int billtotal= resultSet.getInt("bill_total_cost");
            int billmaterialcost= resultSet.getInt("bill_material_cost");
        	java.sql.Date billdate= resultSet.getDate("bill_date");
            // Format the date as needed (adjust the pattern accordingly)
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String sformattedDate = dateFormat.format(serviceDate);
            String bformattedDate = dateFormat.format(billdate);
            out.println("<tr>");
            out.println("<td>" + serviceid + "</td>");
            out.println("<td>" + serviceName + "</td>");
         
            out.println("<td>" + sformattedDate + "</td>");
           
            out.println("<td>" + customer + " "+ cuscontact+"</td>");
            out.println("<td>" + carpenterName + " "+carpenterContact+"</td>");
            out.println("<td>" + billid + "</td>");
            out.println("<td>" + bformattedDate + "</td>");
            out.println("<td>" + billmaterialcost + "</td>");
            out.println("<td>" + billtotal + "</td>");
            out.println("<td><button class='btn btn-primary'>View</button>'</td>");
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
  <!-- Bootstrap and JavaScript libraries -->
  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
  <script>
	 function updateCosts() {
		 
		 var materialSelect = document.getElementById("serviceId");
         var materialCost = document.getElementById("materialCost");
         
		 var selectedServiceId = materialSelect.value;
		 
         var selectedOption = materialSelect.options[materialSelect.selectedIndex];
         var price = selectedOption.getAttribute("data-cost");
        var materialCost =parseInt(price); 
        var labourCost = parseInt(0.3 * materialCost);
        var tax = parseInt(0.05 * parseInt(materialCost + labourCost));
        document.getElementById("materialCost").value = materialCost;
        document.getElementById("labourCost").value = labourCost;
        document.getElementById("tax").value = tax;
        calculateCost();
    }

    function calculateCost() {
        // Calculate total cost
        var materialCost = parseInt(document.getElementById("materialCost").value);
        var labourCost = parseInt(document.getElementById("labourCost").value);
        var tax = parseInt(document.getElementById("tax").value);
        var additionalCost=parseInt(document.getElementById('additionalc').value);
        var totalCost = parseInt(materialCost + labourCost + tax+additionalCost);

        // Update the total cost input field
        document.getElementById("totalCost").value = totalCost;
    }

    function clearForm() {
        // Reset all input fields to their initial state
        document.getElementById("serviceId").selectedIndex = 0;
        document.getElementById("materialCost").value = "";
        document.getElementById("labourCost").value = "";
        document.getElementById("tax").value = "";
        document.getElementById('additionalc').value=0;
        document.getElementById("totalCost").value = "";
    }
    </script>
</body>
</html>
    