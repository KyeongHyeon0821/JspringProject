package com.spring.JspringProject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.JspringProject.vo.UserVo;

@Controller
@RequestMapping("/errorPage")
public class ErrorController {
	// 에러 연습폼
	@RequestMapping(value = "/errorMain", method = RequestMethod.GET)
	public String errorMainGet() {
		return "errorPage/errorMain";
	}
	
	// JSP 페이지에서의 에러발생시
	@RequestMapping(value = "/error1", method = RequestMethod.GET)
	public String error1Get() {
		return "errorPage/error1";
	}
	
	// JSP 페이지에서의 에러발생시 메세지 보여주는 폼
	@RequestMapping(value = "/errorMessage1", method = RequestMethod.GET)
	public String errorMessage1Get() {
		return "errorPage/errorMessage1";
	}
	
	// Servlet 에러(400) 발생시 이동페이지 처리
	@RequestMapping(value = "/error400", method = RequestMethod.GET)
	public String error400Get() {
		return "errorPage/error400";
	}
	
	// Servlet 에러(404) 발생시 이동페이지 처리
	@RequestMapping(value = "/error404", method = RequestMethod.GET)
	public String error404Get() {
		return "errorPage/error404";
	}
	
	// Servlet 에러(405) 발생시 이동페이지 처리
	@RequestMapping(value = "/error405", method = RequestMethod.POST)
	public String error405Post() {
		return "errorPage/error405";
	}
	
	//Servlet 에러(500)발생시 이동페이지 처리
	@RequestMapping(value = "/errorNullPointer", method = RequestMethod.GET)
	public String errorNullPointerExceptionGet(UserVo vo) {
		int temp = vo.getMid().length();
		return "errorPage/errorMain";
	}
	
	// NullPointerException 오류 발생시 처리하는곳
	@RequestMapping(value = "/errorNullPointerException", method = RequestMethod.GET)
	public String errorNullPointerExceptionGet() {
		return "errorPage/errorNullPointer";
	}
	
	// NullPointerException 오류 발생시 처리하는곳
	@RequestMapping(value = "/errorNumberFormatException", method = RequestMethod.GET)
	public String errorNumberFormatExceptionGet() {
		return "errorPage/errorNumberFormatException";
	}
	
	// ArrayIndexOutOfBoundsException 오류 발생시 처리하는곳
	@RequestMapping(value = "/errorArrayIndexOutOfBoundsException", method = RequestMethod.GET)
	public String errorArrayIndexOutOfBoundsExceptionGet() {
		return "errorPage/errorArrayIndexOutOfBoundsException";
	}
	
}
