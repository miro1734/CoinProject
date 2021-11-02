<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://code.highcharts.com/stock/highstock.js"></script>
<script src="https://code.highcharts.com/stock/modules/exporting.js"></script>
<script type="text/javascript">
var timeCase = "minutes/";
var time = 5;
var code = "${requestScope.code}";
var name;
var coin;
var money;
var count;
var positionMoney = Number("${requestScope.positionMoney}");
var clientMoney = Number("${sessionScope.clinet.krw}");
var position_coin_count = Number("${requestScope.positionCount}");
var now_money = Number("${requestScope.now_money}");

function coinPrice() { // 코인의 현재 가격을 불러오는 부분
	$.ajax({
		url : "https://api.upbit.com/v1/ticker?markets=" + code,
		data : "get",
		dataType : "json",
		success : function(r) {
			$("#trade_price").val(r[0].trade_price);
			$(".allMoney").html(Math.floor(now_money + (r[0].trade_price * position_coin_count)) + " KRW");
			if (r[0].change == "RISE") {
				$(".coin_price").html(r[0].trade_price + " KRW").css("color", "red");
				$(".coin_rate").html("+" + (r[0].change_rate * 100).toFixed(2) + "%").css("color", "red");	
				$(".coin_change_price").html("(▲" + r[0].change_price + " )").css("color", "red");
			} else {
				$(".coin_price").html(r[0].trade_price + " KRW").css("color", "blue");
				$(".coin_rate").html("-" + (r[0].change_rate * 100).toFixed(2) + "%").css("color", "blue");	
				$(".coin_change_price").html("(▼" + r[0].change_price + " )").css("color", "blue");
			}
			$(".high_price").html(r[0].high_price + "&nbsp;").css("color", "red");
			$(".low_price").html(r[0].low_price + "&nbsp;").css("color", "blue");
			$(".close_price").html("전일가 " + r[0].prev_closing_price);
		}
	});
}
function timeControll() { // 분봉, 일봉 버튼
	$("#5_minute").css("background-color", "#c4c4c4");
	$("#1_minute").click(function(){
		timeCase = "minutes/";
		time = 1;
		$(".btn_container").children("button").css("background-color", "#f5f5f5");
		$(this).css("background-color", "#c4c4c4");
	});
	$("#5_minute").click(function(){
		timeCase = "minutes/";
		time = 5;
		$(".btn_container").children("button").css("background-color", "#f5f5f5");
		$(this).css("background-color", "#c4c4c4");
	});
	$("#15_minute").click(function(){
		timeCase = "minutes/";
		time = 15;
		$(".btn_container").children("button").css("background-color", "#f5f5f5");
		$(this).css("background-color", "#c4c4c4");
	});
	$("#1_hour").click(function(){
		timeCase = "minutes/";
		time = 60;
		$(".btn_container").children("button").css("background-color", "#f5f5f5");
		$(this).css("background-color", "#c4c4c4");
	});
	$("#4_hour").click(function(){
		timeCase = "minutes/";
		time = 240;
		$(".btn_container").children("button").css("background-color", "#f5f5f5");
		$(this).css("background-color", "#c4c4c4");
	});
	$("#1_day").click(function(){
		timeCase = "days/";
		time = "";
		$(".btn_container").children("button").css("background-color", "#f5f5f5");
		$(this).css("background-color", "#c4c4c4");
	});
}
function bitChart(){ // 받아온 json 데이터로 캔들스틱 차트를 구현하는 부분
	var chartdata = [];
	$.getJSON("https://api.upbit.com/v1/candles/"+timeCase+time+"?market="+ code +"&count=100", function (data) {
		$.each(data, function(i, item){
			chartdata.push([item.timestamp, item.opening_price, item.high_price, item.low_price, item.trade_price]);
		});
	}).done(function(){
		Highcharts.stockChart('chart_container',{
			title: {
				text: name
			},
			chart: {
				width : 1400,
				height : 500
		    },
		    xAxis: [{
		    	type: 'datetime',
		    	width : 1330
	         }],
		    credits: {
		        enabled: false
		    },
		    navigator: {
		        enabled: false
		    },
		    scrollbar: {
		        enabled: false
		    },
		    navigation: {
		        buttonOptions: {
		            enabled: false
		        }
		    },
			plotOptions: {
				candlestick: {
					downColor: 'blue',
					upColor: 'red'
				}
			},
			rangeSelector: {
				enabled: false	
			},
			series: [{
				name: name,
				type: 'candlestick',
				data: chartdata
			}]
		});
	});
}

