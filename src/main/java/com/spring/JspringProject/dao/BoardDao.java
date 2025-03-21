package com.spring.JspringProject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.JspringProject.vo.BoardVo;

public interface BoardDao {

	int getBoardTotRecCnt();

	List<BoardVo> getBoardList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	BoardVo getBoardContent(@Param("idx") int idx);

	void setBoardReadNumPlus(@Param("idx") int idx);

	int setBoardInput(@Param("vo") BoardVo vo);

	int setBoardDelete(@Param("idx") int idx);

	int setBoardUpdate(@Param("vo") BoardVo vo);

}
