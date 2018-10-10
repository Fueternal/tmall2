<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- c通常用于条件判断和遍历	fmt用于格式化日期和货币	fn用于校验长度	 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- sortBar.jsp 即排序条，做了如下几个与数据相关的事情
	1. 根据sort参数判断哪个排序按钮高亮
	2. 每个排序按钮提交到本页面，即/forecategory，并带上参数sort -->

<!DOCTYPE html>
<html>

	<script>
	$(function(){
	    $("input.sortBarPrice").keyup(function(){
	        var num= $(this).val();
	        if(num.length==0){
	            $("div.productUnit").show();
	            return;
	        }
	             
	        num = parseInt(num);
	        if(isNaN(num))
	            num= 1;
	        if(num<=0)
	            num = 1;
	        $(this).val(num);      
	         
	        var begin = $("input.beginPrice").val();
	        var end = $("input.endPrice").val();
	        if(!isNaN(begin) && !isNaN(end)){
	            console.log(begin);
	            console.log(end);
	            $("div.productUnit").hide();
	            $("div.productUnit").each(function(){
	                var price = $(this).attr("price");
	                price = new Number(price);
	                 
	                if(price<=end && price>=begin)
	                    $(this).show();
	            });
	        }
	    });
	});
	</script>
	
	
	<div class="categorySortBar">
		<table class="categorySortBarTable categorySortTable">
			<tr>
				<td <c:if test="${'all'==param.sort || empty param.sort }">class="grayColumn"</c:if> >
					<a href="?categoryId=${c.categoryId }&sort=all">综合
						<span class="glyphicon glyphicon-arrow-down"></span>
					</a>
				</td>
				<td <c:if test="${'review'==param.sort }">class="grayColumn"</c:if> >
					<a href="?categoryId=${c.categoryId }&sort=review">人气
						<span class="glyphicon glyphicon-arrow-down"></span>
					</a>
				</td>
				<td <c:if test="${'date'==param.sort }">class="grayColumn"</c:if> >
					<a href="?categoryId=${c.categoryId }&sort=date">新品
						<span class="glyphicon glyphicon-arrow-down"></span>
					</a>
				</td>
				<td <c:if test="${'saleCount'==param.sort }">class="grayColumn"</c:if> >
					<a href="?categoryId=${c.categoryId }&sort=saleCount">销量
						<span class="glyphicon glyphicon-arrow-down"></span>
					</a>
				</td>
				<td <c:if test="${'price'==param.sort }">class="grayColumn"</c:if> >
					<a href="?categoryId=${c.categoryId }&sort=price">价格
						<span class="glyphicon glyphicon-resize-vertical"></span>
					</a>
				</td>
			</tr>
		</table>
		
		<table>
			<tr>
				<td><input class="sortBarPrice beginPrice" type="text" placeholder="请输入"></td>
				<td class="grayColumn priceMiddleColumn">-</td>
				<td><input class="sortBarPrice endPrice" type="text" placeholder="请输入"></td>
			</tr>
		</table>
	</div>
	
	
</html>



