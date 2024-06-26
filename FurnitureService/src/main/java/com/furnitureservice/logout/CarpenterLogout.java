package com.furnitureservice.logout;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.furnitureservice.log.Logger;

@WebServlet("/carpenter/logout")
public class CarpenterLogout extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 HttpSession session = request.getSession(false);
		 new Logger("Carpenter Logged Out Successfull carpenter Id-"+session.getAttribute("carpenterId"));
	        if (session != null) {
	            // Invalidate the session
	            session.invalidate();
	        }

	        // Redirect back to the login page
	        response.sendRedirect(request.getContextPath() + "/carpenter/login.jsp");
	}
}
