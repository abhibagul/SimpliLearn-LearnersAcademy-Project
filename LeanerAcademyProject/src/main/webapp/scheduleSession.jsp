<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Schedule Session</title>
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
	
	<%@page import="java.text.SimpleDateFormat"%>
	<%@page import="java.text.ParseException"%>
	<%@page import="java.util.Date"%>
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
	<jsp:include page="sidebarComp.jsp"/>

	<div class="data">
	
	<jsp:include page="headerComp.jsp"/>
  
	
	<div class="p-3 control">

	<h3> <i class="bi bi-person-video2"></i> Schedule Session</h3>
	

	<%
	
	String sesName = "";
	String sesDate = "";
	String sesStart = "";
	String sesEnd = "";
	String sesStd = "";
	String sesDiv = "";
	String sesSub = "";
	String sesTeach = "";
	
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
	
	if(request.getParameter("sesName") != null){
		sesName = request.getParameter("sesName");
	}
	
	if(request.getParameter("sesDate") != null){
		sesDate = request.getParameter("sesDate");
	}
	
	if(request.getParameter("sesStart") != null){
		sesStart = request.getParameter("sesStart");
	}
	
	if(request.getParameter("sesEnd") != null){
		sesEnd = request.getParameter("sesEnd");
	}
	
	if(request.getParameter("sesStd") != null){
		sesStd = request.getParameter("sesStd");
	}
	
	if(request.getParameter("sesDiv") != null){
		sesDiv = request.getParameter("sesDiv");
	}
	
	if(request.getParameter("sesSub") != null){
		sesSub = request.getParameter("sesSub");
	}
	
	if(request.getParameter("sesTeach") != null){
		sesTeach = request.getParameter("sesTeach");
	}
	
	
	%>

	<div class="my-3 p-3 bg-body rounded shadow-sm">
	
	
		<%
		
		if(request.getParameter("step") != null && request.getParameter("step").equals("5")){
			%>
			<form method="post" action="<%= request.getContextPath() %>/CreateSession">
					<input type="hidden" name="action" value="createSession">
					<input type="hidden" name="sesName" value="<%= sesName %>">
					<input type="hidden" name="sesDate" value="<%= sesDate %>">
					<input type="hidden" name="sesStart" value="<%= sesStart %>">
					<input type="hidden" name="sesEnd" value="<%= sesEnd %>">
					<input type="hidden" name="sesStd" value="<%= sesStd %>">
					<input type="hidden" name="sesDiv" value="<%= sesDiv %>">
					<input type="hidden" name="sesSub" value="<%= sesSub %>">
					<input type="hidden" name="sesTeach" value="<%= sesTeach %>">
					
					<div class=" g-3 mb-3 align-items-center">
					  <div class="col-5">
					    <label for="sesName" class="col-form-label">Session Name</label>
					  </div>
					  <div class="col-auto">
						<input  class="form-control"  type="text" disabled name="sesName2" value="<%= sesName %>">
					  </div>
					</div>
					
					<div class=" g-3 mb-3 align-items-center">
					  <div class="col-5">
					    <label for="sesDate" class="col-form-label">Session Date</label>
					  </div>
					  <div class="col-auto">
						<input  class="form-control"  type="text" disabled name="sesDate2" value="<%= sesDate %>">
					  </div>
					</div>
					
					<div class=" g-3 mb-3 align-items-center">
					  <div class="col-5">
					    <label for="sesStart" class="col-form-label">Session Start Time</label>
					  </div>
					  <div class="col-auto">
						<input  class="form-control"  type="text" disabled name="sesStart2" value="<%= sesStart %>">
					  </div>
					</div>
					
					<div class=" g-3 mb-3 align-items-center">
					  <div class="col-5">
					    <label for="sesEnd" class="col-form-label">Session End Time</label>
					  </div>
					  <div class="col-auto">
						<input  class="form-control"  type="text" disabled name="sesEnd2" value="<%= sesEnd %>">
					  </div>
					</div>
					
					
					<div class=" g-3 mb-3 align-items-center">
					  <div class="col-5">
					    <label for="sesStd" class="col-form-label">Standard</label>
					  </div>
					  <div class="col-auto">
						<input  class="form-control"  type="text" disabled name="sesStd2" value="<%= sesStd %>">
					  </div>
					</div>
					
					<div class=" g-3 mb-3 align-items-center">
					  <div class="col-5">
					    <label for="sesDiv" class="col-form-label">Division</label>
					  </div>
					  <div class="col-auto">
						<input  class="form-control"  type="text" disabled name="sesDiv2" value="<%= sesDiv %>">
					  </div>
					</div>
					
					<div class=" g-3 mb-3 align-items-center">
					  <div class="col-5">
					    <label for="sesSub" class="col-form-label">Session Subject ID</label>
					  </div>
					  <div class="col-auto">
						<input  class="form-control"  type="text" disabled name="sesSub2" value="<%= sesSub %>">
					  </div>
					</div>
					
					<div class=" g-3 mb-3 align-items-center">
					  <div class="col-5">
					    <label for="sesTeach" class="col-form-label">Session Teacher ID</label>
					  </div>
					  <div class="col-auto">
						<input  class="form-control"  type="text" disabled name="sesTeach2" value="<%= sesTeach %>">
					  </div>
					</div>
					
					
					<input class="btn btn-primary" type="submit" value="Create Session">
				</form>
			<% 
		}
		
		if(request.getParameter("step") != null){
			
			if( !request.getParameter("step").equals("5")){
				%>
				
				<form method="post" action="<%= request.getContextPath() %>/scheduleSession.jsp">
					<input type="hidden" name="action" value="createSession">
					<input type="hidden" name="sesName" value="<%= sesName %>">
					<input type="hidden" name="sesDate" value="<%= sesDate %>">
					<input type="hidden" name="sesStart" value="<%= sesStart %>">
					<input type="hidden" name="sesEnd" value="<%= sesEnd %>">
					
					<% if(request.getParameter("step").equals("1")){ %>
					<div class=" g-3 mb-3 align-items-center">
					  <div class="col-5">
					    <label for="sesStd" class="col-form-label">Standard</label>
					  </div>
					  <div class="col-auto">
					    <select class="form-control"  name="sesStd"  id="sesStd">
							<%
							
								try{
									
									String sql ="SELECT DISTINCT std FROM class";
						
									resultSet = statement.executeQuery(sql);
									
									while(resultSet.next()){
										%>
										<option value="<%=resultSet.getString("std") %>" <% if(resultSet.getString("std").equals(request.getParameter("sesStd"))){ %> selected="selected" <% } %>><%=resultSet.getString("std") %></option>
										<%
									}
						
									
								}catch(Exception e){
									e.printStackTrace();
								}
							
							%>
							
							</select>
					  </div>
					</div>
					
					<input type="hidden" name="step" value="2">
					<% }else{
						
						%> 
						
							<input type="hidden" name="sesStd" value="<%= sesStd %>">
							
						
						<%
						
					} //step1
					
					%>
					
					 
					
					<%
					if(request.getParameter("step").equals("2")){
						
						try{
							
							PreparedStatement divSelPS = connection.prepareStatement("SELECT DISTINCT class FROM class WHERE std=?");
							divSelPS.setString(1, request.getParameter("sesStd"));
				
							resultSet = divSelPS.executeQuery();
							
							if(resultSet.next()) {
								
								%>
								
								<div class=" g-3 mb-3 align-items-center">
						  <div class="col-5">
						    <label for="sesDiv" class="col-form-label">Session Division</label>
						  </div>
						  <div class="col-auto">
						   <select class="form-control" required  name="sesDiv"  id="sesDiv">
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
						
					<input type="hidden" name="step" value="3">
								<%
								
							}
						}catch(Exception e){
							e.printStackTrace();
						}
					
					}else{
						
						%> 
						<input type="hidden" name="sesDiv" value="<%= sesDiv %>">
						
					
						<%
						
					}//step 2
					
					%>
					
					
					<%
					if(request.getParameter("step").equals("3")){
						
						try{
							
							PreparedStatement subSelPS = connection.prepareStatement("SELECT * from subject WHERE class=?");
							subSelPS.setString(1, request.getParameter("sesStd"));
				
							resultSet = subSelPS.executeQuery();
							
							if(resultSet.next()) {
								
								%>
								
								<div class=" g-3 mb-3 align-items-center">
						  <div class="col-5">
						    <label for="sesSub" class="col-form-label">Session Subject</label>
						  </div>
						  <div class="col-auto">
						   <select class="form-control" required  name="sesSub"  id="sesSub">
							<%
								do{
									%>
									
									<option value="<%=resultSet.getString("id") %>" ><%=resultSet.getString("name") %></option>
						
									<%
								}while(resultSet.next());
							
							%>
							</select>
						   </div>
						</div>
						
					<input type="hidden" name="step" value="4">
								<%
								
							}
						}catch(Exception e){
							e.printStackTrace();
						}
					
					}else{
						
						%> 
						<input type="hidden" name="sesSub" value="<%= sesSub %>">
						
					
						<%
						
					}//step 3
					
					%>
					
					
					<%
					if(request.getParameter("step").equals("4")){
						
						try{
							
							PreparedStatement teachSelPS = connection.prepareStatement("SELECT * from teacher");
				
							resultSet = teachSelPS.executeQuery();
							
							if(resultSet.next()) {
								
								%>
								
								<div class=" g-3 mb-3 align-items-center">
						  <div class="col-5">
						    <label for="sesTeach" class="col-form-label">Session Teacher</label>
						  </div>
						  <div class="col-auto">
						   <select class="form-control" required  name="sesTeach"  id="sesTeach">
							<%
								do{
									%>
									
									<option value="<%=resultSet.getString("id") %>" ><%=resultSet.getString("name") %></option>
						
									<%
								}while(resultSet.next());
							
							%>
							</select>
						   </div>
						</div>
						
					<input type="hidden" name="step" value="5">
								<%
								
							}
						}catch(Exception e){
							e.printStackTrace();
						}
					
					}else{
						
						%> 
						<input type="hidden" name="sesTeach" value="<%= sesTeach %>">
						
					
						<%
						
					}//step 3
					
					%>
					
					<input class="btn btn-primary" type="submit" value="Next">
					<input class="btn btn-light" type="reset" value="Reset">
				</form>
				<%
			}
		}else{
		
		%>
	
		<form method="post" action="<%= request.getContextPath() %>/scheduleSession.jsp">
		
		<input type="hidden" name="action" value="createSession">
		<input type="hidden" name="step" value="1">
		
		<div class=" g-3 mb-3 align-items-center">
		  <div class="col-5">
		    <label for="sesName" class="col-form-label">Session Name</label>
		  </div>
		  <div class="col-auto">
		    <input type="text" id="sesName" name="sesName" value="<%= sesName %>" required class="form-control" aria-describedby="Session Name">
		  </div>
		</div>
		
		<%
			java.sql.Date dateStr=new java.sql.Date(System.currentTimeMillis());
		    			
		
		%>
		
		<div class=" g-3 mb-3 align-items-center">
		  <div class="col-5">
		    <label for="sesDate" class="col-form-label">Session Date</label>
		  </div>
		  <div class="col-auto">
		    <input type="date" id="sesDate" min="<%= dateStr %>" name="sesDate" value="<%= sesDate %>" required class="form-control" aria-describedby="session Date">
		  </div>
		</div>
		
		<div class=" g-3 mb-3 align-items-center">
		  <div class="col-5">
		    <label for="sesStart" class="col-form-label">Session Start Time</label>
		  </div>
		  <div class="col-auto">
		    <input type="time"  onchange="updateEndTime()"  id="sesStart" name="sesStart" value="<%= sesStart %>" required class="form-control" aria-describedby="sesStart">
		  </div>
		</div>
		
		<div class=" g-3 mb-3 align-items-center">
		  <div class="col-5">
		    <label for="sesEnd" class="col-form-label">Session End Time</label>
		  </div>
		  <div class="col-auto">
		    <input type="time" id="sesEnd" name="sesEnd" value="<%= sesEnd %>" required class="form-control" aria-describedby="sesEnd">
		  </div>
		</div>
		
		<input class="btn btn-primary" type="submit" value="Next">
		<input class="btn btn-light" type="reset" value="Reset">
		
		
		</form>
		
		<%
		}
		%>

	</div><!-- white card -->
	
	


	</div>
	<!-- /main content -->
	</div>
	
	</main>
	
	<script>
	function updateEndTime(){
		let st = document.getElementById('sesStart').value;
		document.getElementById("sesEnd").min = st;
	}
	
	</script>


</body>
</html>