package com.ssm.tmall.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.tmall.entity.Category;
import com.ssm.tmall.service.CategoryService;
import com.ssm.tmall.util.ImageUtil;
import com.ssm.tmall.util.Page;
import com.ssm.tmall.util.UploadedImageFile;

@Controller
@RequestMapping("")
public class CategoryController {
	
	@Autowired
	private CategoryService categoryService;
	
	@RequestMapping("admin_category_list")
	public String listCategory(Model model, Page page) {
		PageHelper.offsetPage(page.getStart(), page.getCount());
		List<Category> list = categoryService.list();
		int total = (int) new PageInfo<>(list).getTotal();
		page.setTotal(total);
		model.addAttribute("list", list);
		model.addAttribute("page", page);
		return "admin/listCategory";
	}
	
	@RequestMapping("admin_category_add")
	public String addCategory(Category category, HttpSession session, UploadedImageFile uploadedImageFile) throws Exception {
		categoryService.add(category);
//		System.out.println(category.getCategoryName());
//		System.out.println(category.getCategoryId());
		File imageFile = new File(session.getServletContext().getRealPath("img/category"));
		File file = new File(imageFile, category.getCategoryId()+".jpg");
		if (!file.getParentFile().exists()) {
			file.getParentFile().mkdirs();
		}
//		System.out.println("111111-----------"+file.toString());
		uploadedImageFile.getCategoryImage().transferTo(file);
		BufferedImage img = ImageUtil.change2jpg(file);
//		System.out.println("2222---------"+img.toString());
		boolean write = ImageIO.write(img, "jpg", file);
//		System.out.println("33333---------"+write);
//		category.setCategoryId(1212);
//		System.out.println(category.getCategoryId());
	
		return "redirect:/admin_category_list";
	}
	
	@RequestMapping("admin_category_delete")
	public String deleteCategory(Integer categoryId, HttpSession session) {
		System.out.println("-----"+categoryId);
		categoryService.delete(categoryId);
		
		//通过session获取ControllerContext然后获取分类图片位置，接着删除分类图片
		File imgFile = new File(session.getServletContext().getRealPath("img/category"));
		File file = new File(imgFile, categoryId+".jpg");
		file.delete();
		
		return "redirect:/admin_category_list";
	}
	
	@RequestMapping("admin_category_edit")
	public String editCategory(Model model, Integer categoryId) {
		Category c = categoryService.get(categoryId);
		model.addAttribute("category", c);
		return "admin/editCategory";
	}

	@RequestMapping("admin_category_update")
	public String updateCategory(Category category, HttpSession session, UploadedImageFile uploadedImageFile) throws Exception {
		categoryService.update(category);
		
		MultipartFile image = uploadedImageFile.getCategoryImage();
		if (image!=null && !image.isEmpty()) {
			File imageFile = new File(session.getServletContext().getRealPath("img/category"));
			File file = new File(imageFile, category.getCategoryId()+".jpg");
			if (!file.getParentFile().exists()) {
				file.getParentFile().mkdirs();
			}
			image.transferTo(file);
			BufferedImage img = ImageUtil.change2jpg(file);
			ImageIO.write(img, "jpg", file);
		}
		return "redirect:/admin_category_list";
	}
}
