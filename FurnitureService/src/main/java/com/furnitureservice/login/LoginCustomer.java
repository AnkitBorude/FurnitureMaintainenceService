package com.furnitureservice.login;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.furnitureservice.con.*;
@WebServlet("/customer/login")
public class LoginCustomer extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        String contactNumber = request.getParameter("contactNumber");
        String password = request.getParameter("password");
        try {
          
            connection = DbConnector.getConnection();
            String sql = "SELECT customer_id FROM customer WHERE customer_contact = ? AND customer_password = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, contactNumber);
            preparedStatement.setString(2, password);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
         
                int customerId = resultSet.getInt("customer_id");


                HttpSession session = request.getSession();
                session.setAttribute("customerId", customerId);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/customer/dashboard.jsp");
                dispatcher.forward(request, response);
            } else {
            	 request.setAttribute("loginfailed", "Invalid username or password");
                 RequestDispatcher dispatcher = request.getRequestDispatcher("/customer/login.jsp");
                 dispatcher.forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close the resources
            try {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}