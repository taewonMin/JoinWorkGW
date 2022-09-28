package com.joinwork.board.issue.dto;

import java.util.List;

import com.joinwork.common.dto.BaseVO;

public class IssueVO extends BaseVO {
	private int issueBoardId;
	private String issueBoardTitle;
	private String issueBoardContent;
	private int issueBoardReadcnt;
	private String issueBoardCreateDt;
	private String issueBoardUpdateDt;
	private String issueBoardUpdaterId;
	private String empId;
	private int dutyBoardId;
	private int milestoneId;
	private String issueBoardSt;
	private String issueProjectSt;	// 프로젝트 상태
	private String issueOpenSt = "Y";	// 이슈 공개 여부
	private String empName;
	private String empPicture;
	private String officialName;
	private String deptName;
	private String teamName;
	private int replyCount;	// 댓글수
	private String isOpen = "open";	// 탭 체크
	private int oppIssueCount;	// 열린/닫힌 이슈 개수
	private String dutyBoardTitle;	// 관련 업무명
	private String milestoneName;	// 마일스톤 이름
	private int openIssueCount;	// 진행중인 이슈개수
	private int closedIssueCount;	// 종료된 이슈개수
	
	private List<IssueReplyVO> issueReplyList; // 댓글 리스트
	
	public int getIssueBoardId() {
		return issueBoardId;
	}
	public void setIssueBoardId(int issueBoardId) {
		this.issueBoardId = issueBoardId;
	}
	public String getIssueBoardTitle() {
		return issueBoardTitle;
	}
	public void setIssueBoardTitle(String issueBoardTitle) {
		this.issueBoardTitle = issueBoardTitle;
	}
	public String getIssueBoardContent() {
		return issueBoardContent;
	}
	public void setIssueBoardContent(String issueBoardContent) {
		this.issueBoardContent = issueBoardContent;
	}
	public int getIssueBoardReadcnt() {
		return issueBoardReadcnt;
	}
	public void setIssueBoardReadcnt(int issueBoardReadcnt) {
		this.issueBoardReadcnt = issueBoardReadcnt;
	}
	public String getIssueBoardCreateDt() {
		return issueBoardCreateDt;
	}
	public void setIssueBoardCreateDt(String issueBoardCreateDt) {
		this.issueBoardCreateDt = issueBoardCreateDt;
	}
	public String getIssueBoardUpdateDt() {
		return issueBoardUpdateDt;
	}
	public void setIssueBoardUpdateDt(String issueBoardUpdateDt) {
		this.issueBoardUpdateDt = issueBoardUpdateDt;
	}
	public String getIssueBoardUpdaterId() {
		return issueBoardUpdaterId;
	}
	public void setIssueBoardUpdaterId(String issueBoardUpdaterId) {
		this.issueBoardUpdaterId = issueBoardUpdaterId;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public int getDutyBoardId() {
		return dutyBoardId;
	}
	public void setDutyBoardId(int dutyBoardId) {
		this.dutyBoardId = dutyBoardId;
	}
	public int getMilestoneId() {
		return milestoneId;
	}
	public void setMilestoneId(int milestoneId) {
		this.milestoneId = milestoneId;
	}
	public String getIssueBoardSt() {
		return issueBoardSt;
	}
	public void setIssueBoardSt(String issueBoardSt) {
		this.issueBoardSt = issueBoardSt;
	}
	public String getIssueProjectSt() {
		return issueProjectSt;
	}
	public void setIssueProjectSt(String issueProjectSt) {
		this.issueProjectSt = issueProjectSt;
	}
	public String getIssueOpenSt() {
		return issueOpenSt;
	}
	public void setIssueOpenSt(String issueOpenSt) {
		this.issueOpenSt = issueOpenSt;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getEmpPicture() {
		return empPicture;
	}
	public void setEmpPicture(String empPicture) {
		this.empPicture = empPicture;
	}
	public String getOfficialName() {
		return officialName;
	}
	public void setOfficialName(String officialName) {
		this.officialName = officialName;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
	public int getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}
	public String getIsOpen() {
		return isOpen;
	}
	public void setIsOpen(String isOpen) {
		this.isOpen = isOpen;
	}
	public int getOppIssueCount() {
		return oppIssueCount;
	}
	public void setOppIssueCount(int oppIssueCount) {
		this.oppIssueCount = oppIssueCount;
	}
	public String getDutyBoardTitle() {
		return dutyBoardTitle;
	}
	public void setDutyBoardTitle(String dutyBoardTitle) {
		this.dutyBoardTitle = dutyBoardTitle;
	}
	public List<IssueReplyVO> getIssueReplyList() {
		return issueReplyList;
	}
	public void setIssueReplyList(List<IssueReplyVO> issueReplyList) {
		this.issueReplyList = issueReplyList;
	}
	public String getMilestoneName() {
		return milestoneName;
	}
	public void setMilestoneName(String milestoneName) {
		this.milestoneName = milestoneName;
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
	
}
