package com.ssm.tmall.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.math.RandomUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;

import com.github.pagehelper.PageHelper;
import com.ssm.tmall.entity.Category;
import com.ssm.tmall.entity.OrderItem;
import com.ssm.tmall.entity.Orders;
import com.ssm.tmall.entity.Product;
import com.ssm.tmall.entity.ProductImage;
import com.ssm.tmall.entity.ProductProperty;
import com.ssm.tmall.entity.Review;
import com.ssm.tmall.entity.Users;
import com.ssm.tmall.service.CategoryService;
import com.ssm.tmall.service.OrderItemService;
import com.ssm.tmall.service.OrderService;
import com.ssm.tmall.service.ProductImageService;
import com.ssm.tmall.service.ProductPropertyService;
import com.ssm.tmall.service.ProductService;
import com.ssm.tmall.service.ReviewService;
import com.ssm.tmall.service.UsersService;

import comparator.ProductAllComparator;
import comparator.ProductDateComparator;
import comparator.ProductPriceComparator;
import comparator.ProductReviewComparator;
import comparator.ProductSaleCountComparator;

/**
 * 	创建了ForeController专门用来对应前台页面的路径
 * @author fuhf
 */

@Controller
@RequestMapping("")
public class ForeController {
	
	@Autowired
	CategoryService categoryService;
	@Autowired
	ProductService productService;
	@Autowired
	UsersService usersService;
	@Autowired
	ProductPropertyService productPropertyService;
	@Autowired
	ReviewService reviewService;
	@Autowired
	ProductImageService productImageService;
	@Autowired
	OrderService orderService;
	@Autowired
	OrderItemService orderItemService;
	
	/**
	 * home()方法映射首页访问路径 "forehome".
			1. 查询所有分类
			2. 为这些分类填充产品集合
			3. 为这些分类填充推荐产品集合
			4. 服务端跳转到home.jsp
	 * @param model
	 * @return
	 */
	@RequestMapping("forehome")
	public String home(Model model) {
		List<Category> categories = categoryService.list();
		productService.fill(categories);
		productService.fillByRow(categories);
		model.addAttribute("cs", categories);
		return "fore/home";
	}
	
	/**
	 * registerPage.jsp 的form提交数据到路径 foreregister,导致ForeController.register()方法被调用
		1. 通过参数User获取浏览器提交的账号密码
		2. 通过HtmlUtils.htmlEscape(name);把账号里的特殊符号进行转义
		3. 判断用户名是否存在
			3.1 如果已经存在，就服务端跳转到reigster.jsp，并且带上错误提示信息
			3.2 如果不存在，则加入到数据库中，并服务端跳转到registerSuccess.jsp页面
	 * @param model
	 * @param user
	 * @return
	 */
	@RequestMapping("foreregister")
	public String register(Model model, Users user) {
		String userName = user.getUserName();
		userName = HtmlUtils.htmlEscape(userName);	//为什么要用 HtmlUtils.htmlEscape？ 因为有些同学在恶意注册的时候，会使用诸如 <script>alert('papapa')</script> 这样的名称，会导致网页打开就弹出一个对话框。 那么在转义之后，就没有这个问题了。
		user.setUserName(userName);
		boolean exist = usersService.isExist(userName);
		if (exist) {
			String m = " 该用户名已经被注册,不能使用	";
			model.addAttribute("msg", m);
			model.addAttribute("user", null);	//model.addAttribute("user", null); 这句话的用处是当用户存在，服务端跳转到register.jsp的时候不带上参数user, 否则当注册失败的时候，会在原本是“请登录”的超链位置显示刚才注册的名称。 可以试试把这一条语句注释掉观察这个现象
		}
		usersService.add(user);
		
		return "redirect:registerSuccessPage";
	}
	
	
	/**
	 * loginPage.jsp的form提交数据到路径 forelogin,导致ForeController.login()方法被调用
		1. 获取账号密码
		2. 把账号通过HtmlUtils.htmlEscape进行转义
		3. 根据账号和密码获取User对象
		3.1 如果对象为空，则服务端跳转回login.jsp，也带上错误信息，并且使用 loginPage.jsp 中的办法显示错误信息
		3.2 如果对象存在，则把对象保存在session中，并客户端跳转到首页"forehome"
	 */
	@RequestMapping("forelogin")
	public String login(Model model, @RequestParam("userName")String userName, @RequestParam("password")String password, HttpSession session) {
		userName = HtmlUtils.htmlEscape(userName);
		Users user = usersService.get(userName, password);
		
		if (user == null) {
			model.addAttribute("msg", "账户密码错误，请重新输入！	");
			return	"fore/login";
		}
		
		session.setAttribute("user", user);
		return "redirect:forehome";
	}
	
