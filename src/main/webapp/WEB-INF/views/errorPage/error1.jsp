<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page errorPage="/WEB-INF/views/errorPage/errorMessage1.jsp" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>error1.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br/></p>
<div class="container">
  <h2>에러를 발생시켜주는 JSP 페이지</h2>
<%
	// int su = 10 / 10; // 정상처리
	int su = 10 / 0; // 에러처리 페이지로 보내야한다.
%>  
  <div>결과 : <%=su %></div>
  <hr class="border-secondary" />
  <div>
  	<a href="errorMain" class="btn btn-success">돌아가기</a>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>