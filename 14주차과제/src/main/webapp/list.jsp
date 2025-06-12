<%@page import="cs.dit.member.MemberDTO"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>사용자 목록</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
</head>
<body>
<div class="container"><br>	
	<h1 class="text-center font-weight-bold">사용자 정보</h1>
	<br>

	<!-- 디버깅용 -->
	<p>dtos: ${dtos}</p>

	<table class="table table-hover">
	  <thead>
	    <tr>
	      <th>아이디</th>
	      <th>이름</th>
	      <th>비밀번호</th>
	      <th>사진</th>
	      <th>수정</th>
	    </tr>
	  </thead>
	  <tbody>
	    <c:forEach var="dto" items="${dtos}">
	      <tr>
	        <td>${dto.id}</td>
	        <td>${dto.name}</td>
	        <td>${dto.pwd}</td>
	        <td>
	          <a download href="/photos/${dto.photo}">
	            <img src="/photos/${dto.photo}" width="100" height="80"/>
	          </a>
	        </td>
	        <td>
	          <a href="${pageContext.request.contextPath}/member/updateForm?id=${dto.id}" class="btn btn-sm btn-outline-primary">수정</a>
	          <a href="${pageContext.request.contextPath}/member/delete?id=${dto.id}" class="btn btn-sm btn-outline-danger" onclick="return confirm('정말 삭제할까요?')">삭제</a>
	        </td>
	      </tr>
	    </c:forEach>
	  </tbody>
	</table>
</div>
</body>
</html>
