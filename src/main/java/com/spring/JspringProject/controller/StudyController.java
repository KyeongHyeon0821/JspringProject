package com.spring.JspringProject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.JspringProject.service.StudyService;

//@RestController
@Controller
@RequestMapping("/study")
public class StudyController {

	@Autowired
	private StudyService studyService;
	
	@RequestMapping("/ajax/ajaxForm")
	public String ajaxFormGet() {
		return "study/ajax/ajaxForm";
	}
	
//동기식 호출
//@RequestMapping("/ajax/ajaxTest1")
//public String ajaxTest1Get(Model model, int idx) {
//	model.addAttribute("idx", idx);
//	return "study/ajax/ajaxForm";
//}
	
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest1", method = RequestMethod.GET, produces = "application/text; charset=utf-8")
	public String ajaxTest1Get(int idx) {
		String str = "전송값 : " + idx;
		return str;
	}

	@RequestMapping(value = "/ajax/ajaxTest2_1", method = RequestMethod.GET)
	public String ajaxTest2_1Get() {
		return "study/ajax/ajaxTest2_1";
	}
	
//	@ResponseBody
//	@RequestMapping(value = "/ajax/ajaxTest2_1", method = RequestMethod.POST)
//	public String[] ajaxTest2_1Post(String dodo) {
//		String[] strArray = new String[100];
//		strArray = studyService.getCityStringArray(dodo);
//		return strArray;
//	}
	
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest2_1", method = RequestMethod.POST)
	public String[] ajaxTest2_1Post(String dodo) {
		return studyService.getCityStringArray(dodo);
	}
	
	@RequestMapping(value = "/ajax/ajaxTest2_2", method = RequestMethod.GET)
	public String ajaxTest2_2Get() {
		return "study/ajax/ajaxTest2_2";
	}
	
	@ResponseBody
	@RequestMapping(value="/ajax/ajaxTest2_2", method = RequestMethod.POST)
	public List<String> ajaxTest2_2Post(String dodo) {
		return studyService.getCityVosArray(dodo);
	}
	
	
	
	
}
