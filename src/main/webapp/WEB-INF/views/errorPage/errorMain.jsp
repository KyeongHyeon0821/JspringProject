<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>errorMain.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br/></p>
<div class="container">
  <h2>에러 발생에 대한 대처 연습</h2>
  <hr class="border-secondary" />
  <h6>JSP 에러</h6>
  <div>
  	<a href="error1" class="btn btn-success">JSP 파일에서의 오류페이지 호출</a> &nbsp;
  	<a href="errorMessage1" class="btn btn-primary">오류발생시 호출할 메세지페이지</a>
  </div>
  <hr class="border-secondary" />
  <h6>Servlet 에러(web.xml에서 처리)</h6>
  <div>
  	<a href="error400?error=100" class="btn btn-info">400오류</a> &nbsp;
  	<a href="0000" class="btn btn-success">404오류</a> &nbsp;
  	<a href="${ctp}/errorPage/error405" class="btn btn-primary">405오류</a> &nbsp;
  </div>
  <hr class="border-secondary" />
  <h6>Servlet 에러(500에러 발생예제)</h6>
  <div>
  	<a href="${ctp}/errorPage/errorNullPointer" class="btn btn-info">500(NullPointerException)</a> &nbsp;
  	<a href="0000" class="btn btn-success">404오류</a> &nbsp;
  	<a href="${ctp}/errorPage/error405" class="btn btn-primary">405오류</a> &nbsp;
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>