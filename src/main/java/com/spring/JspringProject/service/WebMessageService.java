package com.spring.JspringProject.service;

import java.util.List;

import com.spring.JspringProject.vo.WebMessageVo;

public interface WebMessageService {

	int setWmInputOk(WebMessageVo vo);

	List<WebMessageVo> getWebMessageList(String mid, int mSw, int startIndexNo, int pageSize);

	WebMessageVo getWebMessageContent(int idx, String mid);

	int setWmDeleteCheck(int idx, int mFlag);

	void setWebMessageSwUpdate(int idx);

	int setWebMessageDeleteAll(String mid);

	void setWebMessageDeleteAllProcess();

	int getTotRecCnt(String mid, int mSw);

}
