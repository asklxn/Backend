<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.naming.*, javax.sql.*" %>

<%
	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String pwd = request.getParameter("pwd");

	Connection conn = null;
	PreparedStatement pstmt = null;

	try {
		// 커넥션 풀에서 커넥션 가져오기
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/kimdb");
		conn = ds.getConnection();

		String sql = "UPDATE member SET name = ?, pwd = ? WHERE id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, name);
		pstmt.setString(2, pwd);
		pstmt.setString(3, id);

		pstmt.executeUpdate();

	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
		if (conn != null) try { conn.close(); } catch (SQLException e) {}
	}
%>

<script>
	alert("변경되었습니다!");
	location.href = 'list.jsp';
</script>
