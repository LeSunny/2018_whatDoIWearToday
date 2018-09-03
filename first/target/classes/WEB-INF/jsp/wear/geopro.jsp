<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type="text/javascript" src="</script>http://maps.google.com/maps/api/js?sensor=false"></script>
<%@ include file="/WEB-INF/include/include-header-first.jspf" %>

</head>
<body>
<script type="text/javascript">

	navigator.geolocation.getCurrentPosition(function(position){
		var latitude = position.coords.latitude;
		var longitude = position.coords.longitude;
		alert("위도 : "+latitude+" 경도 : "+longitude);
		
	});
	
</script>
<%@ include file="/WEB-INF/include/include-body.jspf" %>

</body>
</html>