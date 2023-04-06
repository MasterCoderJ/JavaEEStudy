/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.70
 * Generated at: 2023-02-06 15:38:15 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.board;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import com.mvc3.domain.Board;

public final class detail_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = new java.util.HashSet<>();
    _jspx_imports_classes.add("com.mvc3.domain.Board");
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
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

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
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

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    if (!javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      final java.lang.String _jspx_method = request.getMethod();
      if ("OPTIONS".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        return;
      }
      if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSP들은 오직 GET, POST 또는 HEAD 메소드만을 허용합니다. Jasper는 OPTIONS 메소드 또한 허용합니다.");
        return;
      }
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");

	//포워딩에 의해 이 페이지가 호출되기 때문에, 유지된 요청 정보로부터 dto를 꺼내자
	Board board= (Board)request.getAttribute("board");

      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<meta charset=\"UTF-8\">\r\n");
      out.write("<title>Insert title here</title>\r\n");
      out.write("<script src=\"https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js\"></script>\r\n");
      out.write("\r\n");
      out.write("<!-- Latest compiled and minified CSS -->\r\n");
      out.write("<link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css\">\r\n");
      out.write("\r\n");
      out.write("<!-- jQuery library -->\r\n");
      out.write("<script src=\"https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.slim.min.js\"></script>\r\n");
      out.write("\r\n");
      out.write("<!-- Popper JS -->\r\n");
      out.write("<script src=\"https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js\"></script>\r\n");
      out.write("\r\n");
      out.write("<!-- Latest compiled JavaScript -->\r\n");
      out.write("<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js\"></script>\r\n");
      out.write("\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("	\r\n");
      out.write("	function del(){\r\n");
      out.write("		if(confirm(\"삭제하시겠습니까?\")){\r\n");
      out.write("			$(\"#form1\").attr({\r\n");
      out.write("				action:\"/board/delete.do\",\r\n");
      out.write("				method:\"post\"\r\n");
      out.write("			});\r\n");
      out.write("			$(\"#form1\").submit();\r\n");
      out.write("		}\r\n");
      out.write("	}\r\n");
      out.write("	\r\n");
      out.write("	function edit(){\r\n");
      out.write("		if(confirm(\"수정하시겠습니까?\")){\r\n");
      out.write("			$(\"#form1\").attr({\r\n");
      out.write("				action:\"/board/update.do\",\r\n");
      out.write("				method:\"post\"\r\n");
      out.write("			});\r\n");
      out.write("			\r\n");
      out.write("			$(\"#form1\").submit();\r\n");
      out.write("		}\r\n");
      out.write("	}\r\n");
      out.write("	\r\n");
      out.write("	$(function(){\r\n");
      out.write("		$(\"#bt_del\").click(function(){\r\n");
      out.write("			del();\r\n");
      out.write("		});\r\n");
      out.write("		\r\n");
      out.write("		$(\"#bt_edit\").click(function(){\r\n");
      out.write("			edit();\r\n");
      out.write("		});\r\n");
      out.write("		\r\n");
      out.write("	});\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("	<div class=\"container m-5\">\r\n");
      out.write("		<form id=\"form1\">\r\n");
      out.write("			<input type=\"hidden\" name=\"board_idx\" value=\"");
      out.print(board.getBoard_idx());
      out.write("\">\r\n");
      out.write("			<div class=\"form-group\">\r\n");
      out.write("				<input type=\"text\" class=\"form-control\" value=\"");
      out.print(board.getTitle() );
      out.write("\" name=\"title\">\r\n");
      out.write("			</div>\r\n");
      out.write("			<div class=\"form-group\">\r\n");
      out.write("				<input type=\"text\" class=\"form-control\" value=\"");
      out.print(board.getWriter() );
      out.write("\" name=\"writer\">\r\n");
      out.write("			</div>\r\n");
      out.write("			<div class=\"form-group\">\r\n");
      out.write("				<textarea class=\"form-control\" placeholder=\"Enter content\" name=\"content\">");
      out.print(board.getContent() );
      out.write("</textarea>\r\n");
      out.write("			</div>\r\n");
      out.write("		</form>\r\n");
      out.write("		<div class=\"form-group\">\r\n");
      out.write("			<button type=\"button\" class=\"btn btn-success\" id=\"bt_edit\">수정</button>\r\n");
      out.write("			<button type=\"button\" class=\"btn btn-success\" id=\"bt_del\">삭제</button>\r\n");
      out.write("			<button type=\"button\" class=\"btn btn-success\" id=\"bt_list\">목록</button>\r\n");
      out.write("		</div>\r\n");
      out.write("	</div>\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
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