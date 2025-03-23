package com.spring.JspringProject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.JspringProject.dao.UserDaoImpl;
import com.spring.JspringProject.vo.UserVo;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDaoImpl userDao;

	@Override
	public UserVo getUserIdSearch(String mid) {
		return userDao.getUserIdSearch(mid);
	}

	@Override
	public int setUserInput(UserVo vo) {
		return userDao.setUserInput(vo);
	}

	@Override
	public UserVo getUserSearchPart(UserVo vo) {
		return userDao.getUserSearchPart(vo);
	}

	@Override
	public List<UserVo> getUserList() {
		return userDao.getUserList();
	}

	@Override
	public int setUserDeleteOk(int idx) {
		return userDao.setUserDeleteOk(idx);
	}

	@Override
	public UserVo getSearchIdx(int idx) {
		return userDao.getSearchIdx(idx);
	}

	@Override
	public int setUserUpdate(UserVo vo) {
		return userDao.setUserUpdate(vo);
	}

	@Override
	public int getUserCnt() {
		return userDao.getUserCnt();
	}
	
	
}
