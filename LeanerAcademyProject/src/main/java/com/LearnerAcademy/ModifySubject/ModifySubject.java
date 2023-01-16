package com.LearnerAcademy.ModifySubject;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.LinkedList;

import com.LearnerAcademy.DBConfig.DBConfig;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class ModifySubject
 */
public class ModifySubject extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModifySubject() {
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
			String oldSubName =  request.getParameter("oldSubName");
			String subName = request.getParameter("subName");
			String[] stdName = request.getParameterValues("stdName");
			LinkedList<String> ignoreRows = new LinkedList<String>();
			
			
			//remove old records
			String delStr = "DELETE FROM subject WHERE name=?";
			
			for(int j=0; j < stdName.length; j++) {
				delStr += " and class <> \"" + stdName[j] + "\"";
			}
			
			PreparedStatement delPS = con.prepareStatement(delStr);
			delPS.setString(1, oldSubName);
			int iDel = delPS.executeUpdate();
			
			//get all std for subject 
			PreparedStatement allRecPS = con.prepareStatement("SELECT class FROM subject where name=?");
			allRecPS.setString(1, oldSubName);
			ResultSet allStd = allRecPS.executeQuery();
			
			while(allStd.next()) {
				String compareStr = allStd.getString("class");
				if(Arrays.asList(stdName).contains( compareStr)) {
					ignoreRows.add(compareStr);
				}
			}
			
			
			//add new records
			int i = 0;
			for(int c=0; c< stdName.length; c++) {
								
				//retrive values from db
				if(!ignoreRows.contains(stdName[c])) {
					PreparedStatement ps = con.prepareStatement("INSERT INTO subject (name,class) VALUES (?,?)");
					ps.setString(1, subName);
					ps.setString(2, stdName[c]);
					i += ps.executeUpdate();
				}
			}
			
			if(i > 0) {
				response.sendRedirect("manageSubject/modifySubject.jsp?action=updation&status=1&subName="+subName);
			}else{
				response.sendRedirect("manageSubject/modifySubject.jsp?action=updation&status=0&subName=" + oldSubName );
			}
			
			
		} catch (SQLException e) {	;
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

}
