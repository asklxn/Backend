<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 가입 결과</title>
</head>
<body>
    <h1>회원 가입 결과</h1>
    
    <%
   			 request.setCharacterEncoding("UTF-8");
        // 단일 값 입력 받기
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");

        // 출력
        out.println("<p><strong>이름:</strong> " + name + "</p>");
        out.println("<p><strong>이메일:</strong> " + email + "</p>");
        out.println("<p><strong>성별:</strong> " + gender + "</p>");
        out.println("<p><strong>전화번호:</strong> " + phone + "</p>");
    %>

    <br><br>
    <a href="signup.jsp">다시 가입하기</a>
</body>
</html>