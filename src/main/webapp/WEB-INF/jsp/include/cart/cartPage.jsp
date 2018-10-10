<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
	
<script>
	var deleteOrderItem = false;
	var deleteOrderItemid = 0;
	$(function(){
	 
	    $("a.deleteOrderItem").click(function(){
	        deleteOrderItem = false;
	        var itemId = $(this).attr("itemId")
	        deleteOrderItemid = itemId;
	        $("#deleteConfirmModal").modal('show');   
	    });
	    $("button.deleteConfirmButton").click(function(){
	        deleteOrderItem = true;
	        $("#deleteConfirmModal").modal('hide');
	    });
	     
	    $('#deleteConfirmModal').on('hidden.bs.modal', function (e) {
	        if(deleteOrderItem){
	            var page="foredeleteOrderItem";
	            $.post(
	                    page,
	                    {"itemId":deleteOrderItemid},
	                    function(result){
	                        if("success"==result){
	                            $("tr.cartProductItemTR[itemId="+deleteOrderItemid+"]").hide();
	                        }
	                        else{
	                            location.href="loginPage";
	                        }
	                    }
	                );
	             
	        }
	    }) 
	     
	    $("img.cartProductItemIfSelected").click(function(){
	        var selectit = $(this).attr("selectit")
	        if("selectit"==selectit){
	            $(this).attr("src","img/site/cartNotSelected.png");
	            $(this).attr("selectit","false")
	            $(this).parents("tr.cartProductItemTR").css("background-color","#fff");
	        }
	        else{
	            $(this).attr("src","img/site/cartSelected.png");
	            $(this).attr("selectit","selectit")
	            $(this).parents("tr.cartProductItemTR").css("background-color","#FFF8E1");
	        }
	        syncSelect();
	        syncCreateOrderButton();
	        calcCartSumPriceAndNumber();
	    });
	    $("img.selectAllItem").click(function(){
	        var selectit = $(this).attr("selectit")
	        if("selectit"==selectit){
	            $("img.selectAllItem").attr("src","img/site/cartNotSelected.png");
	            $("img.selectAllItem").attr("selectit","false")
	            $(".cartProductItemIfSelected").each(function(){
	                $(this).attr("src","img/site/cartNotSelected.png");
	                $(this).attr("selectit","false");
	                $(this).parents("tr.cartProductItemTR").css("background-color","#fff");
	            });        
	        }
	        else{
	            $("img.selectAllItem").attr("src","img/site/cartSelected.png");
	            $("img.selectAllItem").attr("selectit","selectit")
	            $(".cartProductItemIfSelected").each(function(){
	                $(this).attr("src","img/site/cartSelected.png");
	                $(this).attr("selectit","selectit");
	                $(this).parents("tr.cartProductItemTR").css("background-color","#FFF8E1");
	            });            
	        }
	        syncCreateOrderButton();
	        calcCartSumPriceAndNumber();
	         
	    });
	     
	    $(".orderItemNumberSetting").keyup(function(){
	        var productId=$(this).attr("productId");
	        var stock= $("span.orderItemStock[productId="+productId+"]").text();
	        var price= $("span.orderItemPromotePrice[productId="+productId+"]").text();
	         
	        var num= $(".orderItemNumberSetting[productId="+productId+"]").val();
	        num = parseInt(num);
	        if(isNaN(num))
	            num= 1;
	        if(num<=0)
	            num = 1;
	        if(num>stock)
	            num = stock;
	         
	        syncPrice(productId,num,price);
	    });
	 
	    $(".numberPlus").click(function(){
	         
	        var productId=$(this).attr("productId");
	        var stock= $("span.orderItemStock[productId="+productId+"]").text();
	        var price= $("span.orderItemPromotePrice[productId="+productId+"]").text();
	        var num= $(".orderItemNumberSetting[productId="+productId+"]").val();
	 
	        num++;
	        if(num>stock)
	            num = stock;
	        syncPrice(productId,num,price);
	    });
	    $(".numberMinus").click(function(){
	        var productId=$(this).attr("productId");
	        var stock= $("span.orderItemStock[productId="+productId+"]").text();
	        var price= $("span.orderItemPromotePrice[productId="+productId+"]").text();
	         
	        var num= $(".orderItemNumberSetting[productId="+productId+"]").val();
	        --num;
	        if(num<=0)
	            num=1;
	        syncPrice(productId,num,price);
	    });
	     
	    $("button.createOrderButton").click(function(){
	        var params = "";
	        $(".cartProductItemIfSelected").each(function(){
	            if("selectit"==$(this).attr("selectit")){
	                var itemId = $(this).attr("itemId");
	                params += "&itemId="+itemId;
	            }
	        });
	        params = params.substring(1);
	        location.href="forebuy?"+params;
	    });
	     
	})
	 
	function syncCreateOrderButton(){
	    var selectAny = false;
	    $(".cartProductItemIfSelected").each(function(){
	        if("selectit"==$(this).attr("selectit")){
	            selectAny = true;
	        }
	    });
	     
	    if(selectAny){
	        $("button.createOrderButton").css("background-color","#C40000");
	        $("button.createOrderButton").removeAttr("disabled");
	    }
	    else{
	        $("button.createOrderButton").css("background-color","#AAAAAA");
	        $("button.createOrderButton").attr("disabled","disabled");     
	    }
	         
	}
	function syncSelect(){
	    var selectAll = true;
	    $(".cartProductItemIfSelected").each(function(){
	        if("false"==$(this).attr("selectit")){
	            selectAll = false;
	        }
	    });
	     
	    if(selectAll)
	        $("img.selectAllItem").attr("src","img/site/cartSelected.png");
	    else
	        $("img.selectAllItem").attr("src","img/site/cartNotSelected.png");
	     
	}
	function calcCartSumPriceAndNumber(){
	    var sum = 0;
	    var totalNumber = 0;
	    $("img.cartProductItemIfSelected[selectit='selectit']").each(function(){
	        var itemId = $(this).attr("itemId");
	        var price =$(".cartProductItemSmallSumPrice[itemId="+itemId+"]").text();
	        price = price.replace(/,/g, "");
	        price = price.replace(/￥/g, "");
	        sum += new Number(price);  
	         
	        var num =$(".orderItemNumberSetting[itemId="+itemId+"]").val();
	        totalNumber += new Number(num);
	         
	    });
	     
	    $("span.cartSumPrice").html("￥"+formatMoney(sum));
	    $("span.cartTitlePrice").html("￥"+formatMoney(sum));
	    $("span.cartSumNumber").html(totalNumber);
	}
	function syncPrice(productId,num,price){
	    $(".orderItemNumberSetting[productId="+productId+"]").val(num);
	    var cartProductItemSmallSumPrice = formatMoney(num*price);
	    $(".cartProductItemSmallSumPrice[productId="+productId+"]").html("￥"+cartProductItemSmallSumPrice);
	    calcCartSumPriceAndNumber();
	     
	    var page = "forechangeOrderItem";
	    $.post(
	            page,
	            {"productId":productId,"number":num},
	            function(result){
	                if("success"!=result){
	                    location.href="loginPage";
	                }
	            }
	        );
	 
	}