	/*
	 * 	登出
	 */
	@RequestMapping("forelogout")
	public String logout(HttpSession session) {
		session.removeAttribute("user");
		
		return "redirect:forehome";
	}
	
	/*
	 * 显示产品信息页面，ForeController.product() 方法被调用
		1. 获取参数pid
		2. 根据pid获取Product 对象p
		3. 根据对象p，获取这个产品对应的单个图片集合
		4. 根据对象p，获取这个产品对应的详情图片集合
		5. 获取产品的所有属性值
		6. 获取产品对应的所有的评价
		7. 设置产品的销量和评价数量
		8. 把上述取值放在request属性上
		9. 服务端跳转到 "product.jsp" 页面
	 */
	@RequestMapping("foreproduct")
	public String product(Model model, int productId) {
		Product product = productService.get(productId);
		
		List<ProductImage> productSingleImages = product.getProductSingleImages();
		List<ProductImage> productDetailImages = product.getProductDetailImages();
		product.setProductSingleImages(productSingleImages);
		product.setProductDetailImages(productDetailImages);
		
		List<ProductProperty> productProperties = productPropertyService.list(product.getProductId());
		List<Review> reviews = reviewService.list(product.getProductId());
//		productService.setProductImage(product);
		productService.setSaleAndReviewNumber(product);
		
		model.addAttribute("p", product);
		model.addAttribute("reviews", reviews);
		model.addAttribute("productProperties", productProperties);
		return "fore/product";
	}
	
	
	/**
	 * imgAndInfo.jsp中监听购买和加入购物车按钮采用异步ajax访问路径/forecheckLogin会导致ForeController.checkLogin()方法被调用。
		获取session中的"user"对象
		如果不为空，即表示已经登录，返回字符串"success"
		如果为空，即表示未登录，返回字符串"fail"
	 */
	@RequestMapping("forecheckLogin")
	@ResponseBody
	public String checkLogin(HttpSession session) {
		Users user = (Users) session.getAttribute("user");
		if (null!=user) {
			return "success";
		}
		return "fail";
	}
	
	
	/*
	 * 在modal.jsp中，点击了登录按钮之后，访问路径/foreloginAjax,导致ForeController.loginAjax()方法被调用
		1. 获取账号密码
		2. 通过账号密码获取User对象
			2.1 如果User对象为空，那么就返回"fail"字符串。
			2.2 如果User对象不为空，那么就把User对象放在session中，并返回"success" 字符串
	 */
	@RequestMapping("foreloginAjax")
	@ResponseBody
	public String loginAjax(@RequestParam("userName")String userName, @RequestParam("password")String password, HttpSession session) {
		userName = HtmlUtils.htmlEscape(userName);
		Users user = usersService.get(userName, password);
		
		if (user==null) {
			return "fail";
		}
		session.setAttribute("user", user);
		return "success";
	}
	
	/*
	 *  1. 获取参数cid
		2. 根据cid获取分类Category对象 c
		3. 为c填充产品
		4. 为产品填充销量和评价数据
		5. 获取参数sort
			5.1 如果sort==null，即不排序
			5.2 如果sort!=null，则根据sort的值，从5个Comparator比较器中选择一个对应的排序器进行排序
		6. 把c放在model中
		7. 服务端跳转到 category.jsp
	 */
	@RequestMapping("forecategory")
	public String category(Integer categoryId, Model model, String sort) {
		Category category = categoryService.get(categoryId);
		productService.fill(category);
		productService.setSaleAndReviewNumber(category.getProducts());
		
		if (null!=sort) {
			switch (sort) {
			case "review":
				Collections.sort(category.getProducts(), new ProductReviewComparator());
				break;
			case "date":
				Collections.sort(category.getProducts(), new ProductDateComparator());
				break;
			case "saleCount":
				Collections.sort(category.getProducts(), new ProductSaleCountComparator());
				break;
			case "price":
				Collections.sort(category.getProducts(), new ProductPriceComparator());
				break;
			case "all":
				Collections.sort(category.getProducts(), new ProductAllComparator());
				break;
			}
		}
		
		model.addAttribute("c", category);
		return "fore/category";
	}
	
	
	/*
	 * 通过search.jsp或者simpleSearch.jsp提交数据到路径 /foresearch， 导致ForeController.search()方法被调用
		1. 获取参数keyword
		2. 根据keyword进行模糊查询，获取满足条件的前20个产品
		3. 为这些产品设置销量和评价数量
		4. 把产品结合设置在model的"ps"属性上
		5. 服务端跳转到 searchResult.jsp 页面
	 */
	@RequestMapping("foresearch")
	public String search(Model model, String keyword) {
		PageHelper.offsetPage(0, 20);
		
		List<Product> search = productService.search(keyword);
		productService.setSaleAndReviewNumber(search);
		
		model.addAttribute("ps", search);
		return "fore/searchResult";
	}
	
