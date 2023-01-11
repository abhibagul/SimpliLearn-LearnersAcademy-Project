package com.LearnerAcademy.modifyClass;

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
 * Servlet implementation class modifyClass
 */
public class modifyClass extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public modifyClass() {
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
			String className = request.getParameter("className");
			String stdName = request.getParameter("stdName");
			String divName = request.getParameter("divName");
			String id = request.getParameter("id");
			
			//retrive values from db
			PreparedStatement ps = con.prepareStatement("UPDATE class SET name=?,class=?,std=? WHERE id=?");
			ps.setString(1, className);
			ps.setString(2, divName);
			ps.setString(3, stdName);
			ps.setString(4, id);
			int i = ps.executeUpdate();
			
			if(i > 0) {
				response.sendRedirect("manageClasses/modifyClass.jsp?action=updation&status=1&classId="+id);
			}else{
				response.sendRedirect("manageClasses/modifyClass.jsp?action=updation&status=0&className=" + className + "&stdName="+stdName + "&divName="+divName + "&id="+id);
			}
			
			
		} catch (SQLException e) {	;
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

}
