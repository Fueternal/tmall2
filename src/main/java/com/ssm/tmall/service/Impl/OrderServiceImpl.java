package com.ssm.tmall.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.ssm.tmall.entity.OrderItem;
import com.ssm.tmall.entity.Orders;
import com.ssm.tmall.entity.OrdersExample;
import com.ssm.tmall.entity.Users;
import com.ssm.tmall.mapper.OrdersMapper;
import com.ssm.tmall.service.OrderItemService;
import com.ssm.tmall.service.OrderService;
import com.ssm.tmall.service.UsersService;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	OrdersMapper ordersMapper;
	@Autowired
	UsersService usersService;
	@Autowired
	OrderItemService orderItemService;
	
	@Override
	public void add(Orders order) {
		ordersMapper.insert(order);
	}

	@Override
	public void delete(Integer orderId) {
		ordersMapper.deleteByPrimaryKey(orderId);
	}

	@Override
	public void update(Orders order) {
		ordersMapper.updateByPrimaryKeySelective(order);
	}

	@Override
	public Orders get(Integer orderId) {
		return ordersMapper.selectByPrimaryKey(orderId);
	}

	@Override
	public List<Orders> list() {
		OrdersExample example = new OrdersExample();
		example.setOrderByClause("orderId desc");
		List<Orders> list = ordersMapper.selectByExample(example);
		setUser(list);
		return list;
	}
	
	public void setUser(Orders order) {
		Users user = usersService.get(order.getUserId());
		order.setUser(user);
	}
	
	public void setUser(List<Orders> orders) {
		for (Orders order : orders) {
			setUser(order);
		}	
	}

	/*
	 * 实现add(Order o, List<OrderItem> ois)方法，该方法通过注解进行事务管理
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackForClassName="Exception")
	public float add(Orders order, List<OrderItem> ois) {
		float total = 0;
		 
		add(order);
		
		//用来模拟当增加订单后出现异常，观察事务管理是否预期发生。（需要把false修改为true才能观察到）
		if (false) {
			throw new RuntimeException();
		}
		
		for (OrderItem orderItem : ois) {
			orderItem.setOrderId(order.getOrderId());
			orderItemService.update(orderItem);
			total += orderItem.getNumber()*orderItem.getProduct().getPromotePrice();
		}
		
		return total;
	}

	@Override
	public List<Orders> list(Integer userId, String excludedStatus) {
		OrdersExample example = new OrdersExample();
		example.createCriteria().andUserIdEqualTo(userId).andStatusNotEqualTo(excludedStatus);	//???andStatusNotEqualTo
		example.setOrderByClause("userId desc");
		List<Orders> list = ordersMapper.selectByExample(example);
		return list;
	}
	

}




