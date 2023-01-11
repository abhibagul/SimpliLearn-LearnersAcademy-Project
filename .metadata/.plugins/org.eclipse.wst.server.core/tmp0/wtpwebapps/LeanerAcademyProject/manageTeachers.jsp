<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Teachers</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

<link href="dashboard.css" rel="stylesheet">
</head>
<body class="bg-light">
	<%@page import="java.sql.DriverManager"%>
	<%@page import="java.sql.ResultSet"%>
	<%@page import="java.sql.Statement"%>
	<%@page import="java.sql.Connection"%>
	<%@page import="java.sql.PreparedStatement" %>
	<%
		String session_u_name = (String)session.getAttribute("usname");
		String role = (String)session.getAttribute("role");	
	
		if(role != "admin"){
			response.sendRedirect("admin.jsp");
			
		}
		
		String driverName = "com.mysql.jdbc.Driver";
		String connectionUrl = "jdbc:mysql://localhost:3306/";
		String dbName = "learnersacademy";
		String userId = "root";
		String password = "root12345";

		String pageName = (String) request.getParameter("page");
		
		String action = (String)request.getParameter("action");

		try {
			Class.forName(driverName);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	
		Connection connection = null;
		Statement statement = null;
		ResultSet resultSet = null;
	
		try{
			
			connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
			statement=connection.createStatement();
		
			//deleting division
			if(action.equals("deleteSubject") && request.getParameter("subId") != null){
				PreparedStatement delPS = connection.prepareStatement("DELETE FROM subject where id=?");
				delPS.setString(1, request.getParameter("subId"));
				delPS.execute();
			}
		
		}catch(Exception e){
			e.printStackTrace();
		}
	
		
	%>



	
	
<main>
	<jsp:include page="sidebarComp.jsp"/>

	<div class="data">
	
	<jsp:include page="headerComp.jsp"/>
  
	
	<div class="p-3 control">
	
		<div class="row">
			<div class="col-sm-6">
				<h4><i class="bi bi-person-workspace"></i> Manage Teachers</h4>
			</div>
			<div class="col-sm-6 text-end">
				<a href="<%=request.getContextPath()%>/manageTeachers/createTeacher.jsp" class="btn btn-primary shadow-sm"><i class="bi bi-plus-lg"></i> Add New Teacher</a>
			</div>
		</div>
	
		
	</div>


	</div>
	<!-- /main content -->
	</div>
	
	</main>
	

</body>
</html>