</script>
	
<head>
	<title>购物车</title>
</head>
<body>
	
	<div class="cartDiv">
		<div class="cartTitle pull-right">
			<span>已选商品  (不含运费)</span>
			<span class="cartTitlePrice">￥0.00</span>
			<button class="createOrderButton" disabled="disabled">结 算</button>
		</div>
		
		<div class="cartProductList">
			<table class="cartProductTable">
				<thead>
					<tr>
						<th class="selectAndImage"><img src="img/site/cartNotSelected.png" selectit="false" >全选</th>
						<th>商品信息</th>
						<th>单价</th>
						<th>数量</th>
						<th>金额</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${ois }" var="oi">
						<tr itemId=${oi.itemId } class="cartProductItemTR">
							<td>
								<img selectit="false" itemId=${oi.itemId } src="img/site/cartNotSelected.png" class="cartProductItemIfSelected">
								<a style="display: none" href="#nowhere"><img src="img/site/cartSelected.png"></a>
								<img class="cartProductImg" src="img/productSingle_middle/${oi.product.productImage.imageId }.jpg">
							</td>
							<td>
								<div>
									<a class="cartProductLink" href="foreproduct?productId=${oi.product.productId }">${oi.product.productName }</a>
									<div class="cartProductLinkInnerDiv">
	                                    <img src="img/site/creditcard.png" title="支持信用卡支付">
	                                    <img src="img/site/7day.png" title="消费者保障服务,承诺7天退货">
	                                    <img src="img/site/promise.png" title="消费者保障服务,承诺如实描述">
	                                </div>
								</div>
							</td>
							<td>
								 <span class="cartProductItemOringalPrice">￥ ${oi.product.originalPrice }</span>
								 <span class="cartProductItemPromotionPrice">￥ ${oi.product.promotePrice }</span>
							</td>
							<td>
								<div class="cartProductChangeNumberDiv">
									<span class="hidden orderItemStock" productId="${oi.product.productId }">${oi.product.stock }</span>
									<span class="hidden orderItemPromotePrice" productId="${oi.product.productId }">${oi.product.promotePrice }</span>
									<a productId="${oi.product.productId }" class="numberMinus" href="#nowhere">-</a>
									<input productId="${oi.product.productId }" itemId="${oi.itemId }" class="orderItemNumberSetting" autocomplete="off" value="${oi.number }">
									<a stock="${oi.product.stock }" productId="${oi.product.productId }" class="numberPlus" href="#nowhere">+</a>
								</div>
							</td>
							<td>
								<span class="cartProductItemSmallSumPrice" productId="${oi.product.productId }" itemId="${oi.itemId }">
									￥<fmt:formatNumber type="number" value=" ${oi.number*oi.product.promotePrice }" minFractionDigits="2" />
								</span>
							</td>
							<td>
								 <a class="deleteOrderItem" itemId="${oi.itemId }"  href="#nowhere">删除</a>
							</td>
						</tr>
					</c:forEach>
					
				</tbody>
			</table>
		</div>
		
		<div class="cartFoot">
			<img selectit="false" class="selectAllItem" src="img/site/cartNotSelected.png">
			<span>全选</span>
			
			<div class="pull-right">
				<span>已选商品<span class="cartSumNumber">0</span>件</span>
				<span>合计 (不含运费): </span>
				<span class="cartSumPrice" >￥0.00</span>
				<button class="createOrderButton" disabled="disabled"> 结 算 </button>
			</div>
		</div>
		
	</div>
	
</body>


</html>






