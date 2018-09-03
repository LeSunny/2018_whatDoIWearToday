<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Main 상의</title>
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
	<table class="top">
		<tr>
			<td><a href="#this" class="btn" id="sleeveless"><img src="./../../resources/images/031-sleeveless.png" /></a></td>	
			<td><a href="#this" class="btn" id="Tshirt"><img src="./../../resources/images/tshirt.png" /></a></td>	
		</tr>
		<tr>
			<td><a href="#this" class="btn" id="longsleeves"><img src="./../../resources/images/028-long-sleeves-t-shirt.png" /></a></td>	
			<td><a href="#this" class="btn" id="shirt"><img src="./../../resources/images/029-shirt-1.png" /></a></td>	
		</tr>
		<tr>
			<td><a href="#this" class="btn" id="hoodie"><img src="./../../resources/images/027-hoodie.png" /></a></td>	
			<td><a href="#this" class="btn" id="sweater"><img src="./../../resources/images/026-sweater.png" /></a></td>	
		</tr>
		<tr>
			<td><a href="#this" class="btn" id="plus"><img src="./../../resources/images/plus-button.png" /></a></td>	
			<td><div id=girlDiv></div></td>
			
		</tr>
	</table>
<%@ include file="/WEB-INF/include/include-body.jspf" %>

<script>
if("${sessionScope.user.SEX}"=="F"){
	$("#girlDiv").html("<a href='#this' class='btn' id='dress'><img src='./../../resources/images/024-dress.png' /></a>");
}
$(document).ready(function(){
	$("#logout").on("click", function(e){
        e.preventDefault();
        fn_logout();
   });
	$("#sleeveless").on("click", function(e){
        e.preventDefault();
        fn_sleeveless();
   });
	$("#Tshirt").on("click", function(e){
        e.preventDefault();
        fn_Tshirt();
   });
	$("#longsleeves").on("click", function(e){
        e.preventDefault();
        fn_longsleeves();
   });
	$("#shrit").on("click", function(e){
        e.preventDefault();
        fn_shirt();
   });
	$("#hoodie").on("click", function(e){
        e.preventDefault();
        fn_hoodie();
   });
	$("#sweater").on("click", function(e){
        e.preventDefault();
        fn_sweater();
   });
	$("#plus").on("click", function(e){
        e.preventDefault();
        fn_addPic();
   });
	$("#home").on("click", function(e){
        e.preventDefault();
        goHome();
   });	
	$("#closet").on("click", function(e){
        e.preventDefault();
        fn_showMyCloset();
    });
});
   
function goHome(){
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("<c:url value='/wear/weathertest.do' />");
	   comSubmit.submit();
}
function fn_showMyCloset(){
    var comSubmit = new ComSubmit();
    comSubmit.setUrl("<c:url value='/wear/mycloset.do' />");
    comSubmit.submit();
}
function fn_logout(){
	   var comSubmit = new ComSubmit();
	   comSubmit.setUrl("<c:url value='/logout.do' />");
	   comSubmit.submit();
	}
function fn_sleeveless(){
	   var comSubmit = new ComSubmit();
	   comSubmit.setUrl("<c:url value='/wear/top/sleeveless.do' />");
	   comSubmit.submit();
	}
function fn_Tshirt(){
	   var comSubmit = new ComSubmit();
	   comSubmit.setUrl("<c:url value='/wear/top/Tshirt.do' />");
	   comSubmit.submit();
	}
function fn_longsleeves(){
	   var comSubmit = new ComSubmit();
	   comSubmit.setUrl("<c:url value='/wear/top/longsleeves.do' />");
	   comSubmit.submit();
	}
function fn_shirt(){
	   var comSubmit = new ComSubmit();
	   comSubmit.setUrl("<c:url value='/wear/top/shirt.do' />");
	   comSubmit.submit();
	}
function fn_hoodie(){
	   var comSubmit = new ComSubmit();
	   comSubmit.setUrl("<c:url value='/wear/top/hoodie.do' />");
	   comSubmit.submit();
	}
function fn_sweater(){
	   var comSubmit = new ComSubmit();
	   comSubmit.setUrl("<c:url value='/wear/top/sweater.do' />");
	   comSubmit.submit();
	}
function fn_addPic(){
	   var comSubmit = new ComSubmit();
	   comSubmit.setUrl("<c:url value='/wear/camera.do' />");
	   comSubmit.submit();
	}
</script>

</body>
</html>
