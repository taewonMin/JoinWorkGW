package com.joinwork.board.duty.dto;

import java.util.Date;

public class DutyReplyVO {
	private int replyId;
	private String replyContent;
	private Date replyCreateDt;
	private Date replyUpdateDt;
	private int dutyBoardId;
	private String empWriterId;
	private String empName;
	
	public int getReplyId() {
		return replyId;
	}
	public void setReplyId(int replyId) {
		this.replyId = replyId;
	}
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	public Date getReplyCreateDt() {
		return replyCreateDt;
	}
	public void setReplyCreateDt(Date replyCreateDt) {
		this.replyCreateDt = replyCreateDt;
	}
	public Date getReplyUpdateDt() {
		return replyUpdateDt;
	}
	public void setReplyUpdateDt(Date replyUpdateDt) {
		this.replyUpdateDt = replyUpdateDt;
	}
	public int getDutyBoardId() {
		return dutyBoardId;
	}
	public void setDutyBoardId(int dutyBoardId) {
		this.dutyBoardId = dutyBoardId;
	}
	public String getEmpWriterId() {
		return empWriterId;
	}
	public void setEmpWriterId(String empWriterId) {
		this.empWriterId = empWriterId;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	
}
