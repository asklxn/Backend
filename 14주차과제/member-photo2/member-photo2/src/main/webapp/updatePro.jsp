<%@page import="cs.dit.member.MemberDAO"%>
<%@page import="cs.dit.member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import ="java.sql.*, javax.naming.*, javax.sql.*" %>
<%	
// 	request.setCharacterEncoding("utf-8");

// 	String id = request.getParameter("id");
// 	String name = request.getParameter("name");
// 	String pwd = request.getParameter("pwd");
// 	String photo = request.getParameter("photo");

// 	MemberDTO dto = new MemberDTO(id, name, pwd, photo);
// 	MemberDAO dao = new MemberDAO();
	
// 	dao.update(dto);

	%>

	<script>
		let ans = alert("변경되었습니다!");
		if (!ans){
			location.href='list.jsp';
		}
	</script>



