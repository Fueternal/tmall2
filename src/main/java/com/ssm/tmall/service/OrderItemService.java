package com.ssm.tmall.service;

import java.util.List;

import com.ssm.tmall.entity.OrderItem;
import com.ssm.tmall.entity.Orders;

public interface OrderItemService {
	
	void add(OrderItem orderItem);
	void delete(Integer orderItemId);
	void update(OrderItem orderItem);
	OrderItem get(Integer orderItemId);
	List<OrderItem> list();
	
	/*
同时还提供fill(Order order)和fill(List<Order> orders), 先说fill(Order order) : 
为什么要提供这个方法呢？ 因为在订单管理界面，首先是遍历多个订单，然后遍历这个订单下的多个订单项。 而由MybatisGenerator逆向工程所创建的一套自动生成代码，是不具备一对多关系的，需要自己去二次开发。 这里就是做订单与订单项的一对多关系。
在fill(Order order)中：
	1. 根据订单id查询出其对应的所有订单项
	2. 通过setProduct为所有的订单项设置Product属性
	3. 遍历所有的订单项，然后计算出该订单的总金额和总数量
	4. 最后再把订单项设置在订单的orderItems属性上。
在fill(List<Order> orders) 中，就是遍历每个订单，然后挨个调用fill(Order order)。
	 */
	void fill(List<Orders> os);
	
	void fill(Orders order);
	
	
	/*
	 * 	增加根据产品获取销售量的方法：
	 */
	int getSaleCount(int productId);
	
	
	/*
	 * 
	 */
	List<OrderItem> listByUser(int userId);
	
	
}
