<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
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
			<td><a href="#this" class="btn" id="plus"><img src="./../../resources/images/plus-button.png" /></a></td>	
		</tr>
	</table>
<%@ include file="/WEB-INF/include/include-body.jspf" %>

<script>
$(document).ready(function(){
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
	$("#bubbleJacket").on("click", function(e){
        e.preventDefault();
        fn_bubbleJacket();
    });
	$("#cardigan").on("click", function(e){
        e.preventDefault();
        fn_cardigan();
    });
	$("#fieldJacket").on("click", function(e){
        e.preventDefault();
        fn_filedJacket();
    });
	$("#jacket").on("click", function(e){
        e.preventDefault();
        fn_jacket();
    });
	$("#leather").on("click", function(e){
        e.preventDefault();
        fn_leatherJacket();
    });
	$("#shearling").on("click", function(e){
        e.preventDefault();
        fn_shearling();
    });
	$("#trenchCoat").on("click", function(e){
        e.preventDefault();
        fn_trenchCoat();
    });
	$("#winterCoat").on("click", function(e){
        e.preventDefault();
        fn_winterCoat();
    });
});
   
function fn_showMyCloset(){
    var comSubmit = new ComSubmit();
    comSubmit.setUrl("<c:url value='/wear/mycloset.do' />");
    comSubmit.submit();
}
function goHome(){
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("<c:url value='/wear/weathertest.do' />");
	   comSubmit.submit();
}
    
function fn_addPic(){
   var comSubmit = new ComSubmit();
   comSubmit.setUrl("<c:url value='/wear/camera.do' />");
   comSubmit.submit();
}

function fn_bubbleJacket(){
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("<c:url value='/wear/outerwear/BubbleJacket.do' />");
	comSubmit.submit();
}

function fn_cardigan(){
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("<c:url value='/wear/outerwear/cardigan.do' />");
	comSubmit.submit();
}
function fn_fieldJacket(){
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("<c:url value='/wear/outerwear/fieldJacket.do' />");
	comSubmit.submit();
}
function fn_jacket(){
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("<c:url value='/wear/outerwear/jacket.do' />");
	comSubmit.submit();
}
function fn_letherJacket(){
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("<c:url value='/wear/outerwear/letherJacket.do' />");
	comSubmit.submit();
}
function fn_shearling(){
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("<c:url value='/wear/outerwear/shearling.do' />");
	comSubmit.submit();
}
function fn_trenchCoat(){
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("<c:url value='/wear/outerwear/trenchCoat.do' />");
	comSubmit.submit();
}
function fn_winterCoat(){
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("<c:url value='/wear/outerwear/winterCoat.do' />");
	comSubmit.submit();
}


</script>

<%@ include file="/WEB-INF/include/include-body.jspf" %>
</body>
</html>