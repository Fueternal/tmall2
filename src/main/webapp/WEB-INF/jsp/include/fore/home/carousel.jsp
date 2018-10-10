<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 轮播部分，都是静态的页面，没有用到服务端数据	 -->
<!DOCTYPE html>
<html>
	
	<div id="carousel-of-product" class="carousel-of-product carousel slide1" data-ride="carousel">
		
		<ol class="carousel-indicators">
			<li data-target="#carousel-of-product" data-slide-to="0" class="active"></li>
		    <li data-target="#carousel-of-product" data-slide-to="1"></li>
		    <li data-target="#carousel-of-product" data-slide-to="2"></li>
		    <li data-target="#carousel-of-product" data-slide-to="3"></li>
		</ol>
		
		
		<div class="carousel-inner" role="listbox">
			<div class="item active">
				<img class="carousel carouselImage" src="img/lunbo/1.jpg" >
			</div>
			<div class="item">
      			<img  class="carouselImage" src="img/lunbo/2.jpg" >
    		</div>
		    <div class="item">
		        <img  class="carouselImage" src="img/lunbo/3.jpg" >
		    </div>
		    <div class="item">
		        <img  class="carouselImage" src="img/lunbo/4.jpg" >
		    </div>
		</div>
		
		<!-- Controls -->
<!--   <a class="left carousel-control" href="#carousel-of-product" role="button" data-slide="prev"> -->
<!--     <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span> -->
 
<!--   </a> -->
<!--   <a class="right carousel-control" href="#carousel-of-product" role="button" data-slide="next"> -->
<!--     <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span> -->
 
<!--   </a> -->

	</div>
	

</html>