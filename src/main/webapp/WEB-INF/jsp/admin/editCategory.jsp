<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>
 
<!DOCTYPE html>
<html>
	<script>
    $(function(){
 
        $("#editForm").submit(function(){
            if(!checkEmpty("name","分类名称"))
                return false;
            return true;
        });
    });
 
	</script>
	
<head>
<meta charset="UTF-8">
<title>编辑分类</title>
</head>
<body>
	<div class="workingArea">
		
		<ol class="breakcrumb">
			<li><a href="admin_category_list">所有分类</a></li>
			<li class="active">编辑分类</li>
		</ol>
		
		<div class="panel panel-warning editDiv">
			<div class="panel-heading">编辑分类</div>
			<div class="panel-body">
				<form action="admin_category_update" id="editForm" method="post" enctype="multipart/form-data">
					<table class="editTable">
						<tr>
							<td>分类名称</td>
							<td><input id="name" name="categoryName" value="${category.categoryName }" type="text" class="form-control">
						</tr>
						<tr>
							<td>分类图片</td>
							<td><input id="categoryPic" name="categoryImage" type="file" accept="image/*"></td>
						</tr>
						<tr class="submitTR">
							<td colspan="2" align="center">
								<input type="hidden" name="categoryId" value="${category.categoryId }">
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