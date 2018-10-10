package com.ssm.tmall.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.tmall.entity.Orders;
import com.ssm.tmall.entity.Users;
import com.ssm.tmall.service.OrderItemService;
import com.ssm.tmall.service.OrderService;
import com.ssm.tmall.service.UsersService;
import com.ssm.tmall.util.Page;

/*
 * 因为订单的增加和删除，都是在前台进行的。 所以OrderController提供的是list方法和delivery(发货)方法
 */

@Controller
@RequestMapping("")
public class OrderController {

	@Autowired
	OrderService orderService;
	@Autowired
	OrderItemService orderItemService;
	
	@RequestMapping("admin_order_list")
	public String listOrder(Model model, Page page) {
		PageHelper.offsetPage(page.getStart(), 10);
		List<Orders> list = orderService.list();
		int total = (int) new PageInfo<>(list).getTotal();
		page.setTotal(total);
		
		orderItemService.fill(list);	//将订单金额和订单商品数量封装到订单对应的订单项
		
		model.addAttribute("list", list);
		model.addAttribute("page", page);
		return "admin/listOrder";
	}
	
	@RequestMapping("admin_order_delivery")	//发货
	public String deliveryOrder(Orders order) {
		order.setDeliveryDate(new Date());	//创建发货时间
		order.setStatus(OrderService.waitConfirm);	//将订单状态变为待收货
		orderService.update(order);	//将上述两个属性更新到订单中
		return "redirect:/admin_order_list";
	}
	
}
