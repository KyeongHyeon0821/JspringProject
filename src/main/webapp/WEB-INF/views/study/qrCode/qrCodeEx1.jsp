<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>qrCodeEx1.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script>
    'use strict';
    
    function qrCodeCreate1() {
    	let mid = $("#mid").val();
    	let name = $("#name").val();
    	let email = $("#email").val();
    	
    	if(mid.trim()=="" || name.trim()=="" || email.trim()=="") {
    		alert("개인 정보를 입력해 주세요");
    		$("#mid").focus();
    		return false;
    	}
    	
    	let query = {
    			mid   : mid,
    			name  : name,
    			email : email
    	}
    	
    	$.ajax({
    		url  : "qrCodeCreate1",
    		type : "post",
    		data : query,
    		success:function(res) {
    			if(res != "") {
	    			let qrCode = "QR Code 명 : " + res + "<br/>";
	    			qrCode += '<img src="${ctp}/qrCode/'+res+'.png" />';
	    			$("#demo").html(qrCode);
    			}
    			else alert("QR코드 생성 실패~~");
    		},
    		error : function() { alert("전송 오류!!"); }
    	});
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <h2>개인 정보를 QR코드로 생성하기</h2>
  <form name="myform" method="post">
    <table class="table table-bordered text-center">
      <tr>
        <th>아이디</th>
        <td><input type="text" name="mid" id="mid" value="${sMid}" autofocus required class="form-control"/></td>
      </tr>
      <tr>
        <th>성명</th>
        <td><input type="text" name="name" id="name" value="${sNickName}" required class="form-control"/></td>
      </tr>
      <tr>
        <th>이메일</th>
        <td><input type="text" name="email" id="email" value="cjsk1126@namver.com" required class="form-control"/></td>
      </tr>
      <tr>
        <td colspan="2">
          <input type="button" value="QR코드생성" onclick="qrCodeCreate1()" class="btn btn-success"/>
          <input type="reset" value="다시입력" class="btn btn-warning"/>
          <input type="button" value="돌아가기" onclick="location.href='qrCodeForm';" class="btn btn-info"/>
        </td>
      </tr>
    </table>
  </form>
  <hr class="border-secondary"/>
  <div id="demo"></div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>