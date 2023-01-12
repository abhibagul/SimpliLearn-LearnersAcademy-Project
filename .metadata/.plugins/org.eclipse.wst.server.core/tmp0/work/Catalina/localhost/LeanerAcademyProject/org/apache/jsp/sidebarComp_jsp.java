/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/10.0.23
 * Generated at: 2023-01-12 06:08:15 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.jsp.*;

public final class sidebarComp_jsp extends org.apache.jasper.runtime.HttpJspBase
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
    _jspx_imports_classes = null;
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
      out.write("    	");

		String session_u_name = (String)session.getAttribute("usname");
		String role = (String)session.getAttribute("role");	
	
		if(role != "admin"){
			response.sendRedirect("admin.jsp");
		}
		

      out.write("\r\n");
      out.write("\r\n");
      out.write("<div class=\"sidebar d-flex flex-column flex-shrink-0 p-3 text-bg-dark shadow-sm\" style=\"width: 280px;\">\r\n");
      out.write("    <a href=\"/\" class=\"d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none\">\r\n");
      out.write("      <span class=\"fs-4\">Learners Academy</span>\r\n");
      out.write("    </a>\r\n");
      out.write("    <hr>\r\n");
      out.write("    <ul class=\"nav nav-pills flex-column mb-auto\">\r\n");
      out.write("      \r\n");
      out.write("      <li>\r\n");
      out.write("        <a href=\"");
      out.print(request.getContextPath());
      out.write("/dashboard.jsp\" class=\"nav-link text-white\">\r\n");
      out.write("         <i class=\"bi bi-speedometer2\"></i>\r\n");
      out.write("          Dashboard\r\n");
      out.write("        </a>\r\n");
      out.write("      </li>\r\n");
      out.write("      <li>\r\n");
      out.write("        <a href=\"");
      out.print(request.getContextPath());
      out.write("/manageClasses.jsp\" class=\"nav-link text-white\">\r\n");
      out.write("          <i class=\"bi bi-cassette\"></i>\r\n");
      out.write("          Classes\r\n");
      out.write("        </a>\r\n");
      out.write("      </li>\r\n");
      out.write("      \r\n");
      out.write("      <li>\r\n");
      out.write("        <a href=\"");
      out.print(request.getContextPath());
      out.write("/manageSubjects.jsp\" class=\"nav-link text-white\">\r\n");
      out.write("          <i class=\"bi bi-book\"></i>\r\n");
      out.write("          Subjects\r\n");
      out.write("        </a>\r\n");
      out.write("      </li>\r\n");
      out.write("      \r\n");
      out.write("      \r\n");
      out.write("      <li>\r\n");
      out.write("        <a href=\"");
      out.print(request.getContextPath());
      out.write("/manageTeachers.jsp\" class=\"nav-link text-white\">\r\n");
      out.write("         <i class=\"bi bi-person-workspace\"></i>\r\n");
      out.write("          Teachers\r\n");
      out.write("        </a>\r\n");
      out.write("      </li>\r\n");
      out.write("      \r\n");
      out.write("      <li>\r\n");
      out.write("        <a href=\"");
      out.print(request.getContextPath());
      out.write("/manageStudent.jsp\" class=\"nav-link text-white\">\r\n");
      out.write("          <i class=\"bi bi-people-fill\"></i>\r\n");
      out.write("          Students\r\n");
      out.write("        </a>\r\n");
      out.write("      </li>\r\n");
      out.write("      \r\n");
      out.write("      <li>\r\n");
      out.write("        <a href=\"");
      out.print(request.getContextPath());
      out.write("/manageClasses.jsp\" class=\"nav-link text-white\">\r\n");
      out.write("          <i class=\"bi bi-person-video2\"></i>\r\n");
      out.write("          Sessions\r\n");
      out.write("        </a>\r\n");
      out.write("      </li>\r\n");
      out.write("      \r\n");
      out.write("     \r\n");
      out.write("      \r\n");
      out.write("    </ul>\r\n");
      out.write("    <hr>\r\n");
      out.write("    <ul class=\"nav nav-pills flex-column\">\r\n");
      out.write("     <li>\r\n");
      out.write("        <a href=\"");
      out.print(request.getContextPath());
      out.write("/scheduleSession.jsp\" class=\"nav-link text-white bg-primary\">\r\n");
      out.write("          <i class=\"bi bi-person-video2\"></i>\r\n");
      out.write("          Schedule Sessions\r\n");
      out.write("        </a>\r\n");
      out.write("      </li>\r\n");
      out.write("     </ul>\r\n");
      out.write("     <hr/>\r\n");
      out.write("    <div class=\"dropdown\">\r\n");
      out.write("      <a href=\"#\" class=\"d-flex align-items-center text-white text-decoration-none dropdown-toggle\" data-bs-toggle=\"dropdown\" aria-expanded=\"false\">\r\n");
      out.write("        <img src=\"https://media.licdn.com/dms/image/D5635AQEQ4k_kZ4kdIQ/profile-framedphoto-shrink_100_100/0/1668686633887?e=1673964000&v=beta&t=TZKx0jFoK6b7mqTGCrOMChWQslY-pgmgte-rBFLOOsg\" alt=\"\" width=\"32\" height=\"32\" class=\"rounded-circle me-2\">\r\n");
      out.write("        <strong>");
 out.print(session_u_name); 
      out.write("</strong>\r\n");
      out.write("      </a>\r\n");
      out.write("      <ul class=\"dropdown-menu dropdown-menu-dark text-small shadow\">\r\n");
      out.write("        <li><a class=\"dropdown-item\" href=\"#\">Profile</a></li>\r\n");
      out.write("            <li><a class=\"dropdown-item\" href=\"#\">Manage Users</a></li>\r\n");
      out.write("        <li><hr class=\"dropdown-divider\"></li>\r\n");
      out.write("        <li><a class=\"dropdown-item\" href=\"");
      out.print(request.getContextPath());
      out.write("/logout.jsp\">Sign out</a></li>\r\n");
      out.write("      </ul>\r\n");
      out.write("    </div>\r\n");
      out.write("  </div>\r\n");
      out.write("	<!-- /sidebar -->\r\n");
      out.write("	\r\n");
      out.write("	<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js\" integrity=\"sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN\" crossorigin=\"anonymous\"></script>");
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
