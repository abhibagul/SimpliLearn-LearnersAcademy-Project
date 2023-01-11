package com.LearnerAcademy.ModifySubject;

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
			
			HttpSession session=request.getSession();
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/LearnersAcademy", "root", "root12345");
		
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
			
			
			//remove old records
			PreparedStatement delPS = con.prepareStatement("DELETE FROM subject WHERE name=?");
			delPS.setString(1, oldSubName);
			int iDel = delPS.executeUpdate();
			
			
			//add new records
			int i = 0;
			for(int c=0; c< stdName.length; c++) {
				//retrive values from db
				PreparedStatement ps = con.prepareStatement("INSERT INTO subject (name,class) VALUES (?,?)");
				ps.setString(1, subName);
				ps.setString(2, stdName[c]);
				i += ps.executeUpdate();
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