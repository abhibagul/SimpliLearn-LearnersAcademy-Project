<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create Class</title>
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

	<h3> Create Standard &amp; Division</h3>
	

	<%
	
	String className = "";
	String stdName = "";
	String divName = "";
	
	if(request.getParameter("action") != null && action.equals("creation")){
		
		if(request.getParameter("status") != null && request.getParameter("status").equals("1")){
			%>
			<div class="alert alert-success" role="alert">
			 Class Created successfully!
			</div>
						
			<%
		}else if(request.getParameter("status") != null && request.getParameter("status").equals("0")){
			%>
			<div class="alert alert-danger" role="alert">
			 Unable to create the class, Try again!
			</div>
						
			<%
			
		}
		
	}
	
	if(request.getParameter("className") != null){
		className = request.getParameter("className");
	}
	
	if(request.getParameter("stdName") != null){
		stdName = request.getParameter("stdName");
	}
	
	if(request.getParameter("divName") != null){
		divName = request.getParameter("divName");
	}
	
	%>

	<div class="my-3 p-3 bg-body rounded shadow-sm">
	
		<form method="post" action="<%= request.getContextPath() %>/createClass">
		
		<input type="hidden" name="action" value="createClass">
		
		<div class=" g-3 mb-3 align-items-center">
		  <div class="col-5">
		    <label for="className" class="col-form-label">Class Name</label>
		  </div>
		  <div class="col-auto">
		    <input type="text" id="className" name="className" value="<%= className %>" required class="form-control" aria-describedby="className">
		  </div>
		</div>
		
		
		<div class=" g-3 mb-3 align-items-center">
		  <div class="col-5">
		    <label for="stdName" class="col-form-label">Standard Name</label>
		  </div>
		  <div class="col-auto">
		    <input type="text" id="stdName" name="stdName" value="<%= stdName %>" required class="form-control" aria-describedby="stdName">
		  </div>
		</div>
		
		<div class=" g-3 mb-3 align-items-center">
		  <div class="col-5">
		    <label for="divName" class="col-form-label">Division Name</label>
		  </div>
		  <div class="col-auto">
		    <input type="text" id="divName" name="divName" value="<%= divName %>" required class="form-control" aria-describedby="divName">
		  </div>
		</div>
		
		<input class="btn btn-primary" type="submit" value="Create">
		<input class="btn btn-light" type="reset" value="Reset">
		
		
		</form>

	</div><!-- white card -->
	
	


	</div>
	<!-- /main content -->
	</div>
	
	</main>
	



</body>
</html>