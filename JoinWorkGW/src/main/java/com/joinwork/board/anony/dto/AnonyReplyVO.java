package com.joinwork.board.anony.dto;

import java.util.Date;

public class AnonyReplyVO {
	private int replyId;
	private String replyContent;
    private Date replyCreateDt;
    private Date replyUpdateDt;
    private int anonyBoardId;
    private String empWriterId;
    
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
	public int getAnonyBoardId() {
		return anonyBoardId;
	}
	public void setAnonyBoardId(int anonyBoardId) {
		this.anonyBoardId = anonyBoardId;
	}
	public String getEmpWriterId() {
		return empWriterId;
	}
	public void setEmpWriterId(String empWriterId) {
		this.empWriterId = empWriterId;
	}
    
    
}