	/*
	 * 通过上个步骤访问的地址 /forebuyone 导致ForeController.buyone()方法被调用
		1. 获取参数pid
		2. 获取参数num
		3. 根据pid获取产品对象p
		4. 从session中获取用户对象user
		
		接下来就是新增订单项OrderItem， 新增订单项要考虑两个情况
		a. 如果已经存在这个产品对应的OrderItem，并且还没有生成订单，即还在购物车中。 那么就应该在对应的OrderItem基础上，调整数量
			a.1 基于用户对象user，查询没有生成订单的订单项集合
			a.2 遍历这个集合
			a.3 如果产品是一样的话，就进行数量追加
			a.4 获取这个订单项的 id
		
		b. 如果不存在对应的OrderItem,那么就新增一个订单项OrderItem
			b.1 生成新的订单项
			b.2 设置数量，用户和产品
			b.3 插入到数据库
			b.4 获取这个订单项的 id
		
		最后， 基于这个订单项id客户端跳转到结算页面/forebuy
	 */
	@RequestMapping("forebuyone")
	public String buyone(int productId, int num, HttpSession session) {
		Product product = productService.get(productId);
		
		int itemId = 0;
		boolean found = false;
		
		Users user = (Users) session.getAttribute("user");
		
		List<OrderItem> listByUser = orderItemService.listByUser(user.getUserId());
		for (OrderItem orderItem : listByUser) {
			if (orderItem.getProduct().getProductId().intValue()==product.getProductId().intValue()) {
				orderItem.setNumber(orderItem.getNumber()+num);
				orderItemService.update(orderItem);
				found = true;
				itemId = orderItem.getItemId();
				break;
			}
		}
		
		if (!found) {
			OrderItem oi = new OrderItem();
			oi.setProductId(productId);
			oi.setUserId(user.getUserId());
			oi.setNumber(num);
			orderItemService.add(oi);
			itemId = oi.getItemId();
		}
		
		return "redirect:forebuy?itemId="+itemId;
	}
	
	
	/*
	 * 在上个知识点立即购买最后，客户端跳转到结算路径： "@forebuy?itemId="+itemId;导致ForeController.buy()方法被调用
		1. 通过字符串数组获取参数itemId
			为什么这里要用字符串数组试图获取多个itemId，而不是int类型仅仅获取一个itemId? 
			因为根据购物流程环节与表关系，结算页面还需要显示在购物车中选中的多条OrderItem数据，所以为了兼容从购物车页面跳转过来的需求，要用字符串数组获取多个itemId
		2. 准备一个泛型是OrderItem的集合ois
		3. 根据前面步骤获取的oiids，从数据库中取出OrderItem对象，并放入ois集合中
		4. 累计这些ois的价格总数，赋值在total上
		5. 把订单项集合放在session的属性 "ois" 上
		6. 把总价格放在 model的属性 "total" 上
		7. 服务端跳转到buy.jsp
	 */
	@RequestMapping("forebuy")
	public String buy(Model model, String[] itemId, HttpSession session) {
		List<OrderItem> list = new ArrayList<>();
		
		float total = 0;	//用于表示订单总价
		
		for (String strid : itemId) {
			int id = Integer.parseInt(strid);
			OrderItem orderItem = orderItemService.get(id);
			total += orderItem.getProduct().getPromotePrice() * orderItem.getNumber();
			list.add(orderItem);
		}
		
		/*
		 1. session 里放的数据可以在其他页面使用
		 2. model的数据，只能在接下来的页面使用，其他页面就不能使用了哦
		 */
		session.setAttribute("ois", list);
		model.addAttribute("total", total);
		
		return "fore/buy";
	}
	
	
	/*
	 * 上一步访问地址/foreaddCart导致ForeController.addCart()方法被调用
		addCart()方法和立即购买中的 ForeController.buyone()步骤做的事情是一样的，区别在于返回不一样
		1. 获取参数pid
		2. 获取参数num
		3. 根据pid获取产品对象p
		4. 从session中获取用户对象user
		
		接下来就是新增订单项OrderItem， 新增订单项要考虑两个情况
		a. 如果已经存在这个产品对应的OrderItem，并且还没有生成订单，即还在购物车中。 那么就应该在对应的OrderItem基础上，调整数量
			a.1 基于用户对象user，查询没有生成订单的订单项集合
			a.2 遍历这个集合
			a.3 如果产品是一样的话，就进行数量追加
			a.4 获取这个订单项的 id
		
		b. 如果不存在对应的OrderItem,那么就新增一个订单项OrderItem
			b.1 生成新的订单项
			b.2 设置数量，用户和产品
			b.3 插入到数据库
			b.4 获取这个订单项的 id
		
		与ForeController.buyone() 客户端跳转到结算页面不同的是， 最后返回字符串"success"，表示添加成功
	 */
	@RequestMapping("foreaddCart")
	@ResponseBody
	public String addCart(Integer productId, int num, HttpSession session) {
		Product product = productService.get(productId);
		Users user = (Users) session.getAttribute("user");
		
		boolean found = false;
		
		List<OrderItem> listByUser = orderItemService.listByUser(user.getUserId());
		for (OrderItem orderItem : listByUser) {
			if (orderItem.getProduct().getProductId().intValue()==product.getProductId().intValue()) {
				orderItem.setNumber(orderItem.getNumber()+num);
				orderItemService.update(orderItem);
				found = true;
				break;
			}
		}
		
		if (!found) {
			OrderItem orderItem = new OrderItem();
			orderItem.setProductId(product.getProductId());
			orderItem.setUserId(user.getUserId());
			orderItem.setNumber(num);
			orderItemService.add(orderItem);
		}
		
		
		return "success";
	}
	
