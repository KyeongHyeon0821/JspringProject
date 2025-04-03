package com.spring.JspringProject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.JspringProject.dao.WebMessageDao;
import com.spring.JspringProject.vo.WebMessageVo;

@Service
public class WebMessageServiceImpl implements WebMessageService {

	@Autowired
	WebMessageDao webMessageDao;

	@Override
	public int setWmInputOk(WebMessageVo vo) {
		return webMessageDao.setWmInputOk(vo);
	}

	@Override
	public List<WebMessageVo> getWebMessageList(String mid, int mSw, int startIndexNo, int pageSize) {
		return webMessageDao.getWebMessageList(mid, mSw, startIndexNo, pageSize);
	}

	@Override
	public WebMessageVo getWebMessageContent(int idx, String mid) {
		return webMessageDao.getWebMessageContent(idx, mid);
	}

	@Override
	public int setWmDeleteCheck(int idx, int mFlag) {
		return webMessageDao.setWmDeleteCheck(idx, mFlag);
	}

	@Override
	public void setWebMessageSwUpdate(int idx) {
		webMessageDao.setWebMessageSwUpdate(idx);
	}

	@Override
	public int setWebMessageDeleteAll(String mid) {
		return webMessageDao.setWebMessageDeleteAll(mid);
	}

	@Override
	public void setWebMessageDeleteAllProcess() {
		webMessageDao.setWebMessageDeleteAllProcess();
	}

	@Override
	public int getTotRecCnt(String mid, int mSw) {
		return webMessageDao.getTotRecCnt(mid, mSw);
	}
}
