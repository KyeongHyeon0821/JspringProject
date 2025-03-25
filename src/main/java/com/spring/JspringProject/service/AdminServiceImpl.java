package com.spring.JspringProject.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.JspringProject.dao.AdminDao;
import com.spring.JspringProject.vo.ComplaintVo;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminDao adminDao;

	@Override
	public int getNewMemberCnt() {
		return adminDao.getNewMemberCnt();
	}

	@Override
	public int setMemberLevelChange(int level, int idx) {
		return adminDao.setMemberLevelChange(level, idx);
	}

	@Override
	public int setBoardComplaintInput(ComplaintVo vo) {
		return adminDao.setBoardComplaintInput(vo);
	}

	@Override
	public void setBoardTableComplaintOk(int partIdx) {
		adminDao.setBoardTableComplaintOk(partIdx);
	}

	
}
