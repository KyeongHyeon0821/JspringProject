package com.spring.JspringProject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.JspringProject.service.AdminService;
import com.spring.JspringProject.service.BoardService;
import com.spring.JspringProject.service.MemberService;
import com.spring.JspringProject.vo.BoardVo;
import com.spring.JspringProject.vo.ComplaintVo;
import com.spring.JspringProject.vo.MemberVo;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	AdminService adminService;

	@Autowired
	MemberService memberService;
	
	@Autowired
	BoardService boardService;
	
	@GetMapping("/adminMain")
	public String adminMainGet() {
		return "admin/adminMain";
	}
	
	@GetMapping("/adminLeft")
	public String adminLeftGet() {
		return "admin/adminLeft";
	}
	
	@GetMapping("/adminContent")
	public String adminContentGet(Model model) {
		int newMemberCnt = adminService.getNewMemberCnt();
		model.addAttribute("newMemberCnt", newMemberCnt);
		return "admin/adminContent";
	}
	
	@GetMapping("/member/memberList")
	public String memberListGet(Model model,
			@RequestParam(name="level", defaultValue = "99", required = false) int level
			) {
		List<MemberVo> vos = memberService.getMemberList(level);
		model.addAttribute("vos", vos);
		model.addAttribute("level", level);
		
		return "admin/member/memberList";
	}
	
	// 개별 회원 레벨 등급 변경처리
	@ResponseBody
	@RequestMapping(value = ("/memberLevelChange"), method = RequestMethod.POST)
	public String memberLevelChangePost(int level, int idx) {
		return adminService.setMemberLevelChange(level, idx) + "";
	}
	
	// 선택된 회원 레벨 등급 변경처리
	@ResponseBody
	@RequestMapping(value = ("/checkedMemberLevelChange"), method = RequestMethod.POST)
	public String checkedMemberLevelChange(int level, String idxes) {
		System.out.println("level : " + level);
		System.out.println("idxes : " + idxes);
		int res = 0;
		
		String[] idxArray = idxes.split(",");
		for(String idxStr : idxArray) {
			res = adminService.setMemberLevelChange(level, Integer.parseInt(idxStr));
		}
		
		return res+"";
	}
	
	
	// 개별 회원정보 상세보기
	@RequestMapping(value = ("/memberInfor/{idx}"), method = RequestMethod.GET)
	public String memberInforGet(Model model, @PathVariable int idx) {
		MemberVo vo = memberService.getMemberIdxSearch(idx);
		model.addAttribute("vo", vo);
		return "admin/member/memberInfor";
	}
	
	// 신고 리스트 보기
	@RequestMapping(value = ("/complaint/complaintList"), method = RequestMethod.GET)
	public String complaintListGet(Model model) {
		List<ComplaintVo> vos = adminService.getComplaintList();
		model.addAttribute("vos", vos);
		return "admin/complaint/complaintList";
	}
	
	// 신고 게시글 상세보기
	@RequestMapping(value = ("/boardInfor/{idx}"), method = RequestMethod.GET)
	public String boardInforGet(Model model, @PathVariable int idx) {
		BoardVo vo = boardService.getBoardContent(idx);
		model.addAttribute("vo", vo);
		return "admin/complaint/boardInfor";
	}
	
	
	
	// 신고글 감추기/보이기
	@ResponseBody
	@RequestMapping(value = ("/complaint/contentChange"), method = RequestMethod.POST)
	public String contentChangePost(int contentIdx, String contentSw) {
		String res = "";
		// 컨텐츠 감추기/보이기 처리
		res = adminService.setContentChange(contentIdx, contentSw) + "";
		// 컨첸츠 보이기 처리를 했다면 신고 테이블에서 해당 컨텐츠를 삭제
		if(res.equals("1") && contentSw.equals("S")) {
			res = adminService.setComplaintDeleteContent(contentIdx) + "";
		}
		
		return res;
	}
	
	// 신고글 삭제하기
	@ResponseBody
	@RequestMapping(value = ("/complaint/contentDelete"), method = RequestMethod.POST)
	public String contentDeletePost(int contentIdx, String contentName) {
		String res = "";
		// 게시글을 삭제하려면 complaint table에서 먼저 해당 게시글에 대한 신고를 삭제 해야함 (외래키로 잡고있기 때문)
		res = adminService.setComplaintDeleteContent(contentIdx) + "";
		if(res.equals("1") && contentName.equals("B"))	res = boardService.setBoardDelete(contentIdx) + "";
		//else if(res.equals("1") && contentName.equals("P")) return pdsService.setPdsDelete(contentIdx) + "";
		
		return res;
	}
	
	
	
}
