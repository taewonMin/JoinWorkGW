package com.joinwork.approval.dto;

public class FormVO {
    private int formId;
    private int formSupId;
    private String formSupName;
    private String formName;
    private String formContent;
    private String formPeriod;
    private int level;
    
    
    
	public String getFormPeriod() {
		return formPeriod;
	}
	public void setFormPeriod(String formPeriod) {
		this.formPeriod = formPeriod;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public int getFormId() {
		return formId;
	}
	public void setFormId(int formId) {
		this.formId = formId;
	}
	public int getFormSupId() {
		return formSupId;
	}
	public void setFormSupId(int formSupId) {
		this.formSupId = formSupId;
	}
	public String getFormSupName() {
		return formSupName;
	}
	public void setFormSupName(String formSupName) {
		this.formSupName = formSupName;
	}
	public String getFormName() {
		return formName;
	}
	public void setFormName(String formName) {
		this.formName = formName;
	}
	public String getFormContent() {
		return formContent;
	}
	public void setFormContent(String formContent) {
		this.formContent = formContent;
	}
    
    
}
