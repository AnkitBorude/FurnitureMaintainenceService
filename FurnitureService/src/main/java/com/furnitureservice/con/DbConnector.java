package com.furnitureservice.con;
import java.sql.Connection;
import java.sql.DriverManager;
import javax.sql.*;
public class DbConnector {
	
	public static Connection getConnection()
	{
		
		final String port="5432";
		final String username="application_frontend";
		final String password="abcd@1234";
	try
	{
		Class.forName("org.postgresql.Driver");
		Connection connection=DriverManager.getConnection("jdbc:postgresql://localhost:5432/furnitureaid",username,password);
		return connection;
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	return null;
	}
}
