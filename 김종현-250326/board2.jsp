<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시판 글쓰기 결과</title>
</head>
<body>
    <h1>게시판 글쓰기 결과</h1>
    
    <%
        // 폼에서 전달된 데이터 받기
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String author = request.getParameter("author");
        
        // 데이터가 제대로 전달되었는지 출력
        if (title != null && content != null && author != null) {
            out.println("<h2>제목: " + title + "</h2>");
            out.println("<p><strong>작성자:</strong> " + author + "</p>");
            out.println("<p><strong>내용:</strong></p>");
            out.println("<p>" + content + "</p>");
        } else {
            out.println("<p>입력된 정보가 없습니다.</p>");
        }
    %>

    <br><br>
    <a href="board.jsp">다시 작성하기</a>
</body>
</html>