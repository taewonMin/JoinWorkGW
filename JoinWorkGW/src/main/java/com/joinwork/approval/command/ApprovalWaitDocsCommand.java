package com.joinwork.approval.command;

import java.util.Date;

public class ApprovalWaitDocsCommand {
     private String docId;
     private String approvalTitle;
     private Date approvalRecommandDt;
     private String formName;
     
     
	public String getFormName() {
		return formName;
	}
	public void setFormName(String formName) {
		this.formName = formName;
	}
	public String getDocId() {
		return docId;
	}
	public void setDocId(String docId) {
		this.docId = docId;
	}
	public String getApprovalTitle() {
		return approvalTitle;
	}
	public void setApprovalTitle(String approvalTitle) {
		this.approvalTitle = approvalTitle;
	}
	public Date getApprovalRecommandDt() {
		return approvalRecommandDt;
	}
	public void setApprovalRecommandDt(Date approvalRecommandDt) {
		this.approvalRecommandDt = approvalRecommandDt;
	}
	
	
      
     
     
}
