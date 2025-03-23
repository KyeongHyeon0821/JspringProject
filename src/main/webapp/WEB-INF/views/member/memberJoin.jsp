<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberJoin.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
	<script>
    'use strict';
  	
    let idCheckSw = 0;
    let nickCheckSw = 0;
    
    
  	// 정규식정의...(아이디,닉네임(한글/영문,숫자,밑줄),성명(한글/영문),이메일,전화번화({2,3}/{3,4}/{4}))
  	let regMid = /^[a-zA-Z0-9_]{4,20}$/;
  	let regNickName = /^[a-zA-Z0-9_가-힣]{2,20}$/;  // 한글, 영문, 숫자, 밑줄, 2~20자
  	let regName = /^[가-힣]{2,10}$/; // 한글 2~10자
  	let regEmail = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/; // 일반적인 이메일 형식
  	let regTel = /\d{2,3}-\d{3,4}-\d{4}$/;
  	let regPwd = /^[A-Za-z\d!@#$%]{8,20}$/; // 영문, 숫자, 특수문자(!@#$%)만 가능한 8~20자
  	
    // 회원가입에 필요한 정보 체크(정규식)
    function fCheck() {
    	// 필수 항목 먼저 체크하기
    	let mid = myform.mid.value.trim();
    	let pwd = myform.pwd.value.trim();
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
    	
    	if(!regMid.test(mid)) {
    		alert("아이디는 4~20자리의 영문 대/소문자와 숫자, 언더바(_)만 가능합니다.");
    		myform.mid.focus();
    		return false;
    	}
    	else if(!regPwd.test(pwd)) {
    		alert("비밀번호는 4~20자리의 영문, 숫자, 특수문자(!@#$%)만 가능합니다.");
    		myform.pwd.focus();
    		return false;
    	}
    	else if(!regNickName.test(nickName)) {
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
    		// 아이디 중복버튼 눌렸는지 체크
    		if(idCheckSw == 0){
    			alert("아이디 중복체크 버튼을 눌러주세요");
						document.getElementById("midBtn").focus();    		
    		}
    		// 닉네임 중복버튼 눌렸는지 체크
    		else if(nickCheckSw == 0){
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
    
    
    // 아이디 중복검사
    function idCheck() {
    	let mid = myform.mid.value;
    	
    	if(mid.trim() == "") {
    		alert("아이디를 입력하세요");
    		myform.mid.focus();
    	}
    	else if(!regMid.test(mid)) {
    		alert("아이디는 4~20자리의 영문 대/소문자와 숫자, 언더바(_)만 가능합니다.");
    		myform.mid.focus();
    		return false;
    	}
    	else {
    		$.ajax({
    			url  : "${ctp}/member/memberIdChcek",
    			type : "get",
    			data : {mid : mid},
    			success:function(res) {
    				if(res != '0') {
    					alert("이미 사용중인 아이디 입니다. 다시 입력하세요");
    					myform.mid.focus();
    				}
    				else {
    					alert("사용 가능한 아이디 입니다.");
    					idCheckSw = 1;
    					myform.midBtn.disabled = true;
    					myform.mid.readOnly = true;
    				}
    			},
    			error : function() { alert("전송오류!"); }
    		});
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
    
    // 이메일 인증번호 받기
    function emailCertification() {
    	// 필수입력사항 유효성 체크 완료후 인증번호를 받는다.
    	let mid = myform.mid.value;
    	let pwd = myform.pwd.value;
    	let nickName = myform.nickName.value;
    	let name = myform.name.value;
    	let email1 = myform.email1.value.trim();
    	let email2 = myform.email2.value.trim();
    	let email = email1 + "@" + email2;
    	
    	if(!regMid.test(mid)) {
    		alert("아이디는 4~20자리의 영문 대/소문자와 숫자, 언더바(_)만 가능합니다.");
    		myform.mid.focus();
    		return false;
    	}
    	else if(idCheckSw == 0){ 			// 아이디 중복버튼 눌렸는지 체크
    			alert("아이디 중복체크 버튼을 눌러주세요");
					document.getElementById("midBtn").focus();   
		    	return false;

    	}
    	else if(nickCheckSw == 0){ 		// 닉네임 중복버튼 눌렸는지 체크
    			alert("닉네임 중복체크 버튼을 눌러주세요");
					document.getElementById("nickNameBtn").focus(); 
		    	return false;
    	}
    	else if(!regPwd.test(pwd)) {
    		alert("비밀번호는 4~20자리의 영문, 숫자, 특수문자(!@#$%)만 가능합니다.");
    		myform.pwd.focus();
    		return false;
    	}
    	else if(!regNickName.test(nickName)) {
    		alert("닉네임은 8~20자리의 한글, 영문, 숫자, 밑줄(_)만 가능합니다.");
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
    	
    	
    	let spinner = "<div class='text-center'><div class='spinner-border'></div> 메일 발송중입니다. 잠시만 기다려주세요. <div class='spinner-border'></div></div>";
    	$("#demo").html(spinner);
    	
    	// 인증번호 보내기
    	$.ajax({
    		url  : "${ctp}/member/memberEmailCheck",
    		type : "post",
    		data : {email : email},
    		success:function(res) {
    			if(res != '0') {
    				alert("인증번호가 발송되었습니다.\n메일 확인후 인증번호를 아래에 입력해 주세요.");
    				let str = '<div class="input-group">';
    				str += '<input type="text" name="checkKey" id="checkKey" class="form-control"/>';
    				str += '<input type="button" value="인증번호확인" onclick="emailCeritificationOk()" class="btn btn-primary btn-sm"/>';
    				str += '</div>';
    				$("#demo").html(str);
    			}
    			else alert("인증확인버튼을 다시 눌러주세요.");
    		},
    		error : function() { alert("전송오류!"); }
    	});
    }
    
    // 메일로 전송받은 인증번호 확인하기
    function emailCeritificationOk() {
    	let checkKey = $("#checkKey").val();
    	if(checkKey.trim() == "") {
	    	alert("전송받은 메일에서 인증받은 키를 입력해주세요.");
    		$("#checkKey").focus();
    		return false;
    	}
    	
    	// 인증번호 체크를 ajax처리한다.
    	$.ajax({
    		url  : "${ctp}/member/memberEmailCheckOk",
    		type : "post",
    		data : {checkKey : checkKey},
    		success:function(res) {
    			if(res != "0") {
			    	// 인증번호 체크후 인증이 완료되면 기존 버튼들을 감추고 추가 입력부분을 화면에 보여준다.
			    	$("#demo").hide();
			    	$("#certificationBtn").hide();
			    	$("#resetBtn1").hide();
			    	$("#addBtn").show();
			    	$("#addContentCheckDiv").show();
    			}
    			else alert("인증번호 오류~~ 메일을 통해서 발급받은 인증번호를 확인하세요.");
    		},
    		error : function() { alert("전송오류!"); }
    	});
    	
    }
    
    function optionCheck(){
    	let addContent = document.getElementById("addContent");
    	let addContentCheck = document.getElementById("addContentCheck");
    	if(addContentCheck.checked) {
    		addContent.style.display = "block";
    	} else {
    		addContent.style.display = "none";
    	}
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <h3 class="text-center">회 원 가 입</h3>
	<form name="myform" method="post" enctype="multipart/form-data">
  	<table class="table table-bordered text-center border-secondary-subtle">
      <tr>
        <th class="bg-secondary-subtle">아이디</th>
        <td>
          <div class="input-group">
	          <input type="text" name="mid" id="mid" placeholder="아이디를 입력하세요" autofocus required class="form-control" />
	          <input type="button" value="아이디중복체크" id="midBtn" onclick="idCheck()" class="btn btn-secondary btn-sm"/>
          </div>
        </td>
      </tr>
      <tr>
        <th class="bg-secondary-subtle">비밀번호</th>
        <td><input type="password" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요." required class="form-control" /></td>
      </tr>
      <tr>
        <th class="bg-secondary-subtle">닉네임</th>
        <td>
          <div class="input-group">
	          <input type="text" name="nickName" id="nickName" placeholder="닉네임을 입력하세요" required class="form-control" />
	          <input type="button" value="닉네임중복체크" id="nickNameBtn" onclick="nickCheck()" class="btn btn-secondary btn-sm"/>
          </div>
        </td>
      </tr>
      <tr>
        <th class="bg-secondary-subtle">성명</th>
        <td><input type="text" name="name" id="name" placeholder="성명을 입력하세요" required class="form-control" /></td>
      </tr>
      <tr>
        <th class="bg-secondary-subtle">성별</th>
        <td>
        	<input type="radio" name="gender" id="gender1" value="남자" />남자 &nbsp;
        	<input type="radio" name="gender" id="gender2" value="여자" checked />여자
        </td>
      </tr>
      <tr>
        <th class="bg-secondary-subtle">이메일</th>
        <td>
          <div class="input-group">
	          <input type="text" name="email1" id="email1" class="form-control" required />@
	          <select name="email2" id="email2" class="form-select">
	          	<option>naver.com</option>
	          	<option>hanmail.net</option>
	          	<option>gmail.com</option>
	          	<option>daum.net</option>
	          	<option>yahoo.com</option>
	          	<option>hatmail.com</option>
	          	<option>nate.com</option>
	          </select>
          </div>
        </td>
      </tr>
    </table>
    <div class="text-center">
      <input type="button" value="인증번호받기" onclick="emailCertification()" id="certificationBtn" class="btn btn-success btn-sm mb-3" />
      <input type="reset" value="다시입력" id="resetBtn1" onclick="location.reload()" class="btn btn-warning btn-sm ms-2 mb-3"/>
    </div>
    <div class="text-center">  
      <div id="demo"></div>
    </div>
    
    <div id="addContentCheckDiv" style="display:none"><input type="checkbox" onchange="optionCheck()" id="addContentCheck" name="addContentCheck"/> 선택항목보기</div>
    <table class="table table-bordered text-center border-secondary-subtle" id="addContent" style="display:none">
      <tr>
        <th class="bg-secondary-subtle">생일</th>
        <td><input type="date" name="birthday" id="birthday" value="<%=java.time.LocalDate.now()%>" class="form-control" /></td>
      </tr>
      <tr>
        <th class="bg-secondary-subtle">전화번호</th>
        <td>
          <div class="input-group">
	          <select name="tel1" class="form-select">
	            <option value="010" selected>010</option>
	            <option value="02">서울</option>
	            <option value="031">경기</option>
	            <option value="032">인천</option>
	            <option value="041">충남</option>
	            <option value="042">대전</option>
	            <option value="043">충북</option>
	            <option value="051">부산</option>
	            <option value="052">울산</option>
	            <option value="051">부산</option>
	            <option value="054">경북</option>
	            <option value="055">경남</option>
	            <option value="061">전남</option>
	            <option value="062">광주</option>
	            <option value="063">전북</option>
	            <option value="064">제주</option>
	          </select>-
	          <input type="text" name="tel2" id="tel2" class="form-control" />-
	          <input type="text" name="tel3" id="tel3" class="form-control" />
          </div>
        </td>
      </tr>
      <tr>
        <th class="bg-secondary-subtle">주소</th>
        <td>
          <div class="form-group">
	          <div class="input-group">
		          <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control">
							<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-info">
						</div>
						<input type="text" name="roadAddress" id="sample6_address" placeholder="주소" class="form-control">
						<div class="input-group">
							<input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control">
							<input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
						</div>
					</div>
        </td>
      </tr>
      <tr>
        <th class="bg-secondary-subtle">직업</th>
        <td>
          <select class="form-control" name="job">
            <option>학생</option>
            <option>회사원</option>
            <option>공무원</option>
            <option>군인</option>
            <option>자영업</option>
            <option>의사</option>
            <option>법조인</option>
            <option>세무인</option>
            <option>가사</option>
            <option selected>기타</option>
          </select>
        </td>
      </tr>
      <tr>
        <th class="bg-secondary-subtle">취미</th>
        <td class="text-start">
          <input type="checkbox" name="hobby" value="등산">등산&nbsp;
          <input type="checkbox" name="hobby" value="낚시">낚시&nbsp;
          <input type="checkbox" name="hobby" value="바둑">바둑&nbsp;
          <input type="checkbox" name="hobby" value="수영">수영&nbsp;
          <input type="checkbox" name="hobby" value="독서">독서&nbsp;
          <input type="checkbox" name="hobby" value="승마">승마&nbsp;
          <input type="checkbox" name="hobby" value="영화감상">영화감상&nbsp;
          <input type="checkbox" name="hobby" value="축구">축구&nbsp;
          <input type="checkbox" name="hobby" value="농구">농구&nbsp;
          <input type="checkbox" name="hobby" value="배구">배구&nbsp;
          <input type="checkbox" name="hobby" value="기타" checked>기타
        </td>
      </tr>
      <tr>
        <th class="bg-secondary-subtle">자기소개</th>
        <td>
          <textarea rows="5" name="content" class="form-control" placeholder="자기소개를 입력하세요."></textarea>
        </td>
      </tr>
      <tr>
        <th class="bg-secondary-subtle">정보공개</th>
        <td class="text-start">
        	<input type="radio" name="userInfor" id="userinfor1" value="공개" checked />공개 &nbsp;
        	<input type="radio" name="userInfor" id="userinfor2" value="비공개" />비공개
        </td>
      </tr>
      <tr>
        <th class="bg-secondary-subtle">회원사진</th>
        <td>
          <input type="file" name="fName" id="file" class="form-control" />
        </td>
      </tr>
    </table>
    <div class="text-center" id="addBtn" style="display:none">
      <input type="button" value="회원가입" onclick="fCheck()" class="btn btn-success me-2"/>
      <input type="reset" value="다시입력" class="btn btn-warning me-2"/>
      <input type="button" value="돌아가기" onclick="location.href='${ctp}/member/memberLogin';" class="btn btn-primary"/>
    </div>
    <input type="hidden" name="email" />
    <input type="hidden" name="tel" />
    <input type="hidden" name="address" />
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>