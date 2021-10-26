<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$(".commentUpdate").click(function(){
			var cno = $(this).parent().parent().find(".cno").html();
			var d = $(this).parent().parent().find(".ct_update").html();
			$(this).parent().parent().find(".ct_update").html("<form action='updateCcontent.do' method='post' class='update'><input type='hidden' name='bno' value='${requestScope.board.bno}'><input type='hidden' name='cno' value='"+cno+"'></input><input type='text' name='updateCcontent' value='"+d+"'></input></form>");
			$(this).html("수정완료");
			$(this).off("click");
			$(this).click(function(){
				$(this).parent().parent().find(".update").submit();
			})
		})
		$(".commentDelete").click(function(){
			var cno = $(this).parent().parent().find(".cno").html();
			var bno = ${requestScope.board.bno};
			$.ajax({
				data : "cno="+cno+"&bno="+bno,
				type: "post",
				url : "commentDelete.do",
				dataType:"json",
				success:function(){
					
				}
			})
			location.href = "boardView.do?bno="+bno;
		})
		$(".like").click(function(e) {
			e.preventDefault();
			$.ajax({
				url : $(this).attr("href"),
				type: "get",
				dataType:"json",
				success:function(r){
					alert(r.msg);
					if(r.code == 400)
						location.href = "/";
					else
						location.reload();
				}
			});
		});
		$(".hate").click(function(e) {
			e.preventDefault();
			$.ajax({
				url : $(this).attr("href"),
				type: "get",
				dataType:"json",
				success:function(r){
					alert(r.msg);
					if(r.code == 400)
						location.href = "/";
					else
						location.reload();
				}
			});
		});
	});
</script>
<style type="text/css">
	*{
		margin: auto;
		padding: 0px;
	}
	table{
		border-collapse: collapse;
	}
	tr{
		height: 100px;
	}
	td{
		width: 600px;
		position: relative;
		box-sizing:border-box;
	}
	th{ 
		width:600px;
		position: relative;
		box-sizing:border-box;
	}
	tr,td,th{
		border: solid 1px black;
		font-size: 12px;
	}	
	img{
		width: 40px;
		height: 40px;
	}
	a{
		margin-right: 25px;
		margin-left: 25px;
		text-decoration:none;
	}
	textarea{
		border:none;
		width:500px;
		height:100px;
		box-sizing:border-box;
		resize:none;
	}
	.ccontent_register{
		top:0px;
		width:100px;
		height:99px;
		position:absolute;
		right:0px;
		border:none;
		box-sizing:border-box;
	}
	button:active{
	background-color: #c4c4c4;
	transform: translateY(1px);
	}
	header{
		hegiht:200px;
	}
</style>
</head>
<body>
	<header>
	<a href="/"><img alt="" src="resource/img/logo.png" style="width:200px;height:70px;"></a>
	
	</header>
	<table>
		<tr style="height:50px;">
			<td>제목 : ${requestScope.board.title}</td>
		</tr>
		<tr style="height:20px;text-align:right;">
			<td>작성자 : ${requestScope.board.writer } 조회수 : ${requestScope.board.bcount } 작성일 : ${requestScope.board.bdate }</td>
		</tr>
		<tr style="height:300px;vertical-align:top;">
			<td>${requestScope.board.bcontent}</td>
		</tr>
		<tr style="height:60px;">
			<td style="text-align: center;"><a href="boardLike.do?bno=${requestScope.board.bno}" class="like"><img alt="" src="/resource/img/like.png"> ${requestScope.board.blike}</a>
			<a href="boardHate.do?bno=${requestScope.board.bno}" class="hate"><img alt="" src="/resource/img/hate.png"> ${requestScope.board.bhate}</a></td>
		</tr>
		<tr>
			<td style="font-size:0px;">
			<form action="insertCcontent.do" method="post">
			<!-- 여기에 댓글 번호 -->
			<input type="hidden" name="bno" value="${requestScope.board.bno}">
			<input type="hidden" name="writer" value="${requestScope.board.writer}">
			<textarea name="ccontent" placeholder="댓글을 입력해 주세요"></textarea> 
			<button class="ccontent_register" style="box-sizing:boder-box;background-color:#c4c4c4;">등록하기</button>
			</form>
			</td>
		</tr>
	</table>
	<br>
	<div style="text-align:center;margin-left:500px;">
	<c:if test="${requestScope.board.writer == sessionScope.client.id }">
		<button type="button" class="btnUpdate" style="width:50px;height:30px;background-color:#767d83;color:#fff;border-color: #767d83;">수정</button>
		<button type="button" class="btnDelete" style="width:50px;height:30px;background-color: #f0ad4e;color:#fff;border-color: #eea236;">삭제</button>
		<script type="text/javascript">
			 		var btnDelete = document.querySelector(".btnDelete");
			 		btnDelete.onclick = function(){
			 			location.href = "boardDelete.do?bno=${requestScope.board.bno}";
			 		}
			 		var btnUpdate= document.querySelector(".btnUpdate");
			 		btnUpdate.onclick = function(){
			 			location.href = "boardUpdateView.do?bno=${requestScope.board.bno}";
			 		}
		</script>
		</c:if>
		</div>
	<br>
	<table>
		<tr style="height:25px;">
			<th style="width:40px;text-align:center;">번호</th>
			<th style="padding-left:4px;">내용</th>
			<th style="width:80px;">글쓴이</th>
			<th style="width:100px;">날짜</th>
			<th style="width:80px;">수정/삭제</th>
		</tr>
			<% int cnno = 1;%>
			<c:forEach var="comment" items="${requestScope.commentList }">
		<tr style="height:25px;">
			<td style="display:none;" class="cno">${comment.cno}</td>
			<td style="width:40px;text-align:center;"><%=cnno++%></td>
			<td style="padding-left:4px;" class="ct_update">${comment.ccontent}</td>
			<td style="width:80px;text-align:center;">${comment.cwriter }</td>
			<td style="width:100px;text-align:center;">${comment.cdate }</td>
			<td style="width:100px;text-align:center;">
			<c:if test="${comment.cwriter == sessionScope.client.id }">
		<button type="button" class="commentUpdate" style="background-color:#767d83;color:#fff;border-color: #767d83;">수정</button>
		<button type="button" class="commentDelete" style="background-color: #f0ad4e;color:#fff;border-color: #eea236;">삭제</button>
		</c:if>
		</td>
		</tr>
		</c:forEach>
	</table>
	
</body>
</html>