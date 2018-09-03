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


	<header>
	아이디 : ${sessionScope.user.ID } 성별 : ${sessionScope.user.SEX } 레벨 : ${sessionScope.user.MEM_LEVEL } <a href="#this" class="btn" id="logout">로그아웃  </a>
	</header>

	<video id="video" width="640" height="480" autoplay></video>
	<button id="snap">Snap Photo</button>
	<canvas id="canvas" width="640" height="480"></canvas>

	<div id="download">
	    <p><label for="imageName">Image name:</label> <input type="text" placeholder="My Photobooth Pic" id="imageName"></p>
	    <p> Do you want to apply this picture? <button onClick="toDataURL();" >YES</button></p>
	</div>
	<img id="myImage">

	<script>
	    var context = canvas.getContext('2d');
		var video = document.getElementById('video');

	    //var _filenameInput = document.getElementById('imageName');
		//var _downloadButton = document.querySelector('#download button');


		// Get access to the camera!
		if(navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
		    // Not adding `{ audio: true }` since we only want video now
		    navigator.mediaDevices.getUserMedia({ video: true }).then(function(stream) {
		        video.src = window.URL.createObjectURL(stream);
		        video.play();
		    });
		}

		// Trigger photo take
		$("#snap").click(function(){
			context.drawImage(video, 0, 0, 640, 480);
		});

		function toDataURL(){
			var myImage = document.getElementById('myImage');

			myImage.src = canvas.toDataURL();
			window.location.href = myImage.src.replace('image/png', 'image/octet-stream');//'image/octet-stream');
		}


		/*
		document.addEventListener ('keydown', function (event) {
            if(event.keyCode == 32) {
             document.querySelector('#myImage').src = canvas.toDataURL('image/webp')
        	}
 		})

 		_downloadButton.addEventListener('click', _downloadImage);

		var _downloadImage = function(e) {
			//do download
		    var imageDataUrl = canvas.toDataURL('image/png').substring(22);
		    var byteArray = Base64Binary.decode(imageDataUrl);
		    var blob = new Blob([byteArray], {type:'image/png'});
		    var url = window.URL.createObjectURL(blob);

		    var link = document.createElement('a');
		    link.setAttribute('href', url);

		    var filename = _filenameInput.value;
		    if (!filename) {
		        filename = _filenameInput.getAttribute('placeholder');
		    }
		    link.setAttribute('download', filename + '.png');
		    link.addEventListener('click', function() {
		        _downloadButton.className = 'downloaded';
		    });

		    var event = document.createEvent('MouseEvents');
		    event.initMouseEvent('click', true, true, window, 1, 0, 0, 0, 0, false, false, false, false, 0, null);
		    link.dispatchEvent(event);
		};*/
	</script>
  <%@ include file="/WEB-INF/include/include-body.jspf" %>
  </body>
</html>
