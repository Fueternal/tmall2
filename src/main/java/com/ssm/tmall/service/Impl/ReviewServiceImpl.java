package com.ssm.tmall.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssm.tmall.entity.Review;
import com.ssm.tmall.entity.ReviewExample;
import com.ssm.tmall.entity.Users;
import com.ssm.tmall.mapper.ReviewMapper;
import com.ssm.tmall.service.ReviewService;
import com.ssm.tmall.service.UsersService;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	ReviewMapper reviewMapper;
	@Autowired
	UsersService usersService;
	
	@Override
	public void add(Review review) {
		reviewMapper.insert(review);
	}

	@Override
	public void delete(int reviewId) {
		reviewMapper.deleteByPrimaryKey(reviewId);
	}

	@Override
	public void update(Review review) {
		reviewMapper.updateByPrimaryKeySelective(review);
	}

	@Override
	public Review get(int reviewId) {
		return reviewMapper.selectByPrimaryKey(reviewId);
	}

	@Override
	public List<Review> list(int productId) {
		ReviewExample example = new ReviewExample();
		example.createCriteria().andProductIdEqualTo(productId);
		example.setOrderByClause("reviewId desc");
		List<Review> list = reviewMapper.selectByExample(example);
		setUser(list);
		return list;
	}

	@Override
	public int getCount(int productId) {
		List<Review> list = list(productId);
		return list.size();
	}

	public void setUser(Review review) {
		Integer userId = review.getUserId();
		Users user = usersService.get(userId);
		review.setUser(user);
	}
	
	public void setUser(List<Review> list) {
		for (Review review : list) {
			setUser(review);
		}
	}
	
}
