<%@page import="cs.dit.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*, javax.naming.*, javax.sql.*"  %>
    
<%	
// 	request.setCharacterEncoding("utf-8");
// 	String id = request.getParameter("id");

// 	MemberDAO dao = new MemberDAO();
// 	dao.delete(id);

%>
	
<script>
		let ans = alert("삭제되었습니다!");
		if (!ans){
			location.href='list.jsp';
		}
</script>


