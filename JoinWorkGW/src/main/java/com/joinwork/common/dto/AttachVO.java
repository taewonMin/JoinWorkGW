package com.joinwork.common.dto;

import java.util.Date;
import java.util.List;

public class AttachVO  {
	private int attachId;
	private String attachPath;
	private String attachName;
	private String attachType;
	private Date attachCreateDt;
	private Date attachEndDt;
	private String empAttacherId;
	private String attachSize;
	private List<? extends AttachVO> attachList;
	
	
	
	public List<? extends AttachVO> getAttachList() {
		return attachList;
	}
	public void setAttachList(List<? extends AttachVO> attachList) {
		this.attachList = attachList;
	}
	public Date getAttachEndDt() {
		return attachEndDt;
	}
	public void setAttachEndDt(Date attachEndDt) {
		this.attachEndDt = attachEndDt;
	}
	public int getAttachId() {
		return attachId;
	}
	public void setAttachId(int attachId) {
		this.attachId = attachId;
	}
	public String getAttachPath() {
		return attachPath;
	}
	public void setAttachPath(String attachPath) {
		this.attachPath = attachPath;
	}
	public String getAttachName() {
		return attachName;
	}
	public void setAttachName(String attachName) {
		this.attachName = attachName;
	}
	public String getAttachType() {
		return attachType;
	}
	public void setAttachType(String attachType) {
		this.attachType = attachType;
	}
	public Date getAttachCreateDt() {
		return attachCreateDt;
	}
	public void setAttachCreateDt(Date attachCreateDt) {
		this.attachCreateDt = attachCreateDt;
	}
	public String getEmpAttacherId() {
		return empAttacherId;
	}
	public void setEmpAttacherId(String empAttacherId) {
		this.empAttacherId = empAttacherId;
	}
	public String getAttachSize() {
		return attachSize;
	}
	public void setAttachSize(String attachSize) {
		this.attachSize = attachSize;
	}
	
	
}
