package com.spring.JspringProject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.JspringProject.vo.GuestVo;

public interface GuestDao {

	List<GuestVo> getGuestList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	int setGuestInput(@Param("vo") GuestVo vo);

	int setGuestDelete(@Param("idx") int idx);
	
	int getTotRecCnt();

}
