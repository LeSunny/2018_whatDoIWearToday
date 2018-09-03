<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Sign Up Page</title>

	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
		
	<%@ include file="/WEB-INF/include/include-header-first.jspf" %>
	
	<script type="text/javascript">
    
        
    </script>
    
    <style type="text/css">
    	.error{
    	color:#ff0000;
    	font-size:0.9em;
    	font-weight:bold;
    	}
    </style>
</head>
<body>
      
    <center>
    <h1 class="register-title">Welcome</h1>
  	<form id="userInfo" name="userInfo" enctype="multipart/form-data" class="register">
    <div class="register-switch">
      	<input type="radio" name="sex" value="F" id="sex_f" class="register-switch-input" checked>
      	<label for="sex_f" class="register-switch-label">Female</label>
      	<input type="radio" name="sex" value="M" id="sex_m" class="register-switch-input">
    	<label for="sex_m" class="register-switch-label">Male</label>
    </div>
    
    	<input type="hidden" id="idChk" value="N" /> <!-- ID체크를 했는지 안했는지 -->
        <input type="text" class="id" id="id" name="id" placeholder="id" maxlength="30"/>
        <input type="button" value="중복확인" onclick="javascript:chkDupId();">
        <div id="idDiv"></div>
    
       	<input type="text" class="name" id="name" name="name" placeholder="name">
    	<input type="text" class="email" id="email1" name="email1" placeholder="Email address">@
    	<select name="email2">
    		<option>naver.com</option>
    		<option>hanmail.com</option>
    		<option>gmail.com</option>
    	</select>
    	<input type="password" class="pwd" id="pwd" name="pwd" placeholder="Password">
    	<input type="password" class="pwdcheck" id="pwdcheck" name="pwdcheck" placeholder="Please Check Password Again">

    	<input type="text" name="birthyy" id="birthyy" name="birthyy" maxlength="4" placeholder="년(4자)" size="6" >
        <select id="birthmm" name="birthmm">
          	<option value="">월</option>
            <option value="01" >1</option>
            <option value="02" >2</option>
            <option value="03" >3</option>
            <option value="04" >4</option>
            <option value="05" >5</option>
            <option value="06" >6</option>
            <option value="07" >7</option>
            <option value="08" >8</option>
            <option value="09" >9</option>
            <option value="10" >10</option>
            <option value="11" >11</option>
            <option value="12" >12</option>
        </select>
        <input type="text" id="birthdd" name="birthdd" maxlength="2" placeholder="일" size="4" >
        <input type="checkbox" name="cold" id="cold">
    	<label for="cold">추위를 타는 편입니까?</label>
    	<input type="checkbox" name="hot" id="hot">
    	<label for="hot" >더위를 타는 편입니까?</label>
    	<br /><br />
    	<input type="button" value="Create Account" id="signup" class="register-button" > <!-- onClick="e.preventDefault(); fn_insertMember();"> -->
  	</form>




  	<div class="about">
    <p class="about-links">
      <a href="http://www.cssflow.com/snippets/registration-form" target="_parent">View Article</a>
      <a href="http://www.cssflow.com/snippets/registration-form.zip" target="_parent">Download</a>
    </p>
    <p class="about-author">
      &copy; 2013 <a href="http://thibaut.me" target="_blank">Thibaut Courouble</a> 
      <a href="http://www.cssflow.com/mit-license" target="_blank">MIT License</a><br>
      Original PSD by <a href="http://dribbble.com/shots/1115108-Register-UI-Free-PSD-included" target="_blank">Ionut Zamfir</a>
    </p>
  	</div>                    
    </center>
	<%@ include file="/WEB-INF/include/include-body.jspf" %>
	<script type="text/javascript">
	$(document).ready(function(){
        $("#signup").on("click", function(e){
            e.preventDefault();
            checkValue();
            
        });
    });
	function fn_insertMember(){
		var comSubmit = new ComSubmit("userInfo");		
		comSubmit.setUrl("<c:url value='/user/SignUpPro.do' />");
		comSubmit.submit();
	}
	
	
	function chkDupId(){
		
		var prmId = $("#id").val();
		var regexp = /[0-9a-zA-Z]/;// 숫자, 영문, 특수문자

		if($("#id").val()==''){ alert("id를 입력해 주세요."); return;}
		for(var i =0 ; i<prmId.length; i++){
			if(prmId.charAt(i)!=" "&& regexp.test(prmId.charAt(i))==false){
				alert("한글이나 특수 문자는 입력 불가능 합니다.");
				$('#id').val("");
				return;
			}
		}
		if(prmId.length <4){
			alert('ID는 4자 이상입니다.');
			$('#id').val("");
			return;
		}
		else{
						
			$.ajax({
	            data : {"user_id" : prmId }, // user_id에 prmId 값을 넣어 Controller의 /user/chkDupId.do 로 던짐
	            dataType:'json',
	            url : "<c:url value='/user/chkDupId.do'/>",
	            success : function(data) {
	            	
	            	if(data.result == "true"){
	        			$("#idDiv").html(" 사용 가능한 아이디 입니다.");
						$("#idChk").val('Y');
	        		}else{
	        			$("#idDiv").html(" 중복된 아이디로 사용이 불가능 합니다.");
	        			$('#idChk').val('N');	
	        		}
	           },
	           error : function(request,status,error){
	        	   alert("code:"+request.status+"\n"+"error:"+error);
	           }
	        });
		}
			
	}
	
	// 필수 입력정보인 아이디, 비밀번호가 입력되었는지 확인하는 함수
    function checkValue()
    {
        if(!document.userInfo.id.value){
            alert("아이디를 입력하세요.");
            return false;
        }
        
        if(!document.userInfo.pwd.value){
            alert("비밀번호를 입력하세요.");
            return false;
        }
        
        if(!document.userInfo.name.value){
        	alert("이름을 입력하세요.");
        	return false;
        }
        
        if(!document.userInfo.birthyy.value || !document.userInfo.birthmm.value || !document.userInfo.birthdd.value){
        	alert("생년월일을 정확히 입력하세요.");
        	return false;
        }
        
        if(!document.userInfo.email1.value){
        	alert("이메일 주소를 정확히 입력하세요.");
        	return false;
        }
        
        if(isNaN(document.userInfo.birthyy.value) || isNaN(document.userInfo.birthdd.value)){
        	alert("날짜는 숫자만 입력 가능합니다.");
        	return false;
        }
        // 비밀번호와 비밀번호 확인에 입력된 값이 동일한지 확인
        if(document.userInfo.pwd.value != document.userInfo.pwdcheck.value ){
            alert("비밀번호를 동일하게 입력하세요.");
            return false;
        }
        
		if(document.userInfo.idChk.value=='N') {alert('ID 체크를 해주세요.'); return false;}

        fn_insertMember();
        /*if(document.userInfo.idDuplication.value != "idCheck"){
        	alert("아이디 중복체크를 해주세요.");
        	return false;
        }*/
    }
	</script>
</body>
</html>