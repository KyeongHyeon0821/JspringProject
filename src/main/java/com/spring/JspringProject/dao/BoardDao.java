package com.spring.JspringProject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.JspringProject.vo.BoardReplyVo;
import com.spring.JspringProject.vo.BoardVo;

public interface BoardDao {

	int getBoardTotRecCnt();

	List<BoardVo> getBoardList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("search") String search, @Param("searchString") String searchString);

	BoardVo getBoardContent(@Param("idx") int idx);

	void setBoardReadNumPlus(@Param("idx") int idx);

	int setBoardInput(@Param("vo") BoardVo vo);

	int setBoardDelete(@Param("idx") int idx);

	int setBoardUpdate(@Param("vo") BoardVo vo);

	int getBoardTotRecCntSearch(@Param("search") String search, @Param("searchString") String searchString);

	int setboardGoodCheck1(@Param("idx") int idx);

	int setBoardGoodCheck2(@Param("idx") int idx, @Param("goodCnt") int goodCnt);

	BoardVo getPreNextSearch(@Param("idx") int idx, @Param("preNext") String preNext);

	List<BoardReplyVo> getBoardReply(@Param("idx") int idx);

	int setBoardReplyInput(@Param("vo") BoardReplyVo vo);

	int setBoardReplyDelete(@Param("idx") int idx);

	int setReplyUpdateCheckOk(@Param("vo") BoardReplyVo vo);

}
