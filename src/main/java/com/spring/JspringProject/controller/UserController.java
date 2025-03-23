package com.spring.JspringProject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.JspringProject.service.UserService;
import com.spring.JspringProject.vo.UserVo;


@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;
	
	// user 메인화면
	@RequestMapping("/userMain")
	public String userMainGet(Model model) {
		int userCnt = userService.getUserCnt();
		model.addAttribute("userCnt", userCnt);
		return "user/userMain";
	}
	
	// user 등록폼 보기
	@RequestMapping(value = "/userInput", method = RequestMethod.GET)
	public String userInputGet() {
		return "user/userInput";
	}
	
	// user 등록 처리
	@RequestMapping(value = "/userInput", method = RequestMethod.POST)
	public String userInputPost(UserVo vo) {
		 // 아이디 중복체크
		 UserVo vo2 = userService.getUserIdSearch(vo.getMid());
		 if(vo2 != null) return "redirect:/message/userIdDuplication";
		
		 //회원가입 처리
		 int res = userService.setUserInput(vo);
		 if(res != 0)	return "redirect:/message/userInputOk";
		 else return "redirect:/message/userInputNo";
	}

	// user 개별검색 폼 보기
	@RequestMapping(value = "/userSearch", method = RequestMethod.GET)
	public String userSearchGet() {
		return "user/userSearch";
	}
	
	// user 개별검색 처리하기
	@RequestMapping(value = "/userSearchPart", method = RequestMethod.GET)
	public String userSearchPartGet(Model model, UserVo vo) {
		UserVo vo2 = userService.getUserSearchPart(vo);
		if(vo2 == null) return "redirect:/message/userSearchNo";
		
		model.addAttribute("vo", vo2);
		
		return "user/userSearch";
	}
	
	// user 전체 자료 보기
	@RequestMapping(value = "/userList", method = RequestMethod.GET)
	public String userListGet(Model model) {
		List<UserVo> vos = userService.getUserList();
		
		model.addAttribute("vos", vos);
		
		return "user/userList";
	}
	
	
	// user 삭제처리
	@RequestMapping(value = "/userDeleteOk", method = RequestMethod.GET)
	public String userDeleteOkGet(int idx) {
		int res = userService.setUserDeleteOk(idx);
		
		if(res != 0)	return "redirect:/message/userDeleteOk";
		else return "redirect:/message/userDeleteNo";
	}
	
	// user 수정폼 보기
	@RequestMapping(value = "/userUpdate", method = RequestMethod.GET)
	public String userUpdateGet(Model model, int idx) {
		UserVo vo = userService.getSearchIdx(idx);
		
		model.addAttribute("vo", vo);
		
		return "user/userUpdate";
	}
	
	// user 수정 처리하기
	@RequestMapping(value = "/userUpdate", method = RequestMethod.POST)
	public String userUpdatePost(UserVo vo) {
		int res = userService.setUserUpdate(vo);
		
		 if(res != 0)	return "redirect:/message/userUpdateOk";
		 else return "redirect:/message/userUpdateNo";
	}
	
	
	
	
	
	
	
}
