<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>학생 점수 입력</title>
</head>
<body>
    <h1>학생 점수 입력</h1>
    <form action="4-2.jsp" method="post">
        <label for="korean">국어 점수:</label>
        <input type="text" id="korean" name="korean" required><br><br>

        <label for="english">영어 점수:</label>
        <input type="text" id="english" name="english" required><br><br>

        <label for="math">수학 점수:</label>
        <input type="text" id="math" name="math" required><br><br>

        <input type="submit" value="제출">
    </form>
</body>
</html>