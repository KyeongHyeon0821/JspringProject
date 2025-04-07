package com.spring.JspringProject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.JspringProject.vo.ChartVo;
import com.spring.JspringProject.vo.QrCodeVo;

public interface StudyDao {

	List<ChartVo> getRecentlyVisitCount(@Param("i") int i);

	void setQrCodeCreate(@Param("vo") QrCodeVo vo);

	QrCodeVo getQrCodeSearch(@Param("qrCode") String qrCode);



}
