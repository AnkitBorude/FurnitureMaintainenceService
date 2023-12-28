package com.furnitureservice.con;
import java.sql.*;
import java.util.LinkedList;
public class ConnectionPool {
	LinkedList<Connection> connectionPool;
	public ConnectionPool(int n)
	{
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		System.out.println("New Fresh "+ n + " Database Connection Created");
		connectionPool=new LinkedList<Connection>();
		for(int i=0;i<n;i++)
		{
			connectionPool.push(DbConnector.getConnection());
			
		}
	}
	public Connection getConnection()
	{
		if(connectionPool.isEmpty())//creating a new connection if all the connections has been exhausted
		{
			return DbConnector.getConnection();
		}
		
		return connectionPool.pop();
	}
	public void returnConnection(Connection c)
	{
		connectionPool.push(c);
	}
	
	public void closeAllconnections()
	{
		while(!connectionPool.isEmpty())
		{
			try {
				connectionPool.pop().close();
			
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		System.out.println("All Database Connections closed");
		connectionPool=null;
	}
}
