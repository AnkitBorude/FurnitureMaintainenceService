<%@page import="com.furnitureservice.con.DbConnector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
          <a class="nav-link" href="/logout">Logout</a>
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
          <h1 class="h2">Work Orders</h1>
        </div>
          
		 <div class="card mt-5">
        <div class="card-header">
       <h1 class="h3">My Work Orders</h1>
        </div>
        <div class="card-body">
        <div class="row">
        <%
        try{
        Connection con=DbConnector.getConnection();
        String query = "select workorder_id,workorder_date,workorder_description,workorder_status,service_id,carpenter_name from workorder inner join service on workorder.fk_service_id=service.service_id inner join carpenter on workorder.fk_carpenter_id=carpenter.carpenter_id where service.fk_customer_id="+cid+" and service.service_status='Workorder'";
        Statement statement = con.createStatement();
        ResultSet resultSet = statement.executeQuery(query);

        // Loop through the result set and populate the Bootstrap table
        while (resultSet.next()) {
            String workorder_id = resultSet.getString("workorder_id");
           java.sql.Date workorder_date = resultSet.getDate("workorder_date");
            String workorder_description= resultSet.getString("workorder_description");
            String service_id = resultSet.getString("service_id");
          
            String carpenter_name = resultSet.getString("carpenter_name");
            String workorder_status = resultSet.getString("workorder_status");
            
            // Format the date as needed (adjust the pattern accordingly)
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String formattedDate = dateFormat.format(workorder_date );
           
            out.println("<div class='col-lg-4 col-md-6 mb-4'> <div class='card'><div class='card-body'>");
            out.println("<ul class='list-group'>");
            out.println("<li class='list-group-item active'>  WorkOrder ID " + workorder_id + "</li>");
            out.println(" <li class='list-group-item'>  Date " + formattedDate + "</li>");
            out.println(" <li class='list-group-item'>  Description " + workorder_description + "</li>");
            out.println(" <li class='list-group-item'> Service Id " + service_id  + "</li>");
            out.println(" <li class='list-group-item list-group-item-primary'> Name Carpenter " + carpenter_name + "</li>");
            out.println(" <li class='list-group-item list-group-item-success'> Current Status  " + workorder_status + "</li>");
            out.println("</ul>");
            out.println(" </div></div></div>");
        }

        // Close resources
        resultSet.close();
        statement.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
  %>
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
<script>
    document.getElementById('serviceForm').addEventListener('submit', function (event) {
        event.preventDefault();

        // Get form data
        const formData = new FormData(this);
        var customerId=document.getElementById('customerId').innerHTML;
        customerId=customerId.trim();
        formData.append('customerId', customerId.trim()); // Add customer ID

        // Get browser date
        const browserDate = new Date().toLocaleString();

        // Append browser date to form data
        formData.append('browserDate', browserDate);
        var url = 'ServiceRequestApi?sname=' +document.getElementById("serviceName").value+"&sdescription="+document.getElementById("serviceDescription").value+"&customerid="+customerId;
        // Fetch API to send form data to the server
        fetch(url, {
            method: 'GET',
        })
        .then(response => response.json())
        .then(data => {
            // Show success message
            showMessage('success', 'Form submitted successfully!');
        })
        .catch(error => {
            // Show error message
            showMessage('error', 'An error occurred while submitting the form.');
        });
    });

    document.getElementById('serviceForm').addEventListener('reset', function () {
        // Hide the message on form reset
        document.getElementById('message').style.display = 'none';
    });

    function showMessage(type, message) {
        const messageElement = document.getElementById('message');
        messageElement.textContent = message;
        messageElement.className = `alert ${type}`;
        messageElement.style.display = 'block';
    }
</script>
</body>
</html>
    