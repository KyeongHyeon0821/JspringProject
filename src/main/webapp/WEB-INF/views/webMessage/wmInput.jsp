<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>wmInput.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
	<link rel="stylesheet" type="text/css" href="${ctp}/css/linkOrange.css"> 
	<script>
		'use strict';
		
		function fCheck() {
			let receiveId = myform.receiveId.value;
			let title = myform.title.value;
			let content = myform.content.value;
			
			if(receiveId.trim() == "") {
				alert("받는 사람 아이디를 입력하세요");
				myform.receiveId.focus();
				return false;
			}
			else if(title.trim() == "") {
				alert("제목을 입력하세요");
				myform.title.focus();
				return false;
			}
			else if(content.trim() == "") {
				alert("내용을 입력하세요");
				myform.content.focus();
				return false;
			}
			else myform.submit();
		}
		
		function inputMid(mid) {
			myform.receiveId.value = mid; // 회원 아이디를 클릭하면 받는 사람 자동 입력
			document.querySelector('.btn-close').click(); // 모달 창 닫게하기
			myform.receiveId.readOnly = true; // 자동 입력된 아이디 변경 못하게 처리
		}
	</script>
</head>
<body>
<p><br/></p>
<div class="container">
	<form name="myform" method="post" action="wmInputOk">
		<table class="table table-bordered">
			<tr>
				<th>보내는사람</th>
				<td><input type="text" name="sendId" value="${sMid}" readonly class="form-control" /></td>
			</tr>
			<tr>
				<th>받는사람</th>
				<td>
					<div class="input-group">
						<input type="text" name="receiveId" value="" class="form-control" />
						<input type="button" value="주소록" data-bs-toggle="modal" data-bs-target="#myModal" class="btn btn-success" />
					</div>
				</td>
			</tr>
			<tr>
				<th>메세지 제목</th>
				<td>
					<div class="input-group">
						<input type="text" name="title" placeholder="제목을 입력하세요" class="form-control" />
					</div>
				</td>
			</tr>
			<tr>
				<th>메세지 내용</th>
				<td>
					<div class="input-group">
						<textarea name="content" placeholder="내용을 입력하세요" class="form-control"></textarea>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" value="메세지 전송" onclick="fCheck()" class="btn btn-primary me-2" />
					<input type="reset" value="다시쓰기" class="btn btn-info me-2" />
					<input type="button" value="돌아가기" onclick="location.href='webMessage?mSw=1'" class="btn btn-warning" />
				</td>
			</tr>
		</table>
	</form>
	
	<!-- The Modal -->
	<div class="modal fade" id="myModal">
	  <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title" style="text-align: center;">회원 아이디 리스트</h4>
	        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
	      </div>
	      <div class="modal-body">
	      	<c:forEach var="vo" items="${mVos}" varStatus="st">
	      		<a href="javascript:inputMid('${vo.mid}')">${vo.mid}</a><br>
	      	</c:forEach>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
</div>
<p><br/></p>
</body>
</html>