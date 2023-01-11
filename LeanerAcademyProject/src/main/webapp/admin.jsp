<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Login</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%
		String session_u_name = (String)session.getAttribute("usname");
		String role = (String)session.getAttribute("role");	
		String invalid = (String) session.getAttribute("invalid");
		
		
		if(role == "admin"){
			response.sendRedirect("dashboard.jsp");
		}
		
	%>

<div class="container">
<form method="post" action="<%=request.getContextPath()%>/AdminLogin">
<div class="row">
<div class="col-sm-4 offset-4 my-4 ">
	<h1 class="text-center">Admin Login</h1>
	<%
		if(invalid != null) {
			out.print("<h5 class=\"text-danger text-center\">"+invalid + "</h5>");
			request.getSession().setAttribute("invalid", null);
		}
	%>
  <div class="mb-3">
    <label for="exampleInputEmail1" class="form-label">User Name:</label>
    <input type="text" class="form-control" name="username" required="required">
  </div>
  <div class="mb-3">
    <label for="exampleInputPassword1" class="form-label">Password</label>
    <input type="password" class="form-control" name="password" required="required">
  </div>
  <button type="submit" value="adminLogin" class="btn btn-primary">Login</button>
  <button type="reset" class="btn btn-light">Reset</button>
  </div>
</div>
</form>
</div>


</body>
</html>