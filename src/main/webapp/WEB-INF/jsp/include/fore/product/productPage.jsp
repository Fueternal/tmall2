<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- productPage.jsp 又由3个页面组成
1. imgAndInfo.jsp	单个图片和基本信息
2. productReview.jsp	评价信息
3. productDetail.jsp	详情图片	 -->

<!DOCTYPE html>
<html>
	
	<title>模仿天猫官网 ${p.productName}</title>
	<div class="categoryPictureInProductPageDiv">
		<img class="categoryPictureInProductPage" src="img/category/${p.category.categoryId}.jpg">
	</div>

	<div class="productPageDiv">
	    <%@include file="imgAndInfo.jsp" %>
	    <%@include file="productReview.jsp" %>
	    <%@include file="productDetail.jsp" %>
	</div>
	
	
</html>