function refresh_position_count() {
	location.href="refreshPositionCount.do";
}

function buy_order() { // 매수 처리 기능
		$("#btn_order_buy").hover(function(){ // 주문하기 버튼
		$(this).css("background-color", "red").css("color", "white");
	}).mouseleave(function(){
		$(this).css("background-color", "#e9e9e9").css("color", "c4c4c4");
	}).click(function(){
		count = $("#buy_count").html();
		var id = "${sessionScope.client.id}";
		var price = $("#buy_money").html();
		var trade_price = $("#trade_price").val();
		$.ajax({
			url : "coinBuy.do?code="+code+"&count="+count+"&id="+id+"&price="+price + "&trade_price=" + trade_price,
			type : "get",
			dataType : "json",
			success : function(r) {
				alert(r.message);
				refresh_position_count();
				buy_click();
				buy_order();
				sell_click();
				order_10();
				order_25();
				order_50();
				order_100();
				order_self();
				location.reload();
			}
		});
	});
}
function order_10() {
	$(".btn_10").click(function(){ // 버튼 클릭시 가진 돈의 비율로 구매할 수 있는 계산기 부분
		coin = $("#trade_price").val();
		money = Math.floor(${requestScope.now_money} / 10);
		if (${sessionScope.client.krw + requestScope.positionMoney} < coin) {
				count = (money / coin).toFixed(8);
		} else {
			count = Math.floor(money / coin);
		}
		$("#trade_qu_buy").val(count);
		$("#buy_count").html(count);
		$("#buy_money").html(Math.floor(count * coin));
		if ($("#buy_money").html() > money) { // 단가가 비싼 코인 소수점 구매시 보유금액을 초과하지 않게 처리하는 부분
			$("#buy_money").html(money);
			$("#buy_count").html($("#trade_qu_buy").val());
		}
	});
}
function order_25() {
	$(".btn_25").click(function(){
		coin = $("#trade_price").val();
		money = ${requestScope.now_money} / 4;
		if (${sessionScope.client.krw + requestScope.positionMoney} < coin) {
				count = (money / coin).toFixed(8);
		} else {
			count = Math.floor(money / coin);
		}
		$("#trade_qu_buy").val(count);
		$("#buy_count").html(count);
		$("#buy_money").html(Math.floor(count * coin));
		if ($("#buy_money").html() > money) { // 단가가 비싼 코인 소수점 구매시 보유금액을 초과하지 않게 처리하는 부분
			$("#buy_money").html(money);
			$("#buy_count").html($("#trade_qu_buy").val());
		}
	});
}
function order_50() {
	$(".btn_50").click(function(){
		coin = $("#trade_price").val();
		money = ${requestScope.now_money} / 2;
		if (${sessionScope.client.krw + requestScope.positionMoney} < coin) {
				count = (money / coin).toFixed(8);
		} else {
			count = Math.floor(money / coin);
		}
		$("#trade_qu_buy").val(count);
		$("#buy_count").html(count);
		$("#buy_money").html(Math.floor(count * coin));
		if ($("#buy_money").html() > money) { // 단가가 비싼 코인 소수점 구매시 보유금액을 초과하지 않게 처리하는 부분
			$("#buy_money").html(money);
			$("#buy_count").html($("#trade_qu_buy").val());
		}
	});
}
function order_100() {
	$(".btn_100").click(function(){ 
		coin = $("#trade_price").val();
		money = ${requestScope.now_money};
		if (${sessionScope.client.krw + requestScope.positionMoney} < coin) {
				count = (money / coin).toFixed(8);
		} else {
			count = Math.floor(money / coin);
		}
		$("#trade_qu_buy").val(count);
		$("#buy_count").html(count);
		$("#buy_money").html(Math.floor(count * coin));
		if ($("#buy_money").html() > money) { // 단가가 비싼 코인 소수점 구매시 보유금액을 초과하지 않게 처리하는 부분
			$("#buy_money").html(money);
			$("#buy_count").html($("#trade_qu_buy").val());
		}
	});
}
function order_self() {
	$("#trade_qu_buy").change(function(){ // 구매할 수량 직접 입력시 처리하는 부분
		coin = $("#trade_price").val();
		count = $(this).val();
		if (count < 0) {
			$(this).val(0);
			coin = 0;
			count = 0;
		}
		money = ${requestScope.now_money};
		if (money < (count * coin)) {
			if (${sessionScope.client.krw + requestScope.positionMoney} < coin) {
				count = (money / coin).toFixed(8);
		} else {
			count = Math.floor(money / coin);
		}
		$("#buy_count").html(count);
		$("#buy_money").html(Math.floor(count * coin));
		$("#trade_qu_buy").val(count);
		} else {
		$("#buy_count").html($("#trade_qu_buy").val());
		$("#buy_money").html(Math.floor(count * coin));
		}
	});
}
function buy_click() {
	$("#btn_buy").click(function(){
		$(".order_container").html("<button id='btn_order_buy'>주문하기</button>");
		$(".trade_container").html("<input type='number' id='trade_qu_buy' min='0'><button type='button' id='plus2'>+</button><button type='button' id='minus2'>-</button>");
		$(this).css("background-color", "red").css("color", "white");
		$("#btn_sell").css("background-color", "#e9e9e9").css("color", "black");
		$(".have_money").html(${sessionScope.client.krw}+ " KRW");
		$(".buy_or_sell").html("매수가능");
		$(".count_buy_sell").html("매수 수량");
		
		order_10();
		order_25();
		order_50();
		order_100();
		order_self();
		$(".have_money").html(${requestScope.now_money} + " KRW");
		sell_click();
		buy_order();
	});
}
function sell_click() {
	$("#btn_sell").click(function(){
		$(".order_container").html("<button id='btn_order_sell'>주문하기</button>");
		$(".trade_container").html("<input type='number' id='trade_qu_sell' min='0'><button type='button' id='plus2'>+</button><button type='button' id='minus2'>-</button>");
		$(this).css("background-color", "blue").css("color", "white");
		$("#btn_buy").css("background-color", "#e9e9e9").css("color", "black");
		$(".buy_or_sell").html("매도가능");
		$(".have_money").html(Math.floor((Number($("#trade_price").val() * position_coin_count))) + " KRW");
		$(".count_buy_sell").html("매도 수량");
		
		$(".btn_10").click(function(){
				coin = $("#trade_price").val();
				if (positionMoney < coin) {
					count = position_coin_count / 10;
					money = (count * coin).toFixed(8);
				} else {
					count = Math.floor(position_coin_count / 10);
					money = Math.floor(money * coin);
				}
				$("#trade_qu_sell").val(count);
				$("#buy_count").html(count);
				$("#buy_money").html(Math.floor(count * coin));
		});
		$(".btn_25").click(function(){
			coin = $("#trade_price").val();
			if (positionMoney < coin) {
				count = position_coin_count / 4;
				money = (count * coin).toFixed(8);
			} else {
				count = Math.floor(position_coin_count / 4);
				money = Math.floor(money * coin);
			}
			$("#trade_qu_sell").val(count);
			$("#buy_count").html(count);
			$("#buy_money").html(Math.floor(count * coin));
		});
		$(".btn_50").click(function(){
			coin = $("#trade_price").val();
			if (positionMoney < coin) {
				count = position_coin_count / 2;
				money = (count * coin).toFixed(8);
			} else {
				count = Math.floor(position_coin_count / 2);
				money = Math.floor(money * coin);
			}
			$("#trade_qu_sell").val(count);
			$("#buy_count").html(count);
			$("#buy_money").html(Math.floor(count * coin));
		});
		$(".btn_100").click(function(){
			coin = $("#trade_price").val();
			if (positionMoney < coin) {
				count = position_coin_count;
				money = (count * coin).toFixed(8);
			} else {
				count = Math.floor(position_coin_count);
				money = Math.floor(money * coin);
			}
			$("#trade_qu_sell").val(count);
			$("#buy_count").html(count);
			$("#buy_money").html(Math.floor(count * coin));
		});
		$("#trade_qu_sell").change(function(){ // 구매할 수량 직접 입력시 처리하는 부분
			coin = $("#trade_price").val();
			money = Math.floor(positionMoney);
			count = $(this).val();
			if (count < 0) {
				$(this).val(0);
				coin = 0;
				count = 0;
			}
			if (count > position_coin_count) {
				if (positionMoney < coin) {
					count = (money / coin).toFixed(8);
			} else {
				count = position_coin_count;
			}
				$("#buy_count").html(count);
				$("#buy_money").html(Math.floor(count * coin));
				$("#trade_qu_sell").val(count);
				} else {
				$("#buy_count").html($("#trade_qu_sell").val());
				$("#buy_money").html(Math.floor(count * coin));
			}
		});
		$("#btn_order_sell").hover(function(){ // 매도하기 버튼
			$(this).css("background-color", "blue").css("color", "white");
		}).mouseleave(function(){
			$(this).css("background-color", "#e9e9e9").css("color", "c4c4c4");
		}).click(function(){
			count = $("#buy_count").html();
			var id = "${sessionScope.client.id}";
			var price = $("#buy_money").html();
			$.ajax({
				url : "coinSell.do?code="+code+"&count="+count+"&id="+id+"&price="+price,
				type : "get",
				dataType : "json",
				success : function(r) {
					alert(r.message);
					refresh_position_count();
					buy_click();
					buy_order();
					order_10();
					order_25();
					order_50();
					order_100();
					order_self();
					sell_click();
					$(".allMoney").html(Number(r.memberMoney) + Number(r.positionMoney));
					$(".have_money").html(r.money);
					location.reload();
				}
			});
		});
	});
}
$(function(){
	checkIno();
	timeControll();
	coinPrice();
	bitChart();
	setInterval(bitChart, 500);
	setInterval(coinPrice, 500);
	buy_order();
	order_10();
	order_25();
	order_50();
	order_100();
	order_self();
	buy_click();
	sell_click();
});
function insertFavoriteCoin() {
	$(".icon_star").click(function(){ // 관심 종목 지정하는 아이콘
		$.ajax({
			url : "insertFavoriteCoin.do",
			dataType: "json",
			success : function(r) {
				if(r.favoriteCoins != null) {
					$(".favorite_container").html(r.html);
				}
				alert(r.message);
				deleteFavoriteCoin();
			}
		});
	});
}
function deleteFavoriteCoin() {
	$(".icon_check_star").click(function(){
		$.ajax({
			url : "deleteFavoriteCoin.do",
			dataType: "json",
			success : function(r) {
				if(r.favoriteCoins != null) {
					$(".favorite_container").html(r.html);
				}
				alert(r.message);
				insertFavoriteCoin();
			}
		});
	});
}

