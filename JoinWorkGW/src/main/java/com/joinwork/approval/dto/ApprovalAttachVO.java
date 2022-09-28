package com.joinwork.approval.dto;

import com.joinwork.common.dto.AttachVO;

public class ApprovalAttachVO extends AttachVO{
	private String docId;
	private String attachVolume;
	
	
	
	public String getAttachVolume() {
		return attachVolume;
	}

	public void setAttachVolume(String attachVolume) {
		this.attachVolume = attachVolume;
	}

	public String getDocId() {
		return docId;
	}

	public void setDocId(String docId) {
		this.docId = docId;
	}

	
}
