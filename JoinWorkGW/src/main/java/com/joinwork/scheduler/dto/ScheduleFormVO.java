package com.joinwork.scheduler.dto;

import com.joinwork.common.dto.BaseVO;
import com.joinwork.scheduler.command.ScheduleCommand;

public class ScheduleFormVO extends BaseVO{

	private ScheduleVO scheduleVO;
	private ScheduleVO searchScheduleVO;
	private ScheduleCommand scheduleCommand;
	private String from;
	
	public ScheduleFormVO() {
		this.scheduleVO = new ScheduleVO();
		this.searchScheduleVO = new ScheduleVO();
		scheduleCommand = new ScheduleCommand();
	}
	
	
	public String getFrom() {
		return from;
	}
	public void setFrom(String from) {
		this.from = from;
	}
	public ScheduleVO getScheduleVO() {
		return scheduleVO;
	}
	public void setScheduleVO(ScheduleVO scheduleVO) {
		this.scheduleVO = scheduleVO;
	}
	public ScheduleVO getSearchScheduleVO() {
		return searchScheduleVO;
	}

	public void setSearchScheduleVO(ScheduleVO searchScheduleVO) {
		this.searchScheduleVO = searchScheduleVO;
	}

	public ScheduleCommand getScheduleCommand() {
		return scheduleCommand;
	}

	public void setScheduleCommand(ScheduleCommand scheduleCommand) {
		scheduleCommand = scheduleCommand;
	}
	
	
	
	
}
