package com.ssm.tmall.entity;

import java.util.List;

public class Category {
    private Integer categoryId;

    private String categoryName;
    
    //非数据库字段，为前台添加，用于首页竖状导航的分类名称右边显示推荐产品列表。
    private List<Product> products;	//表示一个分类下有多个产品
    private List<List<Product>> productsByRow;	//表示一个分类下有多个产品，这些产品在前台以行的形式多条产品记录
    
    public List<Product> getProducts() {
		return products;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}

	public List<List<Product>> getProductsByRow() {
		return productsByRow;
	}

	public void setProductsByRow(List<List<Product>> productsByRow) {
		this.productsByRow = productsByRow;
	}

	public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName == null ? null : categoryName.trim();
    }
}