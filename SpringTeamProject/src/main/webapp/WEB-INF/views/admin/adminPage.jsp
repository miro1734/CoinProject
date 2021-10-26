<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<style type="text/css">
		* {
			margin: 0;
			padding: 0;		
		}
.news_container2 {
        	background-color: #e9e9e9;
        	width: 100%;
        	height: 100px;
        	padding: 10px;
        	box-sizing: border-box;
        	border-radius: 5px;
        }
        .bx-wrapper {
        	width: 600px;
        	height: 330px;
        	border: none;
            box-shadow: none;
            margin-bottom: 0;
     	}
     	.chat_container .bx-wrapper, .chat_container .bx-viewport{
     		height: 240px;
     	}
     	.news_container {
     		width: 600px;
     		height: 330px;
     	}
        .ndate {
        	color: #c9c9c9;
        	font-size: 10px;
        }
        .heardline {
        	font-size: 12px;
        }
        .blank {
        	height: 10px;
        }
       .bx-wrapper .bx-controls-direction a {
       		top : -15px;
       		transform:rotate(90deg);
       }
       .bx-wrapper .bx-next {
       		right: 10px;
       }
       .bx-wrapper .bx-prev {
       		position : absolute;
       		left : 220px;
       }
</style>
</head>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.15/jquery.bxslider.min.css" rel="stylesheet" /> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.15/jquery.bxslider.min.js"></script>
<script type="text/javascript">
function selectAllNews(r) {
	var str = "<h2>뉴스</h2>";
	str += "<div class='slider'>";
	for (i = 0; i < r.length; i++) {
		str += "<div class='news_container2'>";
		str += "<input name='nno' value=" + r[i].nno + " type='hidden'>";
		str += "<p class='ndate'>" + r[i].ndate + "</p>";
		str += "<p class='heardline'>" + r[i].headline + "</p>";
		str += "<a href='#' class='news_delete'>삭제</a>";
		str += "</div>";
		str += "<div class='blank'></div>";
	}
	str += "</div>";
	str += "<div class='news_write'>글쓰기</div>";
	str += "<form><input type='text' name='headline'>";
	str += "<button type='button' class='btn_news'>작성</button></form>";

	$(".news_container").html(str);
	$(".news_delete").click(news_delete);
	$(".news_write	").click(news_write);
	$(".btn_news").click(btn_news);
	
	 $(".slider").bxSlider({
	        pager : false,
	        mode : 'vertical',
	        auto : false,
	        speed : 200,
	        minSlides : 6,
	        infiniteLoop : false
	    });
}
//뉴스 게시판 글쓰기 버튼을 누르면 글쓰는 부분이 생성되는 함수
function news_write() {
	$("form").css("display", "block");
}
//뉴스 게시판 글 삭제하는 함수
function news_delete() {
	$(this).parent().wrap("<form></form>");
	var nno = $(this).parents("form").serialize();
	console.log(nno);
	$(this).parent().unwrap();
	$.ajax({
		url : "delete.do",
		data : nno,
		dataType : "json",
		success : function(r) {
			selectAllNews(r);
		}
	});
}
function btn_news() {
	var data = $("form").serialize();
	$.ajax({
		url : "newsWrite.do",
		data : data,
		dataType : "json",
		success : function(r) {
			console.log(r);
			selectAllNews(r);
		}
	});
}
	$(function(){
		btn_news();
		$(".slider").bxSlider({
	        pager : false,
	        mode : 'vertical',
	        auto : false,
	        speed : 200,
	        maxSlides : 5,
	        minSlides : 6,
	        infiniteLoop : false
	    });
		
		$(".btnDelete").click(function(){
			var d= $(this).parent().children().first().val();
			$.ajax({
				data:"id="+d,
				type:"post",
				url:"adminDelete.do",
				dataType:"json",
				success:function(r){
				}
			})
					alert("회원제명완료");
					location.href="adminSelect.do"
		})
	})
</script>
<body>
	관리자 페이지
	<a href="logout.do">로그아웃</a>
	<div class="result">
	<!-- 전체 회원 목록을 출력 -->
	<c:forEach var="client" items="${requestScope.list }">
	<c:if test="${client.id != 'admin'}">
		<form>
		<input type="text" name="id" value="${client.id }">
		<input type="text" name="passwd" value="${client.passwd }">
		<input type="text" name="email" value="${client.email }">
		<input type="text" name="krw" value="${client.krw }">
		<input type="text" name="name" value="${client.name }">
		<button type="button" class="btnDelete">회원 제명</button>
		</form>
		</c:if>
	</c:forEach>
	</div>
		<div class="news_container">
	        <h2>뉴스</h2>
	        <div class="slider">
		        <c:forEach var="news" items="${requestScope.news}">
			        	<div class="news_container2">
				        		<input name="nno" value="${news.nno}" type="hidden">
					        	<p class="ndate">${news.ndate}</p>
					        	<p class="heardline">${news.headline}</p>
					        	<a href="#" class="news_delete">삭제</a>
		        		</div>
		        		<div class="blank"></div>
		        </c:forEach>
		    </div><div class="news_write">뉴스 쓰기</div>
		    <form>
		    	<input type="text" name="headline">
		    	<button type="button" class="btn_news">작성</button>
		    </form>
	</div>
</body>
</html>