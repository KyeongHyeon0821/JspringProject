<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>adminContent.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2>관리자 대시보드</h2>
  <br>
  <p>신규 가입 회원의 수 : ${newMemberCnt}</p>
  <p>새로 작성한 방명록 글 : </p>
  <p>새로 작성한 게시글 수 : </p>
</div>
<p><br/></p>
</body>
</html>