<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>编辑属性</title>
</head>
<body>

<div class="workingArea">
	<!-- 路径导航 -->
	<ol class="breadcrumb">
		<li><a href="admin_category_list">所有分类</a></li>
		<li><a href="admin_property_list?categoryId=${c.categoryId }">${c.categoryName }</a></li>
		<li class="active">编辑属性</li>
	</ol>
	
	<div class="panel panel-warning editDiv">
			<div class="panel-heading">编辑属性</div>
			<div class="panel-body">
				<form action="admin_property_update" id="editForm" method="post">
					<table class="editTable">
						<tr>
							<td>属性名称</td>
							<td><input id="name" name="propertyName" value="${p.propertyName }" type="text" class="form-control">
						</tr>
						<tr class="submitTR">
							<td colspan="2" align="center">
								<input type="hidden" name="propertyId" value="${p.propertyId }">
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