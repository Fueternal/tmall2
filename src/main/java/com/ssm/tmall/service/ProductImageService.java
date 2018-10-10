package com.ssm.tmall.service;

import java.util.List;

import com.ssm.tmall.entity.ProductImage;

public interface ProductImageService {
	
	//??:提供了两个常量，分别表示单个图片和详情图片
	String type_single = "type_single";
	String type_detail = "type_detail";
	
	void add(ProductImage productImage);
	
	void delete(Integer imageId);
	
	void update(ProductImage productImage);
	
	ProductImage get(Integer imageId);
	
//	List<ProductImage> list(Integer productId);	//图片显示的某产品下的图片，所以以productId为准
	
	List<ProductImage> list(Integer productId, String type);	//根据产品id和图片类型查询的list方法

}
