package com.spring.JspringProject.service;

import java.util.List;

import com.spring.JspringProject.vo.ReviewReplyVo;
import com.spring.JspringProject.vo.ReviewVo;

public interface ReviewService {

	int setReviewInput(ReviewVo vo);

	List<ReviewVo> getPdsReviewList(String part, int idx);

	double getPdsReviewAvg(String part, int idx);

	List<ReviewReplyVo> getPdsReviewReplyList(String part, int idx);

}
