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
  <title>wmContent.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
	<link rel="stylesheet" type="text/css" href="${ctp}/css/linkOrange.css">
</head>
<body>
<p><br/></p>
<div class="container">
  <table class="table table-bordered">
		<tr>
			<th>보내는사람</th>
			<td class="text-start">${vo.sendId}</td>
		</tr>
		<tr>
			<th>받는사람</th>
			<td class="text-start">${vo.receiveId}</td>
		</tr>
		<tr>
			<th>메세지 제목</th>
			<td class="text-start">${vo.title}</td>
		</tr>
		<tr>
			<th style="height:200px">메세지 내용</th>
			<td class="text-start">${fn:replace(vo.content, newLine, "<br/>")}</td>
		</tr>
		<tr>
			<td colspan="2">
				<c:if test="${mFlag == 1 || mFlag == 2}">
					<input type="button" value="답장쓰기" onclick="location.href='webMessage?mSw=0&receiveId=${vo.sendId}'" class="btn btn-primary me-2" />
				</c:if>
				<c:if test="${mFlag != 5 && mFlag != 3}">
					<input type="button" value="휴지통" onclick="location.href='webDeleteCheck?mSw=5&idx=${vo.idx}&mFlag=${mFlag}';" class="btn btn-warning me-2"/>
				</c:if>
				<c:if test="${mFlag == 3}">
					<input type="button" value="영구삭제" onclick="location.href='webDeleteCheck?mSw=1&mFlag=${param.mFlag}&idx=${vo.idx}';" class="btn btn-danger me-2"/>
				</c:if>
				<input type="button" value="돌아가기" onclick="location.href='webMessage?mSw=${param.mFlag}'" class="btn btn-warning" />
				
			</td>
		</tr>
	</table>
</div>
<p><br/></p>
</body>
</html>