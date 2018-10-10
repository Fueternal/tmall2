package com.ssm.tmall.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssm.tmall.entity.Category;
import com.ssm.tmall.entity.CategoryExample;
import com.ssm.tmall.mapper.CategoryMapper;
import com.ssm.tmall.service.CategoryService;

@Service
public class CategoryServiceImpl implements CategoryService {

	@Autowired
	private CategoryMapper categoryMapper;
	
	@Override
	public List<Category> list() {
		CategoryExample example = new CategoryExample();
		example.setOrderByClause("categoryId");
		return categoryMapper.selectByExample(example);
	}

	@Override
	public void add(Category category) {
		categoryMapper.insert(category);
		
	}

	@Override
	public void delete(Integer categoryId) {
		categoryMapper.deleteByPrimaryKey(categoryId);
		
	}

	@Override
	public Category get(Integer categoryId) {
		return categoryMapper.selectByPrimaryKey(categoryId);
	}

	@Override
	public void update(Category category) {
		categoryMapper.updateByPrimaryKeySelective(category);
	}

}
