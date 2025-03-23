<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberInfor.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2>회원 개인정보 상세보기</h2>
  <table class="table table-bordered">
  	<tr>
  		<th>회원 고유번호</th>
  		<td>${vo.idx}</td>
  	</tr>
  	<tr>
  		<th>회원 아이디</th>
  		<td>${vo.mid}</td>
  	</tr>
  	<tr>
  		<th>회원 비밀번호</th>
  		<td>${vo.pwd}</td>
  	</tr>
  	<tr>
  		<th>회원 별명</th>
  		<td>${vo.nickName}</td>
  	</tr>
  	<tr>
  		<th>회원 성명</th>
  		<td>${vo.name}</td>
  	</tr>
  	<tr>
  		<th>회원 성별</th>
  		<td>${vo.gender}</td>
  	</tr>
  	<tr>
  		<th>회원 생일</th>
  		<td>${vo.birthday}</td>
  	</tr>
  	<tr>
  		<th>회원 성별</th>
  		<td>${vo.gender}</td>
  	</tr>
  	<tr>
  		<th>전화번호</th>
  		<td>${vo.tel}</td>
  	</tr>
  	<tr>
  		<th>회원 주소</th>
  		<td>${vo.address}</td>
  	</tr>
  	<tr>
  		<th>회원 이메일</th>
  		<td>${vo.email}</td>
  	</tr>
  	<tr>
  		<th>직업</th>
  		<td>${vo.job}</td>
  	</tr>
  	<tr>
  		<th>취미</th>
  		<td>${vo.hobby}</td>
  	</tr>
  	<tr>
  		<th>회원 정보 공개여부</th>
  		<td>${vo.userInfor}</td>
  	</tr>
  	<tr>
  		<th>회원 탈퇴 신청여부</th>
  		<td>${vo.userDel}</td>
  	</tr>
  	<tr>
  		<th>회원 누적 포인트</th>
  		<td>${vo.point}</td>
  	</tr>
  	<tr>
  		<th>회원등급</th>
  		<td>${vo.level}</td>
  	</tr>
  	<tr>
  		<th>총 방문수</th>
  		<td>${vo.visitCnt}</td>
  	</tr>
  	<tr>
  		<th>오늘 방문한 횟수</th>
  		<td>${vo.todayCnt}</td>
  	</tr>
  	<tr>
  		<th>최초 가입일</th>
  		<td>${vo.startDate}</td>
  	</tr>
  	<tr>
  		<th>마지막 접속일</th>
  		<td>${vo.lastDate}</td>
  	</tr>
  	<tr>
  		<th>회원 소개</th>
  		<td>${vo.content}</td>
  	</tr>
  	<tr>
  		<th>회원 사진</th>
  		<td><img src="${ctp}/member/${vo.photo}" width="150px"/></td>
  	</tr>
  </table>
  <div class="text-center"><a href="${ctp}/admin/member/memberList" class="btn btn-warning">돌아가기</a></div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>