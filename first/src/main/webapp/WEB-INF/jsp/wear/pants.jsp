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
	아이디 : ${sessionScope.user.ID } 성별 : ${sessionScope.user.SEX } 레벨 : ${sessionScope.user.MEM_LEVEL}
	</header>
	<table class="top">
		<tr>
			<td><a href="#this" class="btn" id="short"><img src="./../../resources/images/005-shorts-1.png" /></a></td>	
			<td><a href="#this" class="btn" id="trousers"><img src="./../../resources/images/007-oxford-wave-suit-pants.png" /></a></td>	
		</tr>
		<tr>
			<td><a href="#this" class="btn" id="skinny"><img src="./../../resources/images/009-slim-fit-pants.png" /></a></td>	
			<td><a href="#this" class="btn" id="cotton"><img src="./../../resources/images/010-jeans.png" /></a></td>	
		</tr>
		<tr>
			<td><div id="girl"> </div></td>
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
	$("#closet").on("click", function(e){
        e.preventDefault();
        fn_showMyCloset();
    });
	$("#home").on("click", function(e){
        e.preventDefault();
        goHome();
   });
	$("#logout").on("click", function(e){
        e.preventDefault();
        fn_logout();
   });
	$("#short").on("click", function(e){
       e.preventDefault();
       fn_shortPants();
  });
	$("#trousers").on("click", function(e){
        e.preventDefault();
        fn_trousers();
   });
	$("#skirt").on("click", function(e){
        e.preventDefault();
        fn_skirt();
   });
	$("#cotton").on("click", function(e){
        e.preventDefault();
        fn_cottonPants();
   });
	$("#fleece").on("click", function(e){
        e.preventDefault();
        fn_fleecelinedPants();
   });
	$("#ice").on("click", function(e){
        e.preventDefault();
        fn_icePants();
   });
	$("#skinny").on("click", function(e){
        e.preventDefault();
        fn_skinnyPants();
   });
	
});
   
   if("${sessionScope.user.SEX}"=='F') $("#girl").html("<a href='#this' class='btn' id='skirt'><img src='./../../resources/images/004-short-skirt.png' /></a>");
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
	
function fn_addPic(){
   var comSubmit = new ComSubmit();
   comSubmit.setUrl("<c:url value='/wear/camera.do' />");
   comSubmit.submit();
}
function fn_showMyCloset(){
    var comSubmit = new ComSubmit();
    comSubmit.setUrl("<c:url value='/wear/mycloset.do' />");
    comSubmit.submit();
}
	function fn_shortPants(){
		var comSubmit = new ComSubmit();
		   comSubmit.setUrl("<c:url value='/wear/pants/shortPants.do' />");
		   comSubmit.submit();
	}
	function fn_trousers(){
		var comSubmit = new ComSubmit();
		   comSubmit.setUrl("<c:url value='/wear/pants/trousers.do' />");
		   comSubmit.submit();
	}
	function fn_cottonPants(){
		var comSubmit = new ComSubmit();
		   comSubmit.setUrl("<c:url value='/wear/pants/cottonPants.do' />");
		   comSubmit.submit();
	}
	function fn_fleecelinedPants(){
		var comSubmit = new ComSubmit();
		   comSubmit.setUrl("<c:url value='/wear/pants/fleecelinedPants.do' />");
		   comSubmit.submit();
	}
	function fn_icePants(){
		var comSubmit = new ComSubmit();
		   comSubmit.setUrl("<c:url value='/wear/pants/icePants.do' />");
		   comSubmit.submit();
	}
	function fn_skinnyPants(){
		var comSubmit = new ComSubmit();
		   comSubmit.setUrl("<c:url value='/wear/pants/skinnyPants.do' />");
		   comSubmit.submit();
	}
	function fn_skirt(){
		var comSubmit = new ComSubmit();
		   comSubmit.setUrl("<c:url value='/wear/pants/skirt.do' />");
		   comSubmit.submit();
	}
</script>

<%@ include file="/WEB-INF/include/include-body.jspf" %>
</body>
</html>