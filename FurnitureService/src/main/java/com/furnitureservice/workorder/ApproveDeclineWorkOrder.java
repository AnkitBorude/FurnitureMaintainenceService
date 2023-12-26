package com.furnitureservice.workorder;

import java.sql.Statement;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
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
@WebServlet("/admin/apprvdeclworkorder")
public class ApproveDeclineWorkOrder extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type=request.getParameter("type");
		String serviceid=request.getParameter("serviceid");
		String workorderid=request.getParameter("workorderid");
	
		//database
		HttpSession session= request.getSession();
		int shopkeeper = (int)session.getAttribute("adminId");
		
		Connection con=DbConnector.getConnection();
		try {
			java.sql.Statement stmt1= con.createStatement();
			if(type.equals("accept"))
			{
				stmt1.execute("update service set service_status= 'Approved' where service_id ="+serviceid);
//	            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/workorder.jsp");
//	            dispatcher.forward(request, response);
				String Log="Admin "+shopkeeper+"Approved workorder id"+workorderid+" of service "+serviceid;
				new Logger(Log);
				response.sendRedirect(request.getContextPath() + "/admin/workorder.jsp");
			}else if(type.equals("decline"))
			{
				  	String query = "select service_id, count(workorder_id) as total from service left join workorder on service.service_id = workorder.fk_service_id where service_id="+serviceid+" group by service_id;";
			        Statement statement = con.createStatement();
			        ResultSet resultSet = statement.executeQuery(query);
			        resultSet.next();
			        int total_count=resultSet.getInt("total");
			        System.out.println(total_count);
			        if(total_count==1)//checking whether the workorder is last if not
			        {
			        	System.out.println("final workorder");
			        	stmt1.execute("delete from workorder where workorder_id ="+workorderid);
			        	stmt1.execute("update service set service_status= 'Assigned' where service_id ="+serviceid);
			        	String Log="Admin "+shopkeeper+"Declined the last workorder id"+workorderid+" of service "+serviceid;
						new Logger(Log);
			        	response.sendRedirect(request.getContextPath() + "/admin/workorder.jsp");
			        }
			        else
			        {
			        	System.out.println("non final workorder");
			        	System.out.println(workorderid);
			        	stmt1.execute("delete from workorder where workorder_id ="+workorderid);
			        	String Log="Admin "+shopkeeper+"Declined workorder id"+workorderid+" of service "+serviceid;
						new Logger(Log);
			        	response.sendRedirect(request.getContextPath() + "/admin/workorder.jsp");
			        }
//	            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/workorder.jsp");
//	            dispatcher.forward(request, response);
			        
			       
			}
			else {
	            response.sendRedirect("/admin/workorder.jsp");
	        }
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}	
	}
