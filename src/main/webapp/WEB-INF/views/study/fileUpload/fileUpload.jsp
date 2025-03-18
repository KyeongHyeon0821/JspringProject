<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>fileUpload.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
	<script>
		'use strict';
		function fCehck() {
			let fName = document.getElementById("fName").value;
			let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
			let maxSize = "1024 * 1024 * 20"; // 한번에 업로드할 파일의 최대용랑을 20mb로 한정
			
			if(fName.trim() == "") {
				alert("업로드할 파일을 선택하세요");
				return false;
			}
			
			let fileSize = document.getElementById("fName").files[0].size;
			if(fileSize > maxSize) alert("업로드할 파일의 최대용량은 20mb 입니다.")
			else if(ext !="jpg" && ext !="gif" && ext !="png" && ext !="ppt" && ext !="pptx" && ext !="hwp" && ext !="zip") {
				alert("업로드 가능 파일은 'jpg/gif/png/zip/ppt/pptx/hwp' 입니다.")
			}
			else myform.submit();
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br/></p>
<div class="container">
  <h2>파일 업로드 연습</h2>
  <form name="myform" method="post" enctype="multipart/form-data">
  	<p>올린이 : 
  		<input type="text" name="mid" value="amin" />
  	</p>
  	<p>파일명 : 
  		<input type="file" name="fName" id="fName" class="form-control" accept=".jpg,.gif,.png,.zip,.ppt,.pptx,.hwp"/>
  	</p>
  	<p>
  		<input type="button" value="파입업로드" onclick="fCehck()" class="btn btn-success" />
  		<input type="reset" value="다시선택" class="btn btn-warning" />
  	</p>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>