package com.spring.JspringProject.service;

import java.util.List;

import com.spring.JspringProject.vo.ScheduleVo;

public interface ScheduleService {

	void getSchedule();

	List<ScheduleVo> getScheduleMenu(String mid, String ymd);

	int setScheduleInput(ScheduleVo vo);

	int setScheduleUpdateOk(ScheduleVo vo);

	int setscheduleDeleteOk(int idx);

}
