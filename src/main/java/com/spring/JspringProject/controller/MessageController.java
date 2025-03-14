package com.spring.JspringProject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {

	@RequestMapping(value = "/message/{msgFlag}", method = RequestMethod.GET)
	public String getMessage(Model model, @PathVariable String msgFlag,
			@RequestParam(name="mid", defaultValue = "", required = false) String mid
		) {
		
		if(msgFlag.equals("userInputOk")) {
			model.addAttribute("message", "회원에 가입되었습니다.");
			model.addAttribute("url", "user/userMain");
		}
		else if(msgFlag.equals("userInputNo")) {
			model.addAttribute("message", "회원에 가입실패~~");
			model.addAttribute("url", "user/userInput");
		}
		else if(msgFlag.equals("user2InputOk")) {
			model.addAttribute("message", "회원에 가입되었습니다.");
			model.addAttribute("url", "user2/userMain");
		}
		else if(msgFlag.equals("user2InputNo")) {
			model.addAttribute("message", "회원에 가입실패~~");
			model.addAttribute("url", "user2/userInput");
		}
		else if(msgFlag.equals("userIdDuplication")) {
			model.addAttribute("message", "이미 사용중인 아이디 입니다.\\n다른 아이디로 가입하세요.");
			model.addAttribute("url", "user/userInput");
		}
		else if(msgFlag.equals("user2IdDuplication")) {
			model.addAttribute("message", "이미 사용중인 아이디 입니다.\\n다른 아이디로 가입하세요.");
			model.addAttribute("url", "user2/userInput");
		}
		else if(msgFlag.equals("userSearchNo")) {
			model.addAttribute("message", "검색한 회원이 없습니다.");
			model.addAttribute("url", "user/userSearch");
		}
		else if(msgFlag.equals("user2SearchNo")) {
			model.addAttribute("message", "검색한 회원이 없습니다.");
			model.addAttribute("url", "user2/userSearch");
		}
		else if(msgFlag.equals("userDeleteOk")) {
			model.addAttribute("message", "회원을 삭제처리 하였습니다.");
			model.addAttribute("url", "user/userList");
		}
		else if(msgFlag.equals("userDeleteNo")) {
			model.addAttribute("message", "회원삭제 실패");
			model.addAttribute("url", "user/userList");
		}
		else if(msgFlag.equals("user2DeleteOk")) {
			model.addAttribute("message", "회원을 삭제처리 하였습니다.");
			model.addAttribute("url", "user2/userList");
		}
		else if(msgFlag.equals("user2DeleteNo")) {
			model.addAttribute("message", "회원삭제 실패");
			model.addAttribute("url", "user2/userList");
		}
		else if(msgFlag.equals("userUpdateOk")) {
			model.addAttribute("message", "회원정보 수정 완료");
			model.addAttribute("url", "user/userList");
		}
		else if(msgFlag.equals("userUpdateNo")) {
			model.addAttribute("message", "회원정보 수정 실패~~");
			model.addAttribute("url", "user/userList");
		}
		else if(msgFlag.equals("user2UpdateOk")) {
			model.addAttribute("message", "회원정보 수정 완료");
			model.addAttribute("url", "user2/userList");
		}
		else if(msgFlag.equals("user2UpdateNo")) {
			model.addAttribute("message", "회원정보 수정 실패~~");
			model.addAttribute("url", "user/userList");
		}
		else if(msgFlag.equals("guestInputOk")) {
			model.addAttribute("message", "방명록에 글이 등록되었습니다.");
			model.addAttribute("url", "guest/guestList");
		}
		else if(msgFlag.equals("guestInputNo")) {
			model.addAttribute("message", "방명록에 글이 등록 실패~~");
			model.addAttribute("url", "guest/guestInput");
		}
		else if(msgFlag.equals("adminOk")) {
			model.addAttribute("message", "관리자 로그인에 성공했습니다.");
			model.addAttribute("url", "guest/guestList");
		}
		else if(msgFlag.equals("adminNo")) {
			model.addAttribute("message", "관리자 로그인에 실패했습니다.");
			model.addAttribute("url", "guest/admin");
		}
		else if(msgFlag.equals("adminLogout")) {
			model.addAttribute("message", "관리자 로그아웃에 성공했습니다.");
			model.addAttribute("url", "guest/guestList");
		}
		else if(msgFlag.equals("guestDeleteOk")) {
			model.addAttribute("message", "방명록을 삭제했습니다.");
			model.addAttribute("url", "guest/guestList");
		}
		else if(msgFlag.equals("guestDeleteNo")) {
			model.addAttribute("message", "방명록을 삭제를 실패했습니다.");
			model.addAttribute("url", "guest/guestList");
		}
		
		return "include/message";
	}
	
}
