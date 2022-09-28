package com.joinwork.doc.dto;


import com.joinwork.common.dto.AttachVO;

public class DocAttachVO extends AttachVO{
	private int docId;

	
	
	public DocAttachVO() {}
	
	public DocAttachVO(AttachVO attachVO) {
		setAttachPath(attachVO.getAttachPath());
		setAttachName(attachVO.getAttachName());
		setAttachType(attachVO.getAttachType());
		setAttachSize(attachVO.getAttachSize());
	}
	
	
	public int getDocId() {
		return docId;
	}
	public void setDocId(int docId) {
		this.docId = docId;
	}
	
	
}
