<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>qrCodeEx2.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script>
    'use strict';
    
    function qrCodeCreate2() {
    	let moveUrl = $("#moveUrl").val();
    	
    	if(moveUrl.trim()=="") {
    		alert("소개할 주소를 입력해 주세요");
    		$("#moveUrl").focus();
    		return false;
    	}
    	
    	let query = {
    			moveUrl : moveUrl
    	}
    	
    	$.ajax({
    		url  : "qrCodeCreate2",
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
  <h2>소개할 사이트를 QR코드로 생성하기</h2>
  <div>(소개하고 싶은 사이트의 주소를 아래 입력해 주세요 : 예) 고궁, 박물과(전시)-그림,문화재 , 블로그, 홈페이지, 상품상세설명, 쿠폰상세설명사이트..)</div>
  <form name="myform" method="post">
    <table class="table table-bordered text-center">
      <tr>
        <th>이동할 주소</th>
        <td><input type="text" name="moveUrl" id="moveUrl" value="cjsk1126.tistory.com" autofocus required class="form-control"/></td>
      </tr>
      <tr>
        <td colspan="2">
          <input type="button" value="QR코드생성" onclick="qrCodeCreate2()" class="btn btn-success"/>
          <input type="reset" value="다시입력" class="btn btn-warning"/>
          <input type="button" value="돌아가기" onclick="location.href='qrCodeForm';" class="btn btn-info"/>
        </td>
      </tr>
      <tr>
        <th></th>
        <td></td>
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