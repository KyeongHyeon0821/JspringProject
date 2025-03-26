<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<% pageContext.setAttribute("newLine", "\n"); %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>boardInfor.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2 class="text-center">글 내용 보기</h2>
  <table class="table table-bordered text-center border-secondary-subtle">
  	<tr>
  		<th class="table-secondary">글쓴이</th>
  		<td>${vo.nickName}</td>
  		<th class="table-secondary">글쓴날짜</th>
  		<td>${fn:substring(vo.WDate, 0, 19)}</td>
  	</tr>
  	<tr>
  		<th class="table-secondary">글조회수</th>
  		<td>${vo.readNum}</td>
  		<th class="table-secondary">접속IP</th>
  		<td>${vo.hostIp}</td>
  	</tr>
  	<tr>
  		<th class="table-secondary">글제목</th>
  		<td colspan="3" class="text-start">${vo.title}&nbsp;
  			<a href="javascript:goodCheck1()" title="좋아요">❤</a>${vo.good}
  			<a href="javascript:goodCheck2(1)" title="좋아요">👍</a>
  			<a href="javascript:goodCheck2(-1)" title="싫어요">👎</a>
  		</td>
  	</tr>
  	<tr>
  		<th class="table-secondary">글내용</th>
  		<td colspan="3" style="height:250px" class="text-start">${fn:replace(vo.content, newLine, "<br>")}</td>
  	</tr>
  </table>
  <div><input type="button" value="돌아가기" onclick="location.href='${ctp}/admin/complaint/complaintList'" class="btn btn-warning" /></div>
</div>

<p><br/></p>
</body>
</html>