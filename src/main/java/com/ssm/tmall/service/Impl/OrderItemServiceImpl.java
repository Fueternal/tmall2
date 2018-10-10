package com.ssm.tmall.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssm.tmall.entity.OrderItem;
import com.ssm.tmall.entity.OrderItemExample;
import com.ssm.tmall.entity.Orders;
import com.ssm.tmall.entity.Product;
import com.ssm.tmall.mapper.OrderItemMapper;
import com.ssm.tmall.service.OrderItemService;
import com.ssm.tmall.service.ProductService;
import com.ssm.tmall.service.ReviewService;

@Service
public class OrderItemServiceImpl implements OrderItemService {
	
	@Autowired
	OrderItemMapper orderItemMapper;
	@Autowired
	ProductService productService;
	@Autowired
	ReviewService reviewService;
	
	@Override
	public void add(OrderItem orderItem) {
		// TODO Auto-generated method stub
		orderItemMapper.insert(orderItem);
	}

	@Override
	public void delete(Integer orderItemId) {
		// TODO Auto-generated method stub
		orderItemMapper.deleteByPrimaryKey(orderItemId);
	}

	@Override
	public void update(OrderItem orderItem) {
		// TODO Auto-generated method stub
		orderItemMapper.updateByPrimaryKeySelective(orderItem);
	}

	@Override
	public OrderItem get(Integer orderItemId) {
		// TODO Auto-generated method stub
		OrderItem orderItem = orderItemMapper.selectByPrimaryKey(orderItemId);
		setProduct(orderItem);
		return orderItem;
	}

	@Override
	public List<OrderItem> list() {
		OrderItemExample example = new OrderItemExample();
		example.setOrderByClause("orderItemId desc");
		List<OrderItem> list = orderItemMapper.selectByExample(example);
		return list;
	}

	/*
	 * 在fill(Order order)中：
		1. 根据订单id查询出其对应的所有订单项
		2. 通过setProduct为所有的订单项设置Product属性
		3. 遍历所有的订单项，然后计算出该订单的总金额和总数量
		4. 最后再把订单项设置在订单的orderItems属性上。
	 */
	@Override
	public void fill(Orders order) {
		OrderItemExample example = new OrderItemExample();
        example.createCriteria().andOrderIdEqualTo(order.getOrderId());
        example.setOrderByClause("orderId desc");
		List<OrderItem> list = orderItemMapper.selectByExample(example);
		setProduct(list);
		
		float total = 0;
		int totalNumber = 0;
		for (OrderItem orderItem : list) {
			total += orderItem.getNumber()*orderItem.getProduct().getPromotePrice();
			totalNumber += orderItem.getNumber();
		}
		
		order.setTotal(total);
		order.setTotalNumber(totalNumber);
		order.setOrderItems(list);
	}

	@Override
	public void fill(List<Orders> list) {
		for (Orders order : list) {
			fill(order);
		}
	}

	/*
	 * orderItem下的产品封装
	 */
	public void setProduct(OrderItem orderItem) {
		Product product = productService.get(orderItem.getProductId());
		orderItem.setProduct(product);
	}
	
	public void setProduct(List<OrderItem> list) {
		for (OrderItem orderItem : list) {
			setProduct(orderItem);
		}
	}

	/**
	 * 	增加根据产品获取销售量的方法
	 */
	@Override
	public int getSaleCount(int productId) {
		OrderItemExample example = new OrderItemExample();
		example.createCriteria().andProductIdEqualTo(productId);
		List<OrderItem> ois = orderItemMapper.selectByExample(example);
		int result = 0;
		for (OrderItem orderItem : ois) {
			result += orderItem.getNumber();
		}
		return result;
	}

	@Override
	public List<OrderItem> listByUser(int userId) {
		OrderItemExample example = new OrderItemExample();
		example.createCriteria().andUserIdEqualTo(userId).andOrderIdIsNull();	//用于购物车的只是在用户下形成了购物需求，并没有生成实际订单order，所以要求andOrderIdIsNull
		List<OrderItem> list = orderItemMapper.selectByExample(example);
		setProduct(list);	//orderItem下的产品封装
		return list;
	}
	

}
