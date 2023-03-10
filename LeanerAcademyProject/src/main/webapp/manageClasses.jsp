<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Classes</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

<link href="dashboard.css" rel="stylesheet">
</head>
<body  class="bg-light">
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
		
		
		
		String action = (String) request.getParameter("action");
		
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
			if(action.equals("deleteClass") && request.getParameter("classId") != null){
				PreparedStatement delPS = connection.prepareStatement("DELETE FROM class where id=?");
				delPS.setString(1, request.getParameter("classId"));
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
				<h4><i class="bi bi-cassette"></i> Manage Divisions and Standards</h4>
			</div>
			<div class="col-sm-6 text-end">
				<a href="<%=request.getContextPath()%>/manageClasses/createClass.jsp" class="btn btn-primary"><i class="bi bi-plus-lg"></i> Create Class &amp; Division</a>
			</div>
		</div>
  
  
  	<div class="my-3 p-3 bg-body rounded shadow-sm">
  	
		<div class="row">
  <div class="col-lg-6 col-md-6 ">
  <form id="stdSelector" action="<%=request.getContextPath()%>/manageClasses.jsp" method="post"  class="row ">
  	<div class="">
    <input type="hidden" name="action" value="classSelector">
    </div>
    <div class="col-sm-6">
	<select class="form-control" onchange="document.getElementById('stdSelector').submit()" name="selectedStd"  id="standardSelector">
	<option value="empty">Select Standard</option>
	<%
	

	
		try{
			
			String sql ="SELECT DISTINCT std FROM class";

			resultSet = statement.executeQuery(sql);
			
			while(resultSet.next()){
				%>
				<option value="<%=resultSet.getString("std") %>" <% if(resultSet.getString("std").equals(request.getParameter("selectedStd"))){ %> selected="selected" <% } %>><%=resultSet.getString("std") %></option>
				<%
			}

			
		}catch(Exception e){
			e.printStackTrace();
		}
	
	%>
	
	</select>
	</div>
  </form>
  </div>
  
	</div>
	
	
	</div>
	
	
	<div class="my-3 p-3 bg-body rounded shadow-sm">
		<%
		
			//out.print("Content: " + action + " for std, " + request.getParameter("selectedStd"));
			if(action != null && !request.getParameter("selectedStd").equals("empty") ){
				
				
				if( action.equals("classSelector") || action.equals("deleteClass")){
					
					PreparedStatement ps = connection.prepareStatement("SELECT * FROM class where std=?");
					ps.setString(1, request.getParameter("selectedStd"));
					
					%>
					<div class="row">
					<div class="col-lg-6 col-sm-6">
					
					<h4>Divisions for Standard <%= request.getParameter("selectedStd") %></h4>
					</div>
					<div class="col-lg-6 col-sm-6 text-end">
					 <a href="<%=request.getContextPath()%>/manageClasses/createClass.jsp?stdName=<%= request.getParameter("selectedStd") %>" class="btn btn-primary btn-sm"><i class="bi bi-plus-lg"></i> Create Division for <%= request.getParameter("selectedStd") %> std</a>
					</div>
					</div>
					<hr/>
					<%
					
						
					try{
											
						
						resultSet = ps.executeQuery();
						
						
							%>
							<table  class="table table-striped table-hover rounded">
							<thead class="bg-dark text-light rounded">
								<tr>
									<th scope="col" class="text-center">Class id</th>
									<th scope="col" class="text-center">Class Name</th>
									<th scope="col" class="text-center">Class Standard</th>
									<th scope="col" class="text-center">Class Division</th>
									<th scope="col" class="text-center">Action</th>
								</tr>
							</thead>
							<tbody>
								
								<% while(resultSet.next()){ %>
							
								<tr>
									<td class="text-center"><%= resultSet.getString("id") %></td>
									<td class="text-center"><%= resultSet.getString("name") %></td>
									<td class="text-center"><%= resultSet.getString("std") %></td>
									<td class="text-center"><%= resultSet.getString("class") %></td>
									<td class="text-center">
										<form class="inline-form"  method="post" action="<%=request.getContextPath()%>/manageClasses/modifyClass.jsp">
											<input type="hidden" name="action" value="editClass">
											<input type="hidden" name="classId" value="<%= resultSet.getString("id") %>">
											<input type="hidden" name="selectedStd" value="<%= request.getParameter("selectedStd") %>">
											<button type="submit" class="btn btn-primary btn-sm">
											<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
											  <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
											  <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
											</svg>
											Edit Division
											</button>
										</form>
										<form class="inline-form" method="post" action="<%=request.getContextPath()%>/manageClasses.jsp">
											<input type="hidden" name="action" value="deleteClass">
											<input type="hidden" name="classId" value="<%= resultSet.getString("id") %>">
											<input type="hidden" name="selectedStd" value="<%= request.getParameter("selectedStd") %>">
											<button type="submit" class="btn btn-danger btn-sm">
											<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
											  <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
											  <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
											</svg>  
											Delete Division
											</button>
										</form>
									</td>
								</tr>
								
								<% } %>
								
							</tbody>
							</table>
						
			<%
						
					}catch(Exception e){
						e.printStackTrace();
					}
					
			
				}
				
				
			}else{
				%>
				
				<h4 class="text-center">Please select the standard from above list.</h4>
				
				<%
			}
		%>
	</div>
	
	</div>
	<!-- /main content -->
	</div>
	
	</main>

</body>
</html>