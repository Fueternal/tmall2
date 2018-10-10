<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>
    
<!DOCTYPE html>
<html>
	
	<script>
    $(function() {
        $("#editForm").submit(function() {
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
<title>编辑产品</title>
</head>
<body>
	
<div class="workingArea">
	<!-- 路径导航 -->
	<ol class="breadcrumb">
		<li><a href="admin_category_list">所有分类</a></li>
		<li><a href="admin_product_list?categoryId=${c.categoryId }">${c.categoryName }</a></li>
		<li class="active">${p.productName }</li>
		<li class="active">编辑属性</li>
	</ol>
	
	<div class="panel panel-warning editDiv">
			<div class="panel-heading">编辑产品</div>
			<div class="panel-body">
				<form action="admin_product_update" id="editForm" method="post">
					<table class="editTable">
						<tr>
							<td>产品名称</td>
							<td><input id="productName" name="productName" value="${p.productName }" type="text" class="form-control">
						</tr>
						<tr>
							<td>产品小标题</td>
							<td><input id="subTitle" name="subTitle" value="${p.subTitle }" type="text" class="form-control">
						</tr>
						<tr>
							<td>原价格</td>
							<td><input id="originalPrice" name="originalPrice" value="${p.originalPrice }" type="text" class="form-control">
						</tr>
						<tr>
							<td>优惠价格</td>
							<td><input id="promotePrice" name="promotePrice" value="${p.promotePrice }" type="text" class="form-control">
						</tr>
						<tr>
							<td>库存</td>
							<td><input id="stock" name="stock" value="${p.stock }" type="text" class="form-control">
						</tr>
						<tr class="submitTR">
							<td colspan="2" align="center">
								<input type="hidden" name="productId" value="${p.productId }">
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
</html>