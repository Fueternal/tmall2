package com.ssm.tmall.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssm.tmall.entity.Property;
import com.ssm.tmall.entity.PropertyExample;
import com.ssm.tmall.mapper.PropertyMapper;
import com.ssm.tmall.service.PropertyService;

@Service
public class PropertyServiceImpl implements PropertyService {

	@Autowired
	PropertyMapper propertyMapper;
	
	@Override
	public void add(Property property) {
		propertyMapper.insert(property);
	}

	@Override
	public void delete(Integer propertyId) {
		propertyMapper.deleteByPrimaryKey(propertyId);
	}

	@Override
	public void update(Property property) {
		propertyMapper.updateByPrimaryKeySelective(property);
	}

	@Override
	public Property get(Integer propertyId) {
		return propertyMapper.selectByPrimaryKey(propertyId);
	}
	
	@Override
	public List<Property> list(Integer categoryId) {
		PropertyExample example = new PropertyExample();
		example.createCriteria().andCategoryIdEqualTo(categoryId);
		example.setOrderByClause("categoryId");
		return propertyMapper.selectByExample(example);
	}
	
}
