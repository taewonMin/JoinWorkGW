package com.joinwork.approval.dto;

import java.util.Date;
import java.util.List;

import com.joinwork.common.command.FileUploadCommand;
import com.joinwork.common.dto.BaseVO;

public class ApprovalVO extends BaseVO {
	private String approvalTitle;
    private String approvalContent;
    private Date approvalRecommandDt;
    private Date approvalTerminationDt;
    private String approvalSt;
    private String approvalEmergencyYn;
    private String approvalSecurity;
    private Date approvalEndDt;
    private String approvalAgencyYn;
    private String approvalPredecessYn;
    private String empDrafterId;
    private String empDrafterName;
    private String empDrafterOfficial;
    private String docId;
    private String formName;
    private String approvalCancelReason;
    private String attachCnt;
    private List<String> docIdList;
    
    
    private String searchDt = "";
    private String searchState = "";
    
    private FileUploadCommand fileUploadCommand;
    
    
    private List<ApprovalAttachVO> attachList;
    
    
    public ApprovalVO() {
    	this.fileUploadCommand = new FileUploadCommand();
    }
    

	public String getEmpDrafterName() {
		return empDrafterName;
	}


	public void setEmpDrafterName(String empDrafterName) {
		this.empDrafterName = empDrafterName;
	}


	public String getEmpDrafterOfficial() {
		return empDrafterOfficial;
	}


	public void setEmpDrafterOfficial(String empDrafterOfficial) {
		this.empDrafterOfficial = empDrafterOfficial;
	}


	public String getSearchState() {
		return searchState;
	}

	
	public List<String> getDocIdList() {
		return docIdList;
	}


	public void setDocIdList(List<String> docIdList) {
		this.docIdList = docIdList;
	}


	public void setSearchState(String searchState) {
		this.searchState = searchState;
	}


	public String getSearchDt() {
		return searchDt;
	}
	public void setSearchDt(String searchDt) {
		this.searchDt = searchDt;
	}
	public String getAttachCnt() {
		return attachCnt;
	}
	public void setAttachCnt(String attachCnt) {
		this.attachCnt = attachCnt;
	}
	public FileUploadCommand getFileUploadCommand() {
		return fileUploadCommand;
	}
	public void setFileUploadCommand(FileUploadCommand fileUploadCommand) {
		this.fileUploadCommand = fileUploadCommand;
	}
	public List<ApprovalAttachVO> getAttachList() {
		return attachList;
	}
	public void setAttachList(List<ApprovalAttachVO> attachList) {
		this.attachList = attachList;
	}
	public String getApprovalCancelReason() {
		return approvalCancelReason;
	}
	public void setApprovalCancelReason(String approvalCancelReason) {
		this.approvalCancelReason = approvalCancelReason;
	}
	public Date getApprovalTerminationDt() {
		return approvalTerminationDt;
	}
	public void setApprovalTerminationDt(Date approvalTerminationDt) {
		this.approvalTerminationDt = approvalTerminationDt;
	}
	public Date getApprovalEndDt() {
		return approvalEndDt;
	}
	public void setApprovalEndDt(Date approvalEndDt) {
		this.approvalEndDt = approvalEndDt;
	}
	public String getFormName() {
		return formName;
	}
	public void setFormName(String formName) {
		this.formName = formName;
	}
	public String getApprovalTitle() {
		return approvalTitle;
	}
	public void setApprovalTitle(String approvalTitle) {
		this.approvalTitle = approvalTitle;
	}
	
	public String getApprovalContent() {
		return approvalContent;
	}
	public void setApprovalContent(String approvalContent) {
		this.approvalContent = approvalContent;
	}
	public Date getApprovalRecommandDt() {
		return approvalRecommandDt;
	}
	public void setApprovalRecommandDt(Date approvalRecommandDt) {
		this.approvalRecommandDt = approvalRecommandDt;
	}
	public String getApprovalSt() {
		return approvalSt;
	}
	public void setApprovalSt(String approvalSt) {
		this.approvalSt = approvalSt;
	}
	public String getApprovalEmergencyYn() {
		return approvalEmergencyYn;
	}
	public void setApprovalEmergencyYn(String approvalEmergencyYn) {
		this.approvalEmergencyYn = approvalEmergencyYn;
	}
	public String getApprovalSecurity() {
		return approvalSecurity;
	}
	public void setApprovalSecurity(String approvalSecurity) {
		this.approvalSecurity = approvalSecurity;
	}
	public String getApprovalAgencyYn() {
		return approvalAgencyYn;
	}
	public void setApprovalAgencyYn(String approvalAgencyYn) {
		this.approvalAgencyYn = approvalAgencyYn;
	}
	public String getApprovalPredecessYn() {
		return approvalPredecessYn;
	}
	public void setApprovalPredecessYn(String approvalPredecessYn) {
		this.approvalPredecessYn = approvalPredecessYn;
	}
	public String getEmpDrafterId() {
		return empDrafterId;
	}
	public void setEmpDrafterId(String empDrafterId) {
		this.empDrafterId = empDrafterId;
	}
	public String getDocId() {
		return docId;
	}
	public void setDocId(String docId) {
		this.docId = docId;
	}
    
}
