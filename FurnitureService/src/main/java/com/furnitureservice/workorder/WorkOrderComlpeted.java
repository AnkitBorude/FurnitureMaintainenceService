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
@WebServlet("/carpenter/markcompleted")
public class WorkOrderComlpeted extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String wid=request.getParameter("wid");
	
		//database
		  
        HttpSession session= request.getSession();
		int carpenter = (int)session.getAttribute("carpenterId");
		
		Connection con=DbConnector.getConnection();
		try {
				java.sql.Statement stmt1= con.createStatement();
			
				stmt1.execute("update workorder set workorder_status= 'Completed' where workorder_id ="+wid);
//				RequestDispatcher dispatcher = request.getRequestDispatcher("/carpenter/workorder.jsp");
//	            dispatcher.forward(request, response);
				response.sendRedirect(request.getContextPath() + "/carpenter/workorder.jsp");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}	
	}
