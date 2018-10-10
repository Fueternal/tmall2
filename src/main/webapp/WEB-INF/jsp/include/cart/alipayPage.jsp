<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>

<!DOCTYPE html>
<html>
	
	<div class="aliPayPageDiv">
		<div class="aliPayPageLogo">
			<img class="pull-left" src="img/site/simpleLogo.png">
			<div style="clear:both"></div>
		</div>
		<div>
			<span class="confirmMoneyText">扫一扫付款（元）</span>
			<span class="confirmMoney">
				￥ <fmt:formatNumber type="number" value="${param.total }" minFractionDigits="2" ></fmt:formatNumber>
			</span>
		</div>
		<div>
			<img class="aliPayImg" src="img/site/alipay2wei.png">
		</div>
		<div>
			<a href="forepayed?orderId=${param.orderId }&total=${param.total }"><button class="confirmPay">确认支付</button></a>
		</div>
	</div>



</html>






