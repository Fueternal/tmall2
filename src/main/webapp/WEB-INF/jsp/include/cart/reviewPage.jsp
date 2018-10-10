<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>    

<!DOCTYPE html>
<html>
	
	<div class="reviewDiv">
		<div class="reviewProductInfoDiv">
			<div class="reviewProductInfoImg">
				<img width="400px" height="400px" src="img/productSingle/${p.productImage }.jpg">
			</div>
			<div class="reviewProductInfoRightDiv">
				${p.productName }
			</div>
			<table class="reviewProductInfoTable">
				<tr>
					<td width="75px">价格 </td>
					<td><span class="reviewProductInfoTablePrice">￥<fmt:formatNumber type="number" value="${p.originalPrice }" minFractionDigits="2"></fmt:formatNumber></span>元</td>
				</tr>
				<tr>
					<td>配送</td>
					<td>快递：	0.00</td>
				</tr>
				<tr>
					<td>月销量</td>
					<td><span class="reviewProductInfoTableSellNumber">${p.saleCount }</span></td>
				</tr>
			</table>
			<div class="reviewProductInfoRightBelowDiv">
				<span class="reviewProductInfoRightBelowImg"><img src="img/site/reviewLight.png"></span>
				<span class="reviewProductInfoRightBelowText">
					现在查看的是 您所购买商品的信息于<fmt:formatDate value="${o.createDate }" pattern="yyyy年MM月dd日"/>下单购买了此商品
				</span>
			</div>
		</div>
		<div style="clear:both"></div>
	</div>
	<div class="reviewStasticsDiv">
		<div class="reviewStasticsLeft">
			<div class="reviewStasticsLeftTop"></div>
			<div class="reviewStasticsLeftContent">累计评论<span class="reviewStasticsNumber">${p.reviewCount }</span></div>
			<div class="reviewStasticsLeftFoot"></div>
		</div>
		<div class="reviewStasticsRight">
			<div class="reviewStasticsRightEmpty"></div>
            <div class="reviewStasticsFoot"></div>
		</div>
	</div>
	
	<c:if test="${param.showonly==true }">
		<div class="reviewDivlistReviews">
			<c:forEach items="${reviews }" var="r">
				<div class="reviewDivlistReviewsEach">
					<div class="reviewDate"><fmt:formatDate value="${r.createDate }" pattern="yyyy-MM-dd"/></div>
					<div class="reviewContent">${r.content }</div>
					<div class="reviewUserInfo pull-right">${r.user.getAnonymousName() }</div>
				</div>
			</c:forEach>
		</div>
	</c:if>
	
	<c:if test="${param.showonly!=true }">
		<div class="makeReviewDiv">
			<form action="foredoreview" method="post">
				<div class="makeReviewText">其他买家，需要你的建议哦！</div>
				<table class="makeReviewTable">
					<tr>
						<td class="makeReviewTableFirstTD">评价商品</td>
						<td><textarea name="content"></textarea></td>
					</tr>
				</table>
				<div class="makeReviewButtonDiv">
					<input type="hidden" name="orderId" value="${o.orderId }">
					<input type="hidden" name="productId" value="${p.productId }">
					<button type="submit">提交评价</button>
				</div>
			</form>
		</div>
	</c:if>


</html>



