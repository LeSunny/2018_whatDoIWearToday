<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>내 옷장</title>
	<%@ include file="/WEB-INF/include/include-header-first.jspf" %>

</head>
<body>
	<header id="header">
		<div class="inner">
			<a href="#this" id="home"><h2>What Do I Wear Today?</h2></a>
			<a href="#this" class="btn" id="logout">로그아웃  </a>
			<a href="#this" class="btn" id="closet">  내 옷장  </a>
		</div>
	아이디 : ${sessionScope.user.ID } 성별 : ${sessionScope.user.SEX } 레벨 : ${sessionScope.user.MEM_LEVEL }
	</header>

	<table class="mycloset">
	<tr>
		<td><a href="#this" class="btn" id="top"> <img src="./../resources/images/tshirt.png" /></a></td>
		<td><a href="#this" class="btn" id="pants"><img src="./../resources/images/jeans.png" /></a></td>
	</tr>
	<tr>
		<td><a href="#this" class="btn" id="outerwear"><img src="./../resources/images/coat.png" /></a></td>
		<td><a href="#this" class="btn" id="etc"><img src="./../resources/images/winter-scarf.png" /></a></td>
	</tr>
	</table>
	<%@ include file="/WEB-INF/include/include-body.jspf" %>

<script>
	$(document).ready(function(){
		$("#logout").on("click", function(e){
	        e.preventDefault();
	        fn_logout();
	   });
		$("#top").on("click", function(e){
	        e.preventDefault();
	        mycloset_top();
	   });
		$("#pants").on("click", function(e){
	        e.preventDefault();
	        mycloset_pants();
	   });
		$("#outerwear").on("click", function(e){
	        e.preventDefault();
	        mycloset_outerwear();
	   });
		$("#etc").on("click", function(e){
	        e.preventDefault();
	        mycloset_etc();
	   });
		$("#home").on("click", function(e){
	        e.preventDefault();
	        goHome();
	   });
		
	});
	   
	function goHome(){
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/wear/weathertest.do' />");
		   comSubmit.submit();
	}
	    
	function fn_logout(){
	   var comSubmit = new ComSubmit();
	   comSubmit.setUrl("<c:url value='/logout.do' />");
	   comSubmit.submit();
	}
	function mycloset_top(){
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/wear/mycloset/top.do' />");
		comSubmit.submit();
	}
	function mycloset_pants(){
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/wear/mycloset/pants.do' />");
		comSubmit.submit();
	}
	function mycloset_outerwear(){
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/wear/mycloset/outerwear.do' />");
		comSubmit.submit();
	}
	function mycloset_etc(){
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/wear/mycloset/etc.do' />");
		comSubmit.submit();
	}
</script>

</body>
</html>