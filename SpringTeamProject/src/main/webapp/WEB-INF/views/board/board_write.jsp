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