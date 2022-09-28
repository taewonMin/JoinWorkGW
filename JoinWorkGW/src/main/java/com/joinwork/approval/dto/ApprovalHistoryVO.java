package com.joinwork.approval.dto;

import java.util.Date;

public class ApprovalHistoryVO {
	private int historySt;
	private String empId;
	private Date historyAllowDt;
	private String docId;
	private String historyTurn;
	private int historyStep;
	private String historySupId;
	private String YN;
	
	
	public String getHistorySupId() {
		return historySupId;
	}
	public void setHistorySupId(String historySupId) {
		this.historySupId = historySupId;
	}
	public String getYN() {
		return YN;
	}
	public void setYN(String yN) {
		YN = yN;
	}
	public int getHistorySt() {
		return historySt;
	}
	public void setHistorySt(int historySt) {
		this.historySt = historySt;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public Date getHistoryAllowDt() {
		return historyAllowDt;
	}
	public void setHistoryAllowDt(Date historyAllowDt) {
		this.historyAllowDt = historyAllowDt;
	}
	public String getDocId() {
		return docId;
	}
	public void setDocId(String docId) {
		this.docId = docId;
	}
	public String getHistoryTurn() {
		return historyTurn;
	}
	public void setHistoryTurn(String historyTurn) {
		this.historyTurn = historyTurn;
	}
	public int getHistoryStep() {
		return historyStep;
	}
	public void setHistoryStep(int historyStep) {
		this.historyStep = historyStep;
	}
	
	
	
}
