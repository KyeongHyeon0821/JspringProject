<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>pdsList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
	<script>
		'use strict';
		function partCheck() {
			let part = $("#part").val();
			location.href="pdsList?pag=1&pageSize=${pageVo.pageSize}&part="+part;
		}
		
		// 자료실 게시글 삭제
		function deleteContent(idx, fSName) {
			let ans = confirm("해당 자료실 글을 삭제 하시겠습니까?");
			if(!ans) return false;
			
			$.ajax({
				url : "${ctp}/pds/deleteContent",
				type : "post",
				data : {
					idx : idx,
					fSName : fSName,
				},
				success : function(res) {
					if(res != "0") {
						alert("자료실 글을 삭제했습니다.");
						location.reload();
					}
					else alert("작업 실패");
				},
				error : function() { alert("전송오류"); }
			});
			
		}
		
		// 자료실 글 모달창으로 상세보기
		function showContentModal(idx, nickName, title, content, part, hostIp, openSw, fDate, downNum, fSize, fNames, fSName) {
			$("#myModal .modal-body .idx").html(idx);
			$("#myModal .modal-body .nickName").html(nickName);
			$("#myModal .modal-body .title").html(title);
			$("#myModal .modal-body .content").html(content);
			$("#myModal .modal-body .part").html(part);
			$("#myModal .modal-body .hostIp").html(hostIp);
			$("#myModal .modal-body .openSw").html(openSw);
			$("#myModal .modal-body .fDate").html(fDate.substring(0,19));
			$("#myModal .modal-body .downNum").html(downNum);
			$("#myModal .modal-body .fSize").html( Math.round(fSize/1024) + "KByte");
			$("#myModal .modal-body .fSName").html(fSName);
			let fNamesArray = fNames.split("/");
			let fName = "";
			
			// 파일 이름 처리
			for(let i of fNamesArray) {
				fName += i + "<br>";
			}
			$("#myModal .modal-body .fName").html(fName);
			
			// 이미지 처리
			let fSNameArray = fSName.split("/");
			let imgs = "";
			
			
			for(let i of fSNameArray) {
				imgs +="<img src='${ctp}/resources/data/pds/" + i + "' width='250px'>";
			}
			$("#myModal .modal-body .imgs").html(imgs);
		}
		
		// 다운로드 수 증가 처리
		function downNumCheck(idx) {
			$.ajax({
				url : "${ctp}/pds/pdsDownNumCheck",
				type : "post",
				data : {idx : idx},
				success : function(res) {
					location.reload();
				},
				error : function() { alert("전송오류!"); }
			});
		}
	</script>
	<link rel="stylesheet" type="text/css" href="${ctp}/css/linkOrange.css" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br/></p>
