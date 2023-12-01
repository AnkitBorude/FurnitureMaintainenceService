package com.furnitureservice.register;
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
import com.furnitureservice.con.*;
import com.furnitureservice.con.*;
@WebServlet("/admin/register")
public class AdminRegister extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cname=request.getParameter("name");
		String ccontact=request.getParameter("contact");
		String cpass=request.getParameter("password");
		boolean registrationSuccessful=false;
		//database
		
		Connection con=DbConnector.getConnection();
		try {
			PreparedStatement stmt =con.prepareStatement("insert into shopkeeper(shopkeeper_name,shopkeeper_contact,shopkeeper_password) values(?,?,?)");
			stmt.setString(1,cname);		
			stmt.setString(2, ccontact);
			stmt.setString(3, cpass);
			int row=stmt.executeUpdate();
		if(row>0)
			{
			registrationSuccessful = true;

	        if (registrationSuccessful) {
	            // Set an attribute to indicate successful registration
	            request.setAttribute("registrationMessage", "Registration successful! Please login.");

	            // Forward the request to the login page
	            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/login.jsp");
	            dispatcher.forward(request, response);
	        } else {
	            // Handle unsuccessful registration
	            response.sendRedirect("/admin/register.jsp");
	        }
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	

}