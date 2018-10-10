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
            if (checkEmpty("name", "属性名称"))
                return true;
            return false;
        });
    });
</script>
	
<head>
<meta charset="UTF-8">
<title>属性管理</title>
</head>
<body>

<div class="workingArea">
	<!-- 路径导航 -->
	<ol class="breadcrumb">
		<li><a href="admin_category_list">所有分类</a></li>
		<li><a href="admin_property_list?categoryId=${c.categoryId }">${c.categoryName }</a></li>
		<li class="active">属性管理</li>
	</ol>
		
	<div class="listDataTableDiv">
		<table class="table table-striped table-bordered table-hover  table-condensed">
			<thead>
				<tr class="success">
					<td>属性ID</td>
					<td>属性名称</td>
					<td>编辑</td>
					<td>删除</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list }" var="p">
					<tr>
						<td>${p.propertyId }</td>
						<td>${p.propertyName }</td>
						<td><a href="admin_property_edit?propertyId=${p.propertyId}"><span class="glyphicon glyphicon-edit"></span></a></td>
		                <td><a deleteLink="true" href="admin_property_delete?propertyId=${p.propertyId}"><span class="glyphicon glyphicon-trash"></span></a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<div class="pageDiv">
		<%@include file="../include/admin/adminPage.jsp" %>
	</div>
	
	<div class="panel panel-info addDiv">
		<div class="panel-heading">新增属性</div>
		<div class="panel-body">
			<form action="admin_property_add" id="addForm" method="post">
				<table class="addTable">
					<tr>
						<td>属性名称</td>
						<td><input id="name" name="propertyName" type="text" class="form-control"></td>
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