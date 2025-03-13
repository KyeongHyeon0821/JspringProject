<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>guestList.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <style>
    th {
      text-align: center;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="text-center">방명록 리스트</h2>
  <table class="table table-borderless m-0 p-0">
  	<tr>
  	  <td><a href="guestInput" class="btn btn-success btn-sm">글쓰기</a></td>
  	  <td class="text-end"><a href="" class="btn btn-primary btn-sm">관리자</a></td>
  	</tr>
  </table>
  <c:forEach var="vo" items="${vos}" varStatus="st">
	  <table class="table table-borderless mt-3 mb-0 p-0">
			<tr>
			  <td>글번호 : ${vo.idx}</td>
			  <td class="text-end">방문IP : ${vo.hostIp}</td>
			</tr>
	  </table>
  	<table class="table table-bordered border-secondary">
  		<tr>
  		  <th class="bg-secondary-subtle">글쓴이</th><td>${vo.name}</td>
  		  <th class="bg-secondary-subtle">방문일자</th><td>${fn:substring(vo.visitDate,0,19)}</td>
  		</tr>
  		<tr>
  		  <th class="bg-secondary-subtle">메일주소</th>
  		  <td colspan="3">
  		    <c:if test="${empty vo.email || fn:length(vo.email)<6 || fn:indexOf(vo.email,'@')==-1 || fn:indexOf(vo.email,'.')==-1}">- 없음 -</c:if>
  		    <c:if test="${!empty vo.email && fn:length(vo.email)>=6 && fn:indexOf(vo.email,'@')!=-1 && fn:indexOf(vo.email,'.')!=-1}">${vo.email}</c:if>
  		  </td>
  		</tr>
  		<tr>
  		  <th class="bg-secondary-subtle">홈페이지</th>
  		  <td colspan="3">
					<c:if test="${empty vo.homePage || fn:length(vo.homePage)<10 || fn:indexOf(vo.homePage,'.')==-1}">- 없음 -</c:if>
					<c:if test="${!empty vo.homePage && fn:length(vo.homePage)>=10 && fn:indexOf(vo.homePage,'.')!=-1}"><a href="https://${vo.homePage}" target="_blank">${vo.homePage}</a></c:if>
  		  </td>
  		</tr>
  		<tr>
  		  <th class="bg-secondary-subtle">방문소감</th>
  		  <td colspan="3" style="height:150px;">${fn:replace(vo.content, newLine, "<br/>")}</td>
  		</tr>
  	</table>
  </c:forEach>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>