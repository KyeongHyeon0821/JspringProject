<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>payment.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
	<script>
		IMP.init("imp76101506");
	
		IMP.request_pay(
		  {
			  pg : "html5_inicis.INIpayTest",
		    pay_method: "card",
		    merchant_uid: 'GreenProject_' + new Date().getTime(), // 주문 고유 번호
		    name: "${vo.name}",
		    amount: "${vo.amount}",
		    buyer_email: "${vo.buyer_email}",
		    buyer_name: "${vo.buyer_name}",
		    buyer_tel: "${vo.buyer_tel}",
		    buyer_addr: "${vo.buyer_addr}",
		    buyer_postcode: "${vo.buyer_postcode}",
		  },
		  function (res) {
			  if(res.success) {
				  alert("결제가 완료되었습니다.");
				  location.href="${ctp}/study/payment/paymentOk";
			  }
			  else {
				  alert("결제가 취소되었습니다.");
				  location.href="${ctp}/study/payment/paymentForm";
			  }
		  },
		);
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br/></p>
<div class="container text-center mb-5">
	<p>
		<img src="${ctp}/images/payment.gif" />
	</p>
  
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>