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
		<%@page import="com.LearnerAcademy.DBConfig.DBConfig" %>
	<%
		String session_u_name = (String)session.getAttribute("usname");
		String role = (String)session.getAttribute("role");	
	
		if(role != "admin"){
			response.sendRedirect("admin.jsp");
			
		}
		
		DBConfig dbc = new DBConfig();
		String driverName = dbc.getDriverName();
		String connectionUrl = dbc.getConnectionUrl();
		String dbName = dbc.getDbName();
		String userId = dbc.getUserId();
		String password = dbc.getPassword();

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
			if(action.equals("deleteTeacher") && request.getParameter("teacherId") != null){
				PreparedStatement delPS = connection.prepareStatement("DELETE FROM teacher where id=?");
				delPS.setString(1, request.getParameter("teacherId"));
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
		
		<div class="row p-3">
		
			<%
			
			PreparedStatement ps = connection.prepareStatement("SELECT * FROM teacher");
			
			try{
				resultSet = ps.executeQuery();
				 while(resultSet.next()){ %>
				 <div class="col-lg-4 col-md-6 col-sm-12 p-3">
				<div class=" p-3 bg-body rounded shadow-sm">
					<h5><%= resultSet.getString("name") %></h5>
					<form class="inline-form" method="post" action="<%=request.getContextPath()%>/manageTeachers.jsp">
						<input type="hidden" name="action" value="deleteTeacher">
						<input type="hidden" name="teacherId" value="<%= resultSet.getString("id") %>">
						<button type="submit" class="btn btn-danger btn-sm">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
						  <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
						  <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
						</svg>  
						</button>
					</form>
				</div>
				</div>
				<%
				 }
			}catch(Exception e){
				e.printStackTrace();
			}
			
			
			%>
		
			
			
		
		</div>
	
		
	</div>


	</div>
	<!-- /main content -->
	</div>
	
	</main>
	

</body>
</html>