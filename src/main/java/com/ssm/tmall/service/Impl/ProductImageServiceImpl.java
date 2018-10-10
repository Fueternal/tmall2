package com.ssm.tmall.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssm.tmall.entity.ProductImage;
import com.ssm.tmall.entity.ProductImageExample;
import com.ssm.tmall.mapper.ProductImageMapper;
import com.ssm.tmall.service.ProductImageService;

@Service
public class ProductImageServiceImpl implements ProductImageService {

	@Autowired
	ProductImageMapper productImageMapper;
	
	@Override
	public void add(ProductImage productImage) {
		productImageMapper.insert(productImage);
	}

	@Override
	public void delete(Integer imageId) {
		productImageMapper.deleteByPrimaryKey(imageId);
	}

	@Override
	public void update(ProductImage productImage) {
		productImageMapper.updateByPrimaryKeySelective(productImage);
	}

	@Override
	public ProductImage get(Integer imageId) {
		return productImageMapper.selectByPrimaryKey(imageId);
	}

	@Override
	public List<ProductImage> list(Integer productId, String type) {
		ProductImageExample example = new ProductImageExample();
		example.createCriteria()
				.andProductIdEqualTo(productId)
				.andTypeEqualTo(type);
		example.setOrderByClause("imageId desc");
		List<ProductImage> list = productImageMapper.selectByExample(example);
		return list;
	}

}
