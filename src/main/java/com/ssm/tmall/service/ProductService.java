package com.ssm.tmall.service;

import java.util.List;

import com.ssm.tmall.entity.Category;
import com.ssm.tmall.entity.Product;

public interface ProductService {
	
	void add(Product product);
	
	void delete(Integer productId);
	
	void update(Product product);
	
	Product get(Integer productId);
	
	List<Product> list(Integer categoryId);	//查询的产品是在一个类别category下的所有产品，即categoryId下的所有产品
	
	void setProductImage(Product product);
	
	//为前台的列表展示与推荐添加以下方法
	void fill(Category category);
	void fill(List<Category> categories);
	void fillByRow(List<Category> categories);
	
	/*
	 * 	增加为产品设置销量和评价数量的方法：
	 */
	void setSaleAndReviewNumber(Product product);
	void setSaleAndReviewNumber(List<Product> list);	
	
	//为搜索产品提供search方法
	List<Product> search(String keyword);
	
}
