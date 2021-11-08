<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	*{
		margin:0 auto;
		padding:0;
		text-decoration: none;
	}
	textarea{
		width:600px;
		height:400px;
		box-sizing:border-box;
		resize:none;
	}
	form{
		margin:0 auto;
		width:601px;
	}
	h2{
		text-align: center;
		margin-bottom: 20px;
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
<c:choose>
				<c:when test="${sessionScope.code == 'KRW-BTC'}">
					<h2 class="coin_name">비트코인 게시판</h2>
				</c:when>
				<c:when test="${sessionScope.code == 'KRW-XRP'}">
					<h2 class="coin_name">리플 게시판</h2>
				</c:when>
				<c:when test="${sessionScope.code == 'KRW-OMG'}">
					<h2 class="coin_name">오미세고 게시판</h2>
				</c:when>
				<c:when test="${sessionScope.code == 'KRW-ETH'}">
					<h2 class="coin_name">이더리움 게시판</h2>
				</c:when>
				<c:when test="${sessionScope.code == 'KRW-ELF'}">
					<h2 class="coin_name">엘프 게시판</h2>
				</c:when>
				<c:when test="${sessionScope.code == 'KRW-DOGE'}">
					<h2 class="coin_name">도지코인 게시판</h2>
				</c:when>
				<c:when test="${sessionScope.code == 'KRW-EOS'}">
					<h2 class="coin_name">이오스 게시판</h2>
				</c:when>
				<c:when test="${sessionScope.code == 'KRW-XLM'}">
					<h2 class="coin_name">스텔라루멘 게시판</h2>
				</c:when>
				<c:when test="${sessionScope.code == 'KRW-MATIC'}">
					<h2 class="coin_name">폴리곤 게시판</h2>
				</c:when>
				<c:when test="${sessionScope.code == 'KRW-TRX'}">
					<h2 class="coin_name">트론 게시판</h2>
				</c:when>
			</c:choose>
	<form action="boardWrite.do" method="post">
		제목 : <input type="text" name="title" placeholder="제목을 입력하세요" style="width:550px;margin-bottom: 10px;">
		<input type="hidden" name="writer" value="${requestScope.board.writer}">
		<br>내용<br>
		<textarea name="bcontent" placeholder="내용을 입력하세요"></textarea><br>
		<button style="background-color:#767d83;color:#fff;border-color: #767d83;">작성</button>
		<button type="button" style="background-color: #f0ad4e;color:#fff;border-color: #eea236;" onclick="history.back();">취소</button>
	</form>
</body>
</html>