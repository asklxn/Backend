<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.naming.*, javax.sql.*" %>

<%
    request.setCharacterEncoding("UTF-8");
    String id = request.getParameter("id");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // 커넥션 풀에서 커넥션 가져오기
        Context initCtx = new InitialContext();
        Context envCtx = (Context)initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/kimdb");
        conn = ds.getConnection();

        String sql = "DELETE FROM member WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        pstmt.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>

<script>
    alert("삭제되었습니다!");
    location.href = 'list.jsp';
</script>
