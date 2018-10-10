<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<!DOCTYPE html>
<html>

	<script>
	    $(function() {
	        $("#addForm").submit(function() {
	            if (!checkEmpty("name", "产品名称"))
	                return false;
	            if (!checkEmpty("subTitle", "小标题"))
	                return false;
	            if (!checkNumber("originalPrice", "原价格"))
	                return false;
	            if (!checkNumber("promotePrice", "优惠价格"))
	                return false;
	            if (!checkInt("stock", "库存"))
	                return false;
	            return true;
	        });
	    });
	</script>

<head>
<meta charset="UTF-8">
<title>产品管理</title>
</head>
<body>

<div class="workingArea">
	<!-- 路径导航 -->
	<ol class="breadcrumb">
		<li><a href="admin_category_list">所有分类</a></li>
		<li><a href="admin_property_list?categoryId=${c.categoryId }">${c.categoryName }</a></li>
		<li class="active">产品管理</li>
	</ol>
	
	<div class="listDataTableDiv">
		<table class="table table-striped table-bordered table-hover  table-condensed">
			<thead>
				<tr class="success">
					<td>产品ID</td>
					<td>图片</td>
					<td>产品名称</td>
					<td>产品小标题</td>
					<td width="60px">原价格</td>
					<td width="60px">优惠价格</td>
					<td width="60px">库存数量</td>
					<td width="60px">图片管理</td>
					<td width="60px">设置属性</td>
					<td width="40px">编辑</td>
					<td width="40px">删除</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list }" var="p">
					<tr>
						<td>${p.productId }</td>
						<td><!-- 将产品单张图片的首张显示在产品管理列表，为了避免空指针，做一个非空的判断 -->
							<c:if test="!empty p.productImage">
								<img src="img/productSingle/${p.productImage.imageId }.jpg" width="40px">
							</c:if>
						</td>
						<td>${p.productName }</td>
						<td>${p.subTitle }</td>
						<td>${p.originalPrice }</td>
						<td>${p.promotePrice }</td>
						<td>${p.stock }</td>
						<td><a href="admin_productImage_list?productId=${p.productId }"><span class="glyphicon glyphicon-picture"></span></a></td>
						<td><a href="admin_productProperty_edit?productId=${p.productId }"><span class="glyphicon glyphicon-th-list"></span></a></td>
						<td><a href="admin_product_edit?productId=${p.productId}"><span class="glyphicon glyphicon-edit"></span></a></td>
		                <td><a deleteLink="true" href="admin_product_delete?productId=${p.productId}"><span class="glyphicon glyphicon-trash"></span></a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<div class="pageDiv">
		<%@include file="../include/admin/adminPage.jsp" %>
	</div>
	
	<div class="panel panel-info addDiv">
		<div class="panel-heading">新增产品</div>
		<div class="panel-body">
			<form action="admin_product_add" id="addForm" method="post">
				<table class="addTable">
					<tr>
						<td>产品名称</td>
						<td><input id="productName" name="productName" type="text" class="form-control"></td>
					</tr>
					<tr>
						<td>产品小标题</td>
						<td><input id="subTitle" name="subTitle" type="text" class="form-control"></td>
					</tr>
					<tr>
						<td>原价格</td>
						<td><input id="originalPrice" name="originalPrice" value="99.99" type="text" class="form-control"></td>
					</tr>
					<tr>
						<td>优惠价格</td>
						<td><input id="promotePrice" name="promotePrice" value="66.66" type="text" class="form-control"></td>
					</tr>
					<tr>
						<td>库存</td>
						<td><input id="stock" name="stock" value="99" type="text" class="form-control"></td>
					</tr>
					<tr class="submitTr">
						<td colspan="2" align="center">
							<input type="hidden" name="categoryId" value="${c.categoryId }">
							<button type="submit" class="btn btn-success">提  交</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>

</div>

</body>

<%@include file="../include/admin/adminFooter.jsp"%>

</html>