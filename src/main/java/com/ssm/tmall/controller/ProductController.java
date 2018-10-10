package com.ssm.tmall.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.tmall.entity.Category;
import com.ssm.tmall.entity.Product;
import com.ssm.tmall.service.CategoryService;
import com.ssm.tmall.service.ProductService;
import com.ssm.tmall.util.Page;

@Controller
@RequestMapping("")
public class ProductController {
	
	@Autowired
	ProductService productService;
	@Autowired
	CategoryService categoryService;
	
	@RequestMapping("admin_product_list")
	public String listProduct(Model model, Page page, Integer categoryId) {
		Category c = categoryService.get(categoryId);
		
		PageHelper.offsetPage(page.getStart(), page.getCount());
		List<Product> list = productService.list(categoryId);
		int total = (int)new PageInfo<>(list).getTotal();
		page.setTotal(total);
		page.setParam("&categoryId=" + c.getCategoryId());	//??
		
		/*for (Product p : list) {
			System.out.println("-----");
			System.out.println(p.getProductImage().getImageId());
		}*/
		
		model.addAttribute("list", list);
		model.addAttribute("page", page);
		model.addAttribute("c", c);
		return "admin/listProduct";
	}
	
	@RequestMapping("admin_product_add")
	public String addProduct(Product product) {
		product.setCreateDate(new Date());
		productService.add(product);
		
		return "redirect:/admin_product_list?categoryId=" + product.getCategoryId();
	}
	
	@RequestMapping("admin_product_delete")
	public String deleteProduct(Integer productId) {
		Integer categoryId = productService.get(productId).getCategoryId();
		productService.delete(productId);
		
		return "redirect:/admin_product_list?categoryId=" + categoryId;
	}
	
	@RequestMapping("admin_product_edit")
	public String editProduct(Model model, Integer productId) {
		Product product = productService.get(productId);
		
		Category category = categoryService.get(product.getCategoryId());
		product.setCategory(category);	//修改时给product对象设置category
		model.addAttribute("c", category);
		model.addAttribute("p", product);
		return "admin/editProduct";
	}
	
	@RequestMapping("admin_product_update")
	public String updateProduct(Product product) {
		productService.update(product);
		
		return "redirect:/admin_product_list?categoryId=" + product.getCategoryId();
	}

}
