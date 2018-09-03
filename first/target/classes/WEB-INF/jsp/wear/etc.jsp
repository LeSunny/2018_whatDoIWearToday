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
			<td><a href="#this" class="btn" id="plus"><img src="./../../resources/images/001-winter-clothes.png" /></a></td>	
		</tr>
		<tr>
			<td><a href="#this" class="btn" id="plus"><img src="./../../resources/images/002-glove.png" /></a></td>	
		</tr>
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
	$("#longUnder").on("click", function(e){
        e.preventDefault();
        fn_longUnderwear();
    });
	$("#winterScarf").on("click", function(e){
        e.preventDefault();
        fn_winterScarf();
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

function fn_longUnderwear(){
	   var comSubmit = new ComSubmit();
	   comSubmit.setUrl("<c:url value='/wear/etc/longUnderwear.do' />");
	   comSubmit.submit();
	}
function fn_winterScarf(){
	   var comSubmit = new ComSubmit();
	   comSubmit.setUrl("<c:url value='/wear/etc/winterScarf.do' />");
	   comSubmit.submit();
	}
function fn_addPic(){
   var comSubmit = new ComSubmit();
   comSubmit.setUrl("<c:url value='/wear/camera.do' />");
   comSubmit.submit();
}
</script>

<%@ include file="/WEB-INF/include/include-body.jspf" %>
</body>
</html>