<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.15/jquery.bxslider.min.css" rel="stylesheet" /> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.15/jquery.bxslider.min.js"></script>
<script type="text/javascript">

// 뉴스 게시판 등록, 삭제시 ajax로 요청해서 json으로 값을 받아오고
// 받아온 값을 다시 배치하는 함수
function selectAllNews(r) {
	var str = "<h2>뉴스</h2>";
	str += "<div class='slider'>";
	for (i = 0; i < r.length; i++) {
		str += "<div class='news_container2'>";
		str += "<input name='nno' value=" + r[i].nno + " type='hidden'>";
		str += "<p class='ndate'>" + r[i].ndate + "</p>";
		str += "<p class='heardline'>" + r[i].headline + "</p>";
		str += "<a href='#' class='news_delete'>삭제</a>";
		str += "</div>";
		str += "<div class='blank'></div>";
	}
	str += "</div>";
	str += "<div class='news_write'>글쓰기</div>";
	str += "<form><input type='text' name='headline'>";
	str += "<button type='button' class='btn_news'>작성</button></form>";

	$(".news_container").html(str);
	$(".news_delete").click(news_delete);
	$(".news_write	").click(news_write);
	$(".btn_news").click(btn_news);
	
	 $(".slider").bxSlider({
	        pager : false,
	        mode : 'vertical',
	        auto : false,
	        speed : 200,
	        minSlides : 6,
	        infiniteLoop : false
	    });
}

// 뉴스 게시판 글 삭제하는 함수
function news_delete() {
	$(this).parent().wrap("<form></form>");
	var nno = $(this).parents("form").serialize();
	$(this).parent().unwrap();
	$.ajax({
		url : "delete.do",
		data : nno,
		dataType : "json",
		success : function(r) {
			selectAllNews(r);
		}
	});
}

// 뉴스 게시판 글쓰기 버튼을 누르면 글쓰는 부분이 생성되는 함수
function news_write() {
	$("form").css("display", "block");
}

// 뉴스 게시판 글쓰기 함수
function btn_news() {
	var data = $("form").serialize();
	$.ajax({
		url : "newsWrite.do",
		data : data,
		dataType : "json",
		success : function(r) {
			selectAllNews(r);
		}
	});
}

//3초마다 업비트 api 서버에서 가상화폐 시세를 요청하여 jsonArray로 받아오고
// 받아온 json데이터를 파싱하여 가상화폐 리스트 구현하는 함수
function coinList() {
	$.ajax({
        url: "https://api.upbit.com/v1/ticker?markets=KRW-BTC,KRW-XRP,KRW-OMG,KRW-ETH,KRW-ELF,KRW-DOGE,KRW-EOS,KRW-XLM,KRW-MATIC,KRW-TRX",
        data: "get",
        dataType: "json",
        success: function (d) {
            for (i = 0; i < 10; i++) {
                $(".market" + i).html(d[i].market);
                if (d[i].change == "RISE") {
                    $(".price" + i).html(d[i].trade_price).css("color", "red")
                    $(".change_rate" + i).html("+" + (d[i].change_rate * 100).toFixed(2) + "%").css("color", "red");
                    $(".change_price" + i).html(d[i].change_price).css("color", "red");
                }
                else {
                    $(".price" + i).html(d[i].trade_price).css("color", "blue");
                    $(".change_rate" + i).html("-" + (d[i].change_rate * 100).toFixed(2) + "%").css("color", "blue");
                    $(".change_price" + i).html("-" + d[i].change_price).css("color", "blue");
                }
            }
        }
    });
}

// 실시간 채팅 처리 부분
var chat_id = "${sessionScope.client.id}";	
var webSocket = new WebSocket("ws://localhost:9999/ws/login.do"); // 웹소켓 핸드쉐이크 연결

function enterKey() { // 엔터키를 누르면 채팅을 전송하는 부분
	$(".input_message").keyup(function(){
		if (event.keyCode == 13) {
			if ($(this).val() != "")			
				send();
		}
	});
}
function onMessage(msg) {
	var data = msg.data;
	var sessionId = null;
	var message = null;
	var arr = data.split(":");
	/* for (i = 0; i <arr.length; i++) {  -메시지가 제대로 파싱되나 확인용이었음
		console.log("arr[" + i + "]:" + arr[i]);
	} */
	sessionId = arr[0]; // 파싱된 클라이언트 이름
	message = arr[1]; // 파싱된 메시지
	var str = "<div class = 'box_msg'>";
	str += sessionId + " : " + message;
	str += "</div>";	
	$(".message_window").append(str);
	$(".message_window").scrollTop(10000);
}

