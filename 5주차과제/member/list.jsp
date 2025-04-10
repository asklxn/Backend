<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.naming.*, javax.sql.*" %>

<%
	Connection con = null;
	PreparedStatement st = null;
	ResultSet rs = null;
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>사용자 목록</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container"><br>	
	<h1 class="text-center font-weight-bold">사용자 정보</h1>
	<br>
	<table class="table table-hover">
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>비밀번호</th>
		</tr>

<%
	try {
		// 커넥션 풀에서 커넥션 얻기
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/kimdb");
		con = ds.getConnection();

		String sql = "SELECT * FROM member";
		st = con.prepareStatement(sql);
		rs = st.executeQuery();

		while(rs.next()) {
			String id = rs.getString("id");
			String name = rs.getString("name");
			String pwd = rs.getString("pwd");
%>
		<tr>
			<td><a href="updateForm.jsp?id=<%=id %>"><%=id %></a></td>
			<td><%=name %></td>
			<td><%=pwd %></td>
		</tr>
<%
		}
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null) try { rs.close(); } catch (SQLException e) {}
		if (st != null) try { st.close(); } catch (SQLException e) {}
		if (con != null) try { con.close(); } catch (SQLException e) {}
	}
%>
	</table>
	</div>	
</body>
</html>
