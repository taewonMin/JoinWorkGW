package com.joinwork.approval.dto;

public class ApprovalFormVO {
	private ApprovalVO approvalVO;
	private ApprovalVO searchApprovalVO;
	
	public ApprovalFormVO() {
		this.approvalVO = new ApprovalVO();
		this.searchApprovalVO = new ApprovalVO();
	}
	
	public ApprovalVO getApprovalVO() {
		return approvalVO;
	}
	public void setApprovalVO(ApprovalVO approvalVO) {
		this.approvalVO = approvalVO;
	}
	public ApprovalVO getSearchApprovalVO() {
		return searchApprovalVO;
	}
	public void setSearchApprovalVO(ApprovalVO searchApprovalVO) {
		this.searchApprovalVO = searchApprovalVO;
	}
	
	
}
