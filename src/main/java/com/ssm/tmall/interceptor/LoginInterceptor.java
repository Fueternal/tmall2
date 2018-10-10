package com.ssm.tmall.interceptor;

import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ssm.tmall.entity.Users;
import com.ssm.tmall.service.CategoryService;
import com.ssm.tmall.service.OrderItemService;

/**	过滤器：
	新建一个过滤器LoginInterceptor ，解决哪些页面需要登录？哪些页面不需要呢？
	a. 不需要登录也可以访问的
		如：注册，登录，产品，首页，分类，查询等等
	b. 需要登录才能够访问的
		如：购买行为，加入购物车行为，查看购物车，查看我的订单等等
	不需要登录也可以访问的已经确定了，但是需要登录才能够访问，截止目前为止还不能确定，所以这个过滤器就判断如果不是注册，登录，产品这些，就进行登录校验
		1. 准备字符串数组 noNeedAuthPage，存放哪些不需要登录也能访问的路径
		2. 获取uri
		3. 去掉前缀/tmall_ssm
		4. 如果访问的地址是/fore开头
			4.1 取出fore后面的字符串，比如是forecart,那么就取出cart
			4.2 判断cart是否是在noNeedAuthPage 
			4.2 如果不在，那么就需要进行是否登录验证
			4.3 从session中取出"user"对象
			4.4 如果对象不存在，就客户端跳转到login.jsp
			4.5 否则就正常执行
 */
public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	@Autowired
	CategoryService categoryService;
	@Autowired
	OrderItemService orderItemService;
	
	/**
     * 在业务处理器处理请求之前被调用
     * 如果返回false
     *     从当前的拦截器往回执行所有拦截器的afterCompletion(),再退出拦截器链
     * 如果返回true
     *    执行下一个拦截器,直到所有的拦截器都执行完毕
     *    再执行被拦截的Controller
     *    然后进入拦截器链,
     *    从最后一个拦截器往回执行所有的postHandle()
     *    接着再从最后一个拦截器往回执行所有的afterCompletion()
     */
public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		HttpSession session = request.getSession();
		String contextPath = session.getServletContext().getContextPath();
//		System.out.println("11111111----" + session.getServletContext().toString());
//		System.out.println("22222222----" + contextPath);
		String[] noNeedAuthPage = new String[] {
				"home",
				"register",
				"login",
				"product",
				"checkLogin",
				"loginAjax",
				"category",
				"search"
		};
		
		String uri = request.getRequestURI();
//		System.out.println("333333---" + uri);
		uri = StringUtils.remove(uri, contextPath);
//		System.out.println("333333++++++---" + uri);
		if (uri.startsWith("/fore")) {
			String method = StringUtils.substringAfterLast(uri, "/fore");
//			System.out.println("4444-----" + method);
			if (!Arrays.asList(noNeedAuthPage).contains(method)) {
				Users user = (Users) session.getAttribute("user");
				if (null==user) {
					response.sendRedirect("loginPage");
					return false;
				}
			}
		}
		
		return true;
	}
	
	
	/**
     * 在业务处理器处理请求执行完成后,生成视图之前执行的动作
     * 可在modelAndView中加入数据，比如当前时间
     */
	public void postHandler(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		
	}
	
	
	/** 
     * 在DispatcherServlet完全处理完请求后被调用,可用于清理资源等  
     * 当有拦截器抛出异常时,会从当前拦截器往回执行所有的拦截器的afterCompletion() 
     */
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception exception) {
		
	}
	

}










