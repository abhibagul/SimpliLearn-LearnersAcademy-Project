<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Dashboard</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

<link href="dashboard.css" rel="stylesheet">
</head>
<body class="bg-light">
	<%@page import="java.sql.DriverManager"%>
	<%@page import="java.sql.ResultSet"%>
	<%@page import="java.sql.Statement"%>
	<%@page import="java.sql.Connection"%>
	
	<%@page import="java.text.SimpleDateFormat"%>
	<%@page import="java.text.ParseException"%>
	<%@page import="java.util.Date"%>
	<%@page import="java.util.Calendar"%>
	<%@page import="java.text.DateFormat"%>
	

	
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
		
		<div class="col-lg-6 col-md-6 col-sm-12">
			<div class=" ">
				<h4>Todays Session</h4>
				<hr/>
				
					<%
					
					
					Date date = Calendar.getInstance().getTime();  
					DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
					String strDate = dateFormat.format(date);  
					
					
					
					PreparedStatement psSes = connection.prepareStatement("SELECT * FROM session where sessionDate=? LIMIT 4");
					psSes.setString(1, strDate);
					
					resultSet = psSes.executeQuery();
					
					
					if(resultSet.next()){
						
					
					do{
						%>
						
						<div class=" col-sm-12 p-3 bg-body rounded shadow-sm mb-3">
						<h5><%= resultSet.getString("sessionName") %> <small class="text-secondary">by <%
							PreparedStatement psTeacher = connection.prepareStatement("SELECT * FROM teacher where id=?");
							psTeacher.setString(1, resultSet.getString("teacher"));
							teacherRes = psTeacher.executeQuery();
							
								while(teacherRes.next()){
									out.print(teacherRes.getString("name"));
								}
							
							%></small></h5>
						<p>Starts at: <span class="badge bg-light text-secondary"> <%= resultSet.getString("sessionStartTime") %></span>
						Subject: <span class="badge bg-light text-secondary"><%
							PreparedStatement pssub = connection.prepareStatement("SELECT * FROM subject where id=? ");
							pssub.setString(1, resultSet.getString("subject"));
							subRes = pssub.executeQuery();
							
								while(subRes.next()){
									out.print(subRes.getString("name"));
								}
							
							%></span>
							</p>
								<form method="post" action="viewSessionInfo.jsp">
						<input type="hidden" name="sesId" value="<%= resultSet.getString("id") %>">
						<input class="btn btn-primary btn-sm" type="submit" value="More Info">
					</form>
						</div>
						 
						
						<%
					}while(resultSet.next());
					
					}else{
						%>
						<div class="col-sm-12 p-3 bg-body rounded shadow-sm mb-3 text-center">
							<h6>No sessions scheduled for today.
							</h6>
							<a href="<%=request.getContextPath()%>/scheduleSession.jsp" class="nav-link text-white bg-primary p-1">
					          <i class="bi bi-person-video2"></i>
					          Schedule Session
					        </a>
						</div>
						
						
						<%
					}
					
					%>
				
			</div>
		</div>
		
		<div class="col-lg-6 col-md-6 col-sm-12">
		
			
		
		</div>
		
	</div>
	
	


	</div>
	<!-- /main content -->
	</div>
	
	</main>
	



</body>
</html>