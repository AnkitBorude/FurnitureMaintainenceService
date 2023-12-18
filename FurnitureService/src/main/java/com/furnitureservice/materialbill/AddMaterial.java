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


@WebServlet("/admin/addmaterial")
public class AddMaterial extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mname=request.getParameter("materialName");
		String mq=request.getParameter("materialQuantity");
		String mr=request.getParameter("materialRate");
		//database
		HttpSession session= request.getSession();
		int shopkeeper = (int)session.getAttribute("adminId");
		Connection con=DbConnector.getConnection();
		try {
			 String sql = "INSERT INTO Material (material_name, material_quantity, material_rate, " +
	                    "fk_shopkeeper_id) " +
	                    "VALUES (?, ?, ?, ?)";
			PreparedStatement stmt =con.prepareStatement(sql);
			stmt.setString(1,mname);		
			stmt.setInt(2,Integer.parseInt(mq));
			stmt.setInt(3,Integer.parseInt(mr));
			stmt.setInt(4,shopkeeper);
			int row=stmt.executeUpdate();
		if(row>0)
			{
			response.sendRedirect(request.getContextPath() + "/admin/billmaterial.jsp");
	        } else {
	            // Handle unsuccessful registration
	        	response.sendRedirect(request.getContextPath() + "/admin/billmaterial.jsp");
	        }
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}	
	}
