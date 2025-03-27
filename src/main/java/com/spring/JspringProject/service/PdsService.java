package com.spring.JspringProject.service;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.JspringProject.vo.PdsVo;

public interface PdsService {

	List<PdsVo> getPdsList(int startIndexNo, int pageSize, String part, String search, String searchString);

	int setPdsInput(MultipartHttpServletRequest mFName, PdsVo vo);

	int imgDelete(int idx, String fSName);

}
