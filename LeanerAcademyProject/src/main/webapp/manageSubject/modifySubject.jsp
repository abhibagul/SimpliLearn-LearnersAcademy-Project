
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Modify Subject</title>
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
	<%@page import="java.util.LinkedList"%>
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

	<h3> Modify Subject</h3>
	

	<%
	
	String subName = "";
	LinkedList<String> stdName = new LinkedList<String>();
	
	if(request.getParameter("action") != null && action.equals("updation")){
		
		if(request.getParameter("status") != null && request.getParameter("status").equals("1")){
			%>
			<div class="alert alert-success" role="alert">
			 Subject Updated successfully!
			</div>
						
			<%
		}else if(request.getParameter("updation") != null && request.getParameter("status").equals("0")){
			%>
			<div class="alert alert-danger" role="alert">
			 Unable to update the Subject, Try again!
			</div>
						
			<%
			
		}
		
	}
	


		try{
			
			connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
			statement=connection.createStatement();
		
			
			PreparedStatement fetchPs = connection.prepareStatement("SELECT * FROM subject where name=?");
			fetchPs.setString(1, request.getParameter("subName"));
			resultSet = fetchPs.executeQuery();
			
			while(resultSet.next()){
				subName = resultSet.getString("name");
				stdName.push(resultSet.getString("class"));
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		

		
	%>

	<div class="my-3 p-3 bg-body rounded shadow-sm">
	
	<%
				//check if the classes exist, because subjects need to be assigned to the standards
				try{
			
					String sql ="SELECT DISTINCT std FROM class";
		
					resultSet  = statement.executeQuery(sql);
					
					if(resultSet.next()) {
						
						%>
						<form method="post" action="<%= request.getContextPath() %>/ModifySubject">
		
						<input type="hidden" name="action" value="modifySubject">
						<input type="hidden" name="oldSubName" value="<%= request.getParameter("subName") %>">
						
						<div class=" g-3 mb-3 align-items-center">
						  <div class="col-5">
						    <label for="subName" class="col-form-label">Subject Name</label>
						  </div>
						  <div class="col-auto">
						    <input type="text" id="subName" name="subName" value="<%= subName %>" required class="form-control" aria-describedby="subName">
						  </div>
						</div>
						
						
						<div class=" g-3 mb-3 align-items-center">
						  <div class="col-5">
						    <label for="stdName" class="col-form-label">Subject Standard</label>
						  </div>
						  <div class="col-auto">
						   <select class="form-control"  name="stdName"  id="stdName" multiple>
						  
						
						
						<%
						do{
							%>
							
							<option value="<%=resultSet.getString("std") %>" <% if(stdName.contains(resultSet.getString("std"))){ %> selected="selected" <% } %> ><%=resultSet.getString("std") %></option>
				
							<%
						}while(resultSet.next());
						
						%>
						</select>
						</div>
						</div>
						
						<input class="btn btn-primary" type="submit" value="Update">
						<input class="btn btn-light" type="reset" value="Reset">
						
						</form>
						<% 
						
					}else{
						%>
						
						<div class="row text-center p-3">
							<div class="col-sm-12">
								<h4>In order to create subjects you need to create standards &amp; classes</h4>
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