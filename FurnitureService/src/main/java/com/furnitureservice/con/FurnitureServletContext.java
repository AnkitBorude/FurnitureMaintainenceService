package com.furnitureservice.con;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class FurnitureServletContext implements ServletContextListener {

	final int TOTAL_INITIAL_CONNECTIONS=5;
	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		//this method would be called when the webapplication is deployed.
		//through this method we can create a context objects which would be then setted as attributes of the
		//web application through which we can access the context Objects
		ServletContext ctx=sce.getServletContext();
		ConnectionPool pool=(ConnectionPool)ctx.getAttribute("pool"); //accessing the context object through attribute
		pool.closeAllconnections();
	}

	public void contextInitialized(ServletContextEvent sce) {
		// TODO Auto-generated method stub
		ServletContext ctx=sce.getServletContext();//accessing the servlet context
		ConnectionPool pool=new ConnectionPool(TOTAL_INITIAL_CONNECTIONS);
		ctx.setAttribute("pool",pool);	//settting the servlet context created pool
	}

}
