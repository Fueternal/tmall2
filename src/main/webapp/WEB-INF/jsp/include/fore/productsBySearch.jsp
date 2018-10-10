<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!-- c通常用于条件判断和遍历	fmt用于格式化日期和货币	fn用于校验长度	 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

	<!-- productsBySearch.jsp 显示产寻结果：
	1. 遍历ps，把每个产品的图片，价格，标题等信息显示出来
	2. 如果ps为空，则显示 "没有满足条件的产品" -->

<!DOCTYPE html>
<html>
	
	<div class="searchProducts">
		<c:forEach items="${ps }" var="p">
			<div class="productUnit">
				<a href="foreproduct?productId=${p.productId }">
					<img src="img/productSingle/${p.productImage.imageId}.jpg">
				</a>
				<span class="productPrice">￥<fmt:formatNumber type="number" value="${p.promotePrice}" minFractionDigits="2"></fmt:formatNumber></span>
				<a class="productLink" href="foreproduct?productId=${p.productId }">${fn:substring(p.productName, 0, 50)}</a>
				
				<a class="tmallLink" href="foreproduct?productId=${p.productId }">天猫专卖</a>
				
				<div class="productInfo">
	                <span class="monthDeal ">月成交 <span class="productDealNumber">${p.saleCount}笔</span></span>
	                <span class="productReview">评价<span class="productReviewNumber">${p.reviewCount}</span></span>
	                <span class="wangwang"><img src="img/site/wangwang.png"></span>
	            </div>
				
			</div>
		</c:forEach>
		
		<c:if test="${empty ps}">
	        <div class="noMatch">没有满足条件的产品<div>
	    </c:if>
	    
	    <div style="clear:both"></div>
	    
	</div>
	
	
</html>



