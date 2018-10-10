<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- categoryAndcarousel.jsp 页面利用ForeController传递过来的数据，天猫国际几个字旁边显示4个分类超链
另外包含了其他3个页面：
categoryMenu.jsp和productsAsideCategorys.jsp和carousel.jsp	 -->

<!DOCTYPE html>
<html>

	<script>
		function showProductsAsideCategorys(categoryId){
		    $("div.eachCategory[categoryId="+categoryId+"]").css("background-color","white");
		    $("div.eachCategory[categoryId="+categoryId+"] a").css("color","#87CEFA");
		    $("div.productsAsideCategorys[categoryId="+categoryId+"]").show();
		}
		 
		function hideProductsAsideCategorys(categoryId){
		    $("div.eachCategory[categoryId="+categoryId+"]").css("background-color","#e2e2e3");
		    $("div.eachCategory[categoryId="+categoryId+"] a").css("color","#000");
		    $("div.productsAsideCategorys[categoryId="+categoryId+"]").hide();
		}
		$(function(){
		    $("div.eachCategory").mouseenter(function(){
		        var categoryId = $(this).attr("categoryId");
		        showProductsAsideCategorys(categoryId);
		    });
		    $("div.eachCategory").mouseleave(function(){
		        var categoryId = $(this).attr("categoryId");
		        hideProductsAsideCategorys(categoryId);
		    });
		    $("div.productsAsideCategorys").mouseenter(function(){
		        var categoryId = $(this).attr("categoryId");
		        showProductsAsideCategorys(categoryId);
		    });
		    $("div.productsAsideCategorys").mouseleave(function(){
		        var categoryId = $(this).attr("categoryId");
		        hideProductsAsideCategorys(categoryId);
		    });
		     
		    $("div.rightMenu span").mouseenter(function(){
		        var left = $(this).position().left;
		        var top = $(this).position().top;
		        var width = $(this).css("width");
		        var destLeft = parseInt(left) + parseInt(width)/2;
		        $("img#catear").css("left",destLeft);
		        $("img#catear").css("top",top-20);
		        $("img#catear").fadeIn(500);
		                 
		    });
		    $("div.rightMenu span").mouseleave(function(){
		        $("img#catear").hide();
		    });
		     
		    var left = $("div#carousel-of-product").offset().left;
		    $("div.categoryMenu").css("left",left-20);
		    $("div.categoryWithCarousel div.head").css("margin-left",left);
		    $("div.productsAsideCategorys").css("left",left-20);
		     
		});
	</script>
	
	<img src="img/site/catear.png" id="catear" class="catear">
	
	<div class="categoryWithCarousel">
		
		<div class="headbar show1">
			<div class="head">
				<span style="margin-left:10px" class="glyphicon glyphicon-th-list"></span>
				<span style="margin-left:10px">商品分类</span>
			</div>
			
			<div class="rightMenu">
				<span><a href=""><img src="img/site/chaoshi.png"/></a></span>
				<span><a href=""><img src="img/site/guoji.png"/></a></span>
				<c:forEach items="${cs }" var="c" varStatus="st">
					<c:if test="${st.count<=4 }">
						<span>
							<a href="forecategory?categoryId=${c.categoryId }">
								${c.categoryName }
							</a>
						</span>
					</c:if>
				</c:forEach>
			</div>
		</div>
		
		<div style="position: relative">
			<%@include file="categoryMenu.jsp" %>
		</div>
		
		<div style="position: relative;left: 0;top: 0;">
    		<%@include file="productsAsideCategorys.jsp" %>
		</div>
		
		<%@include file="carousel.jsp" %>
		
		<div class="carouselBackgroundDiv"></div>
		
	</div>
	
	
</html>













