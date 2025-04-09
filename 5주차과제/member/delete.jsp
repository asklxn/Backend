<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*"  %>

<%
    request.setCharacterEncoding("UTF-8");
    String idx = request.getParameter("idx");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("org.mariadb.jdbc.Driver");
        String url = "jdbc:mariadb://localhost:3307/kimdb";
        String user = "kim";
        String password = "1111";

        Connection con = DriverManager.getConnection("jdbc:mariadb://localhost:3307/kimdb", "kim", "1111");

        String sql = "DELETE FROM board WHERE idx = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(idx));
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
