package com.joinwork.common.command;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class FileUploadCommand {
	private String fileUploadPath;
	private List<MultipartFile> uploadFile;
	private int attachId;
	private int[] deleteFileIds;
	
	public String getFileUploadPath() {
		return fileUploadPath;
	}
	public void setFileUploadPath(String fileUploadPath) {
		this.fileUploadPath = fileUploadPath;
	}
	public List<MultipartFile> getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(List<MultipartFile> uploadFile) {
		this.uploadFile = uploadFile;
	}
	public int getAttachId() {
		return attachId;
	}
	public void setAttachId(int attachId) {
		this.attachId = attachId;
	}
	public int[] getDeleteFileIds() {
		return deleteFileIds;
	}
	public void setDeleteFileIds(int[] deleteFileIds) {
		this.deleteFileIds = deleteFileIds;
	}
	
	
}
