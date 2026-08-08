package com.voting;

import java.io.IOException;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/RequestServlet")
public class RequestServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String req = request.getParameter("request");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/votingdb",
                    "root",
                    "myadmin"
            )) {
                PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO requests(user_email, request_type, message) VALUES(?,?,?)"
                );
                
                ps.setString(1, email);
                ps.setString(2, "GENERAL"); // default type
                ps.setString(3, req);
                
                ps.executeUpdate();
            }

            response.sendRedirect("requestchange.html?success=1");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}