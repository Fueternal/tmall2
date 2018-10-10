<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<html>
	<script>
		$(function() {
			
			$('#addForm').submit(function() {
				if (!checkEmpty("name", "分类名称")) 
					return false;
				if (!checkEmpty("categoryPic", "分类图片")) 
					return false;
				return true;
			})
		})
	
	</script>
	
	<title>分类管理</title>

	<div class="workingArea">
		<h1 class="label label-info">分类管理</h1>
		<br>
		<br>
		
		<div class="listDataTableDiv">
			<table class="table table-striped table-bordered table-hover  table-condensed">
				<thead>
					<tr class="success">
						<th>ID</th>
                    	<th>图片</th>
                    	<th>分类名称</th>
                    	<th>属性管理</th>
                    	<th>产品管理</th>
                    	<th>编辑</th>
                    	<th>删除</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list }" var="c">
						<tr>
							<td>${c.categoryId }</td>
							<td><img height="40px" src="img/category/${c.categoryId}.jpg"></td>
							<td>${c.categoryName}</td>
							<td><a href="admin_property_list?categoryId=${c.categoryId}"><span class="glyphicon glyphicon-th-list"></span></a></td>                   
		                    <td><a href="admin_product_list?categoryId=${c.categoryId}"><span class="glyphicon glyphicon-shopping-cart"></span></a></td>                  
		                    <td><a href="admin_category_edit?categoryId=${c.categoryId}"><span class="glyphicon glyphicon-edit"></span></a></td>
		                    <td><a deleteLink="true" href="admin_category_delete?categoryId=${c.categoryId}"><span class="glyphicon glyphicon-trash"></span></a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
		<div class="pageDiv">
			<%@include file="../include/admin/adminPage.jsp" %>
		</div>
		
		<div class="panel panel-info addDiv">
			<div class="panel-heading">新增分类</div>
			<div class="panel-body">
				<form action="admin_category_add" id="addForm" method="post" enctype="multipart/form-data">
					<table class="addTable">
						<tr>
							<td>分类名称</td>
							<td><input id="name" name="categoryName" type="text" class="form-control"></td>
						</tr>
						<tr>
							<td>分类图片</td>
							<td><input id="categoryPic" name="categoryImage" type="file" accept="image/*"></td>
						</tr>
						<tr class="submitTr">
							<td colspan="2" align="center">
								<button type="submit" class="btn btn-success">提  交</button>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		
	</div>

<%@include file="../include/admin/adminFooter.jsp"%>
</html>







