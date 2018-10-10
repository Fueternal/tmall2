package com.ssm.tmall.service;

import java.util.List;

import com.ssm.tmall.entity.Property;

public interface PropertyService {
	
	void add(Property property);
	
	void delete(Integer propertyId);
	
	void update(Property property);
	
	Property get(Integer propertyId);
	
	List<Property> list(Integer categoryId);	//查询categoryId下的property！因为在业务上需要查询某个分类下的属性，所以list方法会带上对应分类的id。

}
