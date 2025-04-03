package com.spring.JspringProject.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.JspringProject.common.Pagination;
import com.spring.JspringProject.service.MemberService;
import com.spring.JspringProject.service.WebMessageService;
import com.spring.JspringProject.vo.MemberVo;
import com.spring.JspringProject.vo.PageVo;
import com.spring.JspringProject.vo.WebMessageVo;

@Controller
@RequestMapping("/webMessage")
public class WebMessageController {

	@Autowired
	WebMessageService webMessageService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	Pagination pagination;
	
	@GetMapping("/webMessage")
	public String webMessageGet(Model model, HttpSession session,
			@RequestParam(name="mSw", defaultValue = "1", required = false ) int mSw,
			@RequestParam(name="mFlag", defaultValue = "1", required = false ) int mFlag,
			@RequestParam(name="pag", defaultValue = "1", required = false ) int pag,
			@RequestParam(name="pageSize", defaultValue = "6", required = false ) int pageSize,
			@RequestParam(name="idx", defaultValue = "0", required = false ) int idx
		) {
		String mid = session.getAttribute("sMid") + "";
		
		if(mSw == 0) {				// 메세지 작성
			List<MemberVo> mVos = memberService.getMemberList(99);
			model.addAttribute("mVos", mVos);
		} 			
		else if(mSw == 6) { 	// 메세지 내용 보기
			WebMessageVo vo = webMessageService.getWebMessageContent(idx, mid);
			if(vo.getReceiveSw().equals("n")) webMessageService.setWebMessageSwUpdate(idx);
			model.addAttribute("vo", vo);
		}
		else if(mSw == 9) { 	// 휴지통 비우기
			List<WebMessageVo> vos = webMessageService.getWebMessageList(mid, 5, 0, pageSize);
			if(vos.size() != 0) {
				if(webMessageService.setWebMessageDeleteAll(mid) != 0) {
					webMessageService.setWebMessageDeleteAllProcess();
					return "redirect:/message/webMessageResetOk";
				}
				else return "redirect:/message/webMessageResetNo";
			}
			else return "redirect:/message/webMessageEmpty";
		}
		else { 								// mSw가 1~5까지 처리..
			PageVo pageVo = pagination.getTotRecCnt(pag, pageSize, "webMessage", mid, mSw+"");
			//List<WebMessageVo> vos = webMessageService.getWebMessageList(mid, mSw, 0, pageSize);
			List<WebMessageVo> vos = webMessageService.getWebMessageList(mid, mSw, pageVo.getStartIndexNo(), pageSize);
			
			model.addAttribute("vos", vos);
			model.addAttribute("pageVo", pageVo);
		}
		
		model.addAttribute("mSw", mSw);
		model.addAttribute("mFlag", mFlag);
		
		return "webMessage/webMessage";
	}
	
	// 메세지 보내기
	@RequestMapping(value =  "/wmInputOk", method = RequestMethod.POST)
	public String wmInputOkPost(WebMessageVo vo) {
		// 보내는 회원의 id가 있는지 확인
		MemberVo mVo = memberService.getMemberIdCheck(vo.getReceiveId()); 
		if(mVo == null) return "redirect:/message/wmMemberIdNo";
		
		if(webMessageService.setWmInputOk(vo) != 0) return "redirect:/message/wmInputOk";
		else return "redirect:/message/wmInputNo";
	}
	
	// 메세지 삭제처리
	@RequestMapping(value =  "/webDeleteCheck", method = RequestMethod.GET)
	public String wmDeleteCheckGet(Model model, int idx, int mSw, int mFlag) {
		model.addAttribute("mSw", mSw);
		if(webMessageService.setWmDeleteCheck(idx, mFlag) != 0) return "redirect:/message/wmDeleteOk";
		else return "redirect:/message/wmDeleteNo";
	}
	
	
}
