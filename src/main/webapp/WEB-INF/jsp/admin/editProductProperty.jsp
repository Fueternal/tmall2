<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<!DOCTYPE html>
<html>

<script>
	$(function() {
	    $("input.ppValue").keyup(function(){
	        var value = $(this).val();
	        var page = "admin_propertyProperty_update";
	        var pvid = $(this).attr("ppid");
	        var parentSpan = $(this).parent("span");
	        parentSpan.css("border","1px solid yellow");
	        $.post(
	                page,
	                {"value":value,"id":ppid},
	                function(result){
	                    if("success"==result)
	                        parentSpan.css("border","1px solid green");
	                    else
	                        parentSpan.css("border","1px solid red");
	                }
	            );     
	    });
	});
</script>
	
<head>
<meta charset="UTF-8">
<title>编辑产品属性</title>
</head>
<body>
	
<div class="workingArea">
	<!-- 路径导航 -->
	<ol class="breadcrumb">
		<li><a href="admin_category_list">所有分类</a></li>
		<li><a href="admin_product_list?categoryId=${p.category.categoryId }">${p.category.categoryName }</a></li>
		<li class="active">${p.productName }</li>
		<li class="active">编辑产品属性</li>
	</ol>
	
	<div class="editProductPropertyDiv">
		<c:forEach items="${list }" var="pp">
			<div class="eachProductProperty">
				<span class="ppName">${pp.property.propertyName }</span>
				<span class="ppValue"><input class="ppValue" ppid="${pp.productPropertyId }" type="text" value="${pp.value }"></span>
			</div>
		</c:forEach>
		<div style="clear: both"></div>
	</div>
	
</div>	

</body>
</html>