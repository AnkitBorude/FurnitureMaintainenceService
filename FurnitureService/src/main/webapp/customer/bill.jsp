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
  <title>Customer Dashboard</title>
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
    #card-form
    {
    background-color: #D4D4D4;
    }
  </style>
</head>
<body>

  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="#">Customer Dashboard</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ml-auto">
      <li class="nav-item">
          <a class="nav-link" href="#">
          Customer Id:- <span id="customerId">
           <%
    		int cid = (int)session.getAttribute("customerId");
          %>
          <%=cid %></span></a>
        </li>
       <li class="nav-item">
          <a class="nav-link" href="/FurnitureService/customer/logout">Logout</a>
        </li>
      </ul>
    </div>
  </nav>

  <div class="container-fluid">
    <div class="row">
      <!-- Sidebar -->
      <nav id="sidebar" class="col-md-3 col-lg-2 d-md-block bg-dark sidebar">
        <div class="sidebar-sticky">
          <ul class="nav flex-column">
             <li class="nav-item">
              <a class="nav-link" href="/FurnitureService/customer/dashboard.jsp">
                Service Request
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="/FurnitureService/customer/workorder.jsp">
                WorkOrder
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="/FurnitureService/customer/bill.jsp">
                Bill
              </a>
            </li>
          </ul>
        </div>
      </nav>

      <!-- Main content -->
      <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4" id="content">
        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
          <h1 class="h2">Welcome..</h1>
        </div>
       
 <div class="card">
        <div class="card-header">
       <h2>My Bills</h2>
        </div>
        <div class="card-body">
      <div class="table-responsive">
      <table id="example" class="table table-striped data-table" style="width: 100%">
        
        <thead>
            <tr>
                <th>Service Id</th>
                <th>Service Item Name</th>
                <th>Service Date</th>
                <th>Carpenter name & contact</th>
             	<th>Bill Id</th>
             	<th>Bill Date</th>
             	<th>Material Cost</th>
             	<th>Add .Cost</th>
             	<th>Tax</th>
             	<th>Labour Cost</th>
             	<th>Total Bill</th>
             	<th>View Bill</th>
            </tr>
        </thead>
        <tbody>
        
         <%
        
         try
         {
        Connection con=DbConnector.getConnection();
        String query = "SELECT service_id,service_item_name,service_status,service_date,bill.*,customer_id,carpenter_name,carpenter_contact from service left join bill on service.service_id = bill.fk_service_id left join customer on service.fk_customer_id = customer.customer_id LEFT JOIN carpenter ON service.fk_carpenter_id = carpenter.carpenter_id where service_status = 'Billed' and customer_id ="+cid+";";
        Statement statement = con.createStatement();
        ResultSet resultSet = statement.executeQuery(query);
	
        // Loop through the result set and populate the Bootstrap table
        while (resultSet.next()) {
        	int serviceid=resultSet.getInt("service_id");
            String serviceName = resultSet.getString("service_item_name");
           	java.sql.Date serviceDate = resultSet.getDate("service_date");
            
           
            
            String carpenterName = resultSet.getString("carpenter_name");
            String carpenterContact = resultSet.getString("carpenter_contact");
            
            int billid= resultSet.getInt("bill_id");
            int billtotal= resultSet.getInt("bill_total_cost");
            int billmaterialcost= resultSet.getInt("bill_material_cost");
            int billtax= resultSet.getInt("bill_tax");
            int billlabourcost=  resultSet.getInt("bill_labour_cost");
            int additionalcost=billtotal-(billtax+billlabourcost+billmaterialcost);
        	java.sql.Date billdate= resultSet.getDate("bill_date");
        	
            // Format the date as needed (adjust the pattern accordingly)
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String sformattedDate = dateFormat.format(serviceDate);
            String bformattedDate = dateFormat.format(billdate);
            out.println("<tr>");
            out.println("<td>" + serviceid + "</td>");
            out.println("<td>" + serviceName + "</td>");
         
            out.println("<td>" + sformattedDate + "</td>");
    
            out.println("<td>" + carpenterName + " "+carpenterContact+"</td>");
            out.println("<td>" + billid + "</td>");
            out.println("<td>" + bformattedDate + "</td>");
            out.println("<td>" + billmaterialcost + "</td>");
            out.println("<td>" + additionalcost + "</td>");
            out.println("<td>" + billtax + "</td>");
            out.println("<td>" + billlabourcost + "</td>");
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
  </div>

  <!-- Bootstrap and JavaScript libraries -->
  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

</body>
</html>
    