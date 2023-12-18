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
              <a class="nav-link active" href="/FurnitureService/carpenter/dashboard.jsp">
                Dashboard
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="/FurnitureService/carpenter/workorder.jsp">
                WorkOrder
              </a>
            </li>
          </ul>
        </div>
      </nav>

      <!-- Main content -->
      <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4" id="content">
        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
          <h1 class="h2">WorkOrders</h1>
         
        </div>
        <div class="card mt-2" id="card-form">
        <div class="card-header">
  <h1 class="h3">New  Assigned Services</h1>
        </div>
        <div class="card-body">
         
	  <table class="table table-striped data-table" style="width: 100%">
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
    </div>
    </div>
    
    
     <div class="card mt-5">
        <div class="card-header">
 <h1 class="h3">Create WorkOrder</h1>
        </div>
        <div class="card-body">
     <div class="container mt-5 form-container"> 
      <div class="row">
      <div class="col">
    <form method="post" action="createworkorder">
        <div class="form-row">
            <div class="form-group col-md-12">
                <label for="materialName">Select Service Id</label>
                <select class="form-control" id="materialName" name="serviceId">
            <% 
             try
         {
        Connection con=DbConnector.getConnection();
        String query = "select service_id from service where service.fk_carpenter_id = "+carpenter+" and (service.service_status='Assigned' or service.service_status='Approved')";
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
                <label for="workorderStatus">WorkOrder Status</label>
                <input type="text" class="form-control" id="workOrderStatus" name="workorderStatus" placeholder="Status">
            	 <input type="text" id="materialcost" value="0" name="materialwcost" hidden>
            </div>
        </div>
         
        <div class="form-row">
        <input type="text" id="materialcost" value="0" name="materialcost" hidden/>
            <div class="col-md-6">
                <button type="submit" class="btn btn-primary btn-block">Submit</button>
            </div>
            <div class="col-md-6">
                <button type="button" class="btn btn-secondary btn-block" onclick="clearForm()">Clear Form</button>
            </div>
        </div>
    </form>
    </div>
    <div class="col">
    	<div class="form-row">
		<div class="card mt-2 mb-2">
        <div class="card-header">
 		<h1 class="h3">Materials Required</h1>
        </div>
        <div class="card-body">
        <div class="form-row">
        <label for="material">Material:</label>
    <select id="material" class="form-control"></select>

    <label for="amount">Amount:</label>
    <input type="number" id="amount" min="1" class="form-control" required>
	</div>
	<div class="form-row mb-2"></div>
    <button id="add" class="btn btn-primary btn-block">Add</button>
	</div>
   <table class="table table-striped data-table" style="width: 100%">
        <thead>
            <tr>
                <th>Material</th>
                <th>Price</th>
                <th>Amount</th>
                <th>Total</th>
            </tr>
        </thead>
        <tbody id="table-body"></tbody>
    </table>

Total Ammount :-    Rs.  <div id="total" class="text-white bg-dark"> 0 </div>
        </div>
        </div>
    </div>
 </div>
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
                <th>Work id</th>
                <th> Service ID</th>
                 <th>Service Date</th>
                <th>Service Name</th>
                <th>Service Status</th>
                <th>workorder Status</th>
            	<th>workorder cost</th>
            	<th>workorder date</th>
                <th>Customer name & contact </th>
                <th>Mark As Completed</th>
            </tr>
        </thead>
        <tbody>
        
         <%
        
         try
         {
        Connection con=DbConnector.getConnection();
        String query = "select workorder_id,fk_service_id,service_item_name,service_date,service_status,workorder_status,workorder_description,workorder_cost,workorder_date,customer_name,customer_contact from workorder inner join carpenter on workorder.fk_carpenter_id=carpenter.carpenter_id inner join service on workorder.fk_service_id=service.service_id inner join customer on service.fk_customer_id=customer.customer_id where workorder.fk_carpenter_id= "+carpenter;
        Statement statement = con.createStatement();
        ResultSet resultSet = statement.executeQuery(query);

        // Loop through the result set and populate the Bootstrap table
        while (resultSet.next()) {
        	
        	
        	int serviceid=resultSet.getInt("fk_service_id");
            String serviceName = resultSet.getString("service_item_name");
           	java.sql.Date serviceDate = resultSet.getDate("service_date");
            String serviceStatus = resultSet.getString("service_status");
            
            int workorderid=resultSet.getInt("workorder_id");
            String workorderStatus = resultSet.getString("workorder_status");
            String workorderDescription = resultSet.getString("workorder_description");
            int workordercost=resultSet.getInt("workorder_cost");
        	java.sql.Date workDate = resultSet.getDate("workorder_date");
        	
            String customer = resultSet.getString("customer_name");
            String cuscontact = resultSet.getString("customer_contact");
            
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
            out.println("<td>" + workorderStatus + "</td>");
            out.println("<td>" + workordercost + "</td>");
            out.println("<td>" + wformattedDate + "</td>");
            out.println("<td>" + customer +" "+cuscontact+"</td>");
            if(serviceStatus.equals("Approved"))
            {
            	if(workorderStatus.equals("Completed"))
            	{
            		 out.println("<td><div class='alert alert-success' role='alert'>Workorder Completed</td>");
            	}else
            	{
            out.println("<td><form action='markcompleted' method='post'><input type='text' name='wid' value='"+workorderid+"'  hidden><input type='submit' value ='Completed' class='btn btn-success'></form></td>");
            	}
            }else
            {
            	 out.println("<td><form action='markcompleted' method='post'><input type='text' name='wid' value='"+workorderid+"'  hidden><input type='submit' value ='Completed' class='btn btn-success' disabled></form></td>");
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
   function clearForm()
   {
	    const materialSelect = document.getElementById('material');
        const amountInput = document.getElementById('amount');
        const tableBody = document.getElementById('table-body');
        const totalAmount = document.getElementById('total');
        const materialSelect2 = document.getElementById('materialName');
        const workOrder = document.getElementById('workOrder');
        const status = document.getElementById('workOrderStatus');
	   materialSelect.selectedIndex = 0;
	   materialSelect2.selectedInder=0;
	   workOrder.value='';
	   status.value='';
       amountInput.value = '';
       tableBody.innerHTML = '';
       totalAmount.textContent = '0';  
   }
        document.addEventListener('DOMContentLoaded', function () {
            // Sample data for materials
            const materials = [
            	
            	<%
            	   try
                {
               Connection con=DbConnector.getConnection();
               String query = "select material_name,material_rate from material where material_quantity>0";
               Statement statement = con.createStatement();
               ResultSet resultSet = statement.executeQuery(query);

              
               while (resultSet.next()) {
               	String MaterialName=resultSet.getString("material_name");
               	int Materialvalue=resultSet.getInt("material_rate");
                   out.println("{ name:'" + MaterialName + "', price: "+Materialvalue+"},");
               }

               // Close resources
               resultSet.close();
               statement.close();
               con.close();
           } catch (Exception e) {
               e.printStackTrace();
           }
            	%>
                { name: 'Nothing ', price: 0 }
            ];

            const materialSelect = document.getElementById('material');
            const amountInput = document.getElementById('amount');
            const addButton = document.getElementById('add');
            const tableBody = document.getElementById('table-body');
            const totalAmount = document.getElementById('total');
            // Populate material dropdown
            materials.forEach(material => {
                const option = document.createElement('option');
                option.value = material.price;
                option.textContent = material.name;
                materialSelect.appendChild(option);
            });

            addButton.addEventListener('click', function () {
                const materialName = materialSelect.options[materialSelect.selectedIndex].text;
                const materialPrice = parseFloat(materialSelect.value);
                const materialAmount = parseInt(amountInput.value);

                if (isNaN(materialAmount) || materialAmount <= 0) {
                    alert('Please enter a valid amount.');
                    return;
                }

                const totalRowPrice = materialPrice * materialAmount;

                // Create a new row in the table
                const newRow = tableBody.insertRow();
                const nameCell = newRow.insertCell(0);
                const priceCell = newRow.insertCell(1);
                const amountCell = newRow.insertCell(2);
                const totalCell=newRow.insertCell(3);
                
                nameCell.textContent = materialName;
                priceCell.textContent = materialPrice;
                amountCell.textContent = materialAmount;
                totalCell.textContent=totalRowPrice;
                // Update total amount
                updateTotal(totalRowPrice);
            });

            function updateTotal(materialPrice) {
                const currentTotal = parseFloat(totalAmount.textContent);
                const newTotal = currentTotal + materialPrice;
                totalAmount.textContent = newTotal;
                document.getElementById('materialcost').value=newTotal;
            }
        });
    </script>

</body>
</html>
