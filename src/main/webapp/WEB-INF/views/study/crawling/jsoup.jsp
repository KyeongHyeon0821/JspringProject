<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>jsoup.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script>
    'use strict';
    
    function crawling1() {
    	let url = document.getElementById("url").value;
    	let selector = $("#selector").val();
    	
    	if(url.trim() == "" || selector.trim() == "") {
    		alert("크롤링할 주소와 선택자를 입력하세요");
    		return false;
    	}
    	
    	$.ajax({
    		url  : "jsoup",
    		type : "post",
    		data : {
    			url : url,
    			selector : selector
    		},
    		success:function(res) {
    			if(res != "") {
    				$("#demo").html(res);
    			}
    			else $("#demo").html("검색된 자료가 없습니다.");
    		},
    		error : function() { alert("전송오류!!!"); }
    	});
    }
    
    function crawling2() {
    	let url = document.getElementById("url").value;
    	let selector = $("#selector").val();
    	
    	if(url.trim() == "" || selector.trim() == "") {
    		alert("크롤링할 주소와 선택자를 입력하세요");
    		return false;
    	}
    	
    	$.ajax({
    		url  : "jsoup2",
    		type : "post",
    		data : {
    			url : url,
    			selector : selector
    		},
    		success:function(res) {
    			console.log("res : " + res);
    			if(res != "") {
    				let str = '';
    				for(let i=0; i<res.length; i++) {
    					str += res[i] + "<br/>";
    				}
    				$("#demo").html(str);
    			}
    			else $("#demo").html("검색된 자료가 없습니다.");
    		},
    		error : function() { alert("전송오류!!!"); }
    	});
    }
    
    function crawling3() {
    	let url = document.getElementById("url3").value;
    	let selector = $("#selector3").val();
    	
    	if(url.trim() == "" || selector.trim() == "") {
    		alert("크롤링할 주소와 선택자를 입력하세요");
    		return false;
    	}
    	
    	$.ajax({
    		url  : "jsoup3",
    		type : "post",
    		data : {
    			url : url,
    			selector : selector
    		},
    		success:function(res) {
    			console.log("res : " + res);
    			if(res != "") {
    				let str = '';
    				for(let i=0; i<res.length; i++) {
    					str += res[i] + "<br/>";
    				}
    				$("#demo").html(str);
    			}
    			else $("#demo").html("검색된 자료가 없습니다.");
    		},
    		error : function() { alert("전송오류!!!"); }
    	});
    }
    
    function crawling4() {
    	let searchString = document.getElementById("searchString").value;
    	let page = $("#page").val();
    	
    	if(searchString.trim() == "" || page.trim() == "") {
    		alert("크롤링할 검색어와 검색페이지를 입력하세요");
    		return false;
    	}
    	let startPage = page*15 + 1;
    	let search = "https://search.naver.com/search.naver?nso=&page="+page+"&query="+searchString+"&sm=tab_pge&start="+startPage+"&where=web";
    	let searchSelector = "div.total_dsc_wrap";
    	
    	$.ajax({
    		url  : "jsoup4",
    		type : "post",
    		data : {
    			search : search,
    			searchSelector : searchSelector
    		},
    		success:function(res) {
    			console.log("res : " + res);
    			if(res != "") {
    				let str = '';
    				for(let i=0; i<res.length; i++) {
    					str += res[i] + "<br/>";
    				}
    				$("#demo").html(str);
    			}
    			else $("#demo").html("검색된 자료가 없습니다.");
    		},
    		error : function() { alert("전송오류!!!"); }
    	});
    }
    
    function crawling5() {
    	let searchString = document.getElementById("searchString5").value;
    	let page = $("#page5").val();
    	
    	if(searchString.trim() == "" || page.trim() == "") {
    		alert("크롤링할 검색어와 검색페이지를 입력하세요");
    		return false;
    	}
    	let startPage = page*15 + 1;
    	let search = "https://search.naver.com/search.naver?nso=&page="+page+"&query="+searchString+"&sm=tab_pge&start="+startPage+"&where=web";
    	let searchSelector = "div.thumb_single._parent";
    	
    	$.ajax({
    		url  : "jsoup5",
    		type : "post",
    		data : {
    			search : search,
    			searchSelector : searchSelector
    		},
    		success:function(res) {
    			console.log("res : " + res);
    			if(res != "") {
    				let str = '';
    				for(let i=0; i<res.length; i++) {
    					str += res[i] + "<br/>";
    				}
    				$("#demo").html(str);
    			}
    			else $("#demo").html("검색된 자료가 없습니다.");
    		},
    		error : function() { alert("전송오류!!!"); }
    	});
    }
    
    function crawling6() {
    	let url = document.getElementById("url6").value;
    	
    	if(url.trim() == "") {
    		alert("크롤링할 주소를 입력하세요");
    		return false;
    	}
    	// "타이틀/그림/언론사"
    	let selector = "a.link_txt.valid_link/a.link_thumb/span.info_thumb";
    	
    	$.ajax({
    		url  : "jsoup6",
    		type : "post",
    		data : {
    			url : url,
    			selector : selector
    		},
    		success:function(res) {
    			console.log("res : " + res);
    			if(res != "") {
    				let str = '<table class="table table-hover text-center">';
    				str += '<tr><th>번호</th><th>제목</th><th>사진</th><th>언론사</th></tr>';
    				for(let i=0; i<res.length; i++) {
    					str += '<tr>';
    					str += '<td>'+(i+1)+'</td>';
    					str += '<td>'+res[i].item1+'</td>';
    					str += '<td>'+res[i].item2+'</td>';
    					str += '<td>'+res[i].item3+'</td>';
    					str += '</tr>';
    				}
    				str += "</table>"
    				$("#demo").html(str);
    			}
    			else $("#demo").html("검색된 자료가 없습니다.");
    		},
    		error : function() { alert("전송오류!!!"); }
    	});
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <h2>JSOUP 연습</h2>
  <hr class="border-secondary">
  <div><a href="javascript:location.reload()" class="btn btn-warning form-control">다시검색</a></div>
  <hr class="border-secondary">
  <form name="myform">
  	<h4>1.네이버 주요 뉴스 타이틀 검색하기</h4>
    <div class="input-group mb-3">
      <div class="input-group-text">URL주소 입력</div>
      <input type="text" name="url" id="url" value="https://news.naver.com/" class="form-control"/>
    </div>
    <div class="input-group mb-3">
      <div class="input-group-text">셀렉터 입력</div>
      <input type="text" name="selector" id="selector" value="strong.cnf_news_title" class="form-control"/>
      <input type="button" value="검색1" onclick="crawling1()" class="btn btn-success me-1"/>
      <input type="button" value="검색2" onclick="crawling2()" class="btn btn-success"/>
    </div>
  
	  <hr class="border-secondary">
	  <h4>3.네이버 주요 뉴스 타이틀 그림 검색하기</h4>
	  <div class="input-group mb-3">
      <div class="input-group-text">URL주소 입력</div>
      <input type="text" name="url3" id="url3" value="https://news.naver.com/" class="form-control"/>
	  </div>
	  <div class="input-group mb-3">
      <div class="input-group-text">셀렉터 입력</div>
      <input type="text" name="selector3" id="selector3" value="div.cnf_news_thumb" class="form-control"/>
      <input type="button" value="검색3" onclick="crawling3()" class="btn btn-success me-1"/>
	  </div>
	  <hr class="border-secondary">
	  <h4>4.네이버 검색어로 검색하기</h4>
	  <div class="input-group mb-3">
      <div class="input-group-text">URL주소 입력</div>
      <input type="text" name="url4" id="url4" value="https://www.naver.com/" class="form-control"/>
	  </div>
	  <div class="input-group mb-3">
      <div class="input-group-text">검색어 입력</div>
      <input type="text" name="searchString" id="searchString" value="아이유" class="form-control"/>
	  </div>
	  <div class="input-group mb-3">
      <div class="input-group-text">출력페이지</div>
      <input type="text" name="page" id="page" value="2" class="form-control"/>
      <input type="button" value="검색4" onclick="crawling4()" class="btn btn-success me-1"/>
	  </div>
	  <hr class="border-secondary">
	  <h4>5.네이버 검색어로 그림 검색하기</h4>
	  <div class="input-group mb-3">
	    <div class="input-group-text">URL주소 입력</div>
	    <input type="text" name="url5" id="url5" value="https://www.naver.com/" class="form-control"/>
    </div>
	  <div class="input-group mb-3">
      <div class="input-group-text">검색어 입력</div>
      <input type="text" name="searchString5" id="searchString5" value="아이유" class="form-control"/>
	  </div>
    <div class="input-group mb-3">
      <div class="input-group-text">출력페이지</div>
      <input type="text" name="page5" id="page5" value="2" class="form-control"/>
      <input type="button" value="검색5" onclick="crawling5()" class="btn btn-success me-1"/>
    </div>
	  <hr class="border-secondary">
	  <h4>6.다음 연예 홈 검색하기</h4>
	  <div class="input-group mb-3">
	    <div class="input-group-text">URL주소 입력</div>
	    <input type="text" name="url6" id="url6" value="https://entertain.daum.net/" class="form-control"/>
	    <input type="button" value="검색6" onclick="crawling6()" class="btn btn-primary me-1"/>
	  </div>
  </form>
  <div id="demo"></div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>