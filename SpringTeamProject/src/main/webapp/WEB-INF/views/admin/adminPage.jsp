<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
	$(function(){
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
</body>
</html>