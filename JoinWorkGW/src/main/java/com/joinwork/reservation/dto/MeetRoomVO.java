package com.joinwork.reservation.dto;

import java.util.List;

import com.joinwork.common.dto.BaseVO;

public class MeetRoomVO extends BaseVO {
	private int    meetRoomId;		
	private String meetRoomNo;		
	private String meetRoomSt;		
	private String meetRoomManagerId;		
	private int    meetRoomCapacity;	
	private String meetRoomName;
	private String meetRoomAttachName;		
	private String meetRoomAttachType;		
	private String meetRoomCreateDate;		
	private String meetRoomAttachPath;		
	private String meetRoomContent;
	
//////////////////////////////
	private String isType ="user";	// 탭 체크
    private String empId;
    private String empName;
    private String deptId;
    private String deptName;
    private String teamName;
    private String reservationStartTime;
    private String reservationEndTime;
    private String reservationDate;
	private int meetRoomReservationId;
	private String meetRoomTeamId;
	private String meetRoomDetail;
	private String officialName;
	private String MeetRoomReservationSt;
	
	public MeetRoomVO() {}
	
	private List<MeetRoomVO> attachList;	// 첨부 파일 목록(저장용)
	private List<MeetRoomVO> meetRoomAttachList;	// 첨부파일 목록(불러오기용)
	
	
	
//	private List<? extends AttachVO> attachList;
	
	
	
	public String getEmpId() {
		return empId;
	}

	public String getMeetRoomReservationSt() {
		return MeetRoomReservationSt;
	}

	public void setMeetRoomReservationSt(String meetRoomReservationSt) {
		MeetRoomReservationSt = meetRoomReservationSt;
	}

	public String getOfficialName() {
		return officialName;
	}

	public void setOfficialName(String officialName) {
		this.officialName = officialName;
	}

	public String getIsType() {
		return isType;
	}

	public void setIsType(String isType) {
		this.isType = isType;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getTeamName() {
		return teamName;
	}

	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}


	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	public String getEmpName() {
		return empName;
	}



	public void setEmpName(String empName) {
		this.empName = empName;
	}



	public String getMeetRoomDetail() {
		return meetRoomDetail;
	}



	public void setMeetRoomDetail(String meetRoomDetail) {
		this.meetRoomDetail = meetRoomDetail;
	}



	public String getMeetRoomTeamId() {
		return meetRoomTeamId;
	}



	public void setMeetRoomTeamId(String meetRoomTeamId) {
		this.meetRoomTeamId = meetRoomTeamId;
	}



	public void setEmpId(String empId) {
		this.empId = empId;
	}



	public String getReservationStartTime() {
		return reservationStartTime;
	}



	public void setReservationStartTime(String reservationStartTime) {
		this.reservationStartTime = reservationStartTime;
	}



	public String getReservationEndTime() {
		return reservationEndTime;
	}



	public void setReservationEndTime(String reservationEndTime) {
		this.reservationEndTime = reservationEndTime;
	}



	public String getReservationDate() {
		return reservationDate;
	}



	public void setReservationDate(String reservationDate) {
		this.reservationDate = reservationDate;
	}


	public int getMeetRoomReservationId() {
		return meetRoomReservationId;
	}

	public void setMeetRoomReservationId(int meetRoomReservationId) {
		this.meetRoomReservationId = meetRoomReservationId;
	}

	public int getMeetRoomId() {
		return meetRoomId;
	}



	public void setMeetRoomId(int meetRoomId) {
		this.meetRoomId = meetRoomId;
	}



	public String getMeetRoomNo() {
		return meetRoomNo;
	}



	public void setMeetRoomNo(String meetRoomNo) {
		this.meetRoomNo = meetRoomNo;
	}




	public String getMeetRoomSt() {
		return meetRoomSt;
	}



	public void setMeetRoomSt(String meetRoomSt) {
		this.meetRoomSt = meetRoomSt;
	}



	public String getMeetRoomManagerId() {
		return meetRoomManagerId;
	}



	public void setMeetRoomManagerId(String meetRoomManagerId) {
		this.meetRoomManagerId = meetRoomManagerId;
	}



	public int getMeetRoomCapacity() {
		return meetRoomCapacity;
	}



	public void setMeetRoomCapacity(int meetRoomCapacity) {
		this.meetRoomCapacity = meetRoomCapacity;
	}



	public String getMeetRoomName() {
		return meetRoomName;
	}



	public void setMeetRoomName(String meetRoomName) {
		this.meetRoomName = meetRoomName;
	}



	public String getMeetRoomAttachName() {
		return meetRoomAttachName;
	}



	public void setMeetRoomAttachName(String meetRoomAttachName) {
		this.meetRoomAttachName = meetRoomAttachName;
	}



	public String getMeetRoomAttachType() {
		return meetRoomAttachType;
	}



	public void setMeetRoomAttachType(String meetRoomAttachType) {
		this.meetRoomAttachType = meetRoomAttachType;
	}



	public String getMeetRoomCreateDate() {
		return meetRoomCreateDate;
	}



	public void setMeetRoomCreateDate(String meetRoomCreateDate) {
		this.meetRoomCreateDate = meetRoomCreateDate;
	}



	public String getMeetRoomAttachPath() {
		return meetRoomAttachPath;
	}



	public void setMeetRoomAttachPath(String meetRoomAttachPath) {
		this.meetRoomAttachPath = meetRoomAttachPath;
	}



	public String getMeetRoomContent() {
		return meetRoomContent;
	}



	public void setMeetRoomContent(String meetRoomContent) {
		this.meetRoomContent = meetRoomContent;
	}







	public List<MeetRoomVO> getAttachList() {
		return attachList;
	}



	public void setAttachList(List<MeetRoomVO> attachList) {
		this.attachList = attachList;
	}



	public List<MeetRoomVO> getMeetRoomAttachList() {
		return meetRoomAttachList;
	}



	public void setMeetRoomAttachList(List<MeetRoomVO> meetRoomAttachList) {
		this.meetRoomAttachList = meetRoomAttachList;
	}

	



	
	
	
}
