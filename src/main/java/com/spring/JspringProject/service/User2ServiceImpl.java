package com.spring.JspringProject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.JspringProject.dao.User2Dao;
import com.spring.JspringProject.vo.UserVo;

@Service
public class User2ServiceImpl implements User2Service {

	@Autowired
	User2Dao user2Dao;

	@Override
	public UserVo getUserIdSearch(String mid) {
		return user2Dao.getUserIdSearch(mid);
	}

	@Override
	public int setUserInput(UserVo vo) {
		return user2Dao.setUserInput(vo);
	}

	@Override
	public UserVo getUserSearchPart(UserVo vo) {
		return user2Dao.getUserSearchPart(vo);
	}

	@Override
	public List<UserVo> getUserList() {
		return user2Dao.getUserList();
	}

	@Override
	public int setUserDeleteOk(int idx) {
		return user2Dao.setUserDeleteOk(idx);
	}

	@Override
	public UserVo getSearchIdx(int idx) {
		return user2Dao.getSearchIdx(idx);
	}

	@Override
	public int setUserUpdate(UserVo vo) {
		return user2Dao.setUserUpdate(vo);
	}

	@Override
	public int getUserCnt() {
		return user2Dao.getUserCnt();
	}

	@Override
	public List<UserVo> getUserOrderList(String order) {
		return user2Dao.getUserOrderList(order);
	}

}
