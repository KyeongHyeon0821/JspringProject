<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>adminLeft.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
</head>
<body style="background-color:#eee">
<p><br/></p>
<div class="text-center">
  <h5><a href="${ctp}/admin/adminContent" target="adminContent">관리자메뉴</a></h5>
  <hr/>
  <p><a href="${ctp}/" target="_top">홈으로</a></p>
  <hr/>
  <div>
  	<button class="accordion"><b>게시글관리</b></button>
  	<div class="panel">
  		<p><a href="${ctp}/guest/guestList" target="adminContent">방명록리스트</a></p>
  		<p><a href="">게시판리스트</a></p>
  	</div>
  </div>
  <hr/>
  <div>
  	<button class="accordion"><b>회원관리</b></button>
  	<div class="panel">
  		<p><a href="${ctp}/admin/member/memberList" target="adminContent">회원리스트</a></p>
  		<p><a href="">신고리스트</a></p>
  	</div>
  </div>
  <hr/>
</div>
<p><br/></p>
</body>
</html>