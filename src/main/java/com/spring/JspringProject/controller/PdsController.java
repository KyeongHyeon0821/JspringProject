package com.spring.JspringProject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.JspringProject.common.Pagination;
import com.spring.JspringProject.service.PdsService;
import com.spring.JspringProject.vo.BoardVo;
import com.spring.JspringProject.vo.PageVo;
import com.spring.JspringProject.vo.PdsVo;

@Controller
@RequestMapping("/pds")
public class PdsController {

	@Autowired
	PdsService pdsService;
	
	@Autowired
	Pagination pagination;
	
	// 자료실 리스트 보기
	@RequestMapping("/pdsList")
	public String pdsListGet(Model model,
			@RequestParam(name = "part", defaultValue = "전체", required = false) String part,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "5", required = false) int pageSize
		) {
		PageVo pageVo = pagination.getTotRecCnt(pag, pageSize, "pds", part, "");
		List<PdsVo> vos = pdsService.getPdsList(pageVo.getStartIndexNo(), pageVo.getPageSize(), part, "", "");
		
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("vos", vos);
		
		
		return "pds/pdsList";
	}
	
	// 자료실 입력 폼 보기
	@RequestMapping(value =  "/pdsInput", method = RequestMethod.GET)
	public String pdsListGet(Model model,	@RequestParam(name = "part", defaultValue = "전체", required = false) String part	) {
		model.addAttribute("part", part);

		return "pds/pdsInput";
	}
	
	// 자료실 입력 처리
	@RequestMapping(value =  "/pdsInput", method = RequestMethod.POST)
	public String pdsListPost(MultipartHttpServletRequest mFName ,PdsVo vo) {
		int res = pdsService.setPdsInput(mFName, vo);
				
		if(res != 0) return "redirect:/message/pdsInputOk";
		else return "redirect:/message/pdsInputNo";
	}
	
	// 자료실 글 삭제 처리
	@ResponseBody
	@RequestMapping(value =  "/deleteContent", method = RequestMethod.POST)
	public String deleteContentPost(int idx, String fSName) {
		return pdsService.imgDelete(idx, fSName) + ""; 
	}
	
}
