package com.LearnerAcademy.AdminLogin;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.LearnerAcademy.DBConfig.DBConfig;

/**
 * Servlet implementation class AdminLogin
 */
public class AdminLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminLogin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		try {
			
			DBConfig dbc = new DBConfig();
			String driverName = dbc.getDriverName();
			String connectionUrl = dbc.getConnectionUrl();
			String dbName = dbc.getDbName();
			String userId = dbc.getUserId();
			String passw = dbc.getPassword();
			
			
	
			HttpSession session=request.getSession();
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(connectionUrl+dbName, userId, passw);
		
			//input values
			String uname = request.getParameter("username");
			String password = request.getParameter("password");
			
			//retrive values from db
			PreparedStatement ps = con.prepareStatement("Select uname From admins Where  uname=? and password=?");
			ps.setString(1, uname);
			ps.setString(2, password);
			ResultSet rs = ps.executeQuery();
			
			if(rs.next()) {
			
				
				session.setAttribute("usname",uname);
				session.setAttribute("role", "admin");
				
				response.sendRedirect("dashboard.jsp");
				
				
			}else {

				session.setAttribute("invalid", "Invalid Details");
				response.sendRedirect("admin.jsp");
			}
			
		
		} catch (SQLException e) {	;
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		
//		doGet(request, response);
	}

}
