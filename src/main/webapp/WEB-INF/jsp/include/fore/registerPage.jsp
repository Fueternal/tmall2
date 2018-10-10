<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- 该页面为注册页面的主体功能，用于提交账号密码。 在提交之前会进行为空验证，以及密码是否一致验证。	 -->

<!DOCTYPE html>
<html>
	
	<script>
		$(function(){
		    
			//这段代码用于当账号提交到服务端，服务端判断当前账号已经存在的情况下，显示返回的错误提示 "用户名已经被使用,不能使用"
		    <c:if test="${!empty msg}">
		    $("span.errorMessage").html("${msg}");
		    $("div.registerErrorMessageDiv").css("visibility","visible");      
		    </c:if>
		     
		    $(".registerForm").submit(function(){
		        if(0==$("#userName").val().length){
		            $("span.errorMessage").html("请输入用户名");
		            $("div.registerErrorMessageDiv").css("visibility","visible");          
		            return false;
		        }      
		        if(0==$("#password").val().length){
		            $("span.errorMessage").html("请输入密码");
		            $("div.registerErrorMessageDiv").css("visibility","visible");          
		            return false;
		        }      
		        if(0==$("#repeatpassword").val().length){
		            $("span.errorMessage").html("请输入重复密码");
		            $("div.registerErrorMessageDiv").css("visibility","visible");          
		            return false;
		        }      
		        if($("#password").val() !=$("#repeatpassword").val()){
		            $("span.errorMessage").html("重复密码不一致");
		            $("div.registerErrorMessageDiv").css("visibility","visible");          
		            return false;
		        }      
		 
		        return true;
		    });
		})
	</script>
	
	
	<form action="foreregister" method="post" class="registerForm">
		
		<div class="registerErrorMessageDiv">
	        <div class="alert alert-danger" role="alert">
	          <button type="button" class="close" data-dismiss="alert" aria-label="Close"></button>
	            <span class="errorMessage"></span>
	        </div>       
    	</div>
		
		<table class="registerTable" align="center">
			<tr>
				<td class="registerTip registerTableLeftTD">设置会员名</td>
				<td></td>
			</tr>
			<tr>
				<td class="registerTableLeftTD">登录名</td>
				<td class="registerTableRightTD"><input id="userName" name="userName" placeholder="会员名一旦设置成功，无法修改"></td>
			</tr>
			<tr>
				<td class="registerTip registerTableLeftTD">设置登陆密码</td>
				<td class="registerTableRightTD">登陆时验证，保护账号信息</td>
			</tr>
			<tr>
				<td class="registerTableLeftTD">登陆密码</td>
				<td class="registerTableRightTD"><input id="password" name="password" type="password"  placeholder="设置你的登陆密码" ></td>
			</tr>
			<tr>
				<td class="registerTableLeftTD">确认密码</td>
				<td class="registerTableRightTD"><input id="repeatpassword" type="password" placeholder="请再次输入你的密码" ></td>
			</tr>
			<tr>
				<td colspan="2" class="registerButtonTD">
					<a href="registerSuccess.jsp"><button>提   交</button></a>
				</td>
			</tr>
		</table>
		
		
	</form>
	

</html>










