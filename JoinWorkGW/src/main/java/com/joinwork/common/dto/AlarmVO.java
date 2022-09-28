package com.joinwork.common.dto;

public class AlarmVO {
	private int alarmId;
	private String alarmStartDt;
	private String alarmReadDt;
	private int alarmSt;
	private String empReaderId;
	private String alarmTitle;
	private String alarmContent;
	private String alarmUrl;
	private String alarmCategory;
	private String removeUrl;
	private String cri;	// 읽은 알림 삭제용
	
	public int getAlarmId() {
		return alarmId;
	}
	public void setAlarmId(int alarmId) {
		this.alarmId = alarmId;
	}
	public String getAlarmStartDt() {
		return alarmStartDt;
	}
	public void setAlarmStartDt(String alarmStartDt) {
		this.alarmStartDt = alarmStartDt;
	}
	public String getAlarmReadDt() {
		return alarmReadDt;
	}
	public void setAlarmReadDt(String alarmReadDt) {
		this.alarmReadDt = alarmReadDt;
	}
	public int getAlarmSt() {
		return alarmSt;
	}
	public void setAlarmSt(int alarmSt) {
		this.alarmSt = alarmSt;
	}
	public String getEmpReaderId() {
		return empReaderId;
	}
	public void setEmpReaderId(String empReaderId) {
		this.empReaderId = empReaderId;
	}
	public String getAlarmTitle() {
		return alarmTitle;
	}
	public void setAlarmTitle(String alarmTitle) {
		this.alarmTitle = alarmTitle;
	}
	public String getAlarmContent() {
		return alarmContent;
	}
	public void setAlarmContent(String alarmContent) {
		this.alarmContent = alarmContent;
	}
	public String getAlarmUrl() {
		return alarmUrl;
	}
	public void setAlarmUrl(String alarmUrl) {
		this.alarmUrl = alarmUrl;
	}
	public String getAlarmCategory() {
		return alarmCategory;
	}
	public void setAlarmCategory(String alarmCategory) {
		this.alarmCategory = alarmCategory;
	}
	public String getRemoveUrl() {
		return removeUrl;
	}
	public void setRemoveUrl(String removeUrl) {
		this.removeUrl = removeUrl;
	}
	public String getCri() {
		return cri;
	}
	public void setCri(String cri) {
		this.cri = cri;
	}
	
}
