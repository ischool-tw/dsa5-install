<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=utf-8" language="java" pageEncoding="utf-8"%>
<%@ page import="ischool.dsa.exception.DSAServerException"%>
<%@ page import="ischool.dsa.*"%>
<%@ page import="ischool.dsa.server.*"%>
<%@ page import="ischool.dsa.utility.*"%>
<%@ page import="org.w3c.dom.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>DSA <%=Server.Version%>Startup
</title>
</head>
<body>
	<H1>
		DSA Server
		<%=Server.Version%></H1>
	<%
		if (Server.isAvailable()) {
			out.println("<H1>Started</H1>");
			return;
		}

		String serverRoot = getServletContext().getRealPath("");
		String configFile = Path.combine(serverRoot, "WEB-INF/conf/server.xml");
		Element conf = null;
		boolean stepSuccess = false;
		String successHtml = "<span style='color:blue'>Success!</span>";
		String failHtml = "<span style='color:red'>Fail!</span>";
	%>

	<H3>
		load server.xml：<%
		try {
			conf = XmlHelper.parseXml(new File(configFile));
			out.println(successHtml);
			stepSuccess = true;
		} catch (Exception ex) {
			out.println("讀取 server.xml 錯誤 >>> "+ex.getMessage());
			out.println("<xmp>"+ExceptionUtil.getErrorMessage(ex)+"</xmp>");
			stepSuccess = false;
		}
	%>
	</H3>

	<H3>
		<%
			Element driver = null;
			Element url = null;
			Element username = null;
			Element password = null;

			if (stepSuccess) {
				stepSuccess = false;
				try {
					Element db = XmlUtil.selectElement(conf, "Property");
					db = XmlUtil.selectElement(db, "ServerConnection");
					driver = XmlUtil.selectElement(db, "Driver");
					url = XmlUtil.selectElement(db, "URL");
					username = XmlUtil.selectElement(db, "UserName");
					password = XmlUtil.selectElement(db, "Password");

					if (driver != null)
						out.println("read driver " + successHtml + "<br>");
					else
						out.println("read driver " + failHtml + "<br>");

					if (url != null)
						out.println("read db url " + successHtml + "<br>");
					else
						out.println("read db url " + failHtml + "<br>");

					if (username != null)
						out.println("read username " + successHtml + "<br>");
					else
						out.println("read username " + failHtml + "<br>");

					if (password != null)
						out.println("read password " + successHtml + "<br>");
					else
						out.println("read password " + failHtml + "<br>");
					stepSuccess = true;
				} catch (Exception ex) {
					out.println(ex.getMessage());
					stepSuccess = false;
				}
			}
		%>
	</H3>
	<H3>
		test dsa server database connection：
		<%
		if (stepSuccess) {
			stepSuccess = false;
			try {

				Connection conn = ConnectionUtil.createConnection(
						driver.getTextContent(),
						url.getTextContent(),
						username.getTextContent(),
						password.getTextContent());
				conn.close();
				out.println(successHtml);
				stepSuccess = true;
			} catch (Exception ex) {
				SQLException sql = (SQLException) ex.getCause();

				out.println(sql.getMessage());
				stepSuccess = false;
			}
		}
	%>
	</H3>
	<H3>
		dsa server configuration name：<%
		if (stepSuccess) {
			String srvName = conf.getAttribute("Name");
			out.println(srvName);
		}
	%>
	</H3>
	<H3>
		dsa server startup：
		<%
		if (stepSuccess)
		{
			stepSuccess = false;
			try {
				Server.startup(serverRoot);
				out.println(successHtml);
				stepSuccess = true;
			} catch (Exception ex) {
				String msg = ExceptionUtil.getErrorMessage(ex);
				out.println("<xmp>" + msg + "</xmp>");
				stepSuccess = false;
			}
		}
	%>
	</H3>
</body>
</html>
