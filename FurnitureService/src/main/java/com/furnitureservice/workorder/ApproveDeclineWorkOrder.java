package com.furnitureservice.workorder;

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
@WebServlet("/admin/apprvdeclworkorder")
public class ApproveDeclineWorkOrder extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type=request.getParameter("type");
		String serviceid=request.getParameter("serviceid");
		String workorderid=request.getParameter("workerorderid");
	
		//database
		HttpSession session= request.getSession();
		int shopkeeper = (int)session.getAttribute("adminId");
		
		Connection con=DbConnector.getConnection();
		try {
			java.sql.Statement stmt1= con.createStatement();
			if(type.equals("accept"))
			{
				stmt1.execute("update service set service_status= 'Approved' where service_id ="+serviceid);
	            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/workorder.jsp");
	            dispatcher.forward(request, response);
			}else if(type.equals("decline"))
			{
				stmt1.execute("delete from workorder where workorder_id ="+workorderid);
	            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/workorder.jsp");
	            dispatcher.forward(request, response);
			}
			else {
	            response.sendRedirect("/admin/workorder.jsp");
	        }
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}	
	}
