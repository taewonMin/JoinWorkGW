package com.joinwork.board.issue.dto;

import java.util.List;

public class MilestoneVO {
	private int milestoneId;
	private String milestoneName;
	private String milestoneCreateDt;
	private String milestoneEndDt;
	private String milestoneUpdateDt;
	private String milestoneSt;
	private String empId;
	private String empName;
	private String isOpen = "open";	// 탭 체크
	private int openIssueCount;	// 진행중 이슈 개수
	private int closedIssueCount;	// 종료된 이슈 개수
	private int oppListCount;	// 진행/종료된 이슈 개수(반대)
	
	private List<IssueVO> issueList;	// 마일스톤의 이슈리스트
	
	public int getMilestoneId() {
		return milestoneId;
	}
	public void setMilestoneId(int milestoneId) {
		this.milestoneId = milestoneId;
	}
	public String getMilestoneName() {
		return milestoneName;
	}
	public void setMilestoneName(String milestoneName) {
		this.milestoneName = milestoneName;
	}
	public String getMilestoneCreateDt() {
		return milestoneCreateDt;
	}
	public void setMilestoneCreateDt(String milestoneCreateDt) {
		this.milestoneCreateDt = milestoneCreateDt;
	}
	public String getMilestoneEndDt() {
		return milestoneEndDt;
	}
	public void setMilestoneEndDt(String milestoneEndDt) {
		this.milestoneEndDt = milestoneEndDt;
	}
	public String getMilestoneUpdateDt() {
		return milestoneUpdateDt;
	}
	public void setMilestoneUpdateDt(String milestoneUpdateDt) {
		this.milestoneUpdateDt = milestoneUpdateDt;
	}
	public String getMilestoneSt() {
		return milestoneSt;
	}
	public void setMilestoneSt(String milestoneSt) {
		this.milestoneSt = milestoneSt;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getIsOpen() {
		return isOpen;
	}
	public void setIsOpen(String isOpen) {
		this.isOpen = isOpen;
	}
	public int getOpenIssueCount() {
		return openIssueCount;
	}
	public void setOpenIssueCount(int openIssueCount) {
		this.openIssueCount = openIssueCount;
	}
	public int getClosedIssueCount() {
		return closedIssueCount;
	}
	public void setClosedIssueCount(int closedIssueCount) {
		this.closedIssueCount = closedIssueCount;
	}
	public List<IssueVO> getIssueList() {
		return issueList;
	}
	public void setIssueList(List<IssueVO> issueList) {
		this.issueList = issueList;
	}
	public int getOppListCount() {
		return oppListCount;
	}
	public void setOppListCount(int oppListCount) {
		this.oppListCount = oppListCount;
	}
	
}
