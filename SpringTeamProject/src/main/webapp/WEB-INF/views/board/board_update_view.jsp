<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기 페이지</title>
<style type="text/css">
	*{
		margin:0px auto;
		paddin:0px;
		text-decoration: none;
	}
	textarea {
	width:600px;
	height: 500px;
}
h1{
	text-align: center;
	margin-bottom: 20px;
}
form{
	width: 606px;
	}
</style>
</head>
<body>
	<c:if test="${sessionScope.client == null }">
		<script>
			alert("로그인 후 이용하세요");
			location.href="/";
		</script>
	</c:if>
	<header style="border-bottom:1px solid #c4c4c4;margin-bottom:40px;">
	<div style="display:inline;">
		<a href="login.do"><img alt="" src="resource/img/logo.png" style="width:200px;height:70px;"></a>
	</div>
	<div style="display:inline;float: right;margin-top:10px;margin-right:10px;">
		<a href="mypageView.do" style="margin:0px;color: blue;">${sessionScope.client.id }</a>님이 로그인하셨습니다.<br>
		<a href="logout.do" style="float: right;margin-right:0px;color: red;margin-top:10px;">로그아웃</a>
	</div>
	</header>
	<h1>게시글 수정</h1>
	<section>
	<form action="boardUpdate.do" method="post">
		제목 : <input type="text" name="title" value="${requestScope.board.title}" style="width:550px;"><br>
		작성일 : ${requestScope.board.bdate}<br>
		작성자 : ${requestScope.board.writer}<br>
		내용<br>
		<textarea name="bcontent">${requestScope.board.bcontent}</textarea>
		<br>
		<button style="background-color:#767d83;color:#fff;border-color: #767d83;">수정</button>
		<button type="button" onclick="history.back();" style="background-color: #f0ad4e;color:#fff;border-color: #eea236;">취소</button>
		<input type="hidden" name="bno" value="${requestScope.board.bno}">
	</form>
	</section>
</body>
</html>
