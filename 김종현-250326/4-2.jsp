<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>학생 점수 처리 결과</title>
</head>
<body>
    <h1>학생 점수 결과</h1>

    <%
        // 입력받은 점수를 문자열로 받아옵니다.
        String koreanScoreStr = request.getParameter("korean");
        String englishScoreStr = request.getParameter("english");
        String mathScoreStr = request.getParameter("math");
        
        // 문자열을 정수로 변환합니다.
        int koreanScore = Integer.parseInt(koreanScoreStr);
        int englishScore = Integer.parseInt(englishScoreStr);
        int mathScore = Integer.parseInt(mathScoreStr);
        
        // 총점 계산
        int totalScore = koreanScore + englishScore + mathScore;
        
        // 평균 계산
        float averageScore = totalScore / 3.0f;
        
        // 평균을 소수점 두 자리로 포맷
        String formattedAverage = String.format("%.2f", averageScore);
    %>

    <p>국어 점수: <%= koreanScore %></p>
    <p>영어 점수: <%= englishScore %></p>
    <p>수학 점수: <%= mathScore %></p>
    <p>총점: <%= totalScore %></p>
    <p>평균: <%= formattedAverage %></p>
</body>
</html>