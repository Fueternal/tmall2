<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- c通常用于条件判断和遍历	fmt用于格式化日期和货币	fn用于校验长度	 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
	
	<div>
		<a href="${contextPath }">
			<img id="simpleLogo" class="simpleLogo" src="img/site/simpleLogo.png">
		</a>
		
		<form action="foresearch" method="post">
			<div class="simpleSearchDiv pull-right">
				<input type="text" name="keyword" placeholder="平板电脑    平衡车" value="${param.keyword}">
				<button class="searchButton" type="submit">搜天猫</button>
				<div class="searchBelow">
					<c:forEach items="${cs }" var="c" varStatus="st">
						<c:if test="${st.count>=8 and st.count<=11 }">
							<span>
								<a href="forecategory?categoryId=${c.categoryId }">${c.categoryName }</a>
								<c:if test="${st.count != 11 }">
									<span> | </span>
								</c:if>
							</span>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</form>
		<div style="clear:both"></div>
	</div>



</html>