package com.spring.JspringProject.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.JspringProject.vo.MemberVo;

public interface StudyService {

	String[] getCityStringArray(String dodo);

	List<String> getCityVosArray(String dodo);

	int fileUpload(MultipartFile fName, String mid);


}