function send() { // 채팅을 보내는 부분
	webSocket.send(chat_id + ":" + $(".input_message").val());
	$(".input_message").val("");
}

$(function () {
	webSocket.onmessage = onMessage;
	coinList();
	enterKey();
	setInterval(coinList, 500);
    $(".news_write	").click(news_write);
    $(".btn_news").click(btn_news);
    $(".news_delete").click(news_delete);
    
    $(".slider").bxSlider({
        pager : false,
        mode : 'vertical',
        auto : false,
        speed : 200,
        maxSlides : 5,
        minSlides : 6,
        infiniteLoop : false
    });
    
    $("#KRW-BTC").click(function(){
    	location.href = "coinInfo.do?code=KRW-BTC&name=비트코인";
    });
    $("#KRW-XRP").click(function(){
    	location.href = "coinInfo.do?code=KRW-XRP&name=리플";
    });
    $("#KRW-OMG").click(function(){
    	location.href = "coinInfo.do?code=KRW-OMG&name=오미세고";
    });
    $("#KRW-ETH").click(function(){
    	location.href = "coinInfo.do?code=KRW-ETH&name=이더리움";
    });
    $("#KRW-ELF").click(function(){
    	location.href = "coinInfo.do?code=KRW-ELF&name=엘프";
    });
    $("#KRW-DOGE").click(function(){
    	location.href = "coinInfo.do?code=KRW-DOGE&name=도지코인";
    });
    $("#KRW-EOS").click(function(){
    	location.href = "coinInfo.do?code=KRW-EOS&name=이오스";
    });
    $("#KRW-XLM").click(function(){
    	location.href = "coinInfo.do?code=KRW-XLM&name=스텔라루멘";
    });
    $("#KRW-MATIC").click(function(){
    	location.href = "coinInfo.do?code=KRW-MATIC&name=폴리곤";
    });
    $("#KRW-TRX").click(function(){
    	location.href = "coinInfo.do?code=KRW-TRX&name=트론";
    });
});
</script>
<style type="text/css">
	@font-face {
		font-family: 'NotoSansKR';
		src: url("/resource/fonts/NotoSansKR-Regular.otf");
	}
	* {
            margin: 0;
            padding: 0;
            font-family: NotoSansKR;
            text-decoration: none;
        }

        table {
            width: 1200px;
            text-align: center;
            border-collapse: collapse;
            margin-top: 15px;
        }

        td {
            border-bottom: 1px solid #e9e9e9;
            padding: 10px;
            width: 130px;
            height: 45px;
            box-sizing: border-box;
        }

        td p {
            font-size: 10px;
        }
        .news_container2 {
        	background-color: #f5f5f5;
        	width: 100%;
        	height: 100px;
        	padding: 15px;
        	box-sizing: border-box;
        	border-radius: 10px;
        }
        .bx-wrapper {
        	width: 600px;
        	height: 330px;
        	border: none;
            box-shadow: none;
            margin-bottom: 0;
     	}
     	.news_container {
     		width: 600px;
     		height: 330px;
     		border-radius: 5px;
     	}
        .ndate {
        	color: #c9c9c9;
        	font-size: 14px;
        }
        .heardline {
        	font-size: 20px;
        	margin-top: 12px;
        }
        .blank {
        	height: 10px;
        }
       .bx-wrapper .bx-controls-direction a {
       		top : -20px;
       		transform:rotate(90deg);
       }
       .bx-wrapper .bx-next {
       		right: 10px;
       }
       .bx-wrapper .bx-prev {
       		left : 500px;
       }
       form {
       		display: none;
       }
       .main_container {
      		width: 1600px;
       		display: flex;
       		justify-content: space-between;
       		padding: 40px;
       }
       .sub_container {
       	height: 648px;
       }
       .chat_container {
       	margin-top : 20px;
       	box-sizing : border-box;
       	height: 260px;
       	border: 1px solid #e9e9e9;
       	padding: 10px;
       	border-radius: 5px;
       }
       .price_container {
       margin-left: 30px;
       	border: 1px solid #e9e9e9;
       	box-sizing: border-box;
       	padding: 8px;
       	height: 658px;
       	border-radius: 5px;
       }
       fieldset {
       	height: 175px;
       	border: none;
       }
       .box_msg {
       	height: 21px;	
       }
       .slider {
       	height: 330px;
       }
       .message_window {
       	height: 100%;
       	overflow: scroll;
       	overflow-x: hidden;
       	border-top: 1px solid #e9e9e9;
       }
       .news_container {
       	border: 1px solid #e9e9e9;
       	padding: 8px;
       	height: 360px;
       }
       h2 {
       	margin-bottom: 2px;
       	color: #c4c4c4;
       }
       .input_message {
       	width: 100%;
       	height: 25px;
       	border-radius: 8px;
       	background-color: #f5f5f5;
       	border: none;
       	margin-top: 5px;
       	box-sizing: border-box;
       	
       }
