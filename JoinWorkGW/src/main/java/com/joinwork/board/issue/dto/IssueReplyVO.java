package com.joinwork.board.issue.dto;

public class IssueReplyVO {
	private String replyContent;
	private String replyCreateDt;
	private String replyUpdateDt;
	private int replyId;
	private int issueBoardId;
	private String empWriterId;
	private String replyGroupCode;
	private String empName;
	private String empPicture;
	
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	public String getReplyCreateDt() {
		return replyCreateDt;
	}
	public void setReplyCreateDt(String replyCreateDt) {
		this.replyCreateDt = replyCreateDt;
	}
	public String getReplyUpdateDt() {
		return replyUpdateDt;
	}
	public void setReplyUpdateDt(String replyUpdateDt) {
		this.replyUpdateDt = replyUpdateDt;
	}
	public int getReplyId() {
		return replyId;
	}
	public void setReplyId(int replyId) {
		this.replyId = replyId;
	}
	public int getIssueBoardId() {
		return issueBoardId;
	}
	public void setIssueBoardId(int issueBoardId) {
		this.issueBoardId = issueBoardId;
	}
	public String getEmpWriterId() {
		return empWriterId;
	}
	public void setEmpWriterId(String empWriterId) {
		this.empWriterId = empWriterId;
	}
	public String getReplyGroupCode() {
		return replyGroupCode;
	}
	public void setReplyGroupCode(String replyGroupCode) {
		this.replyGroupCode = replyGroupCode;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getEmpPicture() {
		return empPicture;
	}
	public void setEmpPicture(String empPicture) {
		this.empPicture = empPicture;
	}
	
	
}
