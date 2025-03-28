package com.spring.JspringProject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.JspringProject.vo.PdsVo;

public interface PdsDao {

	int getPdsTotRecCnt(@Param("part") String part);

	List<PdsVo> getPdsList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("part") String part, @Param("search") String search, @Param("searchString") String searchString);

	int setPdsInput(@Param("vo") PdsVo vo);

	int setPdsDelete(@Param("idx") int idx);

	int setPdsDownNumPlus(@Param("idx") int idx);

	PdsVo getPdsContent(@Param("idx") int idx);

}
