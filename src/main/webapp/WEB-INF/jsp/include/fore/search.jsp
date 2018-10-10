<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<a href="${contextPath }">
		<img id="logo" class="logo" src="img/site/logo.gif">
	</a>
	
	<form action="foresearch" method="post">
		<div class="searchDiv">
			<input name="keyword" type="text" placeholder="平板电视  男表 	" value="${param.keyword }">
			<button class="searchButton" type="submit">搜索</button>
			<div class="searchBelow">
				<c:forEach items="${cs }" var="c" varStatus="st">
					<c:if test="${st.count>=5 and st.count<=8 }">
						<span>
							<a href="forecategory?categoryId=${c.categoryId }">${c.categoryName }</a>
							<c:if test="${st.count!=8 }">
								<span> | </span>
							</c:if>
						</span>
					</c:if>
				</c:forEach>
			</div>
		</div>
	</form>

</html>