<div class="container">
  <h2>자 료 실 리 스 트(${pageVo.part})</h2>
  <br/>
  <table class="table table-borderLess m-0 p-0">
  	<tr>
  		<td>
  			<form name="partForm">
  				<select name="part" id="part" onchange="partCheck()">
  					<option ${pageVo.part == '전체' ? 'selected' : ''}>전체</option>
  					<option ${pageVo.part == '학습' ? 'selected' : ''}>학습</option>
  					<option ${pageVo.part == '여행' ? 'selected' : ''}>여행</option>
  					<option ${pageVo.part == '음식' ? 'selected' : ''}>음식</option>
  					<option ${pageVo.part == '기타' ? 'selected' : ''}>기타</option>
  				</select>
  			</form>
  		</td>
  		<td class="text-end">
  			<a href="pdsInput?part=${pageVo.part}" class="btn btn-success btn-sm">자료올리기</a>
  		</td>
  	</tr>
  </table>
  <table class="table table-hover text-center">
  	<tr class="table-secondary">
  		<th>번호</th>
  		<th>자료제목</th>
  		<th>올린이</th>
  		<th>올린날짜</th>
  		<th>분류</th>
  		<th>파일명(크기)</th>
  		<th>다운수</th>
  		<th>비고</th>
  	</tr>
  	<c:set var="curScrStartNo" value="${pageVo.curScrStartNo}" />
  	<c:forEach var="vo" items="${vos}" varStatus="st">
  		<tr>
  			<td>${curScrStartNo}</td>
  			<td>
  				<a href="pdsContent?idx=${vo.idx}&pag=${pageVo.pag}&pageSize=${pageVo.pageSize}&part=${pageVo.part}">${vo.title}</a>
  			</td>
  			<td>${vo.nickName}</td>
  			<td>
  				${vo.dateDiff == 0 ? fn:substring(vo.FDate, 11, 19) : fn:substring(vo.FDate, 0, 10)}
  			</td>
  			<td>${vo.part}</td>
  			<td>
  				<c:set var="fNames" value="${fn:split(vo.FName, '/')}" />
  				<c:set var="fSNames" value="${fn:split(vo.FSName, '/')}" />
  				<c:forEach var="fName" items="${fNames}" varStatus="st">
  					<a href="${fSNames[st.index]}" download="${fName}" onclick="downNumCheck(${vo.idx})">${fName}</a><br/>
  				</c:forEach>
  				(<fmt:formatNumber value="${vo.FSize/1024}" pattern="#,##0" />KByte)
  			</td>
  			<td>${vo.downNum}</td>
  			<td>
  				<c:if test="${sMid == vo.mid || sLevel == 0}">
  					<a href="javascript:deleteContent(${vo.idx}, '${vo.FSName}')" class="badge bg-danger">삭제</a>
  				</c:if>
  				<c:if test="${empty vo.content}"><c:set var="content" value="내용없음" /></c:if>
					<c:if test="${!empty vo.content}"><c:set var="content" value="${fn:replace(fn:replace(vo.content, CRLF, '<br/>'), LF, '<br/>')}" /></c:if>
  				<button style="border:none;" type="button" onclick="showContentModal(${vo.idx},'${vo.nickName}','${vo.title}', '${content}', '${vo.part}', '${vo.hostIp}', '${vo.openSw}','${vo.FDate}', '${vo.downNum}', '${vo.FSize}', '${vo.FName}', '${vo.FSName}')" class="badge bg-primary" data-bs-toggle="modal" data-bs-target="#myModal">상세보기</button>
  				<a href="pdsTotalDown?idx=${vo.idx}" class="badge bg-warning" >전체다운</a>
  			</td>
  		</tr>
  		<c:set var="curScrStartNo" value="${curScrStartNo -1}" />
  	</c:forEach>
  </table>
  
  <!-- 블록페이지 시작(1블록의 크기를 3개(3Page)로 한다. -->
	<div class="text-center">
	  <ul class="pagination justify-content-center">
	    <c:if test="${pageVo.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="pdsList?part=${pageVo.part}&pag=1&pageSize=${pageVo.pageSize}">첫페이지</a></li></c:if>
	  	<c:if test="${pageVo.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="pdsList?part=${pageVo.part}&pag=${(pageVo.curBlock-1)*pageVo.blockSize+1}&pageSize=${pageVo.pageSize}">이전블록</a></li></c:if>
  		<c:forEach var="i" begin="${(pageVo.curBlock*pageVo.blockSize)+1}" end="${(pageVo.curBlock*pageVo.blockSize)+pageVo.blockSize}" varStatus="st">
		    <c:if test="${i <= pageVo.totPage && i == pageVo.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="pdsList?part=${pageVo.part}&pag=${i}&pageSize=${pageVo.pageSize}">${i}</a></li></c:if>
		    <c:if test="${i <= pageVo.totPage && i != pageVo.pag}"><li class="page-item"><a class="page-link text-secondary" href="pdsList?part=${pageVo.part}&pag=${i}&pageSize=${pageVo.pageSize}">${i}</a></li></c:if>
	  	</c:forEach>
	  	<c:if test="${pageVo.curBlock < pageVo.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="pdsList?part=${pageVo.part}&pag=${(pageVo.curBlock+1)*pageVo.blockSize+1}&pageSize=${pageVo.pageSize}">다음블록</a></li></c:if>
	  	<c:if test="${pageVo.pag < pageVo.totPage}"><li class="page-item"><a class="page-link text-secondary" href="pdsList?part=${pageVo.part}&pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}">마지막페이지</a></li></c:if>
	  </ul>
	</div>
	<!-- 블록페이지 끝 -->
	

<!-- The Modal -->
	<div class="modal fade" id="myModal">
	  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title">자료실 게시글 상세보기</h4>
	        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
	      </div>
	      <div class="modal-body">
	        <table class="table table-bordered border-secondary-subtle">
	        	<tr>
	        		<th width="10%" class="table-secondary">번호</th><td class="idx"></td><th width="10%" class="table-secondary">제목</th><td class="title"></td>
	        	</tr>
	        	<tr>
	        		<th class="table-secondary">닉네임</th><td class="nickName"></td><th class="table-secondary">IP</th><td class="hostIp"></td>
	        	</tr>
	        	<tr>
	        		<th class="table-secondary">날짜</th><td class="fDate"></td><th class="table-secondary">다운수</th><td class="downNum"></td>
        		</tr>
        		<tr>
	        		<th class="table-secondary">분류</th><td class="part"></td><th class="table-secondary">공개여부</th><td class="openSw"></td>
        		</tr>
	        	<tr>
	        		<th class="table-secondary">상세설명</th><td colspan="3" class="content"></td>
	        	</tr>
	        	<tr>
	        		<th class="table-secondary">파일명</th><td colspan="3" class="fName"></td>
	        	</tr>
	        	<tr>
	        		<th class="table-secondary">파일크기</th><td colspan="3" class="fSize"></td>
	        	</tr>
	        	<tr>
	        		<th colspan="4" class="text-center table-secondary">이미지</th>
	        	</tr>
	        	<tr>
	        		<td class="imgs" colspan="4">
	        		</td>
	        	</tr>
	        </table>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>