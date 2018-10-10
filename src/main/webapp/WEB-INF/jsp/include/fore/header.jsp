<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- c通常用于条件判断和遍历	fmt用于格式化日期和货币	fn用于校验长度	 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
	<!-- 引入bootstrap和jquery -->
	<script src="js/jquery/2.0.0/jquery.min.js"></script>
	<link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
	<script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
	<!-- 自定义前端样式	 -->
	<link href="css/fore/style.css" rel="stylesheet"> 

	
	<script>
		function formatMoney(num){
		    num = num.toString().replace(/\$|\,/g,''); 
		    if(isNaN(num)) 
		        num = "0"; 
		    sign = (num == (num = Math.abs(num))); 
		    num = Math.floor(num*100+0.50000000001); 
		    cents = num%100; 
		    num = Math.floor(num/100).toString(); 
		    if(cents<10) 
		    cents = "0" + cents; 
		    for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++) 
		    num = num.substring(0,num.length-(4*i+3))+','+ 
		    num.substring(num.length-(4*i+3)); 
		    return (((sign)?'':'-') + num + '.' + cents); 
		}
		
		function checkEmpty(id, name){
		    var value = $("#"+id).val();
		    if(value.length==0){
		         
		        $("#"+id)[0].focus();
		        return false;
		    }
		    return true;
		}
		 
		$(function(){
		 
		    $("a.productDetailTopReviewLink").click(function(){
		        $("div.productReviewDiv").show();
		        $("div.productDetailDiv").hide();
		    });
		    $("a.productReviewTopPartSelectedLink").click(function(){
		        $("div.productReviewDiv").hide();
		        $("div.productDetailDiv").show();      
		    });
		     
		    $("span.leaveMessageTextareaSpan").hide();
		    $("img.leaveMessageImg").click(function(){
		         
		        $(this).hide();
		        $("span.leaveMessageTextareaSpan").show();
		        $("div.orderItemSumDiv").css("height","100px");
		    });
		     
		    $("div#footer a[href$=#nowhere]").click(function(){
		        alert("模仿天猫的连接，并没有跳转到实际的页面");
		    });
		     
		    $("a.wangwanglink").click(function(){
		        alert("模仿旺旺的图标，并不会打开旺旺");
		    });
		    $("a.notImplementLink").click(function(){
		        alert("这个功能没做，蛤蛤~");
		    });
		     
		});
		 
	</script>
	
	
</head>
<body>

</body>
</html>