</style>
</head>
<body>
<c:if test="${sessionScope.client == null }">
		<script type="text/javascript">
			alert("세션 만료");
			location.href="/";
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
<div class="main_container">
	<div class="sub_container">
	    <div class="news_container">
	        <h2>코인 뉴스</h2>
	        <div class="slider">
		        <c:forEach var="news" items="${requestScope.news}">
			        	<div class="news_container2">
				        		<input name="nno" value="${news.nno}" type="hidden">
					        	<p class="ndate">${news.ndate}</p>
					        	<p class="heardline">${news.headline}</p>
		        		</div>
		        		<div class="blank"></div>
		        </c:forEach>
		    </div>
	    </div>
		<div class="chat_container">
			<h2>채팅</h2>
			<fieldset>
					<div class="message_window">
					</div>
				<input type="text" class="input_message" placeholder="   메시지를 입력해주세요.">
			</fieldset>
		</div>
	</div>
	<div class="price_container">
        <h2>실시간 시세</h2>
        <table>
        	<tr>
        		<th>종목</th>
        		<th>현재가</th>
        		<th>등락률</th>
        		<th>등락가</th>
        	</tr>
            <tr>
                <td><b id="KRW-BTC">비트코인</b><br>
                    <p class="market0"></p>
                </td>
                <td class="price0"></td>
                <td class="change_rate0"></td>
                <td class="change_price0"></td>
            </tr>
            <tr>
                <td><b id="KRW-XRP">리플</b><br>
                    <p class="market1"></p>
                </td>
                <td class="price1"></td>
                <td class="change_rate1"></td>
                <td class="change_price1"></td>
            </tr>
            <tr>
                <td><b id="KRW-OMG">오미세고</b><br>
                    <p class="market2"></p>
                </td>
                <td class="price2"></td>
                <td class="change_rate2"></td>
                <td class="change_price2"></td>
            </tr>
            <tr>
                <td><b id="KRW-ETH">이더리움</b><br>
                    <p class="market3"></p>
                </td>
                <td class="price3"></td>
                <td class="change_rate3"></td>
                <td class="change_price3"></td>
            </tr>
            <tr>
                <td><b id="KRW-ELF">엘프</b><br>
                    <p class="market4"></p>
                </td>
                <td class="price4"></td>
                <td class="change_rate4"></td>
                <td class="change_price4"></td>
            </tr>
            <tr>
                <td><b id="KRW-DOGE">도지코인</b><br>
                    <p class="market5"></p>
                </td>
                <td class="price5"></td>
                <td class="change_rate5"></td>
                <td class="change_price5"></td>
            </tr>
            <tr>
                <td><b id="KRW-EOS">이오스</b><br>
                    <p class="market6"></p>
                </td>
                <td class="price6"></td>
                <td class="change_rate6"></td>
                <td class="change_price6"></td>
            </tr>
            <tr>
                <td><b id="KRW-XLM">스텔라루멘</b><br>
                    <p class="market7"></p>
                </td>
                <td class="price7"></td>
                <td class="change_rate7"></td>
                <td class="change_price7"></td>
            </tr>
            <tr>
                <td><b id="KRW-MATIC">폴리곤</b><br>
                    <p class="market8"></p>
                </td>
                <td class="price8"></td>
                <td class="change_rate8"></td>
                <td class="change_price8"></td>
            </tr>
            <tr>
                <td><b id="KRW-TRX">트론</b><br>
                    <p class="market9"></p>
                </td>
                <td class="price9"></td>
                <td class="change_rate9"></td>
                <td class="change_price9"></td>
            </tr>
        </table>
    </div>
</div>
</body>
</html>