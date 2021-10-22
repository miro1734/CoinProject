<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<title>JSP 게시판 웹 사이트</title>
<style type="text/css">
	.login-search {
		float: right;
	}
	.login {
		list-style: none;
		text-align: center;
	}
</style>
<!-- 카카오 스크립트 -->
<script>
	Kakao.init('aa6a889a87bae28baa3a5afa0961871e'); //발급받은 키 중 javascript키를 사용해준다.
	console.log(Kakao.isInitialized()); // sdk초기화여부판단
	//카카오로그인
	function kakaoLogin() {
	    Kakao.Auth.login({
	      success: function (response) {
	        Kakao.API.request({
	          url: '/v2/user/me',
	          success: function (response) {
	        	  console.log(response)
	          },
	          fail: function (error) {
	            console.log(error)
	          },
	        })
	      },
	      fail: function (error) {
	        console.log(error)
	      },
	    })
	  }
	$(function(){
		$(".btnRegister").click(function(){
			location.href = "registerView.do";
		});
	});
</script>
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<a class="navbar-brand" href="main.jsp">다나와코인 게시판 웹사이트</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1"></div>
	</nav>
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbtron" style="padding-top: 20px;">
				<form method="post" action="login.do">
					<h3 style="text-align: center;">로그인화면</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디"
							name="userID" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호"
							name="userPassword" maxlength="20">
					</div>
					<div class="form-group">
						<input type="submit" class="btn btn-primary form-control"
							value="로그인">
					</div>
					<button type="button" class="btnRegister">회원가입</button>
				</form>
					<h4 style="text-align: center;">카카오간편로그인</h4>
					<ul>
					<li onclick="kakaoLogin();" class="login"><a
						href="javascript:void(0)"> <img
							src="resource/img/kakao_login_medium_narrow.png">
					</a></li>
				</ul>
			</div>
		</div>
	</div>
	<div class="col-lg-4"></div>
</body>
</html>