<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<!--
	Phantom by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<title>What Do I Wear Today?</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		
		<!--[if lte IE 9]><link rel="stylesheet" href="../../css/ie9.css" /><![endif]-->
		<noscript><link rel="stylesheet" href="../../css/noscript.css" /></noscript>
		<%@ include file="/WEB-INF/include/include-header-first.jspf" %>
		
	</head>
	<body>
	
	
		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Header -->
					<header id="header">
						<div class="logo">
							<span class="icon fa-diamond"></span>
						</div>
						<div class="content">
							<div class="inner">
								<h1>What Do I Wear Today?</h1>
								<p>A fully responsive site template designed by <a href="https://html5up.net">HTML5 UP</a> and released<br />
								for free under the <a href="https://html5up.net/license">Creative Commons</a> license.<br />
								</p>
							</div>
						</div>
						<nav>
							<ul>
								<li><a href="#intro">Intro</a></li>
								<li><a href="#signin">Sign In</a></li>
								<li><a href="#this" id="signup">Sign Up</a></li>
								<!--<li><a href="#elements">Elements</a></li>-->
							</ul>
						</nav>
					</header>

				<!-- Main -->
					<div id="main">

						<!-- Intro -->
							<article id="intro">
								<h2 class="major">Intro</h2>
								<span class="image main"><img src="resources/images/pic01.jpg" alt="" /></span>
								<p>This Web Site lets you find a stylish outfit based on your gender, location and upcoming event type.
								The location detection and weather forecast integration works well.
							  </p>
							</article>

						
							<!-- Sign In -->
							<article id="signin">
								<h2 class="major">Sign In</h2>

								<form  id="signinInfo" name="signinInfo" >
									<div class="field ">
										<label for="id">ID</label>
										<input type="text" name="id" id="id" />
									</div>
									<br />
									<div class="field">
										<label for="pwd">Password</label>
										<input type="password" name="pwd" id="pwd" />
									</div>
									<div id = signinDiv></div>
									<ul class="actions">
										<li><input type="button" value="Login" id="signIn" class="register-button"></li>
									</ul>
								</form>
								<ul class="icons">
									<li><a href="#" class="icon fa-twitter"><span class="label">Twitter</span></a></li>
									<li><a href="#" class="icon fa-facebook"><span class="label">Facebook</span></a></li>
									<li><a href="#" class="icon fa-instagram"><span class="label">Instagram</span></a></li>
									<li><a href="#" class="icon fa-github"><span class="label">GitHub</span></a></li>
								</ul>
							</article>

					</div>

				<!-- Footer -->
					<footer id="footer">
						<p class="copyright">&copy; Untitled. Design: <a href="https://html5up.net">HTML5 UP</a>.</p>
					</footer>

			</div>

		<!-- BG -->
			<div id="bg"></div>


	<%@ include file="/WEB-INF/include/include-body.jspf" %>
	
	<script type="text/javascript">
	
	$(document).ready(function(){
        $("#signup").on("click", function(e){
            e.preventDefault();
            fn_openSignUp();
        });
        $("input#signIn.register-button").on("click", function(e){
            e.preventDefault();
            checkValue();
        });
    });
	function fn_openSignUp(){
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/user/openSignUp.do' />");
		comSubmit.submit();
	}
	function checkValue(){
		
		if(!document.signinInfo.id.value){
			alert("아이디를 입력하세요.");
		}
		else if(!document.signinInfo.pwd.value){
            alert("비밀번호를 입력하세요.");
            return false;
        }else{
        	var prmId = document.signinInfo.id.value;
        	var prmPwd = document.signinInfo.pwd.value;
        	$.ajax({
	            data : {"user_id" : prmId,
	            	"user_pwd" : prmPwd},
	            dataType: 'json',
	            url : "<c:url value='/user/loginCheck.do'/>",
	            success : function(data) {
	            	var result = $.trim(data.result);
	            	if(result == "true"){
	            		fn_LogIn();
	        		}else{
	        			$("#signinDiv").html("아이디와 비밀번호를 확인해 주세요.");
	        		}
	           },
	           error : function(request,status,error){
	        	   alert("code:"+request.status+"\n"+"error:"+error);
	           }
	        });
        	//ajax 결과가 괜찮을 경우 fn_LogIn
        }
	}
	function fn_LogIn(){
		var comSubmit = new ComSubmit("signinInfo");
		comSubmit.setUrl("<c:url value='/user/LoginPro.do' />");
		comSubmit.submit();
	}
	</script>
	</body>
</html>