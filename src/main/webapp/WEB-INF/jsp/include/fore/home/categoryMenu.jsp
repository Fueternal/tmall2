<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- 显示首页左侧的商品分类竖状分类导航  -->
<!DOCTYPE html>
<html>

	<div class="categoryMenu">
		<c:forEach items="${cs }" var="c" >
			<div categoryId="${c.categoryId }" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="forecategory?categoryId=${c.categoryId}">
					${c.categoryName }
				</a>
			</div>
		</c:forEach>
	</div>

</html>