package com.spring.JspringProject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.JspringProject.dao.ReviewDao;
import com.spring.JspringProject.vo.ReviewReplyVo;
import com.spring.JspringProject.vo.ReviewVo;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	ReviewDao reviewDao;

	@Override
	public int setReviewInput(ReviewVo vo) {
		return reviewDao.setReviewInput(vo);
	}

	@Override
	public List<ReviewVo> getPdsReviewList(String part, int idx) {
		return reviewDao.getPdsReviewList(part, idx);
	}

	@Override
	public double getPdsReviewAvg(String part, int idx) {
		return reviewDao.getPdsReviewAvg(part, idx);
	}

	@Override
	public List<ReviewReplyVo> getPdsReviewReplyList(String part, int idx) {
		return reviewDao.getPdsReviewReplyList(part, idx);
	}
}
