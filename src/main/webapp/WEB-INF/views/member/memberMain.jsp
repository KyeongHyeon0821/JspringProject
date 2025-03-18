<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberMain.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br/></p>
<div class="container">
  <h2>이곳은 회원 메인방입니다.</h2>
  <p>현재 로그인한 회원 : ${sMid}(<font color="red">${strLevel}</font>)</p>
  <p>총 방문횟수 : ${vo.visitCnt}</p>
  <p>오늘 방문횟수 : ${vo.todayCnt}</p>
  <p>방명록에 올린 글 수 : ${guestPostCnt}</p>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>