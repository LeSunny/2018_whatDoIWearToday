<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<title>오늘 뭐 입지?</title>
	<%@ include file="/WEB-INF/include/include-header-first.jspf" %>
	
	<style>
	#prev_btn {position:absolute;top:1250px;left:0px}
	#next_btn {position:absolute;top:1250px;right:0px}
	.btn {width:6em;height:80px;border:0;background:#4c4c4c;display:none;}
	
	#slider {position:relative;margin:0 auto;padding:0;list-style:none;width:560px;height:560px;overflow-x:hidden}
	#slider li {display:none;position:absolute;left:0;top:0}
	#slider img {width:560px;height:560px}
	
	#clothes img{width:200px; height:200px;}
	
	</style>
	
</head>
<body>
	<!-- Header -->
	<header id="header">
		<div class="inner">
			<a href="#this" id="home"><h2>What Do I Wear Today?</h2></a>
			<a href="#this" class="butn" id="logout"> 로그아웃  </a>
			<a href="#this" class="butn" id="closet">  내 옷장  </a>
		</div>
		아이디 : ${sessionScope.user.ID } 성별 : ${sessionScope.user.SEX } 레벨 : ${sessionScope.user.MEM_LEVEL } <br />	
	</header>

	<div id="weather"></div>
	
	<button type="button" id="prev_btn" class="btn">이전</button>
	<button type="button" id="next_btn" class="btn">다음</button>
	<br>
	<h2>기온에 맞는 옷차림</h2>
	<div id="clothes"></div>
	<br>
	<br>
	
	<h2>추천 코디 보기</h2>	
	<ul id="slider">
		<div id="recommend"></div>
	</ul>	
		
		
	<%@ include file="/WEB-INF/include/include-body.jspf" %>
	 
<script>
	
	$(document).ready(function(){
		
		 $("#closet").on("click", function(e){
	            e.preventDefault();
	            fn_showMyCloset();
	        });
		 $("#logout").on("click", function(e){
	            e.preventDefault();
	            fn_logout();
	        });
		 
			$("#home").on("click", function(e){
		        e.preventDefault();
		        goHome();
		   });
			
		});
		   
	
	$(function() {
	    var time = 500;
	    var idx = idx2 = 0;
	    var slide_width = $("#slider").width();
	    var slide_count = $("#slider li").size();
	    $("#slider li:first").css("display", "block");
	    if(slide_count > 1)
	        $(".btn").css("display", "inline");
	 
	    $("#prev_btn").click(function() {
	        if(slide_count > 1) {
	            idx2 = (idx - 1) % slide_count;
	            if(idx2 < 0)
	                idx2 = slide_count - 1;
	            $("#slider li:hidden").css("left", "-"+slide_width+"px");
	            $("#slider li:eq("+idx+")").animate({ left: "+="+slide_width+"px" }, time, function() {
	                $(this).css("display", "none").css("left", "-"+slide_width+"px");
	            });
	            $("#slider li:eq("+idx2+")").css("display", "block").animate({ left: "+="+slide_width+"px" }, time);
	            idx = idx2;
	        }
	    });
	 
	    $("#next_btn").click(function() {
	        if(slide_count > 1) {
	            idx2 = (idx + 1) % slide_count;
	            $("#slider li:hidden").css("left", slide_width+"px");
	            $("#slider li:eq("+idx+")").animate({ left: "-="+slide_width+"px" }, time, function() {
	                $(this).css("display", "none").css("left", slide_width+"px");
	            });
	            $("#slider li:eq("+idx2+")").css("display", "block").animate({ left: "-="+slide_width+"px" }, time);
	            idx = idx2;
	        }
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
 
	
	/* 5 days/3hours */    
	var wear = ${daywear};
	var cityname=wear.city.name;
	//날짜 자르기
	var today = new Date();
	var todayArr = (today.toString()).split(' ');
	var now = todayArr[4];
	var hour = now.substring(0,2);
	
	var small = hour - 6;
	var big = hour + 15;
	if(small<=0) small = 0;
	if(big>=24) big = 24;

	var small_cnt = 0;
	for(var i=0; i<8; i++){
		if(small==wear.list[i].dt_txt.substring(11,13)){
			small_cnt=i;
			break;
		}
	}
	var big_cnt=0;
	for(var i=small_cnt; i<8; i++){
		if(big==wear.list[i].dt_txt.substring(11,13) || (big==24)&&0==wear.list[i].dt_txt.substring(11,13)){
			big_cnt=i;
			break;
		}else if(small_cnt==0){
			big_cnt=7;
		}
	}
	
//	document.write(now+" "+hour+" "+big+" "+small+" "+big_cnt+" "+small_cnt+" ");

	var dt=wear.list[small_cnt].dt_txt;
	var dt_last=wear.list[big_cnt].dt_txt;

	//최고, 최저기온, 기상예보
	var temp_min = wear.list[small_cnt].main.temp_min;
	var temp_max = wear.list[small_cnt].main.temp_max;
	var weather = "강우 또는 강설 소식이 없습니다.";

	
	
	for(var i=small_cnt ; i<big_cnt ; i++){
		if(temp_min>wear.list[i].main.temp_min){
			temp_min=wear.list[i].main.temp_min;			
		} 
		if(temp_max<wear.list[i].main.temp_max) {
			temp_max=wear.list[i].main.temp_max;
		}
	}
	

	for(var i=small_cnt ; i<big_cnt ; i++){
		if(wear.list[i].weather[0].main=="Rain" ){
			weather = wear.list[i].dt_txt + "부터 강우 소식이 있습니다. 우산을 챙겨주세요."
			break;
		}
		if(wear.list[i].weather[0].main=="Snow") {
			weather = wear.list[i].dt_txt + "부터 강설 소식이 있습니다. 우산을 챙겨주세요."
			break;
		}
	}
	
	
	/*current weather*/
	var wear2 = ${currentwear};
	var currenttemp = wear2.main.temp;
	
	
	var max_wear, min_wear;
	
	var clothesstr = "";
	var tempdir = "";
	
	var many=0;
	
	
	if("${sessionScope.user.SEX }"=="F"){
		if(temp_max>=27) {
			max_wear = "<font size=2><b>상의 : 나시티, 반팔<br><b>하의</b> : 반바지, 짧은 치마</font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/031-sleeveless.png' /><img src='./../resources/images/tshirt.png' /><br><img src='./../resources/images/005-shorts-1.png' /><img src='./../resources/images/004-short-skirt.png' />";		
			tempdir += "27";
			many = 10;
		}else if(23<= temp_max && temp_max <27){
			max_wear = "<font size=2><b>상의</b> : 반팔, 얇은 셔츠, 얇은 긴팔 <br> <b>하의</b> : 반바지, 면바지, 발목 스키니</font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/tshirt.png' /><img src='./../resources/images/029-shirt-1.png' /><img src='./../resources/images/028-long-sleeves-t-shirt.png' /><br><img src='./../resources/images/005-shorts-1.png' /><img src='./../resources/images/004-short-skirt.png' /><img src='./../resources/images/009-slim-fit-pants.png' />";				
			tempdir += "23";
			many=12;
		}else if(20<= temp_max && temp_max <23){
			max_wear = "<font size=2><b>상의</b> : 긴팔티, 반팔티 + 후드티, 반팔티 + 가디건 <br><b>하의</b> : 면바지, 슬랙스, 스키니</font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/028-long-sleeves-t-shirt.png' /><img src='./../resources/images/027-hoodie.png' /><img src='./../resources/images/020-cardigan-2.png' /><br><img src='./../resources/images/007-oxford-wave-suit-pants.png' /><img src='./../resources/images/009-slim-fit-pants.png' />";		
			tempdir += "20";
			many=13;
		}else if(17<= temp_max && temp_max <20){
			max_wear = "<font size=2><b>상의</b> : 니트, 얇은 가디건, 후드티, 맨투맨 <br> <b>하의</b> : 면바지, 슬랙스, 청바지, 스키니 </font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/026-sweater.png' /><img src='./../resources/images/027-hoodie.png' /><img src='./../resources/images/020-cardigan-2.png' /><br><img src='./../resources/images/007-oxford-wave-suit-pants.png' /><img src='./../resources/images/009-slim-fit-pants.png' /><img src='./../resources/images/010-jeans.png' />";		
			tempdir += "17";
			many=3;
		}else if(12<= temp_max && temp_max <17){
			max_wear = "<font size=2><b>아우터</b> : 가죽자켓, 자켓 , 간절기 야상, 두꺼운 가디건 <br><b>상의</b> :  셔츠, 긴팔, 맨투맨 / <b>하의</b> : 반바지, 치마,  면바지, 슬랙스, 청바지, 스키니 <br> 살색 스타킹</font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/011-leather-biker-jacket.png' /><img src='./../resources/images/016-denim-jacket.png' /><img src='./../resources/images/019-jacket.png' /><img src='./../resources/images/022-cardigan.png' /><br><img src='./../resources/images/029-shirt-1.png' /><img src='./../resources/images/028-long-sleeves-t-shirt.png' /><br><img src='./../resources/images/009-slim-fit-pants' /><img src='./../resources/images/007-oxford-wave-suit-pants.png' /><img src='./../resources/images/010-jeans.png' />";		
			tempdir += "12";
		}else if(10<= temp_max && temp_max <12){
			max_wear = "<font size=2><b>아우터</b> : 트랜치 코트, 간절기 야상, 자켓+가디건, 자켓+니트 <br> <b>상의</b> : 니트, 긴팔, 맨투맨 <br> 여러겹 껴입기(히트택 이용)<br>살색스타킹</font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/012-trench-coat.png' /><img src='./../resources/images/011-leather-biker-jacket.png' /><img src='./../resources/images/019-jacket.png' /><img src='./../resources/images/022-cardigan.png' /><br><img src='./../resources/images/026-sweater.png' /><img src='./../resources/images/025-sweater-1.png' /><img src='./../resources/images/028-long-sleeves-t-shirt.png' /><img src='./../resources/images/029-shirt-1.png' /><br><img src='./../resources/images/009-slim-fit-pants' /><img src='./../resources/images/007-oxford-wave-suit-pants.png' /><img src='./../resources/images/010-jeans.png' />";		
			tempdir += "10";
			
		}else if(6<= temp_max && temp_max <10){
			max_wear = "<font size=2><b>아우터</b> : 코트, 무스탕 <br> <b>상의 : 니트, 기모맨투맨  <br> 하의</b> : 레깅스, 청바지, 긴바지, 스키니, 기모바지<br>두꺼운 스타킹</font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/coat.png' /><img src='./../resources/images/017-coat.png' /><br><img src='./../resources/images/026-sweater.png' /><img src='./../resources/images/025-sweater-1.png' /><br><img src='./../resources/images/009-slim-fit-pants' /><img src='./../resources/images/007-oxford-wave-suit-pants.png' /><img src='./../resources/images/010-jeans.png' />";		
			tempdir += "6";

		}else{
			max_wear = "<font size=2><b>아우터</b> : 패딩, 두꺼운 코트, 무스탕 <br>기모제품, 히트텍, 목도리, 장갑<br>두꺼운 스타킹, 레깅스</font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/013-jacket-2.png' /><img src='./../resources/images/coat.png' /><img src='./../resources/images/017-coat.png' /><br><img src='./../resources/images/001-winter-clothes.png' /><img src='./../resources/images/002-glove.png' /><br><img src='./../resources/images/026-sweater.png' /><img src='./../resources/images/025-sweater-1.png' /><br><img src='./../resources/images/009-slim-fit-pants' /><img src='./../resources/images/007-oxford-wave-suit-pants.png' /><img src='./../resources/images/010-jeans.png' />";		
			tempdir += "cold";
		}		
	}else{
		if(temp_max>=27) {
			max_wear = "<font size=2><b>상의 : 나시티, 반팔<br><b>하의</b> : 반바지</font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/031-sleeveless.png' /><img src='./../resources/images/tshirt.png' /><br><img src='./../resources/images/005-shorts-1.png' />";		
			tempdir += "27";
			many=12;
		}else if(23<= temp_max && temp_max <27){
			max_wear = "<font size=2><b>상의</b> : 반팔, 얇은 셔츠, 얇은 긴팔 <br> <b>하의</b> : 반바지, 면바지, 발목 스키니</font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/tshirt.png' /><img src='./../resources/images/029-shirt-1.png' /><img src='./../resources/images/028-long-sleeves-t-shirt.png' /><br><img src='./../resources/images/005-shorts-1.png' /><img src='./../resources/images/009-slim-fit-pants.png' />";				
			tempdir += "23";
			many=12;
		}else if(20<= temp_max && temp_max <23){
			max_wear = "<font size=2><b>상의</b> : 긴팔티, 반팔티 + 후드티, 반팔티 + 가디건 <br><b>하의</b> : 면바지, 슬랙스, 스키니</font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/028-long-sleeves-t-shirt.png' /><img src='./../resources/images/027-hoodie.png' /><img src='./../resources/images/020-cardigan-2.png' /><br><img src='./../resources/images/007-oxford-wave-suit-pants.png' /><img src='./../resources/images/009-slim-fit-pants.png' />";		
			tempdir += "20";
			many=8;
		}else if(17<= temp_max && temp_max <20){
			max_wear = "<font size=2><b>상의</b> : 니트, 얇은 가디건, 후드티, 맨투맨 <br> <b>하의</b> : 면바지, 슬랙스, 청바지, 스키니 </font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/026-sweater.png' /><img src='./../resources/images/027-hoodie.png' /><img src='./../resources/images/020-cardigan-2.png' /><br><img src='./../resources/images/007-oxford-wave-suit-pants.png' /><img src='./../resources/images/009-slim-fit-pants.png' /><img src='./../resources/images/010-jeans.png' />";		
			tempdir += "17";
			many=10;
		}else if(12<= temp_max && temp_max <17){
			max_wear = "<font size=2><b>아우터</b> : 가죽자켓, 자켓 , 간절기 야상, 두꺼운 가디건 <br><b>상의</b> :  셔츠, 긴팔, 맨투맨 / <b>하의</b> : 반바지, 면바지, 슬랙스, 청바지, 스키니 </font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/011-leather-biker-jacket.png' /><img src='./../resources/images/016-denim-jacket.png' /><img src='./../resources/images/019-jacket.png' /><img src='./../resources/images/022-cardigan.png' /><br><img src='./../resources/images/029-shirt-1.png' /><img src='./../resources/images/028-long-sleeves-t-shirt.png' /><br><img src='./../resources/images/009-slim-fit-pants' /><img src='./../resources/images/007-oxford-wave-suit-pants.png' /><img src='./../resources/images/010-jeans.png' />";		
			tempdir += "12";
			many=2;
		}else if(10<= temp_max && temp_max <12){
			max_wear = "<font size=2><b>아우터</b> : 트랜치 코트, 간절기 야상, 자켓+가디건, 자켓+니트 <br> <b>상의</b> : 니트, 긴팔, 맨투맨 <br> 여러겹 껴입기(히트택 이용)</font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/012-trench-coat.png' /><img src='./../resources/images/011-leather-biker-jacket.png' /><img src='./../resources/images/019-jacket.png' /><img src='./../resources/images/022-cardigan.png' /><br><img src='./../resources/images/026-sweater.png' /><img src='./../resources/images/025-sweater-1.png' /><img src='./../resources/images/028-long-sleeves-t-shirt.png' /><img src='./../resources/images/029-shirt-1.png' /><br><img src='./../resources/images/009-slim-fit-pants' /><img src='./../resources/images/007-oxford-wave-suit-pants.png' /><img src='./../resources/images/010-jeans.png' />";		
			tempdir += "10";			
		}else if(6<= temp_max && temp_max <10){
			max_wear = "<font size=2><b>아우터</b> : 코트, 무스탕 <br> <b>상의 : 니트, 기모맨투맨  <br> 하의</b>청바지, 긴바지, 스키니, 기모바지</font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/coat.png' /><img src='./../resources/images/017-coat.png' /><br><img src='./../resources/images/026-sweater.png' /><img src='./../resources/images/025-sweater-1.png' /><br><img src='./../resources/images/009-slim-fit-pants' /><img src='./../resources/images/007-oxford-wave-suit-pants.png' /><img src='./../resources/images/010-jeans.png' />";		
			tempdir += "6";
		}else{
			max_wear = "<font size=2><b>아우터</b> : 패딩, 두꺼운 코트, 무스탕 <br>기모제품, 히트텍, 목도리, 장갑</font><br>";
			clothesstr=max_wear+"<img src='./../resources/images/013-jacket-2.png' /><img src='./../resources/images/coat.png' /><img src='./../resources/images/017-coat.png' /><br><img src='./../resources/images/001-winter-clothes.png' /><img src='./../resources/images/002-glove.png' /><br><img src='./../resources/images/026-sweater.png' /><img src='./../resources/images/025-sweater-1.png' /><br><img src='./../resources/images/009-slim-fit-pants' /><img src='./../resources/images/007-oxford-wave-suit-pants.png' /><img src='./../resources/images/010-jeans.png' />";		
			tempdir += "cold";
		}	
	}
	
	var htmlstr="";
	if("${sessionScope.user.SEX }"=="F"){
		for(var i=1; i<many+1; i++ ){
			htmlstr +=	"<li><img src='./../resources/images/recommend/"+tempdir+"/20f/"+i+".jpg' /></li>";
		}	
	}else{
		for(var i=1; i<many+1; i++ ){
			htmlstr +=	"<li><img src='./../resources/images/recommend/"+tempdir+"/20m/"+i+".jpg' /></li>";
		}
	}
	
	var str = "<br><br><font size=3> 오늘의 기온 </font> "+temp_max+"도/ "+"19.03"+"도";
	//str += "<br><font size=3> 현재 기온 </font>" + currenttemp;

	str += "<br><font size=2>" + weather;
	$("#weather").html(str);
	$("#clothes").html(clothesstr);
	$("#recommend").html(htmlstr);
	</script>
	
</body>
</html>