package com.ssm.tmall.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ssm.tmall.entity.Product;
import com.ssm.tmall.entity.ProductProperty;
import com.ssm.tmall.service.ProductPropertyService;
import com.ssm.tmall.service.ProductService;

@Controller
@RequestMapping("")
public class ProductPropertyController {
	
	@Autowired
	ProductPropertyService productPropertyService;
	@Autowired
	ProductService productService;
	
	@RequestMapping("admin_productProperty_edit")
	public String editProductProperty(Model model , Integer productId) {
		Product product = productService.get(productId);
		productPropertyService.init(product);
		List<ProductProperty> list = productPropertyService.list(product.getProductId());
		
		model.addAttribute("p", product);
		model.addAttribute("list", list);
		return "admin/editProductProperty";
	}
	
	@RequestMapping("admin_productProperty_update")
	public String updateProductProperty(ProductProperty productProperty) {
		productPropertyService.update(productProperty);
		
		return "success";
	}
}
