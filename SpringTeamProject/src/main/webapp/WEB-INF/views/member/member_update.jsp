<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<style type="text/css">
	*{
        margin: 0;
        padding: 0;
    }
    .head_bar{
        text-align: right;
    }
    .correction{
        margin: 0 auto;
        width: 898px;
        height: 1024px;
    }
    h2{
        font-weight: bold;
        text-align: center;
        padding-top: 30px;
        height: 134px;
        font-size: 30px;
    }

    label{
        width: 117px;
        height: 76px;
        font-size: 20px;
        margin-bottom: 10px;
        margin-left: 110px;
    }
    input{
    	outline: none;
        height: 76px;
        width: 492px;
        margin-bottom: 10px;
        font-size: 20px;
    }
    input:focus{
    	border-bottom: 1px solid #337ab7;
    }
    #id{
        padding-right: 40px;
    }
    #passwd{
    	padding-right: 20px;
    }
    #name{
        padding-right: 60px;
    }
    #email{
        padding-right: 40px;  
    }
    .id{
        border: none;
        border-radius: 10px;
    }
    .id:focus{
    	border-bottom:none;
    }
    .pass{
        border: none;
        border-bottom: 1px solid #e4e4e4;
    }
    .name{
        border: none;
        border-bottom: 1px solid #e4e4e4;
    }
    .email{
        border: none;
        border-bottom: 1px solid #e4e4e4;
    }
    button{
        width: 250px;
        height: 60px;
        border-radius: 5px;
        margin-top: 80px;
        margin-left: 115px;
        background-color: #337ab7;
        font-size: 20px;
        color: white;
    }
    button:hover{
        background-color: #23527c;
    }
    #passResult{
    	font-size: 15px;
    }
</style>
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
<header style="border-bottom:1px solid #c4c4c4;margin-bottom:40px;">
	<div style="display:inline;">
		<a href="login.do"><img alt="" src="resource/img/logo.png" style="width:200px;height:70px;"></a>
	</div>
	<div style="display:inline;float: right;margin-top:10px;margin-right:10px;">
		<a href="mypageView.do" style="margin:0px;color: blue;">${sessionScope.client.id }</a>님이 로그인하셨습니다.<br>
		<a href="logout.do" style="float: right;margin-right:0px;color: red;margin-top:10px;">로그아웃</a>
	</div>
</header>
	<div class="correction">
        <c:if test="${sessionScope.client == null }">
            <c:redirect url="/"/>
        </c:if>
        <h2>다나와 코인<br>
            회원 수정</h2>
        <form action="memberUpdate.do">
        <label for="id" id="id">아이디 : </label>
        <input type="text" name="id"  class="id" value="${sessionScope.client.id }" readonly><br>
        <label for="pass" id="passwd">비밀번호 : </label>
        <input type="text" name="pass" id="pass" class="pass" placeholder="암호를 입력하세요"><br>
        <label for="pass" id="passwd">비밀번호 : </label>
        <input type="text" name="pass2" id="pass2" class="pass" placeholder="암호를 입력하세요"><font id="passResult" ></font><br>
        <label for="name" id="name">이름 : </label>
        <input type="text" name="name" class="name" placeholder="이름을 입력하세요" value="${sessionScope.client.name }"><br>
        <label for="email" id="email">이메일 : </label>
        <input type="text" name="email" class="email" placeholder="이메일을 입력하세요" value="${sessionScope.client.email }"><br>
        <button type="button" class="update_button">수정하기</button>
        <button type="button" class="cancel_button">취소</button>
        </form>
    </div>
</body>
</html>