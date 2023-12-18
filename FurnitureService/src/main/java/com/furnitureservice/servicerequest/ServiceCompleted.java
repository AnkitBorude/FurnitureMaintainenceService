package com.furnitureservice.servicerequest;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.furnitureservice.con.DbConnector;

/**
 * Servlet implementation class AssignCarpenter
 */
@WebServlet("/admin/servicecompleted")
public class ServiceCompleted extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String serviceid=request.getParameter("serviceid");
		//database
		HttpSession session= request.getSession();
		int shopkeeper = (int)session.getAttribute("adminId");
		
		Connection con=DbConnector.getConnection();
		try {
			java.sql.Statement stmt1= con.createStatement();
			stmt1.execute("update service set service_status= 'Completed' where service_id ="+serviceid);
//	        RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/dashboard.jsp");
//	        dispatcher.forward(request, response);
			
			response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}	
	}
