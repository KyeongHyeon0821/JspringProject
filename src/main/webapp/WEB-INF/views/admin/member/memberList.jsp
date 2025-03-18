<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
	<script>
		'use strict';
		function levelItemCheck() {
			let level = $("#levelItem").val();
			location.href="memberList?level="+level;
		}
	</script>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2>전체 회원 리스트</h2>
  <div class="row">
  	<div class="col text-end mb-2">
  		<select name="levelItem" id="levelItem" onchange="levelItemCheck()">
  			<option value="99" ${level == 99 ? 'selected' : ''}>전체보기</option>
  			<option value="1" ${level == 1 ? 'selected' : ''}>우수회원</option>
  			<option value="2" ${level == 2 ? 'selected' : ''}>정회원</option>
  			<option value="3" ${level == 3 ? 'selected' : ''}>준회원</option>
  			<option value="999" ${level == 999 ? 'selected' : ''}>탈퇴신청회원</option>
  			<option value="0" ${level == 0 ? 'selected' : ''}>관리자</option>
  		</select>
  	</div>
  </div>
  <form name="myform">
  	<table class="table table-hover text-center border-secondary-subtle">
  		<tr class="table-secondary">
  			<th>번호</th>
  			<th>아이디</th>
  			<th>닉네임</th>
  			<th>성명</th>
  			<th>생일</th>
  			<th>성별</th>
  			<th>최종방문일</th>
  			<th>오늘방문횟수</th>
  			<th>활동여부</th>
  			<th>현재레벨</th>
  		</tr>
  		<c:forEach var="vo" items="${vos}" varStatus="st">
  			<tr>
  				<td>${vo.idx}</td>
  				<td>${vo.mid}</td>
  				<td>${vo.nickName}</td>
  				<td>${vo.name}</td>
  				<td>${fn:substring(vo.birthday,0,10)}</td>
  				<td>${vo.gender}</td>
  				<td>${fn:substring(vo.lastDate,0,10)}</td>
  				<td>${vo.todayCnt}</td>
  				<td>${vo.userDel}</td>
  				<td>
  					<%-- ${vo.level} --%>
  					<select name="level" id="level" onchange="levelChange(this)">
  						<option value="1" ${vo.level == 1? 'selected' : '' }>우수회원</option>
  						<option value="2" ${vo.level == 2? 'selected' : '' }>정회원</option>
  						<option value="3" ${vo.level == 3? 'selected' : '' }>준회원</option>
  						<option value="0" ${vo.level == 0? 'selected' : '' }>관리자</option>
  						<option value="999" ${vo.level == 999? 'selected' : '' }>탈퇴신청회원</option>
  					</select>
  					
  					</td>
  			
  			</tr>
  		</c:forEach>
  	</table>
  </form>
  
</div>
<p><br/></p>
</body>
</html>