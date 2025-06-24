<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.CartItem" %>
<%@ page import="java.util.List" %>
<%
    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
    int total = 0;
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>장바구니</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/Frontend/common/header.css" />
  <style>
    .section_1 { width: 100%; padding: 80px 100px; }
    .title { text-align: center; font-size: 35px; margin-bottom: 30px; }
    .item_wrap { display: flex; justify-content: space-between; align-items: center; padding: 20px 0; border-bottom: 1px solid #ccc; }
    .item_img { width: 100px; height: 100px; object-fit: cover; }
    .item_text, .item_price, .item_count { width: 150px; text-align: center; }
    .total { text-align: right; font-size: 20px; margin-top: 20px; }
    .buy_btn { display: block; width: 200px; height: 50px; margin: 30px auto; background: #dce5ed; border: 1px solid #000; font-size: 18px; line-height: 50px; text-align: center; cursor: pointer; }
  </style>
</head>
<body>
<header style="display: flex; justify-content: space-between; align-items: center; padding: 10px 40px; border-bottom: 1px solid #ccc;">
  <!-- 로고: 왼쪽 -->
  <img onclick="location.href='<%=request.getContextPath()%>/productList'"
       src="<%=request.getContextPath()%>/Frontend/images/logo_b.png"
       alt="로고" class="logo" style="width: 160px; height: auto; cursor: pointer;" />

  <!-- 메뉴: 오른쪽 -->
  <div class="menu_wrap" style="display: flex; gap: 25px; align-items: center;">
    <div class="menu" onclick="location.href='<%=request.getContextPath()%>/Frontend/addItem.jsp'" style="cursor:pointer; font-weight:bold;">ADD MENU</div>
    <div class="menu" onclick="location.href='<%=request.getContextPath()%>/Frontend/login.jsp'" style="cursor:pointer; font-weight:bold;">LOGIN</div>
    <div class="menu" onclick="location.href='<%=request.getContextPath()%>/qna'" style="cursor:pointer; font-weight:bold;">Q&A</div>
    <div class="menu" onclick="location.href='<%=request.getContextPath()%>/profile'" style="cursor:pointer; font-weight:bold;">MY PAGE</div>
    <div class="menu" onclick="location.href='<%=request.getContextPath()%>/cart'" style="cursor:pointer; font-weight:bold;">CART</div>
  </div>
</header>

<section class="section_1">
  <div class="title">CART</div>

  <% if (cartItems == null || cartItems.isEmpty()) { %>
    <p style="text-align:center;">장바구니에 상품이 없습니다.</p>
  <% } else { 
       for (CartItem item : cartItems) {
         int subtotal = item.getPrice() * item.getCount();
         total += subtotal;
  %>
    <div class="item_wrap">
      <img class="item_img" src="<%=item.getImageUrl()%>" alt="썸네일" />
      <div class="item_text"><%=item.getName()%></div>
      <div class="item_count"><%=item.getCount()%></div>
      <div class="item_price"><%=String.format("%,d원", subtotal)%></div>
    </div>
  <% } %>

  <div class="total">총 금액 : <%=String.format("%,d원", total)%></div>

  <form action="buy" method="post">
    <button class="buy_btn" type="submit">구매하기</button>
  </form>
  <% } %>
</section>
</body>
</html>
