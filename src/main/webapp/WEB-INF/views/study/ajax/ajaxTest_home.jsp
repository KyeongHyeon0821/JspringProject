<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>ajaxTest_home.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script>
	  function fCheck() {
	  	let category = $("#category").val();
	  	let product = $("#product").val();
	  	
	  	if(category == "" || product == "") {
	  		alert("카테고리를 선택후 클릭해주세요");
	  		return false;
	  	}
	  	let str = "선택하신 상품은? " + category + " / " + product;
	  	$("#demo").html(str);
	  }
	  
	  function categoryCheck() {
		  let category = $("#category").val();
		  if(category.trim() == "") {
			  alert("카테고리를 선택하세요.");
			  return false;
		  }
		  
		  $.ajax({
			  url : "${ctp}/study/ajax/ajaxTest_home",
			  type : "post",
			  data : {category : category},
			  success : function(res) {
					console.log("선택된 카테고리", res);
				  let str = '<option value="">상품선택</option>';
				  for(let i=0; i<res.length; i++) {
					  str += '<option>' + res[i] + '</option>';
				  }
				  $("#product").html(str);
			  }, 
			  error : function() {alert("전송오류!");}
		  });
	  }
	  
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
 	<h2>vos 객체연습(카테고리/상품)</h2>
 	<hr/>
 	<form>
 		<h3>카테고리를 선택해주세요</h3>
 		<select name="category" id="category" onchange="categoryCheck()">
 			<option value="">카테고리선택</option>
 			<option>전자기기</option>
 			<option>패션</option>
 			<option>스포츠</option>
 			<option>가전제품</option>
 		</select>
 		<select name="product" id="product">
 			<option value="">상품선택</option>
 		</select>
 		<input type="button" value="선택" onclick="fCheck()" class="btn btn-info ms-2 me-2 mb-3"/>
    <input type="button" value="돌아가기" onclick="location.href='ajaxForm';" class="btn btn-warning mb-3"/>
 	</form>
 	<div id="demo"></div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>