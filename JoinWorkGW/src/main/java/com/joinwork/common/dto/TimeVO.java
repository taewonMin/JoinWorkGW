package com.joinwork.common.dto;

public class TimeVO {
	
	private String attendTime;
	private String leavingTime;
	private String empManagerId;
	private String lunchStartTime;
	private String lunchEndTime;
	public String getAttendTime() {
		return attendTime;
	}
	public void setAttendTime(String attendTime) {
		this.attendTime = attendTime;
	}
	public String getLeavingTime() {
		return leavingTime;
	}
	public void setLeavingTime(String leavingTime) {
		this.leavingTime = leavingTime;
	}
	public String getEmpManagerId() {
		return empManagerId;
	}
	public void setEmpManagerId(String empManagerId) {
		this.empManagerId = empManagerId;
	}
	public String getLunchStartTime() {
		return lunchStartTime;
	}
	public void setLunchStartTime(String lunchStartTime) {
		this.lunchStartTime = lunchStartTime;
	}
	public String getLunchEndTime() {
		return lunchEndTime;
	}
	public void setLunchEndTime(String lunchEndTime) {
		this.lunchEndTime = lunchEndTime;
	}
	
	
}
