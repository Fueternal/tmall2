<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<!DOCTYPE html>
<html>

<script>
    $(function(){
        $("button.orderPageCheckOrderItems").click(function(){
            var orderId = $(this).attr("orderId");
            $("tr.orderPageOrderItemTR[orderId="+orderId+"]").toggle();
        });
    });
 
</script>

<head>
<meta charset="UTF-8">
<title>订单管理</title>
</head>
<body>
	
	<div class="workingArea">
		<h1 class="label label-info">订单管理</h1>
		<br><br><br>
		
		
		<div class="listDataTableDiv">
			<table class="table table-striped table-bordered table-hover1  table-condensed">
				<thead>
					<tr class="success">
						<th>订单ID</th>
						<th>订单状态</th>
						<th width="100px">订单总金额</th>
						<th width="80px">商品数量</th>
						<th>买家名称</th>
						<th width="150px">创建时间</th>
						<th width="150px">支付时间</th>
						<th width="150px">发货时间</th>
						<th width="150px">确认收货时间</th>
						<th width="100px">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list }" var="o">
						<tr>
							<td>${o.orderId }</td>
							<td>${o.getStatuDesc() }</td>
							<!-- fmt:formatNumber标签用于格式化数字，百分比，货币。 minFractionDigits小数点后最小的位数 -->
							<td>￥<fmt:formatNumber type="number" value="${o.total }" minFractionDigits="2"></fmt:formatNumber></td>	
							<td align="center">${o.totalNumber }</td>
							<td align="center">${o.user.userName }</td>
							<!-- fmt:formatDate标签用于使用不同的方式格式化日期   -->
							<td><fmt:formatDate value="${o.createDate }" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></td>
							<td><fmt:formatDate value="${o.payDate }" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></td>
							<td><fmt:formatDate value="${o.deliveryDate }" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></td>
							<td><fmt:formatDate value="${o.confirmDate }" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></td>
							<td>
								<button orderId="${o.orderId }" class="orderPageCheckOrderItems btn btn-primary btn-xs">查看详情</button>
								<c:if test="${o.status=='waitDelivery' }">
									<a href="admin_order_delivery?orderId=${o.orderId }"><button class="btn btn-primary btn-xs">发货</button></a>
								</c:if>
							</td>
						</tr>
						
						<tr class="orderPageOrderItemTR" orderId=${o.orderId }>
							<td colspan="10" align="center" ><!-- 订单详情 -->
								<div class="orderPageOrderItem">
									<table width="800px" align="center" class="orderPageOrderItemTable">
										<c:forEach items="${o.orderItems }" var="oi">
											<tr>
												<td align="left" width="60px">
													<img width="50px" src="img/productSingle/${oi.product.productImage.imageId }.jpg">
												</td>
												<td width="200px" align="center">
													<!-- foreproduct是用于在前台显示产品的，当前还在开发后台。 这个前台显示功能在后续对应的教程会详细讲解呢 -->
													<a href="foreproduct?productId=${oi.product.productId }">
														<span>${oi.product.productName }</span>
													</a>
												</td>
												<td align="center" width="50px">
													<span class="text-muted">${oi.number } 个</span>
												</td>
												<td width="100px" align="center">
													<span class="text-muted">单价： ￥ ${oi.product.promotePrice }</span>
												</td>
											</tr>
										</c:forEach>
									</table>
								</div>
							</td>
						</tr>

					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	
	<div class="pageDiv">
        <%@include file="../include/admin/adminPage.jsp" %>
    </div>


</body>
 
<%@include file="../include/admin/adminFooter.jsp"%>

</html>


