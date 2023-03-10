<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Session</title>
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
		ResultSet teacherRes = null;
		ResultSet subRes = null;
		ResultSet studentRes = null;
	
		try{
			
			connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
			statement=connection.createStatement();
		
			//deleting division
			if(action.equals("deleteSesison") && request.getParameter("sesId") != null){
				PreparedStatement delPS = connection.prepareStatement("DELETE FROM session where id=?");
				delPS.setString(1, request.getParameter("sesId"));
				delPS.execute();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
	
		
		if(request.getParameter("sesId") != null){
			String sesId = request.getParameter("sesId");
		}
		else{
			response.sendRedirect("manageSession.jsp");
		}
	
%>

<main>
	<jsp:include page="sidebarComp.jsp"/>

	<div class="data">
	
	<jsp:include page="headerComp.jsp"/>
  
	
	<div class="p-3 control">


	
	<div class="my-3">
		<%
		
			//out.print("Content: " + action + " for std, " + request.getParameter("selectedStd"));
			
				
					PreparedStatement ps = connection.prepareStatement("SELECT * FROM session where id=?");
					ps.setString(1, request.getParameter("sesId"));
					
					
						
					try{
											
						
						resultSet = ps.executeQuery();
						
						
							%>
						
						<div class="row">
						
								<% while(resultSet.next()){ %>
							
								<div class="col-lg-8 col-md-6 col-sm-12 order-sm-2 px-3 py-1">
									

									<!-- List of students -->
									<div class=" p-3 bg-body rounded shadow-sm">
									<h4>Students</h4>
									<hr/>
									<ul class="list-group list-group-flush">
  


									<%
										PreparedStatement studentPs = connection.prepareStatement("SELECT * FROM student where class=? and std=?");
										studentPs.setString(1, resultSet.getString("class"));
										studentPs.setString(2, resultSet.getString("std"));
										studentRes = studentPs.executeQuery();
										
										
										
										while(studentRes.next()){
											%>
											<li class="list-group-item"><%= studentRes.getString("name") %></li>
											 
											
											<%
										}
										
									%>
									</ul>
									</div>
							</div>
							
							<div class="col-lg-4 col-md-6 col-sm-12 px-3 order-sm-1 py-1">
								<h3><%= resultSet.getString("sessionName") %></h3>
								<p>Time: <span class="badge bg-primary"> <%= resultSet.getString("sessionDate") %> at <%= resultSet.getString("sessionStartTime") %></span></p>
									<hr/>

				<div class=" ">
					
					<ul class="list-group list-group-flush bg-light">
					<li class="list-group-item bg-light">Teacher: <%
					PreparedStatement psTeacher = connection.prepareStatement("SELECT * FROM teacher where id=?");
					psTeacher.setString(1, resultSet.getString("teacher"));
					teacherRes = psTeacher.executeQuery();
					
						while(teacherRes.next()){
							out.print(teacherRes.getString("name"));
						}
					
					%></li>
					<li class="list-group-item bg-light">Subject: <%
					PreparedStatement pssub = connection.prepareStatement("SELECT * FROM subject where id=?");
					pssub.setString(1, resultSet.getString("subject"));
					subRes = pssub.executeQuery();
					
						while(subRes.next()){
							out.print(subRes.getString("name"));
						}
					
					%></li>
					<li class="list-group-item bg-light">Standard: <%= resultSet.getString("std") %></li>
					<li class="list-group-item bg-light">Division: <%= resultSet.getString("class") %></li>
					</ul>
					<hr/>
					
					<form method="post" action="viewSessionInfo.jsp">
						<input type="hidden" name="sesId" value="<%= resultSet.getString("id") %>">
						<input type="hidden" name="action" value="deleteSesison">
						<input class="btn btn-danger btn-sm" type="submit" value="Cancel Session">
					</form>
				</div>
				</div>
								
								<% } %>
								
						</div>
			<%
						
					}catch(Exception e){
						e.printStackTrace();
					}
					
			
				
				
				
		
		%>
	</div>
	
	</div>
	<!-- /main content -->
	</div>
	
	</main>

</body>
</html>