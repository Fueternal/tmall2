package com.ssm.tmall.service;

import java.util.List;

import com.ssm.tmall.entity.OrderItem;
import com.ssm.tmall.entity.Orders;

public interface OrderService {
	
	String waitPay = "waitPay";
    String waitDelivery = "waitDelivery";
    String waitConfirm = "waitConfirm";
    String waitReview = "waitReview";
    String finish = "finish";
    String delete = "delete";
    
    void add(Orders order);
    void delete(Integer orderId);
    void update(Orders order);
    Orders get(Integer orderId);
    List<Orders> list();
    
    //新增方法 add(Order c,List<OrderItem> ois);
    float add(Orders order, List<OrderItem> ois);
    
    //修改OrderService，新增方法List list(int uid, String excludedStatus);
    List<Orders> list(Integer userId, String excludedStatus);
    


}
