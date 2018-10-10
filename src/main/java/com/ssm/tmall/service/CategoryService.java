package com.ssm.tmall.service;

import java.util.List;

import com.ssm.tmall.entity.Category;

public interface CategoryService {
	
	List<Category> list();
	
	void add(Category category);
	
	void delete(Integer categoryId);
	
	Category get(Integer categoryId);
	
	void update(Category category);
	
	
}
