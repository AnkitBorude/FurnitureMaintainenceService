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


@WebServlet("/admin/updatematerial")
public class UpdateMaterial extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mname=request.getParameter("materialId");
		String mq=request.getParameter("materialQuantity");
		String mr=request.getParameter("materialRate");
		//database
		HttpSession session= request.getSession();
		int shopkeeper = (int)session.getAttribute("adminId");
		Connection con=DbConnector.getConnection();
		try {
			 String sql = "Update Material set material_quantity=?, material_rate=? where material_id=?";
			PreparedStatement stmt =con.prepareStatement(sql);
			stmt.setInt(1,Integer.parseInt(mq));		
			stmt.setInt(2,Integer.parseInt(mr));
			stmt.setInt(3,Integer.parseInt(mname));
			int row=stmt.executeUpdate();
		if(row>0)
			{
//	            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/billmaterial.jsp");
//	            dispatcher.forward(request, response);
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
