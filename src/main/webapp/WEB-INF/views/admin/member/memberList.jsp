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
		
		// 등급별 화면 출력 처리
		function levelItemCheck() {
			let level = $("#levelItem").val();
			location.href="memberList?level="+level;
		}
		
		// 회원 등급 변경 처리
		function levelChange(e) {
			//alert("e : " + e.value);
			let ans = confirm("선택한 회원의 등급을 변경하시겠습니까?");
			if(!ans) {
				location.reload();
				return false;
			}
			
			let items = e.value.split("/");
			let query = {
					level : items[0],
					idx : items[1]
			}
			$.ajax({
				url : "${ctp}/admin/memberLevelChange",
				type : "post",
				data : query,
				success:function(res) {
					if(res != "0") {
						alert("등급 수정 완료!");
						location.reload();
					}
					else alert("등급 수정 실패");
				},
				error : function() { alert("전송오류!");}
			});
		}
		
		// 회원 전체 체크/해제
		function allCheckCheckBoxes() {
			let isChecked = document.getElementById("allCheck").checked; // 전체를 대표하는 체크박스 체크 여부
			let checkboxes = document.getElementsByName("eachCheck");    // 각 회원별 체크 박스
			
			for(let i=0; i<checkboxes.length; i++) {
				checkboxes[i].checked = isChecked;												// 전체를 대표하는 체크박스가 체크되어있으면 전부 체크
			}																														// 그렇지 않으면 전부 체크 해제
		}
		
		// 체크된 회원 레벨 변경
		function CheckedMemberlevelChange() {
			let checkedBoxes = document.querySelectorAll('input[name="eachCheck"]:checked'); // 체크가 되어있는 체크박스들
			let checkedIdxes = []; // 체크 되어있는 체크박스의 각 value값(idx)을 담을 변수를 빈 배열로 선언
			
			if (checkedBoxes.length == 0) { // 체크되어있는 박스가 없을 경우
		        alert("회원을 선택해주세요.");
		        return false;
		    }
			
			
			checkedBoxes.forEach(function(checkbox) { // 체크가 되어있는 각 체크박스별 함수 실행
				checkedIdxes.push(checkbox.value);			// 체크 되어있는 체크박스의 value(idx)를 배열에 저장
		  });
			
		  let idxes = checkedIdxes.join(",");      // 배열을 String 타입으로 바꿔서 값 전달
			
			let level = document.getElementById("levels").value;  // 선택된 레벨
			
			let ans = confirm("선택한 회원들의 등급을 변경하시겠습니까?");
			if(!ans) {
				location.reload();
				return false;
			}
			
			let query = {
					level : level,
					idxes : idxes
			}
			$.ajax({
				url : "${ctp}/admin/checkedMemberLevelChange",
				type : "post",
				data : query,
				success:function(res) {
					if(res != "0") {
						alert("등급 수정 완료!");
						location.reload();
					}
					else alert("등급 수정 실패");
				},
				error : function() { alert("전송오류!");}
			});
			
			
		}
	</script>
	<style>
    a {text-decoration: none}
    a:hover {
      text-decoration: underline;
      color: orange;
    }
  </style>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2>전체 회원 리스트</h2>
  <div class="row mt-5">
  	<div class="col text-start">
  		체크된 회원 레벨 변경
  		<select name="levels" id="levels" onchange="CheckedMemberlevelChange()">
				<option value="">레벨선택</option>
				<option value="1">우수회원</option>
				<option value="2">정회원</option>
				<option value="3">준회원</option>
				<option value="0" >관리자</option>
				<option value="999">탈퇴신청회원</option>
			</select>
  	</div>
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
  			<th><input type="checkbox" id="allCheck" onclick="allCheckCheckBoxes()" name="allCheck"/></th>
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
  				<td><input type="checkbox" name="eachCheck" value="${vo.idx}"/></td>
  				<td>${vo.idx}</td>
  				<td><a href="${ctp}/admin/memberInfor/${vo.idx}" title="회원정보 상세보기">${vo.mid}</a></td>
  				<td>${vo.nickName}</td>
  				<td>${vo.name}</td>
  				<td>${fn:substring(vo.birthday,0,10)}</td>
  				<td>${vo.gender}</td>
  				<td>${fn:substring(vo.lastDate,0,10)}</td>
  				<td>${vo.todayCnt}</td>
  				<td>${vo.userDel}</td>
  				<td>
  					<select name="level" id="level" onchange="levelChange(this)">
  						<option value="1/${vo.idx}" ${vo.level == 1? 'selected' : '' }>우수회원</option>
  						<option value="2/${vo.idx}" ${vo.level == 2? 'selected' : '' }>정회원</option>
  						<option value="3/${vo.idx}" ${vo.level == 3? 'selected' : '' }>준회원</option>
  						<option value="0/${vo.idx}" ${vo.level == 0? 'selected' : '' }>관리자</option>
  						<option value="999/${vo.idx}" ${vo.level == 999? 'selected' : '' }>탈퇴신청회원</option>
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