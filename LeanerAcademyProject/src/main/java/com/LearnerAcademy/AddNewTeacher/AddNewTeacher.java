package com.LearnerAcademy.AddNewTeacher;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.LearnerAcademy.DBConfig.DBConfig;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class AddNewTeacher
 */
public class AddNewTeacher extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddNewTeacher() {
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
			String teacherName = request.getParameter("teacherName");
			
			//retrive values from db
			PreparedStatement ps = con.prepareStatement("INSERT INTO teacher (name) VALUES (?)");
			ps.setString(1, teacherName);
			int i = ps.executeUpdate();
			
			if(i > 0) {
				response.sendRedirect("manageTeachers/createTeacher.jsp?action=creation&status=1");
			}else{
				response.sendRedirect("manageTeachers/createTeacher.jsp?action=creation&status=0&teacherName=" + teacherName );
			}
			
			
		} catch (SQLException e) {	;
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

}
