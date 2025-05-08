<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<script src="https://www.google.com/recaptcha/api.js"></script>
	<script>
		$(function() {
			$('#join_box, #join_button').click(function() {
			//$('#join_button').click(function() {
				var captcha = 1;
				$.ajax({
	        url: '${ctp}/study/captchaGoogle/captchaGoogleCheck',
	        type: 'post',
	        data: { recaptcha: $("#g-recaptcha-response").val() },
	        success: function(data) {
	          switch (data) {
	            case 0:
	              captcha = 0;
	              alert("인증되었습니다.\n로그인창으로 이동합니다.")
	              location.href = "${ctp}/member/memberLogin";
	        			break;
	            case 1:
	              alert("자동 가입 방지 봇을 확인 한뒤 진행 해 주세요.");
	              break;
	            default:
	              alert("자동 가입 방지 봇을 실행 하던 중 오류가 발생 했습니다. [Error bot Code : " + Number(data) + "]");
	           		break;
	          }
	        }
	      });
				if(captcha != 0) {
					return false;
				}
			});
		});
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <h2>캡차연습</h2>
  <div class="g-recaptcha" data-sitekey="6Lf5ijErAAAAAJv8hqDDQzvhge6ndHrdbpM1FhLh" id="join_box"></div>	<!-- 사이트키 -->
	<button type="button" id = "join_button" class="btn btn-success btn-sm mt-2">체크박스 선택후 클릭해 주세요</button>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>