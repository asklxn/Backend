<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 가입</title>
</head>
<body>
    <h1>회원 가입 양식</h1>
    <form action="signup2.jsp" method="post">
        <!-- 이름 입력 -->
        <label for="name">이름:</label>
        <input type="text" id="name" name="name" required><br><br>

        <!-- 이메일 입력 -->
        <label for="email">이메일:</label>
        <input type="email" id="email" name="email" required><br><br>

        <!-- 성별 선택 (라디오 버튼) -->
        <label>성별:</label>
        <input type="radio" id="male" name="gender" value="남성" required>
        <label for="male">남성</label>
        <input type="radio" id="female" name="gender" value="여성" required>
        <label for="female">여성</label><br><br>

        <!-- 전화번호 입력 -->
        <label for="phone">전화번호:</label>
        <input type="text" id="phone" name="phone" placeholder="010-1234-5678" pattern="^\d{3}-\d{4}-\d{4}$" required><br><br>

        <!-- 제출 버튼 -->
        <input type="submit" value="가입하기">
    </form>
</body>
</html>