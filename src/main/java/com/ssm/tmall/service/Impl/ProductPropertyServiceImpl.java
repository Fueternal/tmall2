package com.ssm.tmall.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssm.tmall.entity.Product;
import com.ssm.tmall.entity.ProductProperty;
import com.ssm.tmall.entity.ProductPropertyExample;
import com.ssm.tmall.entity.Property;
import com.ssm.tmall.mapper.ProductPropertyMapper;
import com.ssm.tmall.service.ProductPropertyService;
import com.ssm.tmall.service.PropertyService;

@Service
public class ProductPropertyServiceImpl implements ProductPropertyService {

	@Autowired
	ProductPropertyMapper productPropertyMapper;
	@Autowired
	PropertyService propertyService;
	
	/* init方法
		3.1 这个方法的作用是初始化PropertyValue。 为什么要初始化呢？ 因为对于PropertyValue的管理，没有增加，只有修改。 所以需要通过初始化来进行自动地增加，以便于后面的修改。
		3.2 首先根据产品获取分类，然后获取这个分类下的所有属性集合
		3.3 然后用属性和id产品id去查询，看看这个属性和这个产品，是否已经存在属性值了。
		3.4 如果不存在，那么就创建一个属性值，并设置其属性和产品，接着插入到数据库中。
		这样就完成了属性值的初始化。
	 */
	@Override
	public void init(Product product) {
		List<Property> listProperty = propertyService.list(product.getCategoryId());
		for (Property property : listProperty) {
			ProductProperty productProperty = get(product.getProductId(), property.getPropertyId());
			if (productProperty==null) {
				productProperty = new ProductProperty();
				productProperty.setProductId(product.getProductId());
				productProperty.setPropertyId(property.getPropertyId());
				productPropertyMapper.insert(productProperty);
			}
		}
	}

	@Override
	public void update(ProductProperty productProperty) {
		productPropertyMapper.updateByPrimaryKeySelective(productProperty);
	}

	@Override
	public ProductProperty get(Integer productId, Integer propertyId) {
		ProductPropertyExample example = new ProductPropertyExample();
		example.createCriteria().andProductIdEqualTo(productId).andPropertyIdEqualTo(propertyId);
		List<ProductProperty> list = productPropertyMapper.selectByExample(example);
		if (list.isEmpty()) {
			return null;
		}
		return list.get(0);
	}

	@Override
	public List<ProductProperty> list(Integer productId) {
		ProductPropertyExample example = new ProductPropertyExample();
		example.createCriteria().andProductIdEqualTo(productId);
		List<ProductProperty> list = productPropertyMapper.selectByExample(example);
		for (ProductProperty pp : list) {
			Property property = propertyService.get(pp.getPropertyId());
			pp.setProperty(property);
		}
		return list;
	}

}
