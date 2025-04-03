<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>wmList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
	<link rel="stylesheet" type="text/css" href="${ctp}/css/linkOrange.css">
	<script>
		'use strict';
		
		setTimeout("location.reload()", 1000*10);
	</script> 
</head>
<body>
<p><br/></p>
<div class="container">
	<!-- 1:받은메세지 2:새메세지 3:보낸메세지 4:수신확인 5:휴지통 -->
  <table class="table table-hover">
  	<tr class="table-secondary">
  		<th>번호</th>
  		<th>
  			<c:if test="${mSw==1 || mSw==2 || mSw==5}">보낸사람</c:if>
  			<c:if test="${mSw==3 || mSw==4}">받은사람</c:if>
  		</th>
  		<th>제목</th>
  		<th>
  			<c:if test="${mSw==1 || mSw==2 || mSw==5}">(보낸/확인)날짜</c:if>
  			<c:if test="${mSw==3 || mSw==4}">받은날짜</c:if>
  		</th>
  	</tr>
  	<c:set var="curScrStartNo" value="${pageVo.curScrStartNo}" />
  	<c:forEach var="vo" items="${vos}" varStatus="st">
  		<tr>
  			<td>${curScrStartNo}</td>
  			<%-- <td>${st.count}</td> --%>
  		<td>
  			<c:if test="${mSw==1 || mSw==2 || mSw==5}">${vo.sendId}</c:if>
  			<c:if test="${mSw==3 || mSw==4}">${vo.receiveId}</c:if>
  		</td>
  		<td class="text-start">
  			<c:if test="${mSw != 4 && mSw != 5}"><a href="webMessage?mSw=6&mFlag=${param.mSw}&idx=${vo.idx}">${vo.title}</a></c:if>
  			<c:if test="${mSw == 4 || mSw == 5}">${vo.title}</c:if>
  			<c:if test="${vo.receiveSw == 'n' && mSw != 4 && mSw != 5 && mSw != 3}"><img src="${ctp}/images/new.gif" width="30px" /></c:if>
  		</td>
  		<td>
  			<c:if test="${mSw==1 || mSw==2 || mSw==5}">${fn:substring(vo.sendDate, 0, 19)}</c:if>
  			<c:if test="${mSw==3 || mSw==4}">${fn:substring(vo.receiveDate, 0, 19)}</c:if>
  		</td>
  		<c:set var="curScrStartNo" value="${curScrStartNo -1}" />
  	</c:forEach>
  </table>
  
  <!-- 블록페이지 시작(1블록의 크기를 3개(3Page)로 한다. -->
	<div class="text-center">
	  <ul class="pagination justify-content-center">
	    <c:if test="${pageVo.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="webMessage?mSw=${mSw}&mFlag=${mFlag}&pag=1&pageSize=${pageVo.pageSize}">첫페이지</a></li></c:if>
	  	<c:if test="${pageVo.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="webMessage?mSw=${mSw}&mFlag=${mFlag}&pag=${(pageVo.curBlock-1)*pageVo.blockSize+1}&pageSize=${pageVo.pageSize}">이전블록</a></li></c:if>
  		<c:forEach var="i" begin="${(pageVo.curBlock*pageVo.blockSize)+1}" end="${(pageVo.curBlock*pageVo.blockSize)+pageVo.blockSize}" varStatus="st">
		    <c:if test="${i <= pageVo.totPage && i == pageVo.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="webMessage?mSw=${mSw}&mFlag=${mFlag}&pag=${i}&pageSize=${pageVo.pageSize}">${i}</a></li></c:if>
		    <c:if test="${i <= pageVo.totPage && i != pageVo.pag}"><li class="page-item"><a class="page-link text-secondary" href="webMessage?mSw=${mSw}&mFlag=${mFlag}&pag=${i}&pageSize=${pageVo.pageSize}">${i}</a></li></c:if>
	  	</c:forEach>
	  	<c:if test="${pageVo.curBlock < pageVo.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="webMessage?mSw=${mSw}&mFlag=${mFlag}&pag=${(pageVo.curBlock+1)*pageVo.blockSize+1}&pageSize=${pageVo.pageSize}">다음블록</a></li></c:if>
	  	<c:if test="${pageVo.pag < pageVo.totPage}"><li class="page-item"><a class="page-link text-secondary" href="webMessage?mSw=${mSw}&mFlag=${mFlag}&pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}">마지막페이지</a></li></c:if>
	  </ul>
	</div>
	<!-- 블록페이지 끝 -->
</div>
<p><br/></p>
</body>
</html>