package com.furnitureservice.servicerequest;

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
import com.furnitureservice.log.Logger;

/**
 * Servlet implementation class AssignCarpenter
 */
@WebServlet("/admin/assigncarpenter")
public class AssignCarpenter extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String sid=request.getParameter("serviceId");
		String car=request.getParameter("carid");
		//database
		HttpSession session= request.getSession();
		int shopkeeper = (int)session.getAttribute("adminId");
		Connection con=DbConnector.getConnection();
		try {
			PreparedStatement stmt =con.prepareStatement("update service set fk_carpenter_id=? , fk_shopkeeper_id=?,service_status = ? where service_id=?");
			stmt.setInt(1,Integer.parseInt(car));
			stmt.setInt(2, shopkeeper);	
			stmt.setString(3,"Assigned");
			stmt.setInt(4,Integer.parseInt(sid));
			int row=stmt.executeUpdate();
		if(row>0)
			{

        		String Log="Admin "+shopkeeper+"Assgined Carpenter "+car+" to service "+sid;
				new Logger(Log);
	            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/dashboard.jsp");
	            dispatcher.forward(request, response);
	        } else {
	            // Handle unsuccessful registration
	            response.sendRedirect("/admin/dashboard.jsp");
	        }
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}	
	}
