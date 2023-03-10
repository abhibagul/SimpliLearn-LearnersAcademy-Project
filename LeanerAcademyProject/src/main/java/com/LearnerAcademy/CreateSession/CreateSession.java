package com.LearnerAcademy.CreateSession;

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
 * Servlet implementation class CreateSession
 */
public class CreateSession extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateSession() {
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
			/*String driverName = dbc.getDriverName();
			String connectionUrl = dbc.getConnectionUrl();
			String dbName = dbc.getDbName();
			String userId = dbc.getUserId();
			String passw = dbc.getPassword();*/
			
			String driverName = "com.mysql.jdbc.Driver";
			String connectionUrl = "jdbc:mysql://localhost:3306/";
			String dbName = "learnersacademy";
			String userId = "root";
			String password = "root12345";
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
			String sesName = request.getParameter("sesName");
			String sesDate = request.getParameter("sesDate");
			String sesStart = request.getParameter("sesStart");
			String sesEnd = request.getParameter("sesEnd");
			String sesStd = request.getParameter("sesStd");
			String sesDiv = request.getParameter("sesDiv");
			String sesSub = request.getParameter("sesSub");
			String sesTeach = request.getParameter("sesTeach");
			
			System.out.println("Values are " + sesName + " "+ sesDate + " "+ sesStart + " "+ sesEnd + " "+ sesStd + " "+ sesDiv + " "+ sesSub + " "+ sesTeach + " " );
			
			//retrive values from db
			PreparedStatement ps = con.prepareStatement("INSERT INTO session (class,teacher,subject, std, sessionDate, sessionStartTime, sessionEndTime, sessionName) VALUES (?,?,?,?,?,?,?,?)");
			ps.setString(1, sesDiv);
			ps.setString(2, sesTeach);
			ps.setString(3, sesSub);
			ps.setString(4, sesStd);
			ps.setString(5, sesDate);
			ps.setString(6, sesStart);
			ps.setString(7, sesEnd);
			ps.setString(8, sesName);
			int i = ps.executeUpdate();
			
			if(i > 0) {
				response.sendRedirect("manageSession.jsp?action=creation&status=1");
			}else{
				response.sendRedirect("manageSession.jsp?action=creation&status=0");
			}
			
			
		} catch (SQLException e) {	;
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

}
