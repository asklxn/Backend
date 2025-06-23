<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="model.Member" %>
<%
    Member member = (Member) request.getAttribute("member");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8" />
  <title>Nomz Profile</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="<%=request.getContextPath()%>/Frontend/common/header.css" />
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }
    .section_1 {
      width: 100%;
      height: 100vh;
      padding: 100px;
      display: flex;
      justify-content: center;
      align-items: center;
      perspective: 1000px;
    }
    swiper-container {
      position: relative;
      width: 550px;
      height: 360px;
    }
    swiper-slide {
      width: 100%;
      height: 100%;
      box-shadow: 15px 30px 20px rgba(0, 0, 0, 0.3);
      background-color: #dce5ed;
      padding: 70px 50px;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      align-items: center;
      border: 1px solid #0b1838;
    }
    .profile {
      width: 100px;
      height: 100px;
      border-radius: 50%;
      border: 1px solid #0b183880;
    }
    .id {
      font-size: 14px;
    }
    .btn_wrap {
      width: 100%;
      display: flex;
      justify-content: space-between;
      align-items: center;
      text-align: center;
      line-height: 40px;
    }
    .btn {
      width: 49%;
      height: 40px;
      background-color: #0b1838;
      color: #fffdf9;
      font-size: 14px;
      margin-top: 30px;
      cursor: pointer;
      box-shadow: 3px 3px 3px rgba(0, 0, 0, 0.3);
      pointer-events: auto;
    }
    .text_wrap {
      width: 100%;
      padding: 10px 0;
      display: flex;
      justify-content: space-between;
      align-items: center;
      font-size: 14px;
    }
    .lable {
      width: 100px;
      border-right: 0.5px solid #0b1838;
    }
    .value {
      padding-left: 20px;
      width: 100%;
    }
  </style>
</head>
<body>
<header>
  <img onclick="location.href='<%=request.getContextPath()%>/productList'" src="<%=request.getContextPath()%>/Frontend/images/logo_b.png" alt="로고" class="logo" />
  <div class="menu_wrap">
    <div class="menu" onclick="location.href='<%=request.getContextPath()%>/Frontend/addItem.jsp'">ADD MENU</div>
    <div class="menu" onclick="location.href='<%=request.getContextPath()%>/Frontend/login.jsp'">LOGIN</div>
    <div class="menu" onclick="location.href='<%=request.getContextPath()%>/qna'">Q&A</div>
    <div class="menu" onclick="location.href='<%=request.getContextPath()%>/profile'">MY PAGE</div>
    <div class="menu" onclick="location.href='<%=request.getContextPath()%>/Frontend/cart.jsp'">CART</div>
  </div>
</header>

<section class="section_1">
  <swiper-container class="mySwiper" effect="flip" grab-cursor="true" loop="true">
    <swiper-slide>
      <img src="<%=request.getContextPath()%>/Frontend/images/profile.jpg" alt="프로필" class="profile" />
      <div class="id"><%= member != null ? member.getUsername() : "비회원" %></div>
      <div class="btn_wrap">
        <div class="btn orderHistory_btn" onclick="location.href='<%=request.getContextPath()%>/orderHistory'">주문내역</div>
        <div class="btn logout_btn" onclick="alert('로그아웃 되었습니다.'); location.href='<%=request.getContextPath()%>/logout';">로그아웃</div>
      </div>
    </swiper-slide>
    <swiper-slide>
      <div class="text_wrap"><div class="lable">이름</div><div class="value"><%= member != null ? member.getName() : "" %></div></div>
      <div class="text_wrap"><div class="lable">아이디</div><div class="value"><%= member != null ? member.getUsername() : "" %></div></div>
      <div class="text_wrap"><div class="lable">생년월일</div><div class="value"><%= member != null ? member.getBirth() : "" %></div></div>
      <div class="text_wrap"><div class="lable">전화번호</div><div class="value"><%= member != null ? member.getPhone() : "" %></div></div>
      <div class="text_wrap"><div class="lable">주소</div><div class="value"><%= member != null ? member.getAddress() + " " + member.getDetailAddress() : "" %></div></div>
    </swiper-slide>
  </swiper-container>
</section>

<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-element-bundle.min.js"></script>
</body>
</html>
