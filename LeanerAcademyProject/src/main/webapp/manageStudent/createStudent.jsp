<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create Student</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

<link href="../dashboard.css" rel="stylesheet">
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
		
		
		}catch(Exception e){
			e.printStackTrace();
		}
	
		
	%>



	
	
<main>
	<jsp:include page="../sidebarComp.jsp"/>

	<div class="data">
	
	<jsp:include page="../headerComp.jsp"/>
  
	
	<div class="p-3 control">

	<h3> Create Subject</h3>
	

	<%
	
	String studentName = "";
	String studentStd = "";
	
	if(request.getParameter("action") != null && action.equals("creation")){
		
		if(request.getParameter("status") != null && request.getParameter("status").equals("1")){
			%>
			<div class="alert alert-success" role="alert">
			 Subject Created successfully!
			</div>
						
			<%
		}else if(request.getParameter("status") != null && request.getParameter("status").equals("0")){
			%>
			<div class="alert alert-danger" role="alert">
			 Unable to create the Subject, Try again!
			</div>
						
			<%
			
		}
		
	}
	
	if(request.getParameter("studentStd") != null){
		studentStd = request.getParameter("studentStd");
	}else{
		response.sendRedirect(request.getContextPath() + "/manageStudent.jsp");
	}
	
	if(request.getParameter("studentName") != null){
		studentName = request.getParameter("studentName");
	}
	
	if(request.getParameter("studentDiv") != null){
		studentName = request.getParameter("studentDiv");
	}
	
	%>

	<div class="my-3 p-3 bg-body rounded shadow-sm">
	
	<%
				//check if the classes exist, because subjects need to be assigned to the standards
				try{
			
					PreparedStatement divSelPS = connection.prepareStatement("SELECT DISTINCT class FROM class WHERE std=?");
					divSelPS.setString(1, request.getParameter("studentStd"));
		
					resultSet = divSelPS.executeQuery();
					
					if(resultSet.next()) {
						
						%>
						<form method="post" action="<%= request.getContextPath() %>/CreateStudent">
		
						<input type="hidden" name="action" value="createStudent">
						
						<input type="hidden" name="studentStd" value="<%= request.getParameter("studentStd") %>">
						
						<div class=" g-3 mb-3 align-items-center">
						  <div class="col-5">
						    <label for="studentName" class="col-form-label">Student Name</label>
						  </div>
						  <div class="col-auto">
						    <input type="text" id="studentName" name="studentName" value="<%= studentName %>" required class="form-control" aria-describedby="studentName">
						  </div>
						</div>
						
						
						<div class=" g-3 mb-3 align-items-center">
						  <div class="col-5">
						    <label for="studentDiv" class="col-form-label">Student Division</label>
						  </div>
						  <div class="col-auto">
						   <select class="form-control" required  name="studentDiv"  id="studentDiv">
							<%
								do{
									%>
									
									<option value="<%=resultSet.getString("class") %>" ><%=resultSet.getString("class") %></option>
						
									<%
								}while(resultSet.next());
							
							%>
							</select>
						   </div>
						</div>
						
						<input class="btn btn-primary" type="submit" value="Create">
						<input class="btn btn-light" type="reset" value="Reset">
						
						</form>
						<% 
						
					}else{
						%>
						
						<div class="row text-center p-3">
							<div class="col-sm-12">
								<h4>In order to add Student you need to create standards &amp; classes</h4>
								<hr/>
								 <a href="<%=request.getContextPath()%>/manageSubject/createSubject.jsp" class="btn btn-primary"><i class="bi bi-plus-lg"></i> Create Class &amp; Division</a>
							</div>
						</div>
						
						<%
					}
		
					
				}catch(Exception e){
					e.printStackTrace();
				}
			
			%>
	
		

	</div><!-- white card -->
	
	


	</div>
	<!-- /main content -->
	</div>
	
	</main>
	



</body>
</html>