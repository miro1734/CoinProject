<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	textarea{
		width:600px;
		height:400px;
	}
</style>
</head>
<body>
<header style="border-bottom:1px solid #c4c4c4;margin-bottom:40px;">
	<div style="display:inline;">
		<a href="login.do"><img alt="" src="resource/img/logo.png" style="width:200px;height:70px;"></a>
	</div>
	<div style="display:inline;float: right;margin-top:10px;margin-right:10px;">
		<a href="mypageView.do" style="margin:0px;color: blue;">${sessionScope.client.id }</a>님이 로그인하셨습니다.<br>
		<a href="logout.do" style="float: right;margin-right:0px;color: red;margin-top:10px;">로그아웃</a>
	</div>
</header>
	<form action="boardWrite.do" method="post">
		제목 : <input type="text" name="title" placeholder="제목을 입력하세요">
		<input type="hidden" name="writer" value="${requestScope.board.writer}">
		<br>내용<br>
		<textarea name="bcontent" placeholder="내용을 입력하세요"></textarea><br>
		<button>작성</button>
		<button type="button" onclick="history.back();">취소</button>
	</form>
</body>
</html>