package com.joinwork.reservation.dto;

import com.joinwork.common.dto.BaseVO;

public class ReservationNoticeVO extends BaseVO {

	private int reservationNoticeId;
	private String reservationNoticeTitle;
	private String empId;
	private String reservationNoticeContent;
	private String reservationNoticeCreateDate;
	private String reservationNoticeSt;
	private String isType;
	
	
	public ReservationNoticeVO() {}


	

	public int getReservationNoticeId() {
		return reservationNoticeId;
	}




	public void setReservationNoticeId(int reservationNoticeId) {
		this.reservationNoticeId = reservationNoticeId;
	}




	public String getReservationNoticeTitle() {
		return reservationNoticeTitle;
	}


	public void setReservationNoticeTitle(String reservationNoticeTitle) {
		this.reservationNoticeTitle = reservationNoticeTitle;
	}


	public String getEmpId() {
		return empId;
	}


	public void setEmpId(String empId) {
		this.empId = empId;
	}


	public String getReservationNoticeContent() {
		return reservationNoticeContent;
	}


	public void setReservationNoticeContent(String reservationNoticeContent) {
		this.reservationNoticeContent = reservationNoticeContent;
	}


	public String getReservationNoticeCreateDate() {
		return reservationNoticeCreateDate;
	}


	public void setReservationNoticeCreateDate(String reservationNoticeCreateDate) {
		this.reservationNoticeCreateDate = reservationNoticeCreateDate;
	}


	public String getReservationNoticeSt() {
		return reservationNoticeSt;
	}


	public void setReservationNoticeSt(String reservationNoticeSt) {
		this.reservationNoticeSt = reservationNoticeSt;
	}


	public String getIsType() {
		return isType;
	}


	public void setIsType(String isType) {
		this.isType = isType;
	}
	
	






}
