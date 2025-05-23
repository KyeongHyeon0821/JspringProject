<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberLogin.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script>
		'use strict';
		
		window.Kakao.init("20a2d176f8b304aa238b8e166c7cbd99");
		
		function kakaoLogin() {
			window.Kakao.Auth.login({
				scope: 'profile_nickname, account_email',
				success: function(autoObj) {
					//console.log(Kakao.Auth.getAccessToken(), "정상적으로 토큰이 발급됨");
					window.Kakao.API.request({
						url : '/v2/user/me',
						success: function(res) {
							const kakao_account = res.kakao_account;
							//console.log(kakao_account, "전송된 정보");
							location.href="${ctp}/member/kakaoLogin?nickName="+kakao_account.profile.nickname+"&email="+kakao_account.email+"&accessToken="+Kakao.Auth.getAccessToken();
						}
					});
				}
			});
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br/></p>
<div class="container">
  <form name="myform" method="post">
  	<table class="table table-bordered text-center">
      <tr>
        <td colspan="2"><font size="5">로그인</font></td>
      </tr>
      <tr>
        <th>아이디</th>
        <td><input type="text" name="mid" id="mid" value="${mid}" placeholder="아이디를 입력하세요" autofocus required class="form-control" /></td>
      </tr>
      <tr>
        <th>비밀번호</th>
        <td><input type="password" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요." required class="form-control" /></td>
      </tr>
     	<tr>
        <td colspan="2">
          <input type="submit" value="로그인" class="btn btn-success me-2"/>
          <input type="reset" value="다시입력" class="btn btn-warning me-2"/>
          <a href="javascript:kakaoLogin()" class="me-2"><img src="${ctp}/images/kakaoLogin.png" width="73px" /></a>
          <input type="button" value="회원가입" onclick="location.href='${ctp}/member/memberJoin';" class="btn btn-primary"/>
        </td>
      </tr>
    </table>
		<table class="table table-borderless p-0">
      <tr>
        <td class="text-center">
          <input type="checkbox" name="idSave" checked /> 아이디저장 &nbsp;&nbsp;&nbsp;
          [<a href="javascript:midSearch()">아이디 찾기</a>] /
          [<a href="javascript:pwdSearch()">비밀번호 찾기</a>]
        </td>
      </tr>
    </table>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>