/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/10.0.23
 * Generated at: 2023-01-11 13:09:44 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.jsp.*;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.PreparedStatement;

public final class manageClasses_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final jakarta.servlet.jsp.JspFactory _jspxFactory =
          jakarta.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("jakarta.servlet");
    _jspx_imports_packages.add("jakarta.servlet.http");
    _jspx_imports_packages.add("jakarta.servlet.jsp");
    _jspx_imports_classes = new java.util.HashSet<>();
    _jspx_imports_classes.add("java.sql.Connection");
    _jspx_imports_classes.add("java.sql.ResultSet");
    _jspx_imports_classes.add("java.sql.Statement");
    _jspx_imports_classes.add("java.sql.PreparedStatement");
    _jspx_imports_classes.add("java.sql.DriverManager");
  }

  private volatile jakarta.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public jakarta.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final jakarta.servlet.http.HttpServletRequest request, final jakarta.servlet.http.HttpServletResponse response)
      throws java.io.IOException, jakarta.servlet.ServletException {

    if (!jakarta.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      final java.lang.String _jspx_method = request.getMethod();
      if ("OPTIONS".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        return;
      }
      if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET, POST or HEAD. Jasper also permits OPTIONS");
        return;
      }
    }

    final jakarta.servlet.jsp.PageContext pageContext;
    jakarta.servlet.http.HttpSession session = null;
    final jakarta.servlet.ServletContext application;
    final jakarta.servlet.ServletConfig config;
    jakarta.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    jakarta.servlet.jsp.JspWriter _jspx_out = null;
    jakarta.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=ISO-8859-1");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<meta charset=\"ISO-8859-1\">\r\n");
      out.write("<title>Manage Classes</title>\r\n");
      out.write("<link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n");
      out.write("<link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css\">\r\n");
      out.write("\r\n");
      out.write("<link href=\"dashboard.css\" rel=\"stylesheet\">\r\n");
      out.write("</head>\r\n");
      out.write("<body  class=\"bg-light\">\r\n");
      out.write("	\r\n");
      out.write("	\r\n");
      out.write("	\r\n");
      out.write("	\r\n");
      out.write("	\r\n");
      out.write("	");

		String session_u_name = (String)session.getAttribute("usname");
		String role = (String)session.getAttribute("role");	
	
		if(role != "admin"){
			response.sendRedirect("admin.jsp");
			
		}
		
		String driverName = "com.mysql.jdbc.Driver";
		String connectionUrl = "jdbc:mysql://localhost:3306/";
		String dbName = "learnersacademy";
		String userId = "root";
		String password = "root12345";
		
		
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
	
		
		
		
		

      out.write("\r\n");
      out.write("\r\n");
      out.write("<main>\r\n");
      out.write("	");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "sidebarComp.jsp", out, false);
      out.write("\r\n");
      out.write("\r\n");
      out.write("	<div class=\"data\">\r\n");
      out.write("	\r\n");
      out.write("	");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "headerComp.jsp", out, false);
      out.write("\r\n");
      out.write("  \r\n");
      out.write("	\r\n");
      out.write("	<div class=\"p-3 control\">\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("	\r\n");
      out.write("	\r\n");
      out.write("	<div class=\"row\">\r\n");
      out.write("			<div class=\"col-sm-6\">\r\n");
      out.write("				<h4><i class=\"bi bi-cassette\"></i> Manage Divisions and Standards</h4>\r\n");
      out.write("			</div>\r\n");
      out.write("			<div class=\"col-sm-6 text-end\">\r\n");
      out.write("				<a href=\"");
      out.print(request.getContextPath());
      out.write("/manageClasses/createClass.jsp\" class=\"btn btn-primary\"><i class=\"bi bi-plus-lg\"></i> Create Class &amp; Division</a>\r\n");
      out.write("			</div>\r\n");
      out.write("		</div>\r\n");
      out.write("  \r\n");
      out.write("  \r\n");
      out.write("  	<div class=\"my-3 p-3 bg-body rounded shadow-sm\">\r\n");
      out.write("  	\r\n");
      out.write("		<div class=\"row\">\r\n");
      out.write("  <div class=\"col-lg-6 col-md-6 \">\r\n");
      out.write("  <form id=\"stdSelector\" action=\"");
      out.print(request.getContextPath());
      out.write("/manageClasses.jsp\" method=\"post\"  class=\"row \">\r\n");
      out.write("  	<div class=\"\">\r\n");
      out.write("    <input type=\"hidden\" name=\"action\" value=\"classSelector\">\r\n");
      out.write("    </div>\r\n");
      out.write("    <div class=\"col-sm-6\">\r\n");
      out.write("	<select class=\"form-control\" onchange=\"document.getElementById('stdSelector').submit()\" name=\"selectedStd\"  id=\"standardSelector\">\r\n");
      out.write("	<option value=\"empty\">Select Standard</option>\r\n");
      out.write("	");

	

	
		try{
			
			String sql ="SELECT DISTINCT std FROM class";

			resultSet = statement.executeQuery(sql);
			
			while(resultSet.next()){
				
      out.write("\r\n");
      out.write("				<option value=\"");
      out.print(resultSet.getString("std") );
      out.write('"');
      out.write(' ');
 if(resultSet.getString("std").equals(request.getParameter("selectedStd"))){ 
      out.write(" selected=\"selected\" ");
 } 
      out.write('>');
      out.print(resultSet.getString("std") );
      out.write("</option>\r\n");
      out.write("				");

			}

			
		}catch(Exception e){
			e.printStackTrace();
		}
	
	
      out.write("\r\n");
      out.write("	\r\n");
      out.write("	</select>\r\n");
      out.write("	</div>\r\n");
      out.write("  </form>\r\n");
      out.write("  </div>\r\n");
      out.write("  \r\n");
      out.write("	</div>\r\n");
      out.write("	\r\n");
      out.write("	\r\n");
      out.write("	</div>\r\n");
      out.write("	\r\n");
      out.write("	\r\n");
      out.write("	<div class=\"my-3 p-3 bg-body rounded shadow-sm\">\r\n");
      out.write("		");

		
			//out.print("Content: " + action + " for std, " + request.getParameter("selectedStd"));
			if(action != null && !request.getParameter("selectedStd").equals("empty") ){
				
				
				if( action.equals("classSelector") || action.equals("deleteClass")){
					
					PreparedStatement ps = connection.prepareStatement("SELECT * FROM class where std=?");
					ps.setString(1, request.getParameter("selectedStd"));
					
					
      out.write("\r\n");
      out.write("					<div class=\"row\">\r\n");
      out.write("					<div class=\"col-lg-6 col-sm-6\">\r\n");
      out.write("					\r\n");
      out.write("					<h4>Divisions for Standard ");
      out.print( request.getParameter("selectedStd") );
      out.write("</h4>\r\n");
      out.write("					</div>\r\n");
      out.write("					<div class=\"col-lg-6 col-sm-6 text-end\">\r\n");
      out.write("					 <a href=\"");
      out.print(request.getContextPath());
      out.write("/manageClasses/createClass.jsp?stdName=");
      out.print( request.getParameter("selectedStd") );
      out.write("\" class=\"btn btn-primary btn-sm\"><i class=\"bi bi-plus-lg\"></i> Create Division for ");
      out.print( request.getParameter("selectedStd") );
      out.write(" std</a>\r\n");
      out.write("					</div>\r\n");
      out.write("					</div>\r\n");
      out.write("					<hr/>\r\n");
      out.write("					");

					
						
					try{
											
						
						resultSet = ps.executeQuery();
						
						
							
      out.write("\r\n");
      out.write("							<table  class=\"table table-striped table-hover rounded\">\r\n");
      out.write("							<thead class=\"bg-dark text-light rounded\">\r\n");
      out.write("								<tr>\r\n");
      out.write("									<th scope=\"col\" class=\"text-center\">Class id</th>\r\n");
      out.write("									<th scope=\"col\" class=\"text-center\">Class Name</th>\r\n");
      out.write("									<th scope=\"col\" class=\"text-center\">Class Standard</th>\r\n");
      out.write("									<th scope=\"col\" class=\"text-center\">Class Division</th>\r\n");
      out.write("									<th scope=\"col\" class=\"text-center\">Action</th>\r\n");
      out.write("								</tr>\r\n");
      out.write("							</thead>\r\n");
      out.write("							<tbody>\r\n");
      out.write("								\r\n");
      out.write("								");
 while(resultSet.next()){ 
      out.write("\r\n");
      out.write("							\r\n");
      out.write("								<tr>\r\n");
      out.write("									<td class=\"text-center\">");
      out.print( resultSet.getString("id") );
      out.write("</td>\r\n");
      out.write("									<td class=\"text-center\">");
      out.print( resultSet.getString("name") );
      out.write("</td>\r\n");
      out.write("									<td class=\"text-center\">");
      out.print( resultSet.getString("std") );
      out.write("</td>\r\n");
      out.write("									<td class=\"text-center\">");
      out.print( resultSet.getString("class") );
      out.write("</td>\r\n");
      out.write("									<td class=\"text-center\">\r\n");
      out.write("										<form class=\"inline-form\"  method=\"post\" action=\"");
      out.print(request.getContextPath());
      out.write("/manageClasses/modifyClass.jsp\">\r\n");
      out.write("											<input type=\"hidden\" name=\"action\" value=\"editClass\">\r\n");
      out.write("											<input type=\"hidden\" name=\"classId\" value=\"");
      out.print( resultSet.getString("id") );
      out.write("\">\r\n");
      out.write("											<input type=\"hidden\" name=\"selectedStd\" value=\"");
      out.print( request.getParameter("selectedStd") );
      out.write("\">\r\n");
      out.write("											<button type=\"submit\" class=\"btn btn-primary btn-sm\">\r\n");
      out.write("											<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"16\" height=\"16\" fill=\"currentColor\" class=\"bi bi-pencil-square\" viewBox=\"0 0 16 16\">\r\n");
      out.write("											  <path d=\"M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z\"/>\r\n");
      out.write("											  <path fill-rule=\"evenodd\" d=\"M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z\"/>\r\n");
      out.write("											</svg>\r\n");
      out.write("											Edit Division\r\n");
      out.write("											</button>\r\n");
      out.write("										</form>\r\n");
      out.write("										<form class=\"inline-form\" method=\"post\" action=\"");
      out.print(request.getContextPath());
      out.write("/manageClasses.jsp\">\r\n");
      out.write("											<input type=\"hidden\" name=\"action\" value=\"deleteClass\">\r\n");
      out.write("											<input type=\"hidden\" name=\"classId\" value=\"");
      out.print( resultSet.getString("id") );
      out.write("\">\r\n");
      out.write("											<input type=\"hidden\" name=\"selectedStd\" value=\"");
      out.print( request.getParameter("selectedStd") );
      out.write("\">\r\n");
      out.write("											<button type=\"submit\" class=\"btn btn-danger btn-sm\">\r\n");
      out.write("											<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"16\" height=\"16\" fill=\"currentColor\" class=\"bi bi-trash\" viewBox=\"0 0 16 16\">\r\n");
      out.write("											  <path d=\"M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z\"/>\r\n");
      out.write("											  <path fill-rule=\"evenodd\" d=\"M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z\"/>\r\n");
      out.write("											</svg>  \r\n");
      out.write("											Delete Division\r\n");
      out.write("											</button>\r\n");
      out.write("										</form>\r\n");
      out.write("									</td>\r\n");
      out.write("								</tr>\r\n");
      out.write("								\r\n");
      out.write("								");
 } 
      out.write("\r\n");
      out.write("								\r\n");
      out.write("							</tbody>\r\n");
      out.write("							</table>\r\n");
      out.write("						\r\n");
      out.write("			");

						
					}catch(Exception e){
						e.printStackTrace();
					}
					
			
				}
				
				
			}else{
				
      out.write("\r\n");
      out.write("				\r\n");
      out.write("				<h4 class=\"text-center\">Please select the standard from above list.</h4>\r\n");
      out.write("				\r\n");
      out.write("				");

			}
		
      out.write("\r\n");
      out.write("	</div>\r\n");
      out.write("	\r\n");
      out.write("	</div>\r\n");
      out.write("	<!-- /main content -->\r\n");
      out.write("	</div>\r\n");
      out.write("	\r\n");
      out.write("	</main>\r\n");
      out.write("\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof jakarta.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
