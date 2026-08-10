package com.voting;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String usertype = request.getParameter("usertype");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (usertype == null || email == null || password == null ||
            usertype.trim().isEmpty() ||
            email.trim().isEmpty() ||
            password.trim().isEmpty()) {

            response.sendRedirect("login.html?error=empty");
            return;
        }

        Connection con = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/votingdb",
                    "root",
                    "adminmyy"
            );


            // =====================================================
            // VOTER LOGIN
            // =====================================================

            if ("voter".equalsIgnoreCase(usertype)) {

                PreparedStatement ps = con.prepareStatement(
                        "SELECT * FROM voters WHERE email=? AND password=?"
                );

                ps.setString(1, email);
                ps.setString(2, password);

                ResultSet rs = ps.executeQuery();


                if (rs.next()) {


                    HttpSession oldSession = request.getSession(false);

                    if (oldSession != null) {
                        oldSession.invalidate();
                    }

                    HttpSession session =
                            request.getSession(true);

                    session.setAttribute(
                            "user_type",
                            "voter"
                    );

                    session.setAttribute(
                            "email",
                            email
                    );

                    session.setAttribute(
                            "name",
                            rs.getString("name")
                    );


              

                    response.sendRedirect(
                            "voter-dashboard.jsp"
                    );

                } else {

                    response.sendRedirect(
                            "login.html?error=1"
                    );
                }


                rs.close();
                ps.close();

            }



            else if ("admin".equalsIgnoreCase(usertype)) {

             
                PreparedStatement ps = con.prepareStatement(
                        "SELECT * FROM admin WHERE username=? AND password=?"
                );

                ps.setString(1, email);
                ps.setString(2, password);

                ResultSet rs = ps.executeQuery();


                if (rs.next()) {

                    HttpSession oldSession =
                            request.getSession(false);

                    if (oldSession != null) {
                        oldSession.invalidate();
                    }

                    HttpSession session =
                            request.getSession(true);


                    session.setAttribute(
                            "user_type",
                            "admin"
                    );

                    session.setAttribute(
                            "admin",
                            email
                    );


                    response.sendRedirect(
                            "admin-dashboard.jsp"
                    );

                } else {

                    response.sendRedirect(
                            "login.html?error=1"
                    );
                }


                rs.close();
                ps.close();

            }


            // =====================================================
            // INVALID USER TYPE
            // =====================================================

            else {

                response.sendRedirect(
                        "login.html?error=1"
                );
            }


        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "login.html?error=2"
            );

        } finally {

            try {

                if (con != null) {
                    con.close();
                }

            } catch (Exception ignored) {
            }
        }
    }
}