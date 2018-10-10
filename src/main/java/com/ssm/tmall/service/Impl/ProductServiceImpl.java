package com.ssm.tmall.service.Impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssm.tmall.entity.Category;
import com.ssm.tmall.entity.Product;
import com.ssm.tmall.entity.ProductExample;
import com.ssm.tmall.entity.ProductImage;
import com.ssm.tmall.mapper.ProductImageMapper;
import com.ssm.tmall.mapper.ProductMapper;
import com.ssm.tmall.service.CategoryService;
import com.ssm.tmall.service.OrderItemService;
import com.ssm.tmall.service.ProductImageService;
import com.ssm.tmall.service.ProductService;
import com.ssm.tmall.service.ReviewService;

@Service
public class ProductServiceImpl implements ProductService {

	@Autowired
	ProductMapper productMapper;
	@Autowired
//	CategoryMapper categoryMapper;
	CategoryService categoryService;
	@Autowired
	ProductImageService productImageService;
	@Autowired
	OrderItemService orderItemService;
	@Autowired
	ReviewService reviewService;
	
	@Override
	public void add(Product product) {
		productMapper.insert(product);
	}

	@Override
	public void delete(Integer productId) {
		productMapper.deleteByPrimaryKey(productId);
	}

	@Override
	public void update(Product product) {
		productMapper.updateByPrimaryKeySelective(product);
	}
	
	/*
	 * get和list方法都会把取出来的Product对象设置上对应的category
	 */
	public void setCategory(Product product) {
		Integer categoryId = product.getCategoryId();
		Category category = categoryService.get(categoryId);
		product.setCategory(category);
	}
	
	public void setCategory(List<Product> list) {
		for (Product product : list) {
			setCategory(product);
		}
	}

	@Override
	public Product get(Integer productId) {
		Product p = productMapper.selectByPrimaryKey(productId);
		setCategory(p);
		return p;
	}

	@Override
	public List<Product> list(Integer categoryId) {
		ProductExample example = new ProductExample();
		example.createCriteria().andCategoryIdEqualTo(categoryId);
        example.setOrderByClause("productId desc");
		List<Product> list = productMapper.selectByExample(example);
		setCategory(list);
		return list;
	}

	/*
	 *  接下来两个方法设置产品与对应的图片
	 *  setProductImage()将根据productId和图片类型type_single查询出所有的单个图片，然后把第一个取出来放在firstProductImage上。
	 *  在setProductImage方法中为单个产品设置图片
	 */
	@Override
	public void setProductImage(Product product) {
		List<ProductImage> list = productImageService.list(product.getProductId(), ProductImageService.type_single);
		if (!list.isEmpty()) {
			ProductImage pi = list.get(0);
			product.setProductImage(pi);
		}
	}
	//在方法中调用setProductImage(Product product) 为多个产品设置图片
	public void setProductImage(List<Product> list) {
		for (Product product : list) {
			setProductImage(product);
		}
	}

	
	/**
	 *为分类填充产品集合
	 */
	@Override
	public void fill(Category category) {
		List<Product> products = list(category.getCategoryId());
		category.setProducts(products);
	}
	
	/**
	 *为多个分类填充产品集合
	 */
	@Override
	public void fill(List<Category> categories) {
		for (Category category : categories) {
			fill(category);
		}
	}
	
	/**
	 *为多个分类填充推荐产品集合，即把分类下的产品集合，按照8个为一行，拆成多行，以利于后续页面上进行显示
	 */
	@Override
	public void fillByRow(List<Category> categories) {
		int productNumberEachRow = 8;
		for (Category category : categories) {
			List<Product> products = category.getProducts();
			List<List<Product>> productsByRow = new ArrayList<>();
			for (int i = 0; i < products.size(); i+=productNumberEachRow) {
				int size = i + productNumberEachRow;
				size = size<products.size()?size:products.size();
				List<Product> subList = products.subList(i, size);
				productsByRow.add(subList);
			}
			category.setProductsByRow(productsByRow);
		}
		
	}

	/**
	 * 	实现为产品设置销量和评价数量的方法：
	 */
	@Override
	public void setSaleAndReviewNumber(Product product) {
		int saleCount = orderItemService.getSaleCount(product.getProductId());
		product.setSaleCount(saleCount);
		
		int reviewCount = reviewService.getCount(product.getProductId());
		product.setReviewCount(reviewCount);
	}

	@Override
	public void setSaleAndReviewNumber(List<Product> list) {
		for (Product product : list) {
			setSaleAndReviewNumber(product);
		}
	}

	
	@Override
	public List<Product> search(String keyword) {
		ProductExample example = new ProductExample();
		example.createCriteria().andProductNameLike("%" + keyword + "%");
		example.setOrderByClause("productId desc");
		
		List<Product> list = productMapper.selectByExample(example);
		setProductImage(list);
		setCategory(list);
		
		return list;
	}
	
	

}
