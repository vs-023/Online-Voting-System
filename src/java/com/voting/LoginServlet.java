package com.voting;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String usertype = request.getParameter("usertype");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/votingdb",
                    "root",
                    "myadmin"
            );

            // ================= VOTER LOGIN =================
            if ("voter".equalsIgnoreCase(usertype)) {

                PreparedStatement ps = con.prepareStatement(
                        "SELECT * FROM voters WHERE email=? AND password=?"
                );

                ps.setString(1, email);
                ps.setString(2, password);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {

                    HttpSession session = request.getSession();
                    session.invalidate();
                    session = request.getSession(true);

                    session.setAttribute("user_type", "voter");
                    session.setAttribute("email", email);
                    session.setAttribute("name", rs.getString("name"));

                    // 🔥 IMPORTANT FIX
                    session.setAttribute("hasVoted", false);

                    response.sendRedirect("voter-dashboard.jsp");

                } else {
                    response.sendRedirect("login.html?error=1");
                }
            }

            // ================= ADMIN LOGIN =================
            else if ("admin".equalsIgnoreCase(usertype)) {

                PreparedStatement ps = con.prepareStatement(
                        "SELECT * FROM admin WHERE username=? AND password=?"
                );

                ps.setString(1, email);
                ps.setString(2, password);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {

                    HttpSession session = request.getSession();
                    session.invalidate();
                    session = request.getSession(true);

                    session.setAttribute("user_type", "admin");
                    session.setAttribute("admin", email);

                    response.sendRedirect("admin-dashboard.jsp");

                } else {
                    response.sendRedirect("login.html?error=1");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.html?error=2");
        }
    }
}