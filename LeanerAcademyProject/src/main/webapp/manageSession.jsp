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
	
		try{
			
			connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
			statement=connection.createStatement();
		
			//deleting division
			if(action.equals("deleteStudent") && request.getParameter("studentId") != null){
				PreparedStatement delPS = connection.prepareStatement("DELETE FROM student where id=?");
				delPS.setString(1, request.getParameter("studentId"));
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
				<h4><i class="bi bi-person-video2"></i> Manage Sessions</h4>
			</div>
		</div>
  
  
  	<div class="my-3 p-3 bg-body rounded shadow-sm">
  	
		<div class="row">
  <div class="col-lg-6 col-md-6 ">
  <form id="sesDateSel" action="<%=request.getContextPath()%>/manageSession.jsp" method="post"  class="row ">
  	<div class="">
    <input type="hidden" name="action" value="dateSelector">
    </div>
    <div class="col-sm-6">
		<input type="date" class="form-control" name="sesDate" <%  if(request.getParameter("sesDate") != null){  %> value="<%= request.getParameter("sesDate") %>" <% } %>  onchange="document.getElementById('sesDateSel').submit();">
	</div>
  </form>
  </div>
  
  
  <!-- search func -->
   <div class="col-lg-6 col-md-6 ">
   
   
   		<%
   		
   		if(action != null && (action.equals("dateSelector") || action.equals("deleteStudent") )){
   		
   		%>
   		<form id="stdSelector" action="<%=request.getContextPath()%>/manageSession.jsp" method="post"  class="row ">
   			<input type="hidden" name="action" value="dateSelector">
   			<input type="hidden" name="sesDate" value="<%= request.getParameter("sesDate")  %>">
   			<div class=" col-sm-9">
   			<input type="text" placeholder="Search Session" <%  if(request.getParameter("query") != null){  %> value="<%= request.getParameter("query") %>" <% } %> name="query" class="form-control ">
   			</div><div class="col-sm-3">
   			<input type="submit" class="btn btn-primary" value="search">
   			</div>
   		</form>
   		
   		<%
   		
   		}
   		
   		%>
   
   </div>
  
	</div>
	
	
	</div>
	
	
	<div class="my-3">
		<%
		
			//out.print("Content: " + action + " for std, " + request.getParameter("selectedStd"));
			if(action != null ){
				
				
				if( action.equals("dateSelector") || action.equals("deleteStudent")){
					
					String searchSession = "SELECT * FROM session where sessionDate=?";
					
					if(request.getParameter("query") != null){
						searchSession += " AND sessionName LIKE ?";
					}
					
					PreparedStatement ps = connection.prepareStatement(searchSession);
					ps.setString(1, request.getParameter("sesDate"));
					
					if(request.getParameter("query") != null){
						ps.setString(2, "%" + request.getParameter("query") + "%");
					}
					
					%>
					<div class="row">
					<div class="col-lg-6 col-sm-6">
					
					<h4>Sessions on <%= request.getParameter("sesDate") %></h4>
					</div>
					</div>
					<hr/>
					<%
					
						
					try{
											
						
						resultSet = ps.executeQuery();
						
						
							%>
						
						<div class="row">
						
								<% while(resultSet.next()){ %>
							
								<div class="col-lg-4 col-md-6 col-sm-12 px-3 py-1">

				<div class=" p-3 bg-body rounded shadow-sm">
					<h5><%= resultSet.getString("sessionName") %></h5>
					<p>Time: <span class="badge bg-primary"> <%= resultSet.getString("sessionDate") %> at <%= resultSet.getString("sessionStartTime") %></span></p>
					<hr/>
					<ul class="list-group list-group-flush">
					<li class="list-group-item">Teacher: <%
					PreparedStatement psTeacher = connection.prepareStatement("SELECT * FROM teacher where id=?");
					psTeacher.setString(1, resultSet.getString("teacher"));
					teacherRes = psTeacher.executeQuery();
					
						while(teacherRes.next()){
							out.print(teacherRes.getString("name"));
						}
					
					%></li>
					<li class="list-group-item">Subject: <%
					PreparedStatement pssub = connection.prepareStatement("SELECT * FROM subject where id=?");
					pssub.setString(1, resultSet.getString("subject"));
					subRes = pssub.executeQuery();
					
						while(subRes.next()){
							out.print(subRes.getString("name"));
						}
					
					%></li>
					<li class="list-group-item">Standard: <%= resultSet.getString("std") %></li>
					<li class="list-group-item">Division: <%= resultSet.getString("class") %></li>
					</ul>
					<br/>
					<form method="post" action="viewSessionInfo.jsp">
						<input type="hidden" name="sesId" value="<%= resultSet.getString("id") %>">
						<input class="btn btn-primary" type="submit" value="More Info">
					</form>
				</div>
				</div>
								
								<% } %>
								
						</div>
			<%
						
					}catch(Exception e){
						e.printStackTrace();
					}
					
			
				}
				
				
			}else{
				%>
				
				<h4 class="text-center">Please select date for which you want to view the sessions.</h4>
				
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