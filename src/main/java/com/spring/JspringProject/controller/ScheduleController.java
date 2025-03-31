package com.spring.JspringProject.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.JspringProject.service.ScheduleService;
import com.spring.JspringProject.vo.ScheduleVo;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {
	
	@Autowired
	ScheduleService scheduleService;

	// 스케줄 입/출력을 위한 달력...
	@GetMapping("/schedule")
	public String scheduleGet() {
		scheduleService.getSchedule();
		return "schedule/schedule";
	}
	
	// 선택된 일자의 일정을 '확인/등록' 처리
	@GetMapping("/scheduleMenu")
	public String scheduleMenuGet(Model model, HttpSession session, String ymd) {
		String mid = session.getAttribute("sMid") + "";
		String mm = "", dd = "";
		String[] ymdArr = ymd.split("-");
		if(ymd.length() != 10) {
			if(ymdArr[1].length() == 1) mm = "0" + ymdArr[1];
			else mm = ymdArr[1];
			
			if(ymdArr[2].length() == 1) dd = "0" + ymdArr[2];
			else dd = ymdArr[2];
			
			ymd = ymdArr[0] + "-" + mm + "-" + dd; 
		}
		
		List<ScheduleVo> vos = scheduleService.getScheduleMenu(mid, ymd);
		model.addAttribute("vos", vos);
		model.addAttribute("ymd", ymd);
		model.addAttribute("scheduleCnt", vos.size());
		
		return "schedule/scheduleMenu";
	}
	
	// 스케줄 입력 처리하기
	@ResponseBody
	@PostMapping("/scheduleInputOk")
	public String scheduleInputOkPost(ScheduleVo vo) {
		return scheduleService.setScheduleInput(vo) + "";
	}
	
	// 스케줄 수정 처리하기
	@ResponseBody
	@PostMapping("/scheduleUpdateOk")
	public String scheduleUpdateOkPost(ScheduleVo vo) {
		return scheduleService.setScheduleUpdateOk(vo) + "";
	}
	
	// 스케줄 삭제 처리하기
	@ResponseBody
	@PostMapping("/scheduleDeleteOk")
	public String scheduleDeleteOkPost(int idx) {
		return scheduleService.setscheduleDeleteOk(idx) + "";
	}
	
	
}
