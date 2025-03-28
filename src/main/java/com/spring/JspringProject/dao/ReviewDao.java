package com.spring.JspringProject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.JspringProject.vo.ReviewReplyVo;
import com.spring.JspringProject.vo.ReviewVo;

public interface ReviewDao {

	int setReviewInput(@Param("vo") ReviewVo vo);

	List<ReviewVo> getPdsReviewList(@Param("part") String part, @Param("idx") int idx);

	double getPdsReviewAvg(@Param("part") String part, @Param("idx") int idx);

	List<ReviewReplyVo> getPdsReviewReplyList(@Param("part") String part, @Param("idx") int idx);

}