	/*
	 * 访问地址/forecart导致ForeController.cart()方法被调用
		1. 通过session获取当前用户
		所以一定要登录才访问，否则拿不到用户对象,会报错
		2. 获取为这个用户关联的订单项集合 ois
		3. 把ois放在model中
		4. 服务端跳转到cart.jsp
	 */
	@RequestMapping("forecart")
	public String cart(HttpSession session, Model model) {
		Users user = (Users) session.getAttribute("user");
		List<OrderItem> listByUser = orderItemService.listByUser(user.getUserId());
		
		model.addAttribute("ois", listByUser);
		
		return "fore/cart";
	}
	
	/*	调整订单数量
	 * 点击增加或者减少按钮后，根据 cartPage.jsp 中的js代码，会通过Ajax访问/forechangeOrderItem路径，导致ForeController.changeOrderItem()方法被调用
		1. 判断用户是否登录
		2. 获取pid和number
		3. 遍历出用户当前所有的未生成订单的OrderItem
		4. 根据pid找到匹配的OrderItem，并修改数量后更新到数据库
		5. 返回字符串"success"
	 */
	@RequestMapping("forechangeOrderItem")
	@ResponseBody
	public String changeOrderItem(HttpSession session, Integer productId, int number) {
		Users user = (Users) session.getAttribute("user");
		if (null == user) {
			return "fail";
		}
		
		List<OrderItem> listByUser = orderItemService.listByUser(user.getUserId());
		for (OrderItem orderItem : listByUser) {
			if (orderItem.getProductId().intValue()==productId.intValue()) {
				orderItem.setNumber(number);
				orderItemService.update(orderItem);
				break;
			}
		}
		
		return "success";
	}
	
	/*
	 * 删除购物车的信息
	 */
	@RequestMapping("foredeleteOrderItem")
	@ResponseBody
	public String deleteOrderItem(HttpSession session, Integer itemId) {
		Users user = (Users) session.getAttribute("user");
		if (null==user) {
			return "fail";
		}
		orderItemService.delete(itemId);
		
		return "success";
	}
	
	
	
