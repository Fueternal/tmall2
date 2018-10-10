<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>

	<script>
	$(function(){
	    var stock = ${p.stock};
	    $(".productNumberSetting").keyup(function(){
	        var num= $(".productNumberSetting").val();
	        num = parseInt(num);
	        if(isNaN(num))
	            num= 1;
	        if(num<=0)
	            num = 1;
	        if(num>stock)
	            num = stock;
	        $(".productNumberSetting").val(num);
	    });
	     
	    $(".increaseNumber").click(function(){
	        var num= $(".productNumberSetting").val();
	        num++;
	        if(num>stock)
	            num = stock;
	        $(".productNumberSetting").val(num);
	    });
	    $(".decreaseNumber").click(function(){
	        var num= $(".productNumberSetting").val();
	        --num;
	        if(num<=0)
	            num=1;
	        $(".productNumberSetting").val(num);
	    });
	    
	    /* 通过JQuery的.get方法，用异步ajax的方式访问forecheckLogin，获取当前是否登录状态.如果返回的不是"success" 即表明是未登录状态，那么就会打开登录的模态窗口
	    	加入购物车监听按钮
	    */
	    $(".addCartButton").removeAttr("disabled");
	    $(".addCartLink").click(function(){
	        var page = "forecheckLogin";
	        $.get(
	                page,
	                function(result){
	                    if("success"==result){
	                        var productId = ${p.productId};
	                        var num= $(".productNumberSetting").val();
	                        var addCartpage = "foreaddCart";
	                        $.get(
	                                addCartpage,
	                                {"productId":productId,"num":num},
	                                function(result){
	                                    if("success"==result){
	                                        $(".addCartButton").html("已加入购物车");
	                                        $(".addCartButton").attr("disabled","disabled");
	                                        $(".addCartButton").css("background-color","lightgray")
	                                        $(".addCartButton").css("border-color","lightgray")
	                                        $(".addCartButton").css("color","black")
	                                    }
	                                    else{
	                                    }
	                                }
	                        );                         
	                    }
	                    else{
	                        $("#loginModal").modal('show');                    
	                    }
	                }
	        );     
	        return false;
	    });
	    
	    //通过JQuery的.get方法，用异步ajax的方式访问forecheckLogin，获取当前是否登录状态.如果返回的不是"success" 即表明是未登录状态，那么就会打开登录的模态窗口
	    /*
	    	监听购买按钮
	    */
	    $(".buyLink").click(function(){
	        var page = "forecheckLogin";
	        $.get(
	                page,
	                function(result){
	                    if("success"==result){
	                        var num = $(".productNumberSetting").val();
	                        location.href= $(".buyLink").attr("href")+"&num="+num;
	                    }
	                    else{
	                        $("#loginModal").modal('show');                    
	                    }
	                }
	        );     
	        return false;
	    });
	    
	    
	    /*
	    modal.jsp 页面被 footer.jsp 所包含，所以每个页面都是加载了的。
		通过imgAndInfo.jsp页面中的购买按钮或者加入购物车按钮显示出来。
		点击登录按钮时，使用imgAndInfo.jsp 页面中的ajax代码进行登录验证：
	    */
	    $("button.loginSubmitButton").click(function(){
	        var userName = $("#userName").val();
	        var password = $("#password").val();
	         
	        if(0==userName.length||0==password.length){
	            $("span.errorMessage").html("请输入账号密码");
	            $("div.loginErrorMessageDiv").show();          
	            return false;
	        }
	         
	        var page = "foreloginAjax";
	        $.get(
	                page,
	                {"userName":userName,"password":password},
	                function(result){
	                    if("success"==result){
	                        location.reload();
	                    }
	                    else{
	                        $("span.errorMessage").html("账号密码错误");
	                        $("div.loginErrorMessageDiv").show();                      
	                    }
	                }
	        );         
	         
	        return true;
	    });
	    
	     
	    $("img.smallImage").mouseenter(function(){
	        var bigImageURL = $(this).attr("bigImageURL");
	        $("img.bigImg").attr("src",bigImageURL);
	    });
	     
	    $("img.bigImg").load(
	        function(){
	            $("img.smallImage").each(function(){
	                var bigImageURL = $(this).attr("bigImageURL");
	                img = new Image();
	                img.src = bigImageURL;
	                 
	                img.onload = function(){
	                    console.log(bigImageURL);  
	                    $("div.img4load").append($(img));
	                };
	            });    
	        }
	    );
	});
	</script>

	<div class="imgAndInfo">
		
		<div class="imgInimgAndInfo">
			<img src="img/productSingle/${p.productImage.imageId}.jpg" class="bigImg">
			<div class="smallImageDiv">
				<c:forEach items="${p.productSingleImages }" var="pi">
					<img src="img/productSingle_small/${pi.productId}.jpg" bigImageURL="img/productSingle/${pi.productId}.jpg" class="smallImage">
				</c:forEach>
			</div>
			<div class="img4load hidden" ></div>
		</div>
		
		<div class="infoInimgAndInfo">
			<div class="productTitle">${p.productName }</div>
			<div class="productSubTitle">${p.subTitle }</div>
			<div class="productPrice">
				<div class="juhuasuan">
                	<span class="juhuasuanBig" >聚划算</span>
                	<span>此商品即将参加聚划算，<span class="juhuasuanTime">1天19小时</span>后开始</span>
            	</div>
            	<div class="productPriceDiv">
            		<div class="gouwuquanDiv">
            			<img height="16px" src="img/site/gouwujuan.png">
            			<span> 全天猫实物商品通用</span>
            		</div>
            		<div class="originalDiv">
            			<span class="originalPriceDesc">价格</span>
                    	<span class="originalPriceYuan">¥</span>
                   		<span class="originalPrice">
                   			<fmt:formatNumber type="number" value="${p.originalPrice }" minFractionDigits="2"></fmt:formatNumber>
                   		</span>
            		</div>
            		<div class="promotionDiv">
	                    <span class="promotionPriceDesc">促销价 </span>
	                    <span class="promotionPriceYuan">¥</span>
	                    <span class="promotionPrice">
	                        <fmt:formatNumber type="number" value="${p.promotePrice}" minFractionDigits="2"></fmt:formatNumber>
	                    </span>              
                	</div>
            	</div>
			</div>
			
			<div class="productSaleAndReviewNumber">
				<div>销量 <span class="redColor boldWord">${p.saleCount }</span></div>
				<div>累计评价<span class="redColor boldWord">${p.reviewCount }</span></div>
			</div>
			
			<div class="productNumber">
				<span>数量</span>
				<span>
					<span class="productNumberSettingSpan">
						<input class="productNumberSetting" type="text" value="1">
					</span>
					<span class="arrow">
						<a href="#nowhere" class="increaseNumber">
							<span class="updown"><img src="img/site/increase.png"></span>
						</a>
						<span class="updownMiddle"> </span>
						<a href="#nowhere" class="decreaseNumber">
							<span class="updown"><img src="img/site/decrease.png"></span>
						</a>
					</span>
					件
				</span>
				<span>库存${p.stock }件</span>
			</div>
			
			<div class="serviceCommitment">
	            <span class="serviceCommitmentDesc">服务承诺</span>
	            <span class="serviceCommitmentLink">
	                <a href="#nowhere">正品保证</a>
	                <a href="#nowhere">极速退款</a>
	                <a href="#nowhere">赠运费险</a>
	                <a href="#nowhere">七天无理由退换</a>
	            </span>
	        </div> 
	        
	        <div class="buyDiv">
	        	<a class="buyLink" href="forebuyone?productId=${p.productId}"><button class="buyButton">立即购买</button></a>
	        	<a href="#nowhere" class="addCartLink"><button class="addCartButton"><span class="glyphicon glyphicon-shopping-cart"></span>加入购物车</button></a>
	        </div>
			
		</div>
		
		<div style="clear:both"></div>
	
	</div>


</html>