package com.ssm.tmall.service;

import java.util.List;

import com.ssm.tmall.entity.Review;

public interface ReviewService {
	
	void add(Review review);
	
	void delete(int reviewId);
	
	void update(Review review);
	
	Review get(int reviewId);
	
	List<Review> list(int productId);	//通过产品ID查询产品下面的对用过得评价
	
	int getCount(int productId);	//获取产品的累计评价数

}
