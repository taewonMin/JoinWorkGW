package com.joinwork.doc.dto;

import com.joinwork.common.command.FileUploadCommand;
import com.joinwork.doc.dto.DocVO;


public class DocFormVO {

	private DocVO docVO;
	private DocVO searchDocVO;
	private String docType;
	private FileUploadCommand fileUploadCommand;
	
	
	
	
	public DocFormVO() {
		this.docVO = new DocVO();
		this.searchDocVO = new DocVO();
		this.fileUploadCommand = new FileUploadCommand();
	}
	
	
	
	
	public String getDocType() {
		return docType;
	}

	public void setDocType(String docType) {
		this.docType = docType;
	}




	public DocVO getDocVO() {
		return docVO;
	}
	public void setDocVO(DocVO docVO) {
		this.docVO = docVO;
	}
	public DocVO getSearchDocVO() {
		return searchDocVO;
	}
	public void setSearchDocVO(DocVO searchDocVO) {
		this.searchDocVO = searchDocVO;
	}

	public int getDocId() {
		return this.docVO.getDocId();
	}
	public void setDocId(int docId) {
		this.docVO.setDocId(docId);
	}

	public FileUploadCommand getFileUploadCommand() {
		return fileUploadCommand;
	}

	public void setFileUploadCommand(FileUploadCommand fileUploadCommand) {
		this.fileUploadCommand = fileUploadCommand;
	}




	
}
