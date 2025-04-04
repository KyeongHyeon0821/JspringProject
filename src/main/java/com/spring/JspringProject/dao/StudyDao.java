package com.spring.JspringProject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.JspringProject.vo.ChartVo;

public interface StudyDao {

	List<ChartVo> getRecentlyVisitCount(@Param("i") int i);



}
