<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- c通常用于条件判断和遍历	fmt用于格式化日期和货币	fn用于校验长度	 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>

	<c:if test="${empty param.categorycount}">
   		<c:set var="categorycount" scope="page" value="20"/>
	</c:if>
	 
	<c:if test="${!empty param.categorycount}">
	    <c:set var="categorycount" scope="page" value="${param.categorycount}"/>
	</c:if>

	<div class="categoryProducts">
		<c:forEach items="${c.products }" var="p" varStatus="stc">
			<c:if test="${stc.count<=categorycount }">
				<div class="productUnit">
					<div class="productUnitFrame">
						<a href="foreproduct?productId=${p.productId }">
						 	<img class="productImage" src="img/productSingle_middle/${p.productImage.imageId}.jpg">
						</a>
						<span class="productPrice">￥ <fmt:formatNumber type="number" value="${p.promotePrice }" minFractionDigits="2" /></span>
						<a class="productLink" href="foreproduct?productId=${p.productId }">${fn:substring(p.productName, 0, 50)}</a>
						<a  class="tmallLink" href="foreproduct?productId=${p.productId }">天猫专卖</a>
						
						<div class="show1 productInfo">
							<span class="monthDeal">月成交<span class="productDealNumber">${p.saleCount }笔</span></span>
							<span class="productReview">评价<span class="productReviewNumber">${p.reviewCount }</span></span>
							<span>
								<a class="wangwanglink" href="#nowhere"><img src="img/site/wangwang.png"></a>
							</span>
						</div>
					</div>
				</div>
			</c:if>
		</c:forEach>
		<div style="clear:both"></div>
	</div>
</html>


