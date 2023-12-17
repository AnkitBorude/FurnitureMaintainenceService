package com.furnitureservice.workorder;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.furnitureservice.con.DbConnector;

@WebServlet("/carpenter/createworkorder")
public class CreateWorkOrder extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
			String serviceId = request.getParameter("serviceId");
	        String workorderDes = request.getParameter("workorderDes");
	        String workorderStatus = request.getParameter("workorderStatus");
	        String workordercost =request.getParameter("materialwcost");
	        
	        java.sql.Date date = new java.sql.Date(System.currentTimeMillis());
	        
	        HttpSession session= request.getSession();
			int carpenter = (int)session.getAttribute("carpenterId");
			Connection con=DbConnector.getConnection();
			try {
				 String sql = "INSERT INTO workorder (workorder_date,workorder_description, " +
		                    "workorder_status,fk_carpenter_id,fk_service_id,workorder_cost) " +
		                    "VALUES (?, ?, ?, ?,?,?)";
				PreparedStatement stmt =con.prepareStatement(sql);
				stmt.setDate(1,date);		
				stmt.setString(2,workorderDes);
				stmt.setString(3,workorderDes);
				stmt.setInt(4,carpenter);
				stmt.setInt(5,Integer.parseInt(serviceId));
				stmt.setInt(6,Integer.parseInt(workordercost));
				int row=stmt.executeUpdate();
			if(row>0)
				{
				java.sql.Statement stmt1= con.createStatement();
				stmt1.execute("update service set service_status= 'Workorder' where service_id ="+serviceId);
				
		            RequestDispatcher dispatcher = request.getRequestDispatcher("/carpenter/workorder.jsp");
		            dispatcher.forward(request, response);
		        } else {
		            // Handle unsuccessful registration
		            response.sendRedirect("/carpenter/workorder.jsp");
		        }
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}	

	}

