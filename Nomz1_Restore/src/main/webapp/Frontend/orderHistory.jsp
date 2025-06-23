<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>Order History</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/Frontend/common/header.css" />
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f5f5f5;
    }

    .section_1 {
      max-width: 900px;
      margin: 100px auto 50px;
      padding: 20px;
      background-color: #fff;
      border-radius: 12px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    .title {
      font-size: 28px;
      font-weight: bold;
      text-align: center;
      margin-bottom: 40px;
    }
    .item_wrap {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 20px;
      border-bottom: 1px solid #ddd;
    }
    .item_img {
      width: 100px;
      height: 100px;
      object-fit: cover;
      border-radius: 8px;
    }
    .item_info {
      flex-grow: 1;
      margin-left: 20px;
    }
    .item_text {
      font-size: 18px;
      font-weight: 500;
    }
    .item_count, .item_price {
      font-size: 14px;
      color: #555;
      margin-top: 4px;
    }
    .item_day {
      font-size: 14px;
      color: #999;
      text-align: right;
    }
    .empty-message {
      font-size: 20px;
      text-align: center;
      color: #777;
      padding: 50px 0;
    }
  </style>
</head>
<body>

<header>
  <img onclick="location.href='${pageContext.request.contextPath}/productList'"
       src="${pageContext.request.contextPath}/Frontend/images/logo_b.png"
       alt="로고" class="logo" />
  <div class="menu_wrap">
    <div class="menu" onclick="location.href='${pageContext.request.contextPath}/Frontend/addItem.jsp'">ADD MENU</div>
    <div class="menu" onclick="location.href='${pageContext.request.contextPath}/Frontend/login.jsp'">LOGIN</div>
    <div class="menu" onclick="location.href='${pageContext.request.contextPath}/qna'">Q&A</div>
    <div class="menu" onclick="location.href='${pageContext.request.contextPath}/profile'">MY PAGE</div>
    <div class="menu" onclick="location.href='${pageContext.request.contextPath}/Frontend/cart.jsp'">CART</div>
  </div>
</header>


<section class="section_1">
  <div class="title">ORDER HISTORY</div>

  <div id="orderList">
    <c:choose>
      <c:when test="${empty orders}">
        <div class="empty-message">주문 내역이 없습니다.</div>
      </c:when>
      <c:otherwise>
        <c:forEach var="order" items="${orders}">
          <div class="item_wrap">
            <img class="item_img"
                 src="${pageContext.request.contextPath}/uploads/${fn:substringAfter(order.thumbnail, 'uploads/')}"
                 alt="${order.productName}" />

            <div class="item_info">
              <div class="item_text">${order.productName}</div>
              <div class="item_count">수량: ${order.quantity}개</div>
              <div class="item_price">총 가격: 
                <fmt:formatNumber value="${order.quantity * order.price}" type="number"/>원
              </div>
            </div>

            <div class="item_day">${order.orderTime}</div>
          </div>
        </c:forEach>
      </c:otherwise>
    </c:choose>
  </div>
</section>

</body>
</html>
