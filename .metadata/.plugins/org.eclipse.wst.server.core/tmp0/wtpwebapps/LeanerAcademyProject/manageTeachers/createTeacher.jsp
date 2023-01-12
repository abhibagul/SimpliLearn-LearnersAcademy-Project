<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Teacher</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

<link href="../dashboard.css" rel="stylesheet">
</head>
<body class="bg-light">
	<%@page import="java.sql.DriverManager"%>
	<%@page import="java.sql.ResultSet"%>
	<%@page import="java.sql.Statement"%>
	<%@page import="java.sql.Connection"%>
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
		
		String action = (String)request.getParameter("action");

		
	%>



	
	
<main>
	<jsp:include page="../sidebarComp.jsp"/>

	<div class="data">
	
	<jsp:include page="../headerComp.jsp"/>
  
	
	<div class="p-3 control">

	<h3> Add Teacher</h3>
	

	<%
	
	String teacherName = "";
	
	if(request.getParameter("action") != null && action.equals("creation")){
		
		if(request.getParameter("status") != null && request.getParameter("status").equals("1")){
			%>
			<div class="alert alert-success" role="alert">
			 Teacher Added successfully!
			</div>
						
			<%
		}else if(request.getParameter("status") != null && request.getParameter("status").equals("0")){
			%>
			<div class="alert alert-danger" role="alert">
			 Unable to add the Teacher, Try again!
			</div>
						
			<%
			
		}
		
	}
	
	if(request.getParameter("teacherName") != null){
		teacherName = request.getParameter("teacherName");
	}
	

	
	%>

	<div class="my-3 p-3 bg-body rounded shadow-sm">
	
		<form method="post" action="<%= request.getContextPath() %>/AddNewTeacher">
		
		<input type="hidden" name="action" value="createClass">
		
		<div class=" g-3 mb-3 align-items-center">
		  <div class="col-5">
		    <label for="teacherName" class="col-form-label">Name:</label>
		  </div>
		  <div class="col-auto">
		    <input type="text" id="teacherName" name="teacherName" value="<%= teacherName %>" required class="form-control" aria-describedby="teacherName">
		  </div>
		</div>
		
		
	
		
		<input class="btn btn-primary" type="submit" value="Add">
		<input class="btn btn-light" type="reset" value="Reset">
		
		
		</form>

	</div><!-- white card -->
	
	


	</div>
	<!-- /main content -->
	</div>
	
	</main>
	



</body>
</html>