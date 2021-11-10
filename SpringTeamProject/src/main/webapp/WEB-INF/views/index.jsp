<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device" ,initial-scale="1">
<!--카카오 sns 로그인 api-->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<%--애니메이션을 담당하는 자바스크립을 추가하였습니다--%>
<script src="js/bootstrap.js"></script>
<%--홈페이지에 디자인을 담당하는 css를 추가하였습니다 --%>
<link rel="stylesheet" href="css/bootstrap.css">
<title>다나와 코인 사이트</title>
<style type="text/css">
* {
	line-height: 50px;
}
.login-search {
	float: right;
}
.login {
	list-style: none;
	text-align: center;
	position: absolute;
	left: -5px;
}
</style>
<script>
	<!--아이디 암호 1글자라도 입력해야 로그인가능 -->
	var val = /[^a-zA-Z0-9]/gi;
	$(function() {
		$("#frm").submit(function(e) {
			if ($("#inputId").val().length <= 1) {
				$("#inputId+p").html("아이디는 2글자 이상 입력하셔야 합니다.");
				e.preventDefault();
			} else {
				$("#inputId+p").html("");
			}
			if ($("#inputpass").val().length <= 1) {
				$("#inputpass+p").html("암호는 2글자 이상 입력하셔야  합니다.");
				e.preventDefault();
			} else {
				$("#inputpass+p").html("");
			}
		});
	});
</script>
<script>
	<!-- 입력을 제한 할 특수문자(특수문자,띄어쓰기 입력시 바로 지워짐)-->
	var replaceId = /[^a-zA-Z0-9]/gi;
	$(document).ready(function() {
		$("#inputId").on("focusout", function() {
			var x = $(this).val();
			if (x.length > 0) {
				if (x.match(replaceId)) {
					x = x.replace(replaceId, "");
				}
				$(this).val(x);
			}
		}).on("keyup", function() {
			$(this).val($(this).val().replace(replaceId, ""));
		});
	});
</script>
<script>
	<!-- 암호,숫자,특수문자 2자리 이상 입력해야한다 (띄어쓰기 입력시 바로 지워짐) -->
	var replacepass = /[^a-zA-Z0-9{}!@#$%^&*~`()-_]/gi;
	$(document).ready(function() {
		$("#inputpass").on("focusout", function() {
			var x = $(this).val();
			if (x.length > 0) {
				if (x.match(replaceId)) {
					x = x.replace(replacepass, "");
				}
				$(this).val(x);
			}
		}).on("keyup", function() {
			$(this).val($(this).val().replace(replacepass, ""));
		});
	});
</script>
<script>
	<!-- 간편 로그인 카카오 스크립트 -->
	Kakao.init('de572fdeba656a65706e27aa1909ed46'); //발급받은 키 중 javascript키를 사용해준다.
	console.log(Kakao.isInitialized()); // sdk초기화여부판단
	//카카오로그인
	function kakaoLogin() {
		Kakao.Auth.login({
			success : function(response) {
				Kakao.API.request({
					url : '/v2/user/me',
					success : function(r) {
						var d = r.properties.nickname;
						location.href = "main.do?id=" + d;
					},
					fail : function(error) {
						console.log(error)
					},
				})
			},
			fail : function(error) {
				console.log(error)
			},
		})
	}
	$(function() {
		$(".btnRegister").click(function() {
			location.href = "registerView.do";
		});
	});
</script>
</head>
<body>
		<!-- 다나와 이미지 사진 -->
		<div class="logo" style="text-align: center; margin-top: 60px;">
			 <img src="resource/img/logo.png" style="width: 420px;">
		</div>
	<div class="container">
		  <div>
		<!-- 로그인 디자인및 기능 -->
		<div class="container">
			<div class="col-lg-4"></div>
			<div class="col-lg-4">
				<div class="jumbtron" style="padding-top: 20px;">
					<form method="post" action="login.do" id="frm">
						<!-- 아이디 기능 -->
						<div class="form-group">
							<input type="text" class="form-control"
								placeholder="아이디(영문,숫자 2자리 이상 입력)" name="userID" maxlength="8"
								id="inputId">
							<p class="fail"></p>
						</div>
						<!-- 암호 기능 -->
						<div class="form-group">
							<input type="password" class="form-control"
								placeholder="암호(특수문자,영문,숫자 2자리 이상 입력) " name="userPassword"
								maxlength="10" id="inputpass">
							<p class="fail"></p>
						</div>
						<!-- 로그인 -->
						<div class="form-group">
							<input type="submit" class="btn btn-primary form-control"
								value="로그인">
						</div>
					</form>
					<!-- 회원가입 기능 -->
					<div class="form-group">
						<input type="submit" class="btn btn-primary form-control"
							value="회원가입" onclick="location.href = 'registerView.do'">
					</div>
					<!-- 간편로그인  기능 -->
					<div class="form-group" >
						<ul>
							<li onclick="kakaoLogin();" class="login"
								style="width: 100%; height: 100%;"><a
								href="javascript:void(0)"> <img
									src="resource/img/kakao_login_medium_narrow.png">
							</a></li>
						</ul>
					</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-lg-4"></div>
	</div>
</html>