package com.furnitureservice.logout;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.furnitureservice.log.Logger;

/**
 * Servlet implementation class Logout
 */
@WebServlet("/admin/logout")
public class AdminLogout extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 HttpSession session = request.getSession(false);
		 new Logger("Admin Logged Out Successfull admin Id-"+session.getAttribute("adminId"));
	        if (session != null) {
	            // Invalidate the session
	            session.invalidate();
	        }

	        // Redirect back to the login page
	        response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
	}
}
