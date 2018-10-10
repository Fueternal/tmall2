<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
	
<div class="buyPageDiv">

	<form action="forecreateOrder" method="post">
		<div class="buyFlow">
	        <img class="pull-left" src="img/site/simpleLogo.png">
	        <img class="pull-right" src="img/site/buyflow.png">
	        <div style="clear:both"></div>
    	</div>
    	
    	<div class="address">
    		<div class="addressTip">输入收货地址</div>
    		<div class="addressinfo">
    			<table class="addressTable">
    				<tr>
    					<td>详细地址<span class="redStar">*</span></td>
    					<td><textarea name="address" placeholder="建议您如实填写详细收货地址，例如接到名称，门牌好吗，楼层和房间号等信息"></textarea></td>
    				</tr>
    				<tr>
    					<td>邮政编码</td>
    					<td><input name="post" type="text" placeholder="如果您不清楚邮递区号，请填写000000"></td>
    				</tr>
    				<tr>
    					<td>收货人姓名<span class="redStar">*</span></td>
    					<td><input name="receive" type="text" placeholder="长度不超过25个字符"></td>
    				</tr>
    				<tr>
    					<td>手机号码<span class="redStar">*</span></td>
    					<td><textarea name="mobile" placeholder="请输入11位手机号码"></textarea></td>
    				</tr>
    			</table>
    		</div>
    	</div>
    	
    	<div class="productList">
    		<div>确认订单信息</div>
    		<table class="productListTable">
    			<thead>
    				<tr>
    					<th colspan="2" class="productListTableFirstColumn">
    						<img class="tmallbuy" src="img/site/tmallbuy.png">
	                        <a class="marketLink" href="#nowhere">店铺：天猫店铺</a>
	                        <a class="wangwanglink" href="#nowhere"><span class="wangwangGif"></span></a>
    					</th>
    					<th>单价</th>
    					<th>数量</th>
    					<th>小计</th>
    					<th>配送方式</th>
    				</tr>
    				<tr class="rowborder">
	                    <td  colspan="2" ></td>
	                    <td></td>
	                    <td></td>
	                    <td></td>
	                    <td></td>
	                </tr>
    			</thead>
    			
    			<tbody class="productListTableTbody">
    				<c:forEach items="${ois }" var="oi" varStatus="st">
    					<tr class="orderItemTR">
    						<td class="orderItemFirstTD"><img src="img/productSingle_middle/${oi.product.productImage.imageId }.jpg"></td>
    						<td class="orderItemProductInfo">
    							<a href="foreproduct?productId=${oi.product.productId }">${oi.product.productName }</a>
    							<img src="img/site/creditcard.png" title="支持信用卡支付">
	                            <img src="img/site/7day.png" title="消费者保障服务,承诺7天退货">
	                            <img src="img/site/promise.png" title="消费者保障服务,承诺如实描述">
    						</td>
    						<td>
    							<span class="orderItemProductPrice">￥<fmt:formatNumber type="number" value="${oi.product.promotePrice }" /></span>
    						</td>
    						<td class="orderItemProductNumber">${oi.number }</td>
    						<td>
    							<span class="orderItemUnitSum">￥<fmt:formatNumber type="number" value="${oi.product.promotePrice*oi.number }" minFractionDigits="2" /></span>
    						</td>
    						<c:if test="${st.count==1 }">
    							<td class="orderItemLastTD" rowspan="5">
    								<label class="orderItemDeliveryLabel">
    									<input type="radio" checked="checked">普通配送
    								</label>
    								<select class="orderItemDeliverySelect" class="form-control">
    									<option>快递 免邮费</option>
    									<option>新疆、西藏区域邮费10元</option>
    									<option>顺丰到付</option>
    								</select>
    							</td>
    						</c:if>
    					</tr>
    				</c:forEach>
    			</tbody>
    		</table>
    		
    		<div class="orderItemSumDiv">
    			<div class="pull-left">
    				<span class="leaveMessageText">给卖家留言：</span>
    				<span><img class="leaveMessageImg" src="img/site/leaveMessage.png"></span>
    				<span class="leaveMessageTextareaSpan">
    					<textarea name="userMessage" class="leaveMessageTextarea"></textarea>
    					<div><span>还可以输入200个字符</span></div>
    				</span>
    			</div>
    			<span class="pull-right">店铺合计(含运费): ￥<fmt:formatNumber type="number" value="${total }" minFractionDigits="2" /> </span>
    		</div>
    		 
    	</div>
    	
    	<div class="orderItemTotalSumDiv">
    		<div class="pull-right">
    			<span> 实付款： </span>
    			<span>￥<fmt:formatNumber type="number" value="${total }" minFractionDigits="2" /></span>
    		</div>
    	</div>
    	
    	<div class="submitOrderDiv">
            <button type="submit" class="submitOrderButton">提交订单</button>
    	</div>
    	
     </form>
    	
</div>

	


</html>