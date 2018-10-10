package com.ssm.tmall.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.tmall.entity.Users;
import com.ssm.tmall.service.UsersService;
import com.ssm.tmall.util.Page;

@Controller
@RequestMapping("")
public class UsersController {

	@Autowired
	UsersService usersService;
	
	@RequestMapping("admin_user_list")
	public String listUsers(Model model, Page page) {
		PageHelper.offsetPage(page.getStart(), page.getCount());
		List<Users> list = usersService.list();
		int total = (int) new PageInfo<>(list).getTotal();
		page.setTotal(total);
		
		model.addAttribute("list", list);
		model.addAttribute("page", page);
		return "admin/listUser";
	}
}
