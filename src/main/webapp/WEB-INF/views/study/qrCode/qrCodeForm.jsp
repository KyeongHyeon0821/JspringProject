<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>qrCodeForm.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script>
    'use strict';
    
    function qrCodeCreate() {
    	$.ajax({
    		url  : "${ctp}/study/qrCode/qrCodeCreate",
    		type : "post",
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
  <h2>
    QR Code 연습하기
    <a href="qrCodeForm" class="btn btn-warning btn-sm">새로고침</a>
  </h2>
  <hr class="border-secondary">
  <div class="row">
    <div class="col"><a href="javascript:qrCodeCreate()" class="btn btn-success">QR생하기</a></div>
    <div class="col"><a href="qrCodeEx1" class="btn btn-info">개인정보등록</a></div>
    <div class="col"><a href="qrCodeEx2" class="btn btn-primary">소개사이트등록</a></div>
    <div class="col"><a href="qrCodeEx3" class="btn btn-secondary">티켓예매정보등록</a></div>
  </div>
  <hr class="border-secondary">
  <div id="demo"></div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>