package com.spring.JspringProject.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.JspringProject.vo.ChartVo;
import com.spring.JspringProject.vo.QrCodeVo;
import com.spring.JspringProject.vo.TransactionVo;
import com.spring.JspringProject.vo.UserVo;

public interface StudyService {

	String[] getCityStringArray(String dodo);

	List<String> getCityVosArray(String dodo);

	int fileUpload(MultipartFile fName, String mid);

	int multiFileUpload(MultipartHttpServletRequest mFile);

	void getCalendar();

	List<ChartVo> getRecentlyVisitCount(int i);
	

	String setQrCodeCreate(String mid);

	String setQrCodeCreate(QrCodeVo vo);

	String setQrCodeCreate2(QrCodeVo vo);

	String setQrCodeCreate3(QrCodeVo vo);

	QrCodeVo getQrCodeSearch(String qrCode);

	int setTransactionUserInput(TransactionVo vo);

	int setTransactionUser1Input(UserVo vo);

	int setTransactionUser2Input(UserVo vo);

	int setTransactionUser3Input(TransactionVo vo);

	String setThumbnailCreate(MultipartFile file);


}
