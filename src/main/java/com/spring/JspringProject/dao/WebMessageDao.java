package com.spring.JspringProject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.JspringProject.vo.WebMessageVo;

public interface WebMessageDao {

	int setWmInputOk(@Param("vo") WebMessageVo vo);

	List<WebMessageVo> getWebMessageList(@Param("mid") String mid, @Param("mSw") int mSw, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	WebMessageVo getWebMessageContent(@Param("idx") int idx, @Param("mid") String mid);

	int setWmDeleteCheck(@Param("idx") int idx, @Param("mFlag") int mFlag);

	void setWebMessageSwUpdate(@Param("idx") int idx);

	int setWebMessageDeleteAll(@Param("mid") String mid);

	void setWebMessageDeleteAllProcess();

	int getTotRecCnt(@Param("mid") String mid, @Param("mSw") int mSw);

}
