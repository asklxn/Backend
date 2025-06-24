<%@ page contentType="text/html; charset=UTF-8" %>
<%
  String context = request.getContextPath();
%>
<header>
  <img onclick="location.href='<%=context%>/productList'" 
       src="<%=context%>/Frontend/images/logo_b.png" 
       alt="로고" class="logo" />
  <div class="menu_wrap">
    <div class="menu" onclick="location.href='<%=context%>/Frontend/addItem.jsp'">ADD MENU</div>
    <div class="menu" onclick="location.href='<%=context%>/Frontend/login.jsp'">LOGIN</div>
    <div class="menu" onclick="location.href='<%=context%>/qna'">Q&A</div>
    <div class="menu" onclick="location.href='<%=context%>/profile'">MY PAGE</div>
    <div class="menu" onclick="location.href='<%=context%>/cart'">CART</div>
  </div>
</header>
