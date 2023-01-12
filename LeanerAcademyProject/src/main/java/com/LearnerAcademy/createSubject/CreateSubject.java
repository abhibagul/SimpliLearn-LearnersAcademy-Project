package com.LearnerAcademy.createSubject;

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
import java.sql.SQLException;

import com.LearnerAcademy.DBConfig.DBConfig;

/**
 * Servlet implementation class CreateSubject
 */
public class CreateSubject extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateSubject() {
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
			String subName = request.getParameter("subName");
			String[] stdName = request.getParameterValues("stdName");
			
//			System.out.println("Standards: " + stdName);
			int i = 0;
			for(int c=0; c< stdName.length; c++) {
				//retrive values from db
				PreparedStatement ps = con.prepareStatement("INSERT INTO subject (name,class) VALUES (?,?)");
				ps.setString(1, subName);
				ps.setString(2, stdName[c]);
				i += ps.executeUpdate();
			}
			
			
			if(i > 0) {
				response.sendRedirect("manageSubject/createSubject.jsp?action=creation&status=1");
			}else{
				response.sendRedirect("manageSubject/createSubject.jsp?action=creation&status=0&subName=" + subName + "&stdName="+stdName);
			}
			
			
		} catch (SQLException e) {	;
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

}
