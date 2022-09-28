package com.joinwork.reservation.dto;

import com.joinwork.common.dto.BaseVO;

public class ReservationComplainVO extends BaseVO{
	private int complainId;
	private String complainTitle;
	private String complainContent;
	private String complainSt;
	private String empId;
	private String meetRoomId;
	private String complainCreateDate;
	private String empName;
	private String officialName;
	
	public ReservationComplainVO() {}


	public int getComplainId() {
		return complainId;
	}


	public void setComplainId(int complainId) {
		this.complainId = complainId;
	}


	public String getComplainTitle() {
		return complainTitle;
	}

	public void setComplainTitle(String complainTitle) {
		this.complainTitle = complainTitle;
	}

	public String getComplainContent() {
		return complainContent;
	}

	public void setComplainContent(String complainContent) {
		this.complainContent = complainContent;
	}

	public String getComplainSt() {
		return complainSt;
	}

	public void setComplainSt(String complainSt) {
		this.complainSt = complainSt;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getMeetRoomId() {
		return meetRoomId;
	}

	public void setMeetRoomId(String meetRoomId) {
		this.meetRoomId = meetRoomId;
	}

	public String getComplainCreateDate() {
		return complainCreateDate;
	}

	public void setComplainCreateDate(String complainCreateDate) {
		this.complainCreateDate = complainCreateDate;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getOfficialName() {
		return officialName;
	}

	public void setOfficialName(String officialName) {
		this.officialName = officialName;
	}
	
}