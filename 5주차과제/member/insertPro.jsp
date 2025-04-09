<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8"); 

	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String pwd = request.getParameter("pwd");

	// 1. DB 연동 드라이버 로드
	Class.forName("org.mariadb.jdbc.Driver");

	// 2. 연결 객체 생성
	String url = "jdbc:mariadb://localhost:3307/kimdb";  // 포트번호 수정: 기본값 3306
	String user = "kim";
	String password = "1111";
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3307/kimdb", "kim", "1111");

	// 3. SQL 실행 준비
	String sql = "INSERT INTO member (id, name, pwd) VALUES (?, ?, ?)";
	PreparedStatement pstmt = conn.prepareStatement(sql);

	// 4. SQL 실행
	pstmt.setString(1, id);
	pstmt.setString(2, name);
	pstmt.setString(3, pwd);
	int i = pstmt.executeUpdate();  // 몇 행이 삽입되었는지 반환

	// 5. 객체 해제
	pstmt.close();
	conn.close();

	// 6. list.jsp로 이동
	response.sendRedirect("list.jsp");
%>
