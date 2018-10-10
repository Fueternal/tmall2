package com.ssm.tmall.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ssm.tmall.entity.Users;
import com.ssm.tmall.entity.UsersExample;
import com.ssm.tmall.mapper.UsersMapper;
import com.ssm.tmall.service.UsersService;

@Controller
@RequestMapping("")
public class UsersServiceImpl implements UsersService {

	@Autowired
	UsersMapper usersMapper;
	
	@Override
	public void add(Users user) {
		usersMapper.insert(user);
	}

	@Override
	public void delete(Integer userId) {
		usersMapper.deleteByPrimaryKey(userId);
	}

	@Override
	public void update(Users user) {
		usersMapper.updateByPrimaryKeySelective(user);
	}

	@Override
	public Users get(Integer userId) {
		return usersMapper.selectByPrimaryKey(userId);
	}

	@Override
	public List<Users> list() {
		UsersExample example = new UsersExample();
		example.setOrderByClause("userId desc");
		return usersMapper.selectByExample(example);
	}

	@Override
	public boolean isExist(String userName) {
		UsersExample example = new UsersExample();
		example.createCriteria().andUserNameEqualTo(userName);
		List<Users> list = usersMapper.selectByExample(example);
		if (!list.isEmpty()) {
			return true;
		}
		return false;
		
	}

	@Override
	public Users get(String userName, String password) {
		UsersExample example = new UsersExample();
		example.createCriteria().andUserNameEqualTo(userName).andPasswordEqualTo(password);
		List<Users> result = usersMapper.selectByExample(example);
		if (result.isEmpty()) {
			return null;
		}
		
		return result.get(0);
	}

}
