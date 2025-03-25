package com.spring.JspringProject.service;

import com.spring.JspringProject.vo.ComplaintVo;

public interface AdminService {

	int getNewMemberCnt();

	int setMemberLevelChange(int level, int idx);

	int setBoardComplaintInput(ComplaintVo vo);

	void setBoardTableComplaintOk(int partIdx);


}
