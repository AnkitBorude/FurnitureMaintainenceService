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
              <a class="nav-link" href="/FurnitureService/customer/dashboard.jsp"">
                Service Request
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="/FurnitureService/customer/workorder.jsp">
                WorkOrder
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">
                Bill
              </a>
            </li>
             <li class="nav-item">
              <a class="nav-link" href="#">
                Profile
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
         <div class="card mt-5" id="card-form">
        <div class="card-header">
          <h1 class="h3">Create New Service Request</h1>
        </div>
        <div class="card-body">
         
			<div class="container mt-2">
    <form id="serviceForm">
        <div class="form-group">
            <label for="serviceName">Service Item Name:</label>
            <input type="text" class="form-control" id="serviceName" name="serviceN" required>
        </div>

        <div class="form-group">
            <label for="serviceDescription">Description of Required Service:</label>
            <textarea class="form-control" id="serviceDescription" name="serviceDes" rows="4" required></textarea>
        </div>

        <button type="submit" class="btn btn-success">Submit</button>
        <button type="reset" class="btn btn-secondary">Reset</button>
    </form>

    <div id="message" class="mt-3 alert" role="alert" style="display: none;"></div>
</div>
</div>
</div>
<hr>

 <div class="card">
        <div class="card-header">
       <h2>My Service Data</h2>
        </div>
        <div class="card-body">
      <div class="table-responsive">
      <table class="table table-striped data-table" style="width: 100%">
        <thead>
            <tr>
                <th>Service item Name</th>
                <th>Service Date</th>
                <th>Service Description</th>
                <th>Carpenter and Contact</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
        
        <%
        try{
        Connection con=DbConnector.getConnection();
        String query = "SELECT service_item_name, service_date, service_description,carpenter_name,carpenter_contact,service_status FROM service left join carpenter on service.fk_carpenter_id=carpenter.carpenter_id where fk_customer_id="+cid;
        Statement statement = con.createStatement();
        ResultSet resultSet = statement.executeQuery(query);

        // Loop through the result set and populate the Bootstrap table
        while (resultSet.next()) {
            String serviceName = resultSet.getString("service_item_name");
           java.sql.Date serviceDate = resultSet.getDate("service_date");
            String serviceDescription = resultSet.getString("service_description");
            String carpenter = resultSet.getString("carpenter_name");
          
            String carcontact = resultSet.getString("carpenter_contact");
            String service_status = resultSet.getString("service_status");
            if(carpenter==null)
            {
            	carpenter="Not Assigned";
            	carcontact="";
            }
            // Format the date as needed (adjust the pattern accordingly)
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String formattedDate = dateFormat.format(serviceDate);
           
            out.println("<tr>");
            out.println("<td>" + serviceName + "</td>");
            out.println("<td>" + formattedDate + "</td>");
            out.println("<td>" + serviceDescription + "</td>");
            out.println("<td>" + carpenter+" "+carcontact + "</td>");
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
            showMessage('success', 'Service Request Created Successfully !');
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
    