<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    	<%
		String session_u_name = (String)session.getAttribute("usname");
		String role = (String)session.getAttribute("role");	
	
		if(role != "admin"){
			response.sendRedirect("admin.jsp");
		}
		
%>

<div class="sidebar d-flex flex-column flex-shrink-0 p-3 text-bg-dark shadow-sm" style="width: 280px;">
    <a href="/" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
      <span class="fs-4">Learners Academy</span>
    </a>
    <hr>
    <ul class="nav nav-pills flex-column mb-auto">
      
      <li>
        <a href="<%=request.getContextPath()%>/dashboard.jsp" class="nav-link text-white">
         <i class="bi bi-speedometer2"></i>
          Dashboard
        </a>
      </li>
      <li>
        <a href="<%=request.getContextPath()%>/manageClasses.jsp" class="nav-link text-white">
          <i class="bi bi-cassette"></i>
          Classes
        </a>
      </li>
      
      <li>
        <a href="<%=request.getContextPath()%>/manageSubjects.jsp" class="nav-link text-white">
          <i class="bi bi-book"></i>
          Subjects
        </a>
      </li>
      
      
      <li>
        <a href="<%=request.getContextPath()%>/manageTeachers.jsp" class="nav-link text-white">
         <i class="bi bi-person-workspace"></i>
          Teachers
        </a>
      </li>
      
      <li>
        <a href="<%=request.getContextPath()%>/manageStudent.jsp" class="nav-link text-white">
          <i class="bi bi-people-fill"></i>
          Students
        </a>
      </li>
      
      <li>
        <a href="<%=request.getContextPath()%>/manageSession.jsp" class="nav-link text-white">
          <i class="bi bi-person-video2"></i>
          Sessions
        </a>
      </li>
      
     
      
    </ul>
    <hr>
    <ul class="nav nav-pills flex-column">
     <li>
        <a href="<%=request.getContextPath()%>/scheduleSession.jsp" class="nav-link text-white bg-primary">
          <i class="bi bi-person-video2"></i>
          Schedule Sessions
        </a>
      </li>
     </ul>
     <hr/>
    <div class="dropdown">
      <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
        <img src="https://media.licdn.com/dms/image/D5635AQEQ4k_kZ4kdIQ/profile-framedphoto-shrink_100_100/0/1668686633887?e=1673964000&v=beta&t=TZKx0jFoK6b7mqTGCrOMChWQslY-pgmgte-rBFLOOsg" alt="" width="32" height="32" class="rounded-circle me-2">
        <strong><% out.print(session_u_name); %></strong>
      </a>
      <ul class="dropdown-menu dropdown-menu-dark text-small shadow">
        
        <li><a class="dropdown-item" href="<%=request.getContextPath()%>/logout.jsp">Sign out</a></li>
      </ul>
    </div>
  </div>
	<!-- /sidebar -->
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>