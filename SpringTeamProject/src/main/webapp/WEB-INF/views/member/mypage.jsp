<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
var tag = "";
<c:forEach var="plist" items="${requestScope.plist}" end="${requestScope.plist.size()}">
	<c:if test="${plist.COUNT != 0}">
		tag += "${plist.CODE},";
	</c:if>
</c:forEach>
		tag = tag.slice(0,-1);
function positionCoin() {
	$.ajax({
		url : "https://api.upbit.com/v1/ticker?markets=" + tag,
		data: "get",
        dataType: "json",
        success : function(d) {
        	for (i = 0; i < d.length; i++) {
        		var mp = $(".plist_container").children().eq(i).val();
        		var result = ((d[i].trade_price - mp) / mp * 100).toFixed(2);
        		if (result > 0) {
	        		$(".position_table").children().children("tr").eq(i + 1).children("td").eq(1).html("+" + result + "%")
	        		.css("color", "red");
        		} else {
        			$(".position_table").children().children("tr").eq(i + 1).children("td").eq(1).html(result + "%")
	        		.css("color", "blue");
        		}
        	}
        }
	});
}
function coinList() {
	$.ajax({
        url: "https://api.upbit.com/v1/ticker?markets=KRW-BTC,KRW-XRP,KRW-OMG,KRW-ETH,KRW-ELF,KRW-DOGE,KRW-EOS,KRW-XLM,KRW-MATIC,KRW-TRX",
        data: "get",
        dataType: "json",
        success: function (d) {
        	for (i = 0; i < 10; i++) {
        		$(".plist_container").children().eq(i).addClass("eq" + i)
        		tp = d[i].trade_price;
               $(".market" + i).html(d[i].market);
                if (d[i].change == "RISE") {
                    $(".price" + i).html(d[i].trade_price).css("color", "red");
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
$(function () {	
	coinList();
	positionCoin();
	setInterval(coinList, 1000);
	setInterval(positionCoin, 1000);
	favorite_delete();
	
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

function favorite_delete() {
	$(".icon_check_star").click(function() {
		var data = $(this).parent().parent().find(".frm_favorite").serialize();
		$.ajax({
			url : "favoritedelete.do",
			data : data,
			dataType:"json",
			type:"get",
			success:function(r){
				alert("관심코인이 삭제 되었습니다.");
				location.reload();
			}
		});
	});
}
</script>
<style type="text/css">
	
	* {
            margin: 0;
            padding: 0;
            font-family: NotoSansKR;
            text-decoration: none;
      }
      .container{
      	margin: 0 auto;
      }
     @font-face {
		font-family: 'NotoSansKR';
		src: url("/resource/fonts/NotoSansKR-Regular.otf");
	}
    
    .member{
    	text-align: left;
    	font-family: NotoSansKR;
    	font-size: 20px;
    	text-align: center;
    }  
    hr{
    	border:  1px solid #e9e9e9;
    }
	 .my_list table {
            text-align: center;
            border-collapse: collapse;
            margin-top: 10px;
            width: 100%;
        }
        .icon_check_star{
        	width: 30px;
        	margin-left: 10px;
        }
        .star{
        	width: 10px;
        }
        
        th{
        	padding: 30px;
        }
        

       .my_list td {
            border-top: 1px solid #e9e9e9;
            border-bottom: 1px solid #e9e9e9;
            padding: 30px;
            width: 300px;
            height: 42px;
            box-sizing: border-box;
        }
        .my_list{
        	display: flex;
        }
        .favorite_list{
        	margin: 100px 50px;
        	border: 1px solid #e9e9e9;
        	height: 100%;
        	
        }
       .position_list{
       		margin: 100px ;
        	border: 1px solid #e9e9e9;
       }
       h2{
       	color: #c4c4c4;
       	padding: 20px;
       	font-size: 30px;
       }
       .frm_favorite{
       	width: 0px;
       }
       .my_table{
       	width: 250px;
       	margin: 0px 0px;
       	font-weight: bold;
       	
       }
       .my_table td{
       		border: none;
       		text-align: left;
       }
       button{
        margin-top : 50px;
        margin-bottom: 50px;
       	width: 300px;
       	height: 50px;
       	font-family: NotoSansKR;
       	background-color: #e9e9e9;
       	border: 1px solid skyblue;
       	border-radius: 30px;
       	font-size: 20px;
       	font-weight: bold;
       }
       button:hover{
       	background-color: white;
       }
       .member h2{
       		font-size: 50px;
       }
       .member_container{
       	display: flex;
       	margin: 0px auto;
       	width: 470px;
       }
       
</style>
</head>
<body>
<c:if test=""></c:if>
	<div class="plist_container">
		<c:forEach var="plist" items="${requestScope.plist}">
			<c:if test="${plist.COUNT != 0}">
				<input type="hidden" value="${plist.TRADE_PRICE}">
			</c:if>
		</c:forEach>
	</div>
	<header style="border-bottom:1px solid #c4c4c4;margin-bottom:0px;">
	<div style="display:inline;">
		<a href="login.do"><img alt="" src="resource/img/logo.png" style="width:200px;height:70px;"></a>
	</div>
	<div style="display:inline;float: right;margin-top:10px;margin-right:10px;">
		<a href="mypageView.do" style="margin:0px;color: blue;">${sessionScope.client.id }</a>님이 로그인하셨습니다.<br>
		<a href="logout.do" style="float: right;margin-right:0px;color: red;margin-top:10px;">로그아웃</a>
	</div>
</header>
	<div class="container">

	<div class="member">
		<h2>${sessionScope.client.id} 님의 정보</h2>
		<div class="member_container">
		<div>
			<img src="/resource/img/human.png">
		</div>
		<table class="my_table">
			<tr>
				<td>이름 <p>${sessionScope.client.name}</p><td>
			</tr>
			<tr>
				<td>이메일 <p>${sessionScope.client.email}</p></td>
			</tr>
			<tr>
				<td>보유원화 <p>${sessionScope.client.krw} krw</p></td>
			</tr>
			<tr>
			</tr>
		</table>
		</div>
			<a href="memberUpdateView.do"><button>회원정보수정</button></a>
	</div>
	<hr>
	<div class="my_list">
	<div class="favorite_list">
        <h2>관심 코인</h2>
			<table>
				<tr>
					<th></th>
					<th>자산</th>
					<th>실시간 시세</th>
					<th>변동률</th>
				</tr>
			<c:forEach var="favorite" items="${requestScope.flist}" end="${requestScope.flist.size()}">
				<tr>
					<td class="star"><img src="/resource/img/check_star.png" class="icon_check_star"></td>
					  <c:choose>
					  	<c:when test="${favorite.CODE == 'KRW-BTC'}">
					  		<td><b id="KRW-BTC">비트코인</b><br><p class="market0"></p></td>
               		 		<td class="price0"></td>
                			<td class="change_rate0"></td>
					  	</c:when>
					  	<c:when test="${favorite.CODE == 'KRW-XRP'}">
					  		<td><b id="KRW-XRP">리플</b><br><p class="market1"></p></td>
               		 		<td class="price1"></td>
                			<td class="change_rate1"></td>
					  	</c:when>
					  	<c:when test="${favorite.CODE == 'KRW-OMG'}">
					  		<td><b id="KRW-OMG">오미세고</b><br><p class="market2"></p></td>
               		 		<td class="price2"></td>
                			<td class="change_rate2"></td>
					  	</c:when>
					  	<c:when test="${favorite.CODE == 'KRW-ETH'}">
					  		<td><b id="KRW-ETH">이더리움</b><br><p class="market3"></p></td>
               		 		<td class="price3"></td>
                			<td class="change_rate3"></td>
					  	</c:when>
					  	<c:when test="${favorite.CODE == 'KRW-ELF'}">
					  		<td><b id="KRW-ELF">엘프</b><br><p class="market4"></p></td>
               		 		<td class="price4"></td>
                			<td class="change_rate4"></td>
					  	</c:when>
					  	<c:when test="${favorite.CODE == 'KRW-DOGE'}">
					  		<td><b id="KRW-DOGE">도지코인</b><br><p class="market5"></p></td>
               		 		<td class="price5"></td>
                			<td class="change_rate5"></td>
					  	</c:when>
					  	<c:when test="${favorite.CODE == 'KRW-EOS'}">
					  		<td><b id="KRW-EOS">이오스</b><br><p class="market6"></p></td>
               		 		<td class="price6"></td>
                			<td class="change_rate6"></td>
					  	</c:when>
					  	<c:when test="${favorite.CODE == 'KRW-XLM'}">
					  		<td><b id="KRW-XLM">스텔라루멘</b><br><p class="market7"></p></td>
               		 		<td class="price7"></td>
                			<td class="change_rate7"></td>
					  	</c:when>
					  	<c:when test="${favorite.CODE == 'KRW-MATIC'}">
					  		<td><b id="KRW-MATIC">폴리곤</b><br><p class="market8"></p></td>
               		 		<td class="price8"></td>
                			<td class="change_rate8"></td>
					  	</c:when>
					  	<c:when test="${favorite.CODE == 'KRW-TRX'}">
					  		<td><b id="KRW-TRX">트론</b><br><p class="market9"></p></td>
               		 		<td class="price9"></td>
                			<td class="change_rate9"></td>
					  	</c:when>
					  </c:choose>
                	<td><form class="frm_favorite"><input type="hidden" value="${favorite.INO}" name="ino"></form></td>
				</tr>
				</c:forEach>
			
			</table>
    </div>
	<div class="position_list">
		<h2>보유코인</h2>
			<table class="position_table">
				<tr>
					<th>자산</th>
					<th>수익률</th>
					<th>개수</th>
					<th>평단가</th>
				</tr>
			<c:forEach var="position" items="${requestScope.plist}">
					  <c:choose>
					  	<c:when test="${position.CODE =='KRW-BTC' && position.PRICE != 0}">
					  		<tr>
						  		<td><b id="KRW-BTC">비트코인</b><br><p class="market0"></p></td>
						  		<td class="td_profit0">${position.TRADE_PRICE}</td>
						  		<td>${position.COUNT}</td>
								<td>${position.TRADE_PRICE}</td> 
							</tr>
					  	</c:when>
					  	<c:when test="${position.CODE == 'KRW-XRP' && position.PRICE != 0}">
					  		<tr>
						  		<td><b id="KRW-XRP">리플</b><br><p class="market1"></p></td>
						  		<td class="td_profit1"></td>
						  		<td>${position.COUNT}</td>
								<td>${position.TRADE_PRICE}</td> 
							</tr>
					  	</c:when>
					  	<c:when test="${position.CODE == 'KRW-OMG' && position.PRICE != 0}">
					  	<tr>
					  		<td><b id="KRW-OMG">오미세고</b><br><p class="market2"></p></td>
					  		<td class="td_profit2">${position.TRADE_PRICE}</td>
					  		<td>${position.COUNT}</td>
							<td>${position.TRADE_PRICE}</td> 
						</tr>
					  	</c:when>
					  	<c:when test="${position.CODE == 'KRW-ETH' && position.PRICE != 0}">
					  	<tr>
					  		<td><b id="KRW-ETH">이더리움</b><br><p class="market3"></p></td>
					  		<td class="td_profit3">${position.TRADE_PRICE}</td>
					  		<td>${position.COUNT}</td>
							<td>${position.TRADE_PRICE}</td> 
						</tr>
					  	</c:when>
					  	<c:when test="${position.CODE == 'KRW-ELF' && position.PRICE != 0}">
					  		<tr>
						  		<td><b id="KRW-ELF">엘프</b><br><p class="market4"></p></td>
						  		<td class="td_profit4">${position.TRADE_PRICE}</td>
						  		<td>${position.COUNT}</td>
								<td>${position.TRADE_PRICE}</td> 
							</tr>
					  	</c:when>
					  	<c:when test="${position.CODE == 'KRW-DOGE' && position.PRICE != 0}">
				  			<tr>
					  			<td><b id="KRW-DOGE">도지코인</b><br><p class="market5"></p></td>
					  			<td class="td_profit5">${position.TRADE_PRICE}</td>
					  			<td>${position.COUNT}</td>
								<td>${position.TRADE_PRICE}</td> 
							</tr>
					  	</c:when>
					  	<c:when test="${position.CODE == 'KRW-EOS' && position.PRICE != 0}">
					  		<tr>
					  			<td><b id="KRW-EOS">이오스</b><br><p class="market6"></p></td>
					  			<td class="td_profit6">${position.TRADE_PRICE}</td>
					  			<td>${position.COUNT}</td>
								<td>${position.TRADE_PRICE}</td> 
							</tr>
					  	</c:when>
					  	<c:when test="${position.CODE == 'KRW-XLM' && position.PRICE != 0}">
					  		<tr>
					  			<td><b id="KRW-XLM">스텔라루멘</b><br><p class="market7"></p></td>
					  			<td class="td_profit7">${position.TRADE_PRICE}</td>
					  			<td>${position.COUNT}</td>
								<td>${position.TRADE_PRICE}</td> 
							</tr>
					  	</c:when>
					  	<c:when test="${position.CODE == 'KRW-MATIC' && position.PRICE != 0}">
					  	<tr>
					  		<td><b id="KRW-MATIC">폴리곤</b><br><p class="market8"></p></td>
					  		<td class="td_profit8">${position.TRADE_PRICE}</td>
					  		<td>${position.COUNT}</td>
							<td>${position.TRADE_PRICE}</td> 
						</tr>
					  	</c:when>
					  	<c:when test="${position.CODE == 'KRW-TRX' && position.PRICE != 0}">
					  	<tr>
					  		<td><b id="KRW-TRX">트론</b><br><p class="market9"></p></td>
					  		<td class="td_profit9">${position.TRADE_PRICE}</td>
					  		<td>${position.COUNT}</td>
							<td>${position.TRADE_PRICE}</td> 
						</tr>
					  	</c:when>
					  </c:choose>
			</c:forEach>
			</table>
		</div>
	</div>
	</div>
</body>
</html>