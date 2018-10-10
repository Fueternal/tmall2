<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- categoryPage.jsp 里有3个内容
1. 显示当前分类图片
2. 排序条 sortBar.jsp
3. 产品列表 productsByCategory.jsp -->


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>模仿天猫官网-${c.categoryName }</title>
</head>
<body>
	<div id="category">
		<div class="categoryPageDiv">
			<img src="img/category/${c.categoryId }.jpg">
			<%@include file="sortBar.jsp"%>
        	<%@include file="productsByCategory.jsp"%>
		</div>
	</div>

</body>
</html>