	/**
	 * 提交订单访问路径 /forecreateOrder, 导致ForeController.createOrder 方法被调用
		1. 从session中获取user对象
		2. 通过参数Order接受地址，邮编，收货人，用户留言等信息
		3. 根据当前时间加上一个4位随机数生成订单号
		4. 根据上述参数，创建订单对象
		5. 把订单状态设置为等待支付
		6. 从session中获取订单项集合 ( 在结算功能的ForeController.buy() 13行，订单项集合被放到了session中 )
		7. 把订单加入到数据库，并且遍历订单项集合，设置每个订单项的order，更新到数据库
		8. 统计本次订单的总金额
		9. 客户端跳转到确认支付页forealipay，并带上订单id和总金额
	 */
	@RequestMapping("forecreateOrder")
	public String createOrder(HttpSession session, Orders order) {
		Users user = (Users) session.getAttribute("user");
		String orderCode = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()) + RandomUtils.nextInt(10000);
		order.setOrderCode(orderCode);
		order.setCreateDate(new Date());
		order.setUserId(user.getUserId());
		order.setStatus(OrderService.waitPay);
		
		//从session中获取订单项集合 ( 在结算功能的ForeController.buy()，订单项集合被放到了session中 )
		List<OrderItem> ois = (List<OrderItem>) session.getAttribute("ois");
		
		float total = orderService.add(order, ois);
		