function checkIno() { // 코인인포 페이지 들어갔을 때 코인이 관심종목인지 아닌지 체크하는 부분
	var ino = "${requestScope.favoriteCoins[0]}";
	if(ino != 0) {
		$(".favorite_container").html("<img src='/resource/img/check_star.png' class='icon_check_star'>");
		deleteFavoriteCoin();
	}
	else {
		$(".favorite_container").html("<img src='/resource/img/star.png' class='icon_star'>");
		insertFavoriteCoin();
	}
}
</script>
<style type="text/css">
	* {
		margin: 0;
		padding: 0;
	}
	.btn_container {
		height: 100%;
		box-sizing: border-box;
		position: absolute;
		z-index: 100;
		left: 50px;
		margin-top: 20px;
	}
	.btn_container button {
		width: 100px;
		height: 30px;
		box-sizing: border-box;
		border: none;
		background-color: #f5f5f5;
		border-radius: 5px;
	}
	#5_minute {
		background-color: #c4c4c4;
	}
	#chart_container {
		max-width: 1400px;
		border: 1px solid #e9e9e9;
		border-radius: 10px;
	}
	.trade_view {
		width : 400px;
		height : 500px;
		text-align: center;
		margin-right: 10px;
	}
	#btn_buy, #btn_sell {
		width: 50%;
		height: 50px;
		border: none;
		font-size: 20px;
	}
	#btn_buy {
		background-color: red;
		color: white;
		border-top-left-radius: 10px;
		border-bottom-left-radius: 10px;
	}
	#btn_sell {
		background-color: #e9e9e9;
		color: black;
		border-top-right-radius: 10px;
		border-bottom-right-radius: 10px;
	}
	.main_container {
		display: flex;
		justify-content: space-around;
		margin-bottom: 20px;
	}
	.have_krw {
		display : flex;
		justify-content: space-between;
		margin-top: 15px;
	}
	.order_krw {
		display : flex;
		justify-content: space-between;
		margin-top: 5px;
	}
	.have_krw :first-child {
		font-weight: bold;
		font-size: 20px;
	}
	#trade_price {
		width: 100%;
		height: 100%;
		box-sizing: border-box;
		border: none;
		font-weight: bold;
		font-size: 20px;
		text-align: center;
	}
	#trade_qu_buy, #trade_qu_sell{
		width: 80%;
		height: 100%;
		box-sizing: border-box;
		border: none;
		font-weight: bold;
		font-size: 20px;
		text-align: right;
		padding-right: 10px;
	}
	#plus1, #plus2, #minus1, #minus2 {
		width: 10%;
		height: 100%;
		border: none;
		border-left: 1px solid #c4c4c4;
	}
	.trade_container, .trade_container_price {
		border: 1px solid #c4c4c4;
		height: 50px;
		margin-top: 10px;
		border-radius: 10px;
	}
	#price {
		text-align: left;
		margin-top: 20px;
		font-weight: bold;
		font-size: 20px;
	}
	.qu_container {
		width: 100%;
		height: 30px;
		display :flex;
		box-sizing: border-box;
		border: 1px solid #c4c4c4;
		justify-content: space-between;
		margin-top: 8px;
		border-radius: 10px;
	}
	.qu_container button {
		width: 25%;
		border: none;
	}
	#btn_order_buy, #btn_order_sell {
		width: 100%;
		height: 55px;
		border : none;
		border-radius: 10px;
		margin-top: 5px;
		font-weight: bold;
		font-size: 30px;
		color : white;
		background-color: #e9e9e9;
	}
	#order_price {
		text-align: left;
	}
	#order_qu {
		text-align: left;
	}
	.info_container {
		border: 1px solid #e9e9e9;
		width: 71.1%;
		padding: 15px;
		box-sizing: border-box;
		display: flex;
		flex-direction: column;
		margin: 10px;
		margin-left: 43px;
		border-radius: 10px;
	}
	.icon_star, .icon_check_star {
		width: 30px;
	}
	.favorite_container {
		position: relative;
		height: 30px;
		margin-top: 7px;
		margin-left: 5px;
	}
	.coin_rate {
		margin-top: 10px;
		margin-left: 5px;
	}
	.coin_change_price {
		margin-top: 10px;
		margin-left: 5px;
	}
