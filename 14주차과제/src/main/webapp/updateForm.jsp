<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="cs.dit.member.MemberDTO" %>
<%
    MemberDTO dto = (MemberDTO) request.getAttribute("dto");
%>
<!DOCTYPE html>
<html>
<head><title>회원 수정</title></head>
<body>
  <h2>회원 정보 수정</h2>
  <form action="${pageContext.request.contextPath}/member/updatePro" method="post">
  <input type="hidden" name="id" value="${dto.id}">
  <div class="form-group">
    <label>이름</label>
    <input type="text" name="name" value="${dto.name}" class="form-control">
  </div>
  <div class="form-group">
    <label>비밀번호</label>
    <input type="password" name="pwd" value="${dto.pwd}" class="form-control">
  </div>
  <button type="submit" class="btn btn-primary">수정</button>
</form>

</body>
</html>
