<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		String jdbcDriver = "jdbc:mariadb://localhost:3306/project";
		String dbUser = "root";
		String dbPass = "maria12";
		
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String address = request.getParameter("address");
		String representative = request.getParameter("representative");
		String m_class = request.getParameter("class");
		
		String selectMagicStoreID = "select MagicStore_ID from magicstore;";
		ResultSet resultID = null;
		
		String insert_magicstore = 
				"insert into magicstore values('" + id + "', '" + password + "', '" + name + "', '" +
				 address + "', '" + representative + "', '" + m_class + "', '10000');";
		Statement stmt = null;
		Connection conn = null;
		
		try {
			String driver = "org.mariadb.jdbc.Driver";
			try {
				Class.forName(driver);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			stmt = conn.createStatement();
			resultID = stmt.executeQuery(selectMagicStoreID);

			int checkID = 1;
			System.out.println("check1");
			while(resultID.next()) {
				if(id.equals(resultID.getString(1))) {
					
					%>
					<h1>������ ID�� �����մϴ�.</h1>
					<input type="button" value="���ư���" onclick="location.href='register_magicstore.jsp'">
					<%
					checkID = 0;
					break;
				}
			}
		
			if(checkID == 1) {
				stmt.executeUpdate(insert_magicstore);
			%>			
				<div>
					<h1>��� �Ϸ�</h1>
					<p>SQL ���๮
					<p><%=insert_magicstore %>
				</div>
				<div>
					<input type="button" value="���ư���" onclick="location.href='login.jsp'">
				</div>
			<%
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			
		}
	%>
	
</body>
</html>