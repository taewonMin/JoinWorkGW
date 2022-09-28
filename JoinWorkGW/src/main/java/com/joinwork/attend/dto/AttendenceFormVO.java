package com.joinwork.attend.dto;

public class AttendenceFormVO {
	private AttendenceVO attendenceVO;
	private AttendenceVO searchAttendceVO;
	
	public AttendenceFormVO() {
		this.attendenceVO = new AttendenceVO();
		this.searchAttendceVO = new AttendenceVO();
	}

	public AttendenceVO getAttendenceVO() {
		return attendenceVO;
	}

	public void setAttendenceVO(AttendenceVO attendenceVO) {
		this.attendenceVO = attendenceVO;
	}

	public AttendenceVO getSearchAttendceVO() {
		return searchAttendceVO;
	}

	public void setSearchAttendceVO(AttendenceVO searchAttendceVO) {
		this.searchAttendceVO = searchAttendceVO;
	}
	
	
	
	
	
}
