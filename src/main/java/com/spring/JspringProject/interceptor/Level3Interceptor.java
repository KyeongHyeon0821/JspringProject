package com.spring.JspringProject.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class Level3Interceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 99 : (int) session.getAttribute("sLevel");
		
		String viewPage = "";
		
		// 0:관리자, 1:우수회원, 2:정회원, 3:준회원, 99:비회원, 999:탈퇴회원
		if(level > 3) {
			viewPage = "/message/loginError";
			request.getRequestDispatcher(viewPage).forward(request, response);
			return false;
		}
		
		return true;
	}
	
}
