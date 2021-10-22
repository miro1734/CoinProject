<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<script src="/resource/lib/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#pass').keyup(function(){
		$('#passResult').html('');
	});
	$('#pass2').keyup(function(){
		
		if($('#pass').val() != $('#pass2').val()){
	        $('#passResult').html('비밀번호 일치하지 않음');
	        $('#passResult').attr('color', '#f82a2aa3');
	    }else{
	        $('#passResult').html('비밀번호 일치함');
	        $('#passResult').attr('color', '#199894b3');
	    }
	})
})
</script>
</head>
<body>
	<a href="memberUpdateView.do">${sessionScope.client.id }</a>님이 로그인하셨습니다.<br>
	<a href="logout.do">로그아웃</a>
	
	<c:if test="${sessionScope.client == null }">
		<c:redirect url="/"/>
	</c:if>
	<form action="memberUpdate.do">
	아이디 : <input type="text" name="id" value="${sessionScope.client.id }" readonly><br>
	비밀번호 : <input type="text" name="pass" id="pass" placeholder="암호를 입력하세요"><br>
	비밀번호 : <input type="text" name="pass2" id="pass2" placeholder="암호를 입력하세요"><font id="passResult" ></font><br>
	이름 : <input type="text" name="name" placeholder="이름을 입력하세요" value="${sessionScope.client.name }"><br>
	이메일 : <input type="text" name="email" placeholder="이메일을 입력하세요" value="${sessionScope.client.email }"><br>
	<button>수정하기</button>
	<button>취소</button>
	</form>
</body>
</html>