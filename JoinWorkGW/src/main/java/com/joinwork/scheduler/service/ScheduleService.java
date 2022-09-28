package com.joinwork.scheduler.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.joinwork.emp.dto.EmpVO;
import com.joinwork.scheduler.command.ScheduleCommand;
import com.joinwork.scheduler.dao.ScheduleDAO;
import com.joinwork.scheduler.dto.ScheduleVO;

public class ScheduleService {
	
//	ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
//    HttpSession session = servletRequestAttribute.getRequest().getSession(true);
	
	private ScheduleDAO scheduleDAO;
	public void setScheduleDAO(ScheduleDAO scheduleDAO) {
		this.scheduleDAO = scheduleDAO;
	}

	public List<ScheduleCommand> selectScheduleList(ScheduleVO scheduleVO) {
		List<ScheduleVO> scheduleList = scheduleDAO.selectScheduleListByDate(scheduleVO);
		
		List<ScheduleCommand> commandList = new ArrayList<ScheduleCommand>();
		for(ScheduleVO schedule : scheduleList) {
			commandList.add(schedule.toScheduleCommand());
			
		}
		return commandList;
	}

	public ScheduleCommand selectScheduleById(int id) {
		ScheduleVO schedule = scheduleDAO.selectScheduleById(id);
		ScheduleCommand command = schedule.toScheduleCommand();
		return command;
	}
	
	public void registSchedule(ScheduleVO schedule) {
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		schedule.setScheduleWriterId(empId);
//		
		scheduleDAO.insertSchedule(schedule);
	}
	
	
	public void updateSchedule(ScheduleVO schedule) {
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		schedule.setScheduleWriterId(empId);
		
		scheduleDAO.updateSchedule(schedule);
	}
	
	public void deleteSchedule(ScheduleVO schedule) {
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		schedule.setScheduleWriterId(empId);
		
		scheduleDAO.deleteSchedule(schedule);
	}
	
	
}
