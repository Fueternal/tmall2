package com.ssm.tmall.service;

import java.util.List;

import com.ssm.tmall.entity.Users;

public interface UsersService {
	
	void add(Users user);
	void delete(Integer userId);
	void update(Users user);
	Users get(Integer userId);
	List<Users> list();
	
	boolean isExist(String userName);	//用于注册时判断要注册的用户名是否已经被注册
	
	Users get(String userName, String password);	//用于登录时验证用户名和密码
}