/* 예찬님 css ----------------------------------------------------------------------------------- */
table{
		border-collapse: collapse;
		margin:0 auto;
	}
	th, td{
		padding:5px 10px;
		text-align: center;
		font-size: 1.3rem;
	}
	.board_container:hover{
		background-color: #bdbdbd;
	}
</style>
</head>
<body>
<c:if test="${sessionScope.client == null }">
		<script type="text/javascript">
			alert("세션 만료");
			location.href("/");
		</script>
</c:if>
<header style="border-bottom:1px solid #c4c4c4;margin-bottom:40px;">
	<div style="display:inline;">
		<a href="login.do"><img alt="" src="resource/img/logo.png" style="width:200px;height:70px;"></a>
	</div>
	<div style="display:inline;float: right;margin-top:10px;margin-right:10px;">
		<a href="mypageView.do" style="margin:0px;color: blue;">${sessionScope.client.id }</a>님이 로그인하셨습니다.<br>
		<a href="logout.do" style="float: right;margin-right:0px;color: red;margin-top:10px;">로그아웃</a>
	</div>
</header>
	<div class="info_container">
		<div style="display: flex; flex-direction: row">
			<c:choose>
				<c:when test="${requestScope.code == 'KRW-BTC'}">
					<h1 class="coin_name">비트코인</h1>
				</c:when>
				<c:when test="${requestScope.code == 'KRW-XRP'}">
					<h1 class="coin_name">리플</h1>
				</c:when>
				<c:when test="${requestScope.code == 'KRW-OMG'}">
					<h1 class="coin_name">오미세고</h1>
				</c:when>
				<c:when test="${requestScope.code == 'KRW-ETH'}">
					<h1 class="coin_name">이더리움</h1>
				</c:when>
				<c:when test="${requestScope.code == 'KRW-ELF'}">
					<h1 class="coin_name">엘프</h1>
				</c:when>
				<c:when test="${requestScope.code == 'KRW-DOGE'}">
					<h1 class="coin_name">도지코인</h1>
				</c:when>
				<c:when test="${requestScope.code == 'KRW-EOS'}">
					<h1 class="coin_name">이오스</h1>
				</c:when>
				<c:when test="${requestScope.code == 'KRW-XLM'}">
					<h1 class="coin_name">스텔라루멘</h1>
				</c:when>
				<c:when test="${requestScope.code == 'KRW-MATIC'}">
					<h1 class="coin_name">폴리곤</h1>
				</c:when>
				<c:when test="${requestScope.code == 'KRW-TRX'}">
					<h1 class="coin_name">트론</h1>
				</c:when>
			</c:choose>
			<div class="favorite_container">
				<img src="/resource/img/star.png" class="icon_star">
			</div>
		</div>
			<div style="display: flex; flex-direction: row">
				<h1 class="coin_price"></h1>
				<span class="coin_rate"></span>
				<span class="coin_change_price"></span>
			</div>
			<div style="display: flex; flex-direction: row;">
				<span>고가&nbsp;</span>
				<span class="high_price"></span>
				<span>저가&nbsp;</span>
				<span class="low_price"></span>
				<span class="close_price"></span>
			</div>
	</div>
	<div class="main_container">
		<div class="btn_container">
			<button type="button" id="1_minute">1분</button>
			<button type="button" id="5_minute">5분</button>
			<button type="button" id="15_minute">15분</button>
			<button type="button" id="1_hour">1시간</button>
			<button type="button" id="4_hour">4시간</button>
			<button type="button" id="1_day">1일</button>
		</div>
		<div id="chart_container"></div>
		<div class="trade_view">
			<button type="button" id="btn_buy">매수</button><button type="button" id="btn_sell">매도</button>
			<div class="have_krw">
				<span>보유자산</span><span class="allMoney">  KRW</span>
			</div>
			<div class="have_krw">
				<span class="buy_or_sell">매수가능</span><span class="have_money">${requestScope.now_money} KRW</span>
			</div>
			<p id="price">가격</p>
			<div class="trade_container_price">
			<input type="text" id="trade_price" readonly="readonly">
			</div>
			<p id="price">수량</p>
			<div class="trade_container">
				<input type="number" id="trade_qu_buy" min="0">
			</div>
			<div class="qu_container">
				<button type="button" class="btn_10">10%</button>
				<button type="button" class="btn_25">25%</button>
				<button type="button" class="btn_50">50%</button>
				<button type="button" class="btn_100">100%</button>
			</div>
			<div class="order_krw">
				<span>주문 금액</span><span id="buy_money">0 KRW</span>
			</div>
			<div class="order_krw">
				<span class="count_buy_sell">매수 수량</span><span id="buy_count">-</span>
			</div>
			<div class="order_container">
				<button id="btn_order_buy">주문하기</button>
			</div>
		</div>
	</div>
