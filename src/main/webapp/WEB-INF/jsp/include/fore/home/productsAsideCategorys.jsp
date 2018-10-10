<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- productsAsideCategorys.jsp 进行了三层遍历
1. 先取出每个分类
2. 然后取出每个分类的productsByRow集合
3. 根据productsByRow集合，取出每个产品，把产品的subTitle信息里的第一个单词取出来显示。 -->

<!DOCTYPE html>
<html>
	
	<!-- 这个是用于随机挑选一个产品作为推荐产品，来进行高亮显示。 
	严格的说，应该是后台设置那个产品是推荐产品，不过这里直接在前端按照20%的概率，随机挑选了一个产品	 -->
	<script>
		$(function(){
		    $("div.productsAsideCategorys div.row a").each(function(){
		        var v = Math.round(Math.random() *6);
		        if(v == 1)
		            $(this).css("color","#87CEFA");
		    });
		});
	</script>
	
	<c:forEach items="${cs }" var="c">
		<div categoryId="${c.categoryId}" class="productsAsideCategorys">
			<c:forEach items="${c.productsByRow }" var="ps">
				<div class="row show1">
					<c:forEach items="${ps }" var="p">
						<c:if test="${!empty p.subTitle }">
							<a href="foreproduct?productId=${p.productId }">
								<c:forEach items="${fn:split(p.subTitle, '') }" var="title" varStatus="st">
									<c:if test="${st.index==0 }">
										${title }
									</c:if>
								</c:forEach>
							</a>
						</c:if>
					</c:forEach>
					<div class="seperator"></div>
				</div>
			</c:forEach>
		</div>
	</c:forEach>


</html>



