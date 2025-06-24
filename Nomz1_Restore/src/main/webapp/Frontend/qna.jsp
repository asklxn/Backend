<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Question, model.Answer" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>Nomz Q&A</title>
  <link rel="stylesheet" href="<c:url value='/Frontend/common/header.css'/>" />
  <style>
    body { margin: 0; font-family: sans-serif; background-color: #f9f9f9; }
    .section_1 { width: 1200px; padding-top: 100px; margin: 0 auto; }
    .title { text-align: center; font-size: 40px; margin: 30px 0; user-select: none; }
    .con_wrap { margin-top: 30px; }
    .con, .reply {
      display: flex;
      background-color: #dce5ed;
      border: 1px solid #0b1838;
      padding: 10px;
      margin-bottom: 10px;
      flex-direction: column;
    }
    .profile_img {
      width: 50px;
      height: 50px;
      border-radius: 50%;
      object-fit: cover;
      margin-right: 10px;
    }
    .text_wrap { flex: 1; }
    .text {
      background: #fffdf9c7;
      padding: 10px 20px;
      border-radius: 100px;
      margin: 5px 0;
    }
    .date { font-size: 12px; color: #0b1838; }
    .id { font-size: 12px; color: #0b1838; }
    .reply { margin-left: 70px; }
  </style>
</head>
<body>

<header>
  <img onclick="location.href='<%=request.getContextPath()%>/productList'"
       src="<%=request.getContextPath()%>/Frontend/images/logo_b.png"
       alt="로고" class="logo" />
  <div class="menu_wrap">
    <div class="menu" onclick="location.href='<%=request.getContextPath()%>/Frontend/addItem.jsp'">ADD MENU</div>
    <div class="menu" onclick="location.href='<%=request.getContextPath()%>/Frontend/login.jsp'">LOGIN</div>
    <div class="menu" onclick="location.href='<%=request.getContextPath()%>/qna'">Q&A</div>
    <div class="menu" onclick="location.href='<%=request.getContextPath()%>/profile'">MY PAGE</div>
    <div class="menu" onclick="location.href='<%=request.getContextPath()%>/cart'">CART</div>
  </div>
</header>

<section class="section_1">
  <div class="title">Q&A</div>

  <!-- 질문 작성 폼 -->
  <form action="<%= request.getContextPath() %>/addQuestion" method="post"
      style="display: flex; justify-content: center; align-items: center;
             gap: 10px; margin: 0 auto 30px; width: 500px;">
  <input type="text" name="content" placeholder="질문을 입력하세요"
         required style="flex: 1; padding: 10px;" />
  <button type="submit" style="padding: 10px 20px;">등록</button>
</form>


  <!-- 질문/답변 출력 -->
  <div class="con_wrap">
    <%
      List<Question> questionList = (List<Question>) request.getAttribute("questionList");
      if (questionList != null && !questionList.isEmpty()) {
        for (Question q : questionList) {
    %>
    <div class="con">
      <div style="display: flex; align-items: center;">
        <img src="<%= request.getContextPath() %>/Frontend/images/profile.jpg" class="profile_img" alt="user" />
        <div class="text_wrap">
          <div class="date"><%= q.getCreatedAt() %></div>
          <div class="text"><%= q.getContent() %></div>
        </div>
      </div>

      <!-- 답변 출력 -->
      <%
        List<Answer> answers = q.getAnswers();
        if (answers != null) {
          for (Answer a : answers) {
      %>
      <div class="reply" style="display: flex; align-items: center;">
        <img src="<%= request.getContextPath() %>/Frontend/images/logo_profile.png" class="profile_img" alt="admin" />
        <div class="text_wrap">
          <div class="date"><%= a.getCreatedAt() %></div>
          <div class="text"><%= a.getContent() %></div>
        </div>
      </div>
      <% }} %>

      <!-- 답변 작성 폼 -->
      <form action="<c:url value='/addAnswer' />" method="post"
            style="display: flex; gap: 10px; margin-top: 10px; margin-left: 70px;">
        <input type="hidden" name="questionId" value="<%= q.getQuestionId() %>" />
        <input type="text" name="content" placeholder="답변을 입력하세요" required />
        <button type="submit">답변</button>
      </form>
    </div>
    <% }} else { %>
      <div style="text-align: center; padding: 20px;">등록된 질문이 없습니다.</div>
    <% } %>
  </div>
</section>
</body>
</html>
