package com.furnitureservice.servicerequest;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.SQLType;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.furnitureservice.con.*;
/**
 * Servlet implementation class ServiceRequestApi
 */
@WebServlet("/customer/ServiceRequestApi")
public class ServiceRequestApi extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        
        // Dummy response JSON object
        String jsonResponse = "{\"status\": \"success\", \"message\": \"Form data received successfully!\"}";
        // Extract form data
        String serviceName = request.getParameter("sname");
       
        String serviceDescription = request.getParameter("sdescription");
        String customerId = request.getParameter("customerid");
        java.sql.Date date = new java.sql.Date(System.currentTimeMillis());

        // Log the form data (you may want to store it in a database or perform other actions)
        System.out.println("Service Name: " + serviceName);
        System.out.println("Service Description: " + serviceDescription);
        System.out.println("Customer ID: " + customerId);
       

        
        // JDBC variables
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
             connection=DbConnector.getConnection();
            String sql = "INSERT INTO Service (service_item_name, service_date, service_description, " +
                    " fk_customer_id, fk_shopkeeper_id, fk_carpenter_id,service_status) " +
                    "VALUES (?, ?, ?, ?,?,?,?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, serviceName);
            preparedStatement.setDate(2,date);
            preparedStatement.setString(3, serviceDescription);
            preparedStatement.setInt(4,Integer.parseInt(customerId));
            preparedStatement.setNull(5,Types.INTEGER);
            preparedStatement.setNull(6,Types.INTEGER);
            preparedStatement.setString(7,"New");
            int rowsAffected = preparedStatement.executeUpdate();

            // Check the result
            if (rowsAffected > 0) {
                System.out.println("Data inserted successfully!");
            } else {
                System.out.println("Failed to insert data.");
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources in a finally block to ensure they are always closed
            try {
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        // Send the JSON response
        PrintWriter out = response.getWriter();
        out.write(jsonResponse);
        out.flush();
    }

}
