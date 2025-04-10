<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*, javax.sql.DataSource, javax.naming.*" %>

<%
    request.setCharacterEncoding("UTF-8"); 

    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String pwd = request.getParameter("pwd");

    // Context 객체 한 줄로 합쳐서 커넥션 풀 연결
    DataSource ds = (DataSource)new InitialContext().lookup("java:comp/env/jdbc/kimdb");
    Connection conn = ds.getConnection();

    String sql = "INSERT INTO member (id, name, pwd) VALUES (?, ?, ?)";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, id);
    pstmt.setString(2, name);
    pstmt.setString(3, pwd);
    pstmt.executeUpdate();

    pstmt.close();
    conn.close();

    response.sendRedirect("list.jsp");
%>
