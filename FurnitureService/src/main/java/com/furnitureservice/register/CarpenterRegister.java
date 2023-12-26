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
import com.furnitureservice.log.Logger;
import com.furnitureservice.con.*;
@WebServlet("/carpenter/register")
public class CarpenterRegister extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cname=request.getParameter("name");
		String caddress=request.getParameter("address");
		String ccontact=request.getParameter("contact");
		String cpass=request.getParameter("password");
		boolean registrationSuccessful=false;
		//database
		
		Connection con=DbConnector.getConnection();
		try {
			PreparedStatement stmt =con.prepareStatement("insert into carpenter(carpenter_name,carpenter_address,carpenter_contact,carpenter_password) values(?,?,?,?)");
			stmt.setString(1,cname);		
			stmt.setString(2, caddress);
			stmt.setString(3, ccontact);
			stmt.setString(4,cpass);
			int row=stmt.executeUpdate();
		if(row>0)
			{
			registrationSuccessful = true;

	        if (registrationSuccessful) {
	            // Set an attribute to indicate successful registration
	        	String Log="Carpenter Registration Successfull"+ccontact;
				new Logger(Log);
	            request.setAttribute("registrationMessage", "Registration successful! Please login.");

	            // Forward the request to the login page
	            RequestDispatcher dispatcher = request.getRequestDispatcher("/carpenter/login.jsp");
	            dispatcher.forward(request, response);
	        } else {
	            // Handle unsuccessful registration
	        	String Log="Admin Registration Failed"+ccontact;
				new Logger(Log);
	            response.sendRedirect("/carpenter/register.jsp");
	        }
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}