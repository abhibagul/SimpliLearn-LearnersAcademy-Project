package com.LearnerAcademy.createClass;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.LearnerAcademy.DBConfig.DBConfig;

/**
 * Servlet implementation class createClass
 */
public class createClass extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public createClass() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
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
			String password = dbc.getPassword();
			
			
	
			HttpSession session=request.getSession();
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(connectionUrl+dbName, userId, password);
		
			//check if user has permission
			String role = (String)session.getAttribute("role");	
			
			if(role != "admin"){
				response.sendRedirect("admin.jsp");
				return;
			}
			
			//input values
			String className = request.getParameter("className");
			String stdName = request.getParameter("stdName");
			String divName = request.getParameter("divName");
			
			//retrive values from db
			PreparedStatement ps = con.prepareStatement("INSERT INTO class (name,class,std) VALUES (?,?,?)");
			ps.setString(1, className);
			ps.setString(2, divName);
			ps.setString(3, stdName);
			int i = ps.executeUpdate();
			
			if(i > 0) {
				response.sendRedirect("manageClasses/createClass.jsp?action=creation&status=1");
			}else{
				response.sendRedirect("manageClasses/createClass.jsp?action=creation&status=0&className=" + className + "&stdName="+stdName + "&divName="+divName);
			}
			
			
		} catch (SQLException e) {	;
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

}
