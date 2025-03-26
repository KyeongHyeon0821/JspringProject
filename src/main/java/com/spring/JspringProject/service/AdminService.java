package com.spring.JspringProject.service;

import java.util.List;

import com.spring.JspringProject.vo.ComplaintVo;

public interface AdminService {

	int getNewMemberCnt();

	int setMemberLevelChange(int level, int idx);

	int setBoardComplaintInput(ComplaintVo vo);

	void setBoardTableComplaintOk(int partIdx);

	List<ComplaintVo> getComplaintList();

	int setContentChange(int contentIdx, String contentSw);

	int setComplaintDeleteContent(int contentIdx);



}
