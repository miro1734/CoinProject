<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        .result{
            margin: 0 auto;
            width: 880px;
            height: 1024px;
            box-sizing: border-box;
            border: 1px solid #e9e9e9;
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
            margin-left: 130px;
        }
        input{
        	outline: none;
            height: 76px;
            width: 492px;
            margin-bottom: 10px;
            font-size: 20px;
            border: none;
            border-bottom: 1px solid #e4e4e4;
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
        .id_result{
            height: 76px;
            width: 492px;
            font-size: 15px;
            margin-left: 250px;
        }
        .agreement_1 label{
            font-size: 20px;
            margin-top: 20px;
            margin-left: 20px;
        }
        .agreement_1 input{
            margin-left: 12px;
            width: 15px;
            height: 15px;
            margin-top: 30px;
            margin-left: 250px;    
        }
        .agreement_2 label{
            font-size: 20px;
            margin-top: 10px;
            margin-left: 20px;
        }
        .agreement_2 input{
            margin-left: 12px;
            width: 15px;
            height: 15px;
            margin-top: 10px;
            margin-left: 250px;    
        }
        .agreement_3 label{
            font-size: 20px;
            margin-top: 10px;
            margin-left: 20px;
        }
        .agreement_3 input{
            margin-left: 12px;
            width: 15px;
            height: 15px;
            margin-top: 10px;
            margin-left: 250px;   
        }
        .agreement_4 label{
            font-size: 20px;
            margin-top: 10px;
            margin-left: 20px;
        }
        .agreement_4 input{
            margin-left: 12px;
            width: 15px;
            height: 15px;
            margin-top: 10px;
            margin-left: 250px;    
        }
        button{
            width: 503px;
            height: 81px;
            margin-left: 240px;
            margin-bottom: 20px;
            border-radius: 10px;
            background-color: #337ab7;
            font-size: 20px;
            color: white;
        }
        button:hover{
            background-color: #23527c;
        }
        .btnIdCheck{
            width: 100px;
            height: 45px;
            margin-left: 20px;
            font-size: 13px;
            color: white;
        }
        .join_button{
            margin-top: 50px;
        }
        #passResult{
            font-size: 15px;
            margin-left: 250px;
        }
</style>
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
	});
});
$(function() {
	$('.join_button').click(function(e){
		if(registration.id.value ==""){
			alert("아이디를 입력하세요.");
			registration.id.focus();
			return;
		}
		if (registration.pass.value == "") {
	        alert("비밀번호를 입력해 주세요.");
	        registration.pass.focus();
	        e.preventDefault();
	        return;
	    }
	    if (registration.pass.value == "") {
	        alert("비밀번호를 확인해 주세요.");
	        registration.pass.focus();
	        e.preventDefault();
	        return;
	    }
	    if (registration.name.value == "") {
	        alert("이름을 입력해 주세요.");
	        registration.name.focus();
	        e.preventDefault();
	        return;
	    }
	    if (registration.email.value == "") {
	        alert("이메일을 입력해 주세요.");
	        registration.email.focus();
	        e.preventDefault();
	        return;
	    }
	    if(!chk2.checked){
	    	alert("약관 동의를 체크하세요.");
	    	chk2.focus();
	    	e.preventDefault();
	        return;
	    }if(!chk3.checked){
	    	alert("약관 동의를 체크하세요.");
	    	chk3.focus();
	    	e.preventDefault();
	        return;
	    }if(!chk4.checked){
	    	alert("약관 동의를 체크하세요.");
	    	chk4.focus();
	    	e.preventDefault();
	        return;
	    }
	    registration.submit();
	});
})
$(function(){
		$(".cancel_button").click(function(){
			location.href = "/";
		});
	});
</script>
</head>
<body>
	<div class="result">
	    	<h2>다사와 회원가입</h2>
	        <form action="register.do" name="registration">
	        <label for="id" id="id">아이디 : </label>
             <input type="text" name="id" placeholder="아이디를 입력하세요.">
             <button class="btnIdCheck" type="button">아이디중복확인</button><br>
             <span class="id_result"></span><br>
             <label for="pass" id="passwd">비밀번호 : </label>
             <input type="text" name="pass" id="pass" placeholder="비밀번호를 입력하세요."><br>
             <label for="pass" id="passwd">비밀번호 : </label>
             <input type="text" name="pass2" id="pass2" placeholder="비밀번호를 입력하세요"><br><font id="passResult" ></font><br>
             <label for="name" id="name">이름 : </label>   
             <input type="text" name="name" placeholder="이름을 입력하세요."><br>
             <label for="email" id="email">이메일 : </label>
             <input type="text" name="email" placeholder="이메일을 입력하세요."><br>   
             <div class="agreement_1">
             <input type="checkbox" value="1" id="chk1" name="chk1"><label for="chk1">약관 전체 동의</label><br>
             </div>
             <div class="agreement_2">
             <input type="checkbox" value="2" id="chk2" name="chk2"><label for="chk2">다사와 이용 약관동의</label><br>
             </div>
             <div class="agreement_3">
             <input type="checkbox" value="3" id="chk3" name="chk3"><label for="chk3">개인정보 수집 및 이용 동의</label><br>
             </div>
             <div class="agreement_4">
             <input type="checkbox" value="4" id="chk4" name="chk4"><label for="chk4">위치정보 이용약관 동의</label><br>
             </div>
             <button type="button" class="join_button">계정 만들기</button><br>    
             <button type="button" class="cancel_button">취소</button>         
	        </form>
	</div>
</body>
</html>