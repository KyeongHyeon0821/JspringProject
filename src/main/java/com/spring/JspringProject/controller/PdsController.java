package com.spring.JspringProject.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
import com.spring.JspringProject.service.ReviewService;
import com.spring.JspringProject.vo.BoardVo;
import com.spring.JspringProject.vo.PageVo;
import com.spring.JspringProject.vo.PdsVo;
import com.spring.JspringProject.vo.ReviewReplyVo;
import com.spring.JspringProject.vo.ReviewVo;

@Controller
@RequestMapping("/pds")
public class PdsController {

	@Autowired
	PdsService pdsService;
	
	@Autowired
	ReviewService reviewService;
	
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
		return pdsService.setPdsDelete(idx, fSName) + ""; 
	}
	
	// 파일 다운로드 수 증가 처리
	@ResponseBody
	@RequestMapping(value =  "/pdsDownNumCheck", method = RequestMethod.POST)
	public String pdsDownNumCheckPost(int idx) {
		return pdsService.setPdsDownNumPlus(idx) + ""; 
	}
	
	// 자료실 글 상세보기
	@RequestMapping(value =  "pdsContent", method = RequestMethod.GET)
	public String pdsContentGet(Model model, int idx, PageVo pageVo) {
		PdsVo vo = pdsService.getPdsContent(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("pageVo", pageVo);
		
		// 리뷰 가져오기
		List<ReviewVo> rVos = reviewService.getPdsReviewList("pds", idx);
		model.addAttribute("rVos", rVos);
		
		// 리뷰 평점 구하기
		if(!rVos.isEmpty()) {
			double reviewAvg = reviewService.getPdsReviewAvg("pds", idx);
			model.addAttribute("reviewAvg", reviewAvg);
		}
		else model.addAttribute("reviewAvg", 0.0);
		// 리뷰 댓글 가져오기
//		List<ReviewReplyVo> rRvos = reviewService.getPdsReviewReplyList("pds", idx);
//		System.out.println("rRvos : " + rRvos);
//		model.addAttribute("rRvos", rRvos);
		return "pds/pdsContent";
	}
	
	@SuppressWarnings("deprecation")
	@RequestMapping(value = ("/pdsTotalDown"), method = RequestMethod.GET)
	public String pdsTotalDownGet(HttpServletRequest request, int idx) {
		// 다운로드수 증가처리
		pdsService.setPdsDownNumPlus(idx);
		
		// 여러개의 파일을 하나의 통합파일(zip)로 다운로드 처리, 파일명은 '제목.zip'
		String zipName = pdsService.pdsTotalDown(request, idx);
		
		return "redirect:/fileDownAction?path=pds&file="+ java.net.URLEncoder.encode(zipName);
	}
	
}
