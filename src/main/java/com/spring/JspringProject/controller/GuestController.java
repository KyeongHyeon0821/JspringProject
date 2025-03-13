package com.spring.JspringProject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.JspringProject.service.GuestService;
import com.spring.JspringProject.vo.GuestVo;

@Controller
@RequestMapping("/guest")
public class GuestController {

	@Autowired
	GuestService guestService;
	
	@RequestMapping("/guestList")
	public String guestListGet(Model model) {
		List<GuestVo> vos = guestService.getGuestList();
		model.addAttribute("vos", vos);
		
		return "guest/guestList";
	}
	
	@RequestMapping("/guestInput")
	public String guestInputGet() {
		return "guest/guestInput";
	}
	
	@RequestMapping(value="/guestInput", method = RequestMethod.POST)
	public String guestInputPost(Model model, GuestVo vo) {
		int res = guestService.setGuestInput(vo);
		
		if(res != 0) return "redirect:/message/guestInputOk";
		else return "redirect:/message/guestInputNo";
	}
}
