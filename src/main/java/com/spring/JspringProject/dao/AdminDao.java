package com.spring.JspringProject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.JspringProject.vo.ComplaintVo;

public interface AdminDao {

	int getNewMemberCnt();

	int setMemberLevelChange(@Param("level") int level, @Param("idx") int idx);

	int setBoardComplaintInput(@Param("vo") ComplaintVo vo);

	void setBoardTableComplaintOk(@Param("partIdx") int partIdx);

	List<ComplaintVo> getComplaintList();

	int setContentChange(@Param("contentIdx") int contentIdx, @Param("contentSw") String contentSw);

	int setComplaintDeleteContent(@Param("contentIdx") int contentIdx);


}