		return "redirect:forealipay?orderId="+order.getOrderId() + "&total="+total;
	}
	
	/*1. 在上一步确认访问按钮提交数据到/forepayed,导致ForeController.payed方法被调用
		1.1 获取参数oid
		1.2 根据oid获取到订单对象order
		1.3 修改订单对象的状态和支付时间
		1.4 更新这个订单对象到数据库
		1.5 把这个订单对象放在model的属性"o"上
		1.6 服务端跳转到payed.jsp
	2. payed.jsp
		与 register.jsp 相仿，payed.jsp也包含了header.jsp, top.jsp, simpleSearch.jsp， footer.jsp 等公共页面。
		中间是支付成功业务页面 payedPage.jsp
	3. payedPage.jsp
		显示订单中的地址，邮编，收货人，手机号码等等*/
	@RequestMapping("forepayed")
	public String payed(Integer orderId, float total, Model model, HttpSession session) {
		Orders order = orderService.get(orderId);
		order.setStatus(OrderService.waitDelivery);
		order.setPayDate(new Date());
		orderService.update(order);
		model.addAttribute("o", order);
		return "fore/payed";
	}
	
	
	
	/*
	 * /forebought导致ForeController.bought()方法被调用
		1. 通过session获取用户user
		2. 查询user所有的状态不是"delete" 的订单集合os
		3. 为这些订单填充订单项
		4. 把os放在model的属性"os"上
		5. 服务端跳转到bought.jsp
	*/
	@RequestMapping("forebought")
	public String bought(Model model, HttpSession session) {
		Users user = (Users) session.getAttribute("user");
		List<Orders> list = orderService.list(user.getUserId(), OrderService.delete);
		orderItemService.fill(list);
		
		model.addAttribute("os", list);
		return "fore/bought";
	}
	
	/*
	1. 点击确认收货后，访问地址/foreconfirmPay
	2. ForeController.confirmPay()方法被调用
		2.1 获取参数oid
		2.2 通过orderId获取订单对象order
		2.3 为订单对象填充订单项
		2.4 把订单对象放在request的属性"o"上
		2.5 服务端跳转到 confirmPay.jsp

	3. confirmPay.jsp
		与 register.jsp 相仿，confirmPay.jsp也包含了header.jsp, top.jsp, simpleSearch.jsp， footer.jsp 等公共页面。
		中间是订单确认业务页面 confirmPayPage.jsp
	4. confirmPayPage.jsp
		显示订单的创建时间，付款时间和发货时间，以及订单号，收款人信息等
		遍历订单项集合，显示其中的产品图片，产品标题，价格，数量，小计，总结信息
		最后提供确认支付按钮，提交到/foreorderconfirmed路径
		*/
	@RequestMapping("foreconfirmPay")
	public String confirmPay(Model model, Integer orderId) {
		Orders order = orderService.get(orderId);
		orderItemService.fill(order);
		
		model.addAttribute("o", order);
		
		return "fore/conformPay";
	}
	
	
	/*
	 通过上一步最后的确认支付按钮，提交到路径/foreorderConfirmed，导致ForeController.orderConfirmed()方法被调用
	1. ForeController.orderConfirmed() 方法
		1.1 获取参数oid
		1.2 根据参数oid获取Order对象o
		1.3 修改对象o的状态为等待评价，修改其确认支付时间
		1.4 更新到数据库
		1.5 服务端跳转到orderConfirmed.jsp页面
	2. orderConfirmed.jsp
		与 register.jsp 相仿，orderConfirmed.jsp也包含了header.jsp, top.jsp, simpleSearch.jsp， footer.jsp 等公共页面。
		中间是确认收货成功业务页面 orderConfirmedPage.jsp
	3. orderConfirmedPage.jsp
		显示"交易已经成功，卖家将收到您的货款。"
	 */
	@RequestMapping("foreorderConfirmed")
	public String orderConfirmed(Model model, Integer orderId) {
		Orders order = orderService.get(orderId);
		order.setStatus(OrderService.waitReview);
		order.setConfirmDate(new Date());
		orderService.update(order);
		
		return "fore/orderConfirmed";
	}
	
	
	/*
	在我的订单页 上点击删除按钮，根据 boughtPage.jsp 中的ajax操作，会访问路径/foredeleteOrder，导致ForeController.deleteOrder方法被调用
	1. ForeController.deleteOrder()
		1.1 获取参数oid
		1.2 根据oid获取订单对象o
		1.3 修改状态
		1.4 更新到数据库
		1.5 返回字符串"success"
	2. boughtPage.jsp 中的javascript代码获取返回字符串是success的时候，隐藏掉当前这行订单数据。
	 */
	@RequestMapping("foredeleteOrder")
	public String deleteOrder(Model model, Integer orderId) {
		Orders order = orderService.get(orderId);
		order.setStatus(OrderService.delete);
		orderService.update(order);
		
		return "success";
	}
	
	
	/*
	通过点击评价按钮，来到路径/forereview，导致ForeController.review()方法被调用
	1. ForeController.review()
		1.1 获取参数oid
		1.2 根据oid获取订单对象o
		1.3 为订单对象填充订单项
		1.4 获取第一个订单项对应的产品,因为在评价页面需要显示一个产品图片，那么就使用这第一个产品的图片了
		1.5 获取这个产品的评价集合
		1.6 为产品设置评价数量和销量
		1.7 把产品，订单和评价集合放在request上
		1.8 服务端跳转到 review.jsp
	2. review.jsp
		与 register.jsp 相仿，review.jsp也包含了header.jsp, top.jsp, simpleSearch.jsp， 
		footer.jsp 等公共页面。
		中间是产品业务页面 reviewPage.jsp
	3. reviewPage.jsp
		在reviewPage.jsp中显示产品图片，产品标题，价格，产品销量，产品评价数量，以及订单信息等。 
		同时还显示出了该产品所有的评价，但是默认是隐藏的
	 */
	@RequestMapping("forereview")
	public String review(Model model, Integer orderId) {
		Orders order = orderService.get(orderId);
		orderItemService.fill(order);
		Product product = order.getOrderItems().get(0).getProduct();
		List<Review> reviews = reviewService.list(product.getProductId());
		productService.setSaleAndReviewNumber(product);
		
		model.addAttribute("p", product);
		model.addAttribute("o", order);
		model.addAttribute("reviews", reviews);
		return "fore/review";
	}
	
	
	/*
	在评价产品页面点击提交评价，就把数据提交到了/foredoreview路径，导致ForeController.doreview方法被调用
	1. ForeController.doreview()
		1.1 获取参数oid
		1.2 根据oid获取订单对象o
		1.3 修改订单对象状态
		1.4 更新订单对象到数据库
		1.5 获取参数pid
		1.6 根据pid获取产品对象
		1.7 获取参数content (评价信息)
		1.8 对评价信息进行转义，道理同注册ForeController.register()
		1.9 从session中获取当前用户
		1.10 创建评价对象review
		1.11 为评价对象review设置 评价信息，产品，时间，用户
		1.12 增加到数据库
		1.13.客户端跳转到/forereview： 评价产品页面，并带上参数showonly=true
	2. reviewPage.jsp
		在reviewPage.jsp中，当参数showonly==true，那么就显示当前产品的所有评价信息
	 */
	@RequestMapping("foredoreview")
	public String doreview(Model model, HttpSession session, @RequestParam("orderId")Integer orderId, @RequestParam("productId")Integer productId, String content) {
		Orders order = orderService.get(orderId);
		order.setStatus(OrderService.finish);
		orderService.update(order);
		
		Product product = productService.get(productId);
		content = HtmlUtils.htmlEscape(content);
		
		Users user = (Users) session.getAttribute("user");
		Review review = new Review();
		review.setContent(content);
		review.setProductId(productId);
		review.setCreateDate(new Date());
		review.setUserId(user.getUserId());
		reviewService.add(review);
		
		return "redirect:forereview?orderId="+orderId+"&showonly=true";
	}
	
}











