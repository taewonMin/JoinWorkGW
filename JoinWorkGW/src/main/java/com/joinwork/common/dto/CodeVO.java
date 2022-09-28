package com.joinwork.common.dto;

public class CodeVO extends BaseVO{

	private String codeId;
	private String codeName;
	private String codeGroupName;
	private String codeYn;
	private String codeGroupId;
	private String flag;
	
	private int useCount; // 코드 사용자 인원수
	
	public void setCodeId(String codeId) {
		this.codeId = codeId; 
	}
	public String getCodeId() {
		return codeId; 
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName; 
	}
	public String getCodeName() {
		return codeName; 
	}
	public void setCodeYn(String codeYn) {
		this.codeYn = codeYn; 
	}
	public String getCodeYn() {
		return codeYn; 
	}
	public void setCodeGroupName(String codeGroupName) {
		this.codeGroupName = codeGroupName; 
	}
	public String getCodeGroupName() {
		return codeGroupName; 
	}
	public void setCodeGroupId(String codeGroupId) {
		this.codeGroupId = codeGroupId; 
	}
	public String getCodeGroupId() {
		return codeGroupId; 
	}
	public int getUseCount() {
		return useCount;
	}
	public void setUseCount(int useCount) {
		this.useCount = useCount;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}

}