<!-- ---------------------예찬님 body ------------------------------------------------------------------ -->
	
	<hr>
	
	<table>
	
	<tr style="border-bottom:1px solid #c4c4c4;background-color: #e0e0e0;">
		<th style="width:200px;">제목</th>
		<th style="width:100px;">글쓴이</th>
		<th>날짜</th>
		<th>조회수</th>
		<th style="color:blue;">좋아요</th>
		<th style="color:red;">싫어요</th>
	</tr>
	
		
	<c:forEach var="board" items="${requestScope.list }" >
	<tr class="board_container"> 
		<td style="display:none;">${board.bno }</td>
		<td><a href="boardView.do?bno=${board.bno }" style="color:black;">${board.title }</a></td>
		<td>${board.writer }</td>
		<td>${board.bdate }</td>
		<td>${board.bcount }</td>
		<td style="color: blue;">${board.blike }</td>
		<td style="color:red;">${board.bhate }</td>
	</tr>
	</c:forEach>
	<!-- 페이징 처리 -->
	<tr>
		<td colspan="7" style="background-color: #e0e0e0;">
			<c:if test="${requestScope.pagging.priviousPageGroup }">
				<a href="coinInfo.do?pageNo=${requestScope.pagging.startPageOfPageGroup-1}&code=${requestScope.code}"><<</a>			
			</c:if>			
			<c:forEach var="i" begin="${requestScope.pagging.startPageOfPageGroup}" end="${requestScope.pagging.endPageOfPageGroup}">
				<c:choose>
					<c:when test="${i == requestScope.pagging.currentPageNo }">
						${i }
					</c:when>
					<c:otherwise>
						<a href="coinInfo.do?pageNo=${i}&code=${requestScope.code}" style="color: blue;">${i }</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${requestScope.pagging.nextPageGroup }">
				<a href="coinInfo.do?pageNo=${requestScope.pagging.endPageOfPageGroup+1 }&code=${requestScope.code}">>></a>			
			</c:if>			
		</td>
	</tr>
	<tr>
		<td colspan="6" style="background-color: #9e9e9e;">
			<a href="boardWriteView.do" style="color:#fff;">글쓰기</a>
		</td>
	</tr>
	</table>
</body>
</html>