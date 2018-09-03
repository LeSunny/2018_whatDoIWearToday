<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <%@ include file="/WEB-INF/include/include-header-first.jspf" %>
  </head>
  <body><!--
	   Ideally these elements aren't created until it's confirmed that the
  	 client supports video/camera, but for the sake of illustrating the
  	 elements involved, they are created with markup (not JavaScript)
    -->
    
    
	<header id="header">
		<div class="inner">
			<a href="#this" id="home"><h2>What Do I Wear Today?</h2></a>
			<a href="#this" class="btn" id="logout">로그아웃  </a>
			<a href="#this" class="btn" id="closet">  내 옷장  </a>
		</div>
	아이디 : ${sessionScope.user.ID } 성별 : ${sessionScope.user.SEX } 레벨 : ${sessionScope.user.MEM_LEVEL } 
	<br> ${sessionScope.closet.MAIN }<br>${sessionScope.closet.SMALL }
	</header>
		
	<video id="video" width="640" height="480" autoplay></video>
	<button id="snap">Snap Photo</button>
	<form id="frm" name="frm" enctype="multipart/form-data">
	<input type="hidden" name="userId" value=${sessionScope.user.ID }>
		<canvas id="canvas" width="640" height="480"></canvas>
	    <p> Do you want to apply this picture? <a href="#this" class="btn" id="upload" >YES</a></p>
	
	</form>
	<div id=saveDiv></div>
	<a href="#this" class="btn" id="return" >돌아가기</a>	
	<script>
	
	 $(document).ready(function(){
         $("#snap").on("click", function(e){
         	e.preventDefault();
         	context.drawImage(video, 0, 0, 640, 480);
         });
          
         $("#upload").on("click", function(e){ //작성하기 버튼
             e.preventDefault();
             uploadImage();
         });
         
         $("#return").on("click", function(e){ //작성하기 버튼
             e.preventDefault();
             goBack();
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
	 
		var id = "${sessionScope.user.ID}";
		var main = '${sessionScope.closet.MAIN}';
		var small = '${sessionScope.closet.SMALL}';
	    var context = canvas.getContext('2d');
		var video = document.getElementById('video');
	    		
		// Get access to the camera!
		if(navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
			    navigator.mediaDevices.getUserMedia({ video: true }).then(function(stream) {
		        video.src = window.URL.createObjectURL(stream);
		        video.play();
		    });
		}
		
		function goBack(){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/wear/"+main+"/"+small+".do' />");
			comSubmit.submit();
		}
		
		
		function uploadImage() {
			var drawCanvas = document.getElementById('canvas');
			var request = $.ajax({
				type : 'POST',
				enctype : 'multipart/form-data',
				dataType : 'json',
				data : {
					imgUpload:drawCanvas.toDataURL('image/png',1.0),user_id : id, main : "${sessionScope.closet.MAIN}", small : "${sessionScope.closet.SMALL}"},
				url : "<c:url value='/wear/closet/uploadImg.do'/>",
				success : function(data) {
					//alert('success >'+data);
        			$("#saveDiv").html("저장되었습니다.");
				},
	           error : function(request,status,error){
	        	   alert("code:"+request.status+"\n"+"error:"+error);
	           }
			});
		}
		
		
	</script>
  <%@ include file="/WEB-INF/include/include-body.jspf" %>
  </body>
</html>
