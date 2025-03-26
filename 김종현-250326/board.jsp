<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판 글쓰기</title>
</head>
<body>
    <h1>게시판 글쓰기</h1>
    <form action="board2.jsp" method="post">
        <label for="title">제목:</label>
        <input type="text" id="title" name="title" required><br><br>

        <label for="content">내용:</label><br>
        <textarea id="content" name="content" rows="5" cols="50" required></textarea><br><br>

        <label for="author">작성자:</label>
        <input type="text" id="author" name="author" required><br><br>

        <input type="submit" value="작성">
    </form>
</body>
</html>