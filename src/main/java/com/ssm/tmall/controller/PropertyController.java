package com.ssm.tmall.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.tmall.entity.Category;
import com.ssm.tmall.entity.Property;
import com.ssm.tmall.service.CategoryService;
import com.ssm.tmall.service.PropertyService;
import com.ssm.tmall.util.Page;

@Controller
@RequestMapping("")
public class PropertyController {
	
	@Autowired
	PropertyService propertyService;
	@Autowired
	CategoryService categoryService;
	
	@RequestMapping("admin_property_list")
	public String listProperty(Model model, Integer categoryId, Page page) {
		Category c = categoryService.get(categoryId);
		
		PageHelper.offsetPage(page.getStart(), page.getCount());
		List<Property> list = propertyService.list(categoryId);
		int total = (int) new PageInfo<>(list).getTotal();
		page.setTotal(total);
		page.setParam("&categoryId=" + c.getCategoryId());	//??????
		
		model.addAttribute("list", list);
		model.addAttribute("c", c);
		model.addAttribute("page", page);
		return "admin/listProperty";
	}
	
	@RequestMapping("admin_property_add")
	public String addProperty(Property property) {
		propertyService.add(property);
		return "redirect:/admin_property_list?categoryId=" + property.getCategoryId();
	}

	@RequestMapping("admin_property_delete")
	public String deleteProperty(Integer propertyId) {
		Property p = propertyService.get(propertyId);
		propertyService.delete(propertyId);
		return "redirect:/admin_property_list?categoryId=" + p.getCategoryId();
	}
	
	@RequestMapping("admin_property_edit")
	public String editProperty(Model model, Integer propertyId) {
		Property p = propertyService.get(propertyId);
		Category c = categoryService.get(p.getCategoryId());
		p.setCategory(c);	//???
		model.addAttribute("p", p);
		model.addAttribute("c", c);
		return "admin/editProperty";
	}
	
	@RequestMapping("admin_property_update")
	public String updateProperty(Property property) {
		propertyService.update(property);
		return "redirect:/admin_property_list?categoryId=" + property.getCategoryId();
	}

}
