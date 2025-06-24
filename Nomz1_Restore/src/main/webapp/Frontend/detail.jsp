<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Product" %>
<%
  request.setCharacterEncoding("UTF-8");
  Product product = (Product) request.getAttribute("product");

  String name = product.getName();
  int price = product.getPrice();
  String description = product.getDescription();
  String imageUrl = product.getImageUrl();
  int productId = product.getProductId();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Nomz Detail Page</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/Frontend/common/header.css" />
  <style>
    swiper-container { width: 500px; height: 500px; overflow: visible; }
    swiper-slide { background-position: center; background-size: cover; overflow: visible; }
    swiper-slide img { display: block; width: 100%; height: 100%; object-fit: cover; }
    .section_1 { width: 1200px; height: 100vh; margin: 0 auto; padding-top: 60px; display: flex; justify-content: space-between; align-items: center; }
    .item_img { width: 500px; height: 500px; object-fit: cover; border: 2px solid rgba(0, 0, 0, 0.5); }
    .text_wrap { width: 550px; height: 500px; }
    .item_text { font-size: 30px; margin-bottom: 5px; }
    .item_price { font-size: 20px; }
    .line { margin-top: 40px; }
    .item_desc { width: 100%; font-size: 14px; margin-top: 5px; }
    .item_wrap { bottom: 70px; display: flex; flex-direction: column; width: 100%; height: 120px; background-color: #dce5ed; margin-top: 120px; padding: 20px; }
    .price_wrap { display: flex; justify-content: space-between; align-items: center; }
    .count_wrap { width: 100px; height: 27px; border: 1px solid #0b1838; display: flex; justify-content: space-between; align-items: center; }
    .minus, .plus { width: 25px; height: 25px; font-size: 14px; text-align: center; line-height: 25px; cursor: pointer; }
    .item_count { width: 50px; height: 27px; text-align: center; font-size: 14px; line-height: 27px; }
    .total { width: 90px; text-align: right; font-size: 14px; }
    .btn_wrap { display: flex; justify-content: space-between; width: 100%; height: 50px; margin-top: 20px; }
    .cart_btn, .buy_btn { width: 270px; height: 100%; background-color: #0b1838; color: #fffdf9; font-size: 20px; text-align: center; line-height: 50px; cursor: pointer; border: none; }
  </style>
</head>
<body>
<header>
  <img onclick="location.href='<%=request.getContextPath()%>/productList'" src="<%=request.getContextPath()%>/Frontend/images/logo_b.png" alt="로고" class="logo" />
  <div class="menu_wrap">
    <div class="menu" onclick="location.href='Frontend/addItem.jsp'">ADD MENU</div>
     <div class="menu" onclick="location.href='Frontend/login.jsp'">LOGIN</div>
    <div class="menu" onclick="location.href='<%=request.getContextPath()%>/qna'">Q&A</div>
    <div class="menu" onclick="location.href='<%=request.getContextPath()%>/profile'">MY PAGE</div>
    <div class="menu" onclick="location.href='<%=request.getContextPath()%>/cart'">CART</div>
  </div>
</header>

<section class="section_1">
  <img class="item_img" src="<%=request.getContextPath()%>/<%= imageUrl %>" alt="<%= name %>">
  <div class="text_wrap">
    <div class="item_text"><%= name %></div>
    <div class="item_price"><%= price %>원</div>
    <div class="line"></div>
    <div class="item_desc"><%= description %></div>

    <form method="post" action="<%=request.getContextPath()%>/buy">
      <input type="hidden" name="productId" value="<%= productId %>">
      <input type="hidden" name="count" id="formCount" value="1">
      <input type="hidden" name="price" value="<%= price %>">

      <div class="item_wrap">
        <div class="item_text_2"><%= name %></div>
        <div class="price_wrap">
          <div class="count_wrap">
            <div class="minus">▼</div>
            <div class="item_count" id="countDisplay">1</div>
            <div class="plus">▲</div>
          </div>
          <div class="total" id="productTotal"><%= price %>원</div>
        </div>
      </div>

      <div class="btn_wrap">
        <button class="cart_btn" type="button" onclick="addToCart()">장바구니</button>
        <button class="buy_btn" type="submit">구매하기</button>
      </div>
    </form>
  </div>
</section>

<script>
  document.addEventListener("DOMContentLoaded", () => {
    const minusBtn = document.querySelector(".minus");
    const plusBtn = document.querySelector(".plus");
    const countDisplay = document.querySelector("#countDisplay");
    const productTotal = document.querySelector("#productTotal");
    const formCount = document.querySelector("#formCount");
    const unitPrice = <%= price %>;
    let count = 1;

    function updateDisplay() {
      countDisplay.textContent = count;
      productTotal.textContent = (unitPrice * count).toLocaleString() + "원";
      formCount.value = count;
    }

    plusBtn.addEventListener("click", () => {
      count++;
      updateDisplay();
    });

    minusBtn.addEventListener("click", () => {
      if (count > 1) {
        count--;
        updateDisplay();
      }
    });

    updateDisplay();
  });

  function addToCart() {
    const count = parseInt(document.getElementById("formCount").value);
    const item = {
      name: "<%= name %>",
      price: <%= price %>,
      count: count,
      imageUrl: "<%=request.getContextPath()%>/<%= imageUrl %>"
    };
    const cart = JSON.parse(localStorage.getItem("cart") || "[]");
    const existing = cart.find(c => c.name === item.name);
    if (existing) {
      existing.count += item.count;
    } else {
      cart.push(item);
    }
    localStorage.setItem("cart", JSON.stringify(cart));
    alert("장바구니에 추가되었습니다.");
  }
</script>
</body>
</html>
