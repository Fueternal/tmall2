<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 这个modal.jsp里提供了两个模态窗口
1. 登录模态窗口
	当用户在未登录状态，于产品页点击购买的时候会弹出
2. 删除模态窗口
	当用户在我的订单页面,和购物车页面进行删除操作的时候，就会弹出模态删除窗口。	 -->

<!-- modal.jsp 页面被 footer.jsp 所包含，所以每个页面都是加载了的。
通过imgAndInfo.jsp页面中的购买按钮或者加入购物车按钮显示出来。
点击登录按钮时，使用imgAndInfo.jsp 页面中的ajax代码进行登录验证： -->

<!DOCTYPE html>
<html>
	
	<div class="modal" id="loginModal" tabindex="-1" role="dialog">
		<div class="modal-dialog loginDivInProductPageModalDiv">
			<div class="modal-content">
				<div class="loginDivInProductPage">
					
					<div class="loginErrorMessageDiv">
						<div class="alert alert-danger">
							<button type="button" class="close" data-dismiss="alert" aria-label="Close"></button>
							<span class="errorMessage"></span>
						</div>
					</div>
					
					<div class="login_acount_text">账户登录</div>
					
					<div class="loginInput">
						<span class="loginInputIcon">
							<span class="glyphicon glyphicon-user"></span>
						</span>
						<input id="userName" name="userName" placeholder="手机/会员号/邮箱"  type="text">
					</div>
					
					<div class="loginInput">
						<span class="loginInputIcon">
							<span class="glyphicon glyphicon-lock"></span>
						</span>
						<input id="password" name="password" placeholder="密码"  type="password">
					</div>

					<span class="text-danger">不要输入真实的天猫账户密码</span><br><br>
					
					<div>
						<a href="#nowhere">忘记登录密码</a>
						<a href="registerPage" class="pull-right">免费注册</a>
					</div>
					
					<div style="margin-top:20px">
						<button class="btn btn-block redButton loginSubmitButton" type="submit">登录</button>
					</div>

				</div>
			</div>
		</div>
	</div>
	
	<div class="modal" id="deleteConfirmModal" tabindex="-1" role="dialog">
		<div class="modal-dialog deleteConfirmModalDiv">
			<div class="modal-content">
				<div class="modal-header">
					<button data-dismiss="modal" class="close" type="button">
						<span aria-hidden="true">×</span>
						<span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title">确认删除？</h4>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default" type="button">关闭</button>
					<button class="btn btn-primary deleteConfirmButton" id="submit" type="button">确认</button>
				</div>
			</div>
		</div>
	</div>


</html>