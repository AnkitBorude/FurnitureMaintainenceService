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
		final String host="localhost";
		final String dbname="furnitureaid";
		
		final String mString="jdbc:postgresql://"+host+":"+port+"/"+dbname;
	try
	{
		Class.forName("org.postgresql.Driver");
		Connection connection=DriverManager.getConnection(mString,username,password);
		return connection;
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	return null;
	}
}
