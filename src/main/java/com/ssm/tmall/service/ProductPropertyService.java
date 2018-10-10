package com.ssm.tmall.service;

import java.util.List;

import com.ssm.tmall.entity.Product;
import com.ssm.tmall.entity.ProductProperty;

public interface ProductPropertyService {
	
	/*
	 * init方法
		3.1 这个方法的作用是初始化PropertyValue。 为什么要初始化呢？ 因为对于PropertyValue的管理，没有增加，只有修改。 所以需要通过初始化来进行自动地增加，以便于后面的修改。
		3.2 首先根据产品获取分类，然后获取这个分类下的所有属性集合
		3.3 然后用属性和id产品id去查询，看看这个属性和这个产品，是否已经存在属性值了。
		3.4 如果不存在，那么就创建一个属性值，并设置其属性和产品，接着插入到数据库中。
		这样就完成了属性值的初始化。
	 */
	void init(Product product);
	void update(ProductProperty productProperty);	//更新修改
	
	ProductProperty get(Integer productId, Integer propertyId);	//根据属性id和产品id获取ProductProperty对象
	List<ProductProperty> list(Integer productId);	//根据产品id获取所有的属性值

}
