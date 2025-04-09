package com.spring.JspringProject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.JspringProject.vo.ChartVo;
import com.spring.JspringProject.vo.QrCodeVo;
import com.spring.JspringProject.vo.TransactionVo;
import com.spring.JspringProject.vo.UserVo;

public interface StudyDao {

	List<ChartVo> getRecentlyVisitCount(@Param("i") int i);

	void setQrCodeCreate(@Param("vo") QrCodeVo vo);

	QrCodeVo getQrCodeSearch(@Param("qrCode") String qrCode);

	int setTransactionUserInput(@Param("vo") TransactionVo vo);

	int setTransactionUser1Input(@Param("vo") UserVo vo);

	int setTransactionUser2Input(@Param("vo") UserVo vo);

	int setTransactionUser3Input(@Param("vo") TransactionVo vo);



}
