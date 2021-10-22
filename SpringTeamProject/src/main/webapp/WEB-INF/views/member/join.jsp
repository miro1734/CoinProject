<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/resource/lib/jquery-3.6.0.min.js"></script>
<script>//체크 박스 -최진욱 10/16
var status = false;
$(function() {
	$(".btnIdCheck").click(function() {
		var d = "id="+$("input[name=id]").val();
		$.ajax({
			data:d,
			url : "idCheck.do",
			type:"post",
			dataType:"json",
			success:function(r){
				status = r.result;
				if(status=="true")
					$(".id_result").html("아이디가 중복되지 않았습니다.");
				else
					$(".id_result").html("아이디가 중복됩니다.");
			}
		});
	});
	$("form").submit(function(e) {
		if(status == "false"){
			alert("아이디 중복 확인을 하세요");
			e.preventDefault();	
		}
	});
});

$(document).ready(function(){
	$('#chk1').click(function () {
		if($("#chk1").prop("checked")){
			$("input[type=checkbox]").prop("checked",true);	
		}else{
			$("input[type=checkbox]").prop("checked",false);
		}
	});
});
//비밀번호 확인
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
	<div class="result">
	    	<h2>
	            다나와 코인<br>
	            회원가입
	        </h2>
	        <form action="register.do">
	             아이디 : <input type="text" name="id" placeholder="아이디를 입력하세요.">
	             <button class="btnIdCheck" type="button">아이디중복확인</button><br> 
				 <span class="id_result"></span><br>
	             비밀번호 : <input type="password" name="pass" id="pass" placeholder="비밀번호를 입력하세요."><br>
	             비밀번호 : <input type="password" name="pass2" id="pass2" placeholder="비밀번호를 입력하세요."><br>
	             <font id="passResult" ></font><br>  
				 이름 : <input type="text" name="name" placeholder="이름을 입력하세요."><br>
	             이메일 : <input type="text" name="email" placeholder="이메일을 입력하세요."><br>   
	             <input type="checkbox" value="1" id="chk1"> 약관 전체 동의   <br>
	             <input type="checkbox" value="2" id="chk2"> 000000000000000동의  <br>
	             <input type="checkbox" value="3" id="chk3"> 000000000000000동의  <br>
	             <input type="checkbox" value="4" id="chk4"> 000000000000000동의  <br>
	             <button>계정 만들기</button> <br>
	             <button>취소</button>         
	        </form>
	</div>
</body>
</html>