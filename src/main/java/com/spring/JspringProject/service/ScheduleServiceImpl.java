package com.spring.JspringProject.service;

import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.JspringProject.dao.ScheduleDao;
import com.spring.JspringProject.vo.ScheduleVo;

@Service
public class ScheduleServiceImpl implements ScheduleService {

	@Autowired
	ScheduleDao scheduleDao;

	@Override
	public void getSchedule() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		
		// 오늘날짜(년/월/일)를 위한 변수 설정
		Calendar calToday = Calendar.getInstance();
		int toYear = calToday.get(Calendar.YEAR);
		int toMonth = calToday.get(Calendar.MONTH);
		int toDay = calToday.get(Calendar.DATE);
		
		// 화면에 보여주는 달력(년/월)
		Calendar calView = Calendar.getInstance();
		int yy = request.getParameter("yy")==null ? calView.get(Calendar.YEAR) : Integer.parseInt(request.getParameter("yy"));
		int mm = request.getParameter("mm")==null ? calView.get(Calendar.MONTH): Integer.parseInt(request.getParameter("mm"));
		
		if(mm < 0) {
			mm = 11;
			yy--;
		}
		if(mm > 11) {
			mm = 0;
			yy++;
		}
		calView.set(yy, mm, 1);
		
		int startWeek = calView.get(Calendar.DAY_OF_WEEK);
		int lastDay = calView.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		// 화면에 보여줄 년월기준..
		int prevYear = yy;
		int prevMonth = mm - 1;
		int nextYear = yy;
		int nextMonth = mm + 1;
		
		if(prevMonth == -1) {
			prevMonth = 11;
			prevYear--;
		}
		if(nextMonth == 12) {
			nextMonth = 0;
			nextYear++;
		}
		
		Calendar calPrev = Calendar.getInstance();
		calPrev.set(prevYear, prevMonth, 1);
		int prevLastDay = calPrev.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		Calendar calNext = Calendar.getInstance();
		calNext.set(nextYear, nextMonth, 1);
		int nextStartWeek = calNext.get(Calendar.DAY_OF_WEEK);
		
		// 화면에 보여줄 달력에 필요한 변수를 request에 담아서 넘긴다.
		request.setAttribute("toYear", toYear);
		request.setAttribute("toMonth", toMonth);
		request.setAttribute("toDay", toDay);
		
		request.setAttribute("yy", yy);
		request.setAttribute("mm", mm);
		request.setAttribute("startWeek", startWeek);
		request.setAttribute("lastDay", lastDay);
		
		request.setAttribute("prevYear", prevYear);
		request.setAttribute("prevMonth", prevMonth);
		request.setAttribute("nextYear", nextYear);
		request.setAttribute("nextMonth", nextMonth);
		
		request.setAttribute("nextStartWeek", nextStartWeek);
		request.setAttribute("prevLastDay", prevLastDay);
		
		// 등록된 일정을 보여주기 처리하기
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		int level = (int) session.getAttribute("sLevel");
		
		String ym = "";
		
		int intMM = mm + 1;
		if(intMM >= 1 && intMM <= 9) ym = yy + "-0" + intMM;
		else ym = yy + "-" + intMM; 
		List<ScheduleVo> vos = scheduleDao.getScheduleList(mid, ym, level);
		
		request.setAttribute("vos", vos);
		
	}

	@Override
	public List<ScheduleVo> getScheduleMenu(String mid, String ymd) {
		return scheduleDao.getScheduleMenu(mid, ymd);
	}

	@Override
	public int setScheduleInput(ScheduleVo vo) {
		return scheduleDao.setScheduleInput(vo);
	}

	@Override
	public int setScheduleUpdateOk(ScheduleVo vo) {
		return scheduleDao.setScheduleUpdateOk(vo);
	}

	@Override
	public int setscheduleDeleteOk(int idx) {
		return scheduleDao.setscheduleDeleteOk(idx);
	}
	
}
