<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

	<nav class="top">
		<a href="${contextPath }">
			<span class="glyphicon glyphicon-home redColor" style="color: #C40000;margin: 0px"></span>
			天猫首页
		</a>
		
		<span>喵，欢迎来到天猫</span>
		
		<c:if test="${!empty user }">
			<a href="loginPage">${user.userName }</a>
			<a href="forelogout">退出</a>
		</c:if>
		
		<c:if test="${empty user }">
			<a href="loginPage">请登录</a>
			<a href="registerPage">免费注册</a>
		</c:if>
		
		<span class="pull-right">
			<a href="forebought">我的订单</a>
			<a href="forecart">
				<span class="glyphicon glyphicon-shopping-cart redColor" style="color:#C40000;margin:0px"></span>
				购物车<strong>${cartTotalItemNumber}</strong>件
			</a>
		</span>
	
	</nav>


</html>