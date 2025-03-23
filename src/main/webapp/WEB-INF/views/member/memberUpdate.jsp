<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberUpdate.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
	<script>
    'use strict';
  	
    let nickCheckSw = 0;
    
    
  	// 정규식정의...(닉네임(한글/영문,숫자,밑줄),성명(한글/영문),이메일,전화번화({2,3}/{3,4}/{4}))
  	let regNickName = /^[a-zA-Z0-9_가-힣]{2,20}$/;  // 한글, 영문, 숫자, 밑줄, 2~20자
  	let regName = /^[가-힣]{2,10}$/; // 한글 2~10자
  	let regEmail = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/; // 일반적인 이메일 형식
  	let regTel = /\d{2,3}-\d{3,4}-\d{4}$/;
  	let regPwd = /^[A-Za-z\d!@#$%]{8,20}$/; // 영문, 숫자, 특수문자(!@#$%)만 가능한 8~20자
  	
    // 회원가입에 필요한 정보 체크(정규식)
    function fCheck() {
    	// 필수 항목 먼저 체크하기
    	let nickName = myform.nickName.value.trim();
    	let name = myform.name.value.trim();
    	
    	let email1 = myform.email1.value.trim();
    	let email2 = myform.email2.value.trim();
    	let email = email1 + "@" + email2;
    	
    	let tel1 = myform.tel1.value.trim();
    	let tel2 = myform.tel2.value.trim();
    	let tel3 = myform.tel3.value.trim();
    	let tel = tel1 + "-" + tel2 + "-" + tel3;
    	
    	let postcode = myform.postcode.value + " ";
    	let roadAddress = myform.roadAddress.value + " ";
    	let detailAddress = myform.detailAddress.value + " ";
    	let extraAddress = myform.extraAddress.value + " ";
    	let address = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress;
    	
    	let submitFlag = 0;
    	
    	if(!regNickName.test(nickName)) {
    		alert("닉네임은 2~20자리의 한글, 영문, 숫자, 밑줄(_)만 가능합니다.");
    		myform.nickName.focus();
    		return false;
    	}
    	else if(!regName.test(name)) {
    		alert("성명은 2~10자리의 한글만 가능합니다.");
    		myform.name.focus();
    		return false;
    	}
    	else if(!regEmail.test(email)) {
    		alert("이메일 형식이 옳바르지 않습니다. 다시 입력해 주세요.");
    		myform.email2.focus();
    		return false;
    	}
    	else {
    		submitFlag = 1;
    	}
    	
    	// 앞의 개별 필수 항목 체크 완료후, 선택사항 입력시 체크처리
    	if(tel2 != "" && tel3 != "") {
    		if(!regTel.test(tel)) {
    			alert("전화번호형식을 확인하세요.(000-0000-0000)");
    			myform.tel2.focus();
    			return false;
    		}
    		else {
    			submitFlag = 1;
    		}
    	}
    	else {
    		tel2 = " ";
    		tel3 = " ";
    		tel = tel1 + "-" + tel2 + "-" + tel3;
    		submitFlag = 1;
    	}
    	
    	// 사진(jpg/gif/png)에 대한 체크, 용량은 2MByte 이내 - 사진은 공백이 아닐경우 체크해준다.
    	let fName = document.getElementById("file").value;
    	if(fName.trim() != "") {
	    	let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
	    	let maxSize = 1024 * 1024 * 2;	// 한번에 업로드할 파일의 최대용량을 2MByte로 한정
	    	let fileSize = document.getElementById("file").files[0].size;
	    	
	    	if(fileSize > maxSize) {
	    		alert("업로드할 파일의 최대용량은 2MByte입니다.");
	    		return false;
	    	}
	    	else if(ext != "jpg" && ext != "gif" && ext != "png") {
	    		alert("업로드 가능파일은 'jpg/gif/png' 입니다.");
	    		return false;
	    	}
	    	submitFlag = 1;
    	}
    	
    	// 앞에서 모든 항목에 대한 유효성검사를 마치면 중복체크(아이디/닉네임)부분 버튼을 눌렀는지 확인처리
    	if(submitFlag == 1) {
    		if(nickCheckSw == 0){
    			alert("닉네임 중복체크 버튼을 눌러주세요");
						document.getElementById("nickNameBtn").focus();    	
    		// 모든 체크가 완료되었을때 email/te/address를 채워준 후 서버로 전송처리한다.
    		}
    		else {
    			myform.email.value = email;
	    		myform.tel.value = tel;
	    		myform.address.value = address;
	    		
	    		myform.submit();
    		}
    	}
    	else {
    		alert("회원폼의 내용을 확인하세요");
    	}
    	
    }
    
    
     // 닉네임 중복검사
    function nickCheck() {
    	let nickName = myform.nickName.value;
    	
    	if(nickName.trim() == "") {
    		alert("닉네임을 입력하세요");
    		myform.nickName.focus();
    	}
    	else if(!regNickName.test(nickName)) {
    		alert("닉네임은 2~20자리의 한글, 영문, 숫자, 밑줄(_)만 가능합니다.");
    		myform.nickName.focus();
    		return false;
    	}
    	else if(nickName == '${sNickName}') {
    		alert("현재 닉네임을 그대로 사용합니다.");
    		nickCheckSw = 1;
				myform.nickNameBtn.disabled = true;
				myform.nickName.readOnly = true;
				return false;
    	}
    	else {
    		$.ajax({
    			url  : "${ctp}/member/memberNickChcek",
    			type : "get",
    			data : {nickName : nickName},
    			success:function(res) {
    				if(res != '0') {
    					alert("이미 사용중인 닉네임 입니다. 다시 입력하세요");
    					myform.nickName.focus();
    				}
    				else {
    					alert("사용 가능한 닉네임 입니다.");
    					nickCheckSw = 1;
    					myform.nickNameBtn.disabled = true;
    					myform.nickName.readOnly = true;
    				}
    			},
    			error : function() { alert("전송오류!"); }
    		});
    	}
    } 
    
 		// 추가 선택항목 보이기/가리기
    $(function(){
      $("#viewBtn").change(function(){
        if($("#viewBtn").is(":checked")) $("#addContent").show();
        else $("#addContent").hide();
      });
    });
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <h3 class="text-center">회원 정보 수정</h3>
	<form name="myform" method="post" enctype="multipart/form-data">
  	<table class="table table-bordered text-center border-secondary-subtle">
      <tr>
        <th class="bg-secondary-subtle">아이디</th>
        <td>
          <div class="input-group">
	          <input type="text" name="mid" id="mid" value="${sMid}" class="form-control" readonly />
          </div>
        </td>
      </tr>
      <tr>
        <th class="bg-secondary-subtle">닉네임</th>
        <td>
          <div class="input-group">
	          <input type="text" name="nickName" id="nickName" value="${sNickName}" required class="form-control" />
	          <input type="button" value="닉네임중복체크" id="nickNameBtn" onclick="nickCheck()" class="btn btn-secondary btn-sm"/>
          </div>
        </td>
      </tr>
      <tr>
        <th class="bg-secondary-subtle">성명</th>
        <td><input type="text" name="name" id="name" value="${vo.name}" required class="form-control" /></td>
      </tr>
      <tr>
        <th class="bg-secondary-subtle">성별</th>
        <td>
        	<input type="radio" name="gender" id="gender1" value="남자" ${vo.gender=='남자' ? 'checked' : ''} />남자 &nbsp;
        	<input type="radio" name="gender" id="gender2" value="여자" ${vo.gender=='여자' ? 'checked' : ''} />여자
        </td>
      </tr>
      <tr>
        <th class="bg-secondary-subtle">이메일</th>
        <td>
          <div class="input-group">
            <c:set var="email" value="${fn:split(vo.email, '@')}"/>
	          <input type="text" name="email1" id="email1" value="${email[0]}" class="form-control" required />@
	          <select name="email2" id="email2" class="form-select">
	          	<option ${email[1]=='naver.com'   ? 'selected' : ''}>naver.com</option>
	          	<option ${email[1]=='hanmail.net' ? 'selected' : ''}>hanmail.net</option>
	          	<option ${email[1]=='gmail.com'   ? 'selected' : ''}>gmail.com</option>
	          	<option ${email[1]=='daum.net'    ? 'selected' : ''}>daum.net</option>
	          	<option ${email[1]=='yahoo.com'   ? 'selected' : ''}>yahoo.com</option>
	          	<option ${email[1]=='hatmail.com' ? 'selected' : ''}>hatmail.com</option>
	          	<option ${email[1]=='nate.com'    ? 'selected' : ''}>nate.com</option>
	          </select>
          </div>
        </td>
      </tr>
    </table>
    
    <!-- 선택입력사항 -->
    <div class="mb-2" id="viewCheckBtn" onclick="viewBtnCheck()"><input type="checkbox" name="viewBtn" id="viewBtn" checked />선택입력항목 보이기/가리기</div>
    <div id="addContent">
	    <table class="table table-bordered text-center border-secondary-subtle">
	      <tr>
	        <th class="bg-secondary-subtle">생일</th>
	        <td><input type="date" name="birthday" id="birthday" value="${fn:substring(vo.birthday, 0, 10)}" class="form-control" /></td>
	      </tr>
	      <tr>
	        <th class="bg-secondary-subtle">전화번호</th>
	        <td>
	          <div class="input-group">
	            <c:set var="tel" value="${fn:split(vo.tel, '-')}"/>
		          <select name="tel1" class="form-select">
		            <option value="010" ${tel[0]=='010' ? 'selected' : ''}>010</option>
		            <option value="02"  ${tel[0]=='02'  ? 'selected' : ''}>서울</option>
		            <option value="031" ${tel[0]=='031' ? 'selected' : ''}>경기</option>
		            <option value="032" ${tel[0]=='032' ? 'selected' : ''}>인천</option>
		            <option value="041" ${tel[0]=='041' ? 'selected' : ''}>충남</option>
		            <option value="042" ${tel[0]=='042' ? 'selected' : ''}>대전</option>
		            <option value="043" ${tel[0]=='043' ? 'selected' : ''}>충북</option>
		            <option value="051" ${tel[0]=='051' ? 'selected' : ''}>부산</option>
		            <option value="052" ${tel[0]=='052' ? 'selected' : ''}>울산</option>
		            <option value="051" ${tel[0]=='051' ? 'selected' : ''}>부산</option>
		            <option value="054" ${tel[0]=='054' ? 'selected' : ''}>경북</option>
		            <option value="055" ${tel[0]=='055' ? 'selected' : ''}>경남</option>
		            <option value="061" ${tel[0]=='061' ? 'selected' : ''}>전남</option>
		            <option value="062" ${tel[0]=='062' ? 'selected' : ''}>광주</option>
		            <option value="063" ${tel[0]=='063' ? 'selected' : ''}>전북</option>
		            <option value="064" ${tel[0]=='064' ? 'selected' : ''}>제주</option>
		          </select>-
		          <input type="text" name="tel2" id="tel2" value="${fn:trim(tel[1])}" class="form-control" />-
		          <input type="text" name="tel3" id="tel3" value="${fn:trim(tel[2])}" class="form-control" />
	          </div>
	        </td>
	      </tr>
	      <tr>
	        <th class="bg-secondary-subtle">주소</th>
	        <td>
	          <div class="form-group">
		          <div class="input-group">
		            <c:set var="address" value="${fn:split(vo.address, '/')}"/>
			          <input type="text" name="postcode" id="sample6_postcode" value="${fn:trim(address[0])}" class="form-control">
								<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-info">
							</div>
							<input type="text" name="roadAddress" id="sample6_address" value="${fn:trim(address[1])}" class="form-control">
							<div class="input-group">
								<input type="text" name="detailAddress" id="sample6_detailAddress" value="${fn:trim(address[2])}" class="form-control">
								<input type="text" name="extraAddress" id="sample6_extraAddress" value="${fn:trim(address[3])}" class="form-control">
							</div>
						</div>
	        </td>
	      </tr>
	      <tr>
	        <th class="bg-secondary-subtle">직업</th>
	        <td>
	          <select name="job" class="form-control">
	            <option ${vo.job=='학생'  ? 'selected' : ''}>학생</option>
	            <option ${vo.job=='회사원' ? 'selected' : ''}>회사원</option>
	            <option ${vo.job=='공무원' ? 'selected' : ''}>공무원</option>
	            <option ${vo.job=='군인'  ? 'selected' : ''}>군인</option>
	            <option ${vo.job=='자영업' ? 'selected' : ''}>자영업</option>
	            <option ${vo.job=='의사'  ? 'selected' : ''}>의사</option>
	            <option ${vo.job=='법조인' ? 'selected' : ''}>법조인</option>
	            <option ${vo.job=='세무인' ? 'selected' : ''}>세무인</option>
	            <option ${vo.job=='가사'  ? 'selected' : ''}>가사</option>
	            <option ${vo.job=='기타'  ? 'selected' : ''}>기타</option>
	          </select>
	        </td>
	      </tr>
	      <tr>
	        <th class="bg-secondary-subtle">취미</th>
	        <td class="text-start">
	        	<c:set var="varHobbys" value="${fn:split('등산/낚시/바둑/수영/독서/승마/영화감상/축구/농구/배구/기타', '/')}"></c:set>
	        	<c:forEach var="tempHobby" items="${varHobbys}" varStatus="st">
	        		<input type="checkbox" name="hobby" value="${tempHobby}" <c:if test="${fn:contains(vo.hobby,varHobbys[st.index])}">checked</c:if> /> ${tempHobby}&nbsp;
	        	</c:forEach>
	        </td>
	      </tr>
	      <tr>
	        <th class="bg-secondary-subtle">자기소개</th>
	        <td>
	          <textarea rows="5" name="content" class="form-control" placeholder="자기소개를 입력하세요.">${vo.content}</textarea>
	        </td>
	      </tr>
	      <tr>
	        <th class="bg-secondary-subtle">정보공개</th>
	        <td class="text-start">
	        	<input type="radio" name="userInfor" id="userinfor1" value="공개"  ${vo.userInfor=='공개'   ? 'checked' : ''} />공개 &nbsp;
	        	<input type="radio" name="userInfor" id="userinfor2" value="비공개" ${vo.userInfor=='비공개' ? 'checked' : ''} />비공개
	        </td>
	      </tr>
	      <tr>
	        <th class="bg-secondary-subtle">회원사진</th>
	        <td>
	          회원사진 : <img src="${ctp}/member/${vo.photo}" width="100px"/>
	          <input type="file" name="fName" id="file" class="form-control" />
	        </td>
	      </tr>
	    </table>
    </div>
    <!-- <div class="text-center" id="addBtn" style="display:none"> -->
      <input type="button" value="회원정보수정" onclick="fCheck()" class="btn btn-success me-2"/>
      <input type="reset" value="다시입력" class="btn btn-warning me-2"/>
      <input type="button" value="돌아가기" onclick="location.href='${ctp}/member/memberMain';" class="btn btn-primary"/>
    <!-- </div> -->
    <input type="hidden" name="email" />
    <input type="hidden" name="tel" />
    <input type="hidden" name="address" />
    <input type="hidden" name="photo" id="photo" value="${vo.photo}"/>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>