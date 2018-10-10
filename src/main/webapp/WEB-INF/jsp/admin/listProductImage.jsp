<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>
    
<!DOCTYPE html>
<html>
	
<script>
    $(function(){
        $(".addFormSingle").submit(function(){
            if(checkEmpty("filepathSingle","图片文件")){
                $("#filepathSingle").value("");
                return true;
            }
            return false;
        });
        $(".addFormDetail").submit(function(){
            if(checkEmpty("filepathDetail","图片文件"))
                return true;
            return false;
        });
    });
 
</script>
	
<head>
<meta charset="UTF-8">
<title>产品图片管理</title>
</head>
<body>

<div class="workingArea">
	
	<!-- 路径导航 -->
	<ol class="breadcrumb">
		<li><a href="admin_category_list">所有分类</a></li>
		<li><a href="admin_property_list?categoryId=${p.category.categoryId }">${p.category.categoryName }</a></li>
		<li class="active">${p.productName }</li>
		<li class="active">产品图片管理</li>
	</ol>
	
	<table class="addPictureTable" align="center">
		<tr>
			<td class="addPictureTableTD">
				<div>
					<div class="panel panel-warning addPictureDiv">
						<div class="panel-heading">新增产品<b class="text-primary">单个</b>图片</div>
						<div class="panel-body">
							<form action="admin_productImage_add" method="post" class="addFormSingle" enctype="multipart/form-data">
								<table class="addTable">
									<tr><td>请选择本地图片 尺寸400X400 为佳</td></tr>
									<tr><td><input id="filepathSingle" type="file" name="image"></td></tr>
									<tr class="submitTR">
										<td align="center">
											<input type="hidden" name="type" value="type_single">
											<input type="hidden" name="productId" value="${p.productId }">
											<button type="submit" class="btn btn-success">提 交</button>
										</td>
									</tr>
								</table>
							</form>
						</div>
					</div>
					<table class="table table-striped table-bordered table-hover  table-condensed">
						<thead>
							<tr class="success">
								<td>图片ID</td>
								<td>产品单个图片</td>
								<td width="40px">删除</td>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${listSingle }" var="pi">
								<tr>
									<td>${pi.imageId }</td>
									<td>
										<a title="点击查看原图" href="img/productSingle/${pi.imageId }.jpg"><img src="img/productSingle/${pi.imageId }.jpg" height="50px"></a>
									</td>
					                <td><a deleteLink="true" href="admin_productImage_delete?imageId=${pi.imageId}"><span class="glyphicon glyphicon-trash"></span></a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</td>
		
			<td class="addPictureTableTD">
				<div>
					<div class="panel panel-warning addPictureDiv">
						<div class="panel-heading">新增产品<b class="text-primary">详情</b>图片</div>
						<div class="panel-body">
							<form action="admin_productImage_add" method="post" class="addFormDetail" enctype="multipart/form-data">
								<table class="addTable">
									<tr><td>请选择本地图片 尺寸790  为佳</td></tr>
									<tr><td><input id="filepathDetail" type="file" name="image"></td></tr>
									<tr class="submitTR">
										<td align="center">
											<input type="hidden" name="type" value="type_detail">
											<input type="hidden" name="productId" value="${p.productId }">
											<button type="submit" class="btn btn-success">提 交</button>
										</td>
									</tr>
								</table>
							</form>
						</div>
					</div>
					<table class="table table-striped table-bordered table-hover  table-condensed">
						<thead>
							<tr class="success">
								<td>图片ID</td>
								<td>产品详情图片</td>
								<td width="40px">删除</td>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${listDetail }" var="pi">
								<tr>
									<td>${pi.imageId }</td>
									<td><a title="点击查看原图" href="img/productDetail/${pi.imageId }.jpg"><img src="img/productDetail/${pi.imageId }.jpg" height="50px"></a></td>
					                <td><a deleteLink="true" href="admin_productImage_delete?imageId=${pi.imageId}"><span class="glyphicon glyphicon-trash"></span></a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</td>
			
		</tr>
	</table>

</div>

</body>

<%@include file="../include/admin/adminFooter.jsp"%>
</html>