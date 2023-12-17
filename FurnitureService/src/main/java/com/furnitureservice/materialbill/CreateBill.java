package com.furnitureservice.materialbill;

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

@WebServlet("/admin/createbill")
public class CreateBill extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
			String serviceId = request.getParameter("serviceId");
	        String materialCost = request.getParameter("materialCost");
	        String labourCost = request.getParameter("labourCost");
	        String tax =request.getParameter("tax");
	        String totalAmount =request.getParameter("totalAmount");
	        System.out.println(serviceId+" "+materialCost+" "+labourCost);
	        java.sql.Date date = new java.sql.Date(System.currentTimeMillis());
	     
	    	HttpSession session= request.getSession();
			int shopkeeper = (int)session.getAttribute("adminId");
			
			Connection con=DbConnector.getConnection();
			try {
				 String sql = "INSERT INTO bill (bill_date,bill_tax, " +
		                    "bill_labour_cost,bill_material_cost,bill_total_cost,fk_service_id,fk_shopkeeper_id) " +
		                    "VALUES (?, ?, ?, ?,?,?,?)";
				PreparedStatement stmt =con.prepareStatement(sql);
				stmt.setDate(1,date);		
				stmt.setInt(2,Integer.parseInt(tax));
				stmt.setInt(3,Integer.parseInt(labourCost));
				stmt.setInt(4,Integer.parseInt(materialCost));
				stmt.setInt(5,Integer.parseInt(totalAmount));
				stmt.setInt(6,Integer.parseInt(serviceId));
				stmt.setInt(7,shopkeeper);
				int row=stmt.executeUpdate();
			if(row>0)
				{
				java.sql.Statement stmt1= con.createStatement();
				stmt1.execute("update service set service_status= 'Billed' where service_id ="+serviceId);
		            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/bill.jsp");
		            dispatcher.forward(request, response);
		        } else {
		            // Handle unsuccessful registration
		            response.sendRedirect("/admin/bill.jsp");
		        }
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}	

	}

