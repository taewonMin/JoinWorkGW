package com.joinwork.board.duty.dto;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.joinwork.board.duty.command.DutyManagerCommand;
import com.joinwork.board.duty.command.DutyReceptionCommand;
import com.joinwork.board.duty.command.DutyReceptionDeptCommand;
import com.joinwork.common.dto.AttachVO;
import com.joinwork.common.dto.BaseVO;

public class DutyVO extends BaseVO {

	private int dutyBoardId;
	private String dutyBoardTitle;
	private String dutyBoardContent;
	private int dutyBoardReadcnt;
	private Date dutyBoardCreateDt;
	private Date dutyBoardUpdateDt;
	private String dutyBoardUpdaterId;
	@JsonFormat(pattern = "MM/dd/yyyy")
	private Date dutyBoardEndDt;
	private String empWriterId;
	private int deptCnt;
	private int empCnt;
	private int dutyBoardSecurity;
	
	
	private String[] empManagerList;	// 담당자 아이디 목록
	private String[] empReceptionList;	// 담당자 아이디 목록
	private String[] empReceptionDeptList;	// 담당자 아이디 목록
	private List<DutyManagerCommand> dutyManagerList;	// 담당자 목록
	private List<DutyReceptionCommand> receptionList; //참조자 목록
	private List<DutyReceptionDeptCommand> receptionDeptList; //참조자 목록
	
	
	private List<AttachVO> attachList;	// 첨부 파일 목록(저장용)
	private List<DutyAttachVO> dutyAttachList;	// 첨부파일 목록(불러오기용)
	private String empName;		// 팀장 이름
	private String empId;		// 팀장 이름
	private String empPicture;	// 팀장 사진
	private int attachCount;	// 첨부 파일 개수
	
	private List<DutyReplyVO> dutyReplyList;	// 댓글 목록
	private int replyCount; // 댓글수
	
	// 검색조건
	private String searchDeadline = "";	// 완료 기한
	private String searchState = "";	// 진행 상태
	private String searchDept = "";	// 부서/팀
	
	private String dutyBoardCreateDtStr; // 문자형 작성일자
	
	private String dutyType;	// 업무게시판 분류
	private String modifiable = "Y";	// 수정가능여부
	
	public List<DutyReceptionCommand> getReceptionList() {
		return receptionList;
	}
	public void setReceptionList(List<DutyReceptionCommand> receptionList) {
		this.receptionList = receptionList;
	}
	public List<DutyReceptionDeptCommand> getReceptionDeptList() {
		return receptionDeptList;
	}
	public void setReceptionDeptList(List<DutyReceptionDeptCommand> receptionDeptList) {
		this.receptionDeptList = receptionDeptList;
	}
	public int getDeptCnt() {
		return deptCnt;
	}
	public void setDeptCnt(int deptCnt) {
		this.deptCnt = deptCnt;
	}
	public int getEmpCnt() {
		return empCnt;
	}
	public void setEmpCnt(int empCnt) {
		this.empCnt = empCnt;
	}
	public String[] getEmpReceptionDeptList() {
		return empReceptionDeptList;
	}
	public void setEmpReceptionDeptList(String[] empReceptionDeptList) {
		this.empReceptionDeptList = empReceptionDeptList;
	}
	public String[] getEmpReceptionList() {
		return empReceptionList;
	}
	public void setEmpReceptionList(String[] empReceptionList) {
		this.empReceptionList = empReceptionList;
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
	public String getDutyBoardTitle() {
		return dutyBoardTitle;
	}
	public void setDutyBoardTitle(String dutyBoardTitle) {
		this.dutyBoardTitle = dutyBoardTitle;
	}
	public String getDutyBoardContent() {
		return dutyBoardContent;
	}
	public void setDutyBoardContent(String dutyBoardContent) {
		this.dutyBoardContent = dutyBoardContent;
	}
	public int getDutyBoardReadcnt() {
		return dutyBoardReadcnt;
	}
	public void setDutyBoardReadcnt(int dutyBoardReadcnt) {
		this.dutyBoardReadcnt = dutyBoardReadcnt;
	}
	public Date getDutyBoardCreateDt() {
		return dutyBoardCreateDt;
	}
	public void setDutyBoardCreateDt(Date dutyBoardCreateDt) {
		this.dutyBoardCreateDt = dutyBoardCreateDt;
	}
	public Date getDutyBoardUpdateDt() {
		return dutyBoardUpdateDt;
	}
	public void setDutyBoardUpdateDt(Date dutyBoardUpdateDt) {
		this.dutyBoardUpdateDt = dutyBoardUpdateDt;
	}
	public String getDutyBoardUpdaterId() {
		return dutyBoardUpdaterId;
	}
	public void setDutyBoardUpdaterId(String dutyBoardUpdaterId) {
		this.dutyBoardUpdaterId = dutyBoardUpdaterId;
	}
	public Date getDutyBoardEndDt() {
		return dutyBoardEndDt;
	}
	public void setDutyBoardEndDt(Date dutyBoardEndDt) {
		this.dutyBoardEndDt = dutyBoardEndDt;
	}
	public String getEmpWriterId() {
		return empWriterId;
	}
	public void setEmpWriterId(String empWriterId) {
		this.empWriterId = empWriterId;
	}
	public int getDutyBoardSecurity() {
		return dutyBoardSecurity;
	}
	public void setDutyBoardSecurity(int dutyBoardSecurity) {
		this.dutyBoardSecurity = dutyBoardSecurity;
	}
	public String[] getEmpManagerList() {
		return empManagerList;
	}
	public void setEmpManagerList(String[] empManagerList) {
		this.empManagerList = empManagerList;
	}
	public List<DutyManagerCommand> getDutyManagerList() {
		return dutyManagerList;
	}
	public void setDutyManagerList(List<DutyManagerCommand> dutyManagerList) {
		this.dutyManagerList = dutyManagerList;
	}
	public List<AttachVO> getAttachList() {
		return attachList;
	}
	public void setAttachList(List<AttachVO> attachList) {
		this.attachList = attachList;
	}
	public List<DutyAttachVO> getDutyAttachList() {
		return dutyAttachList;
	}
	public void setDutyAttachList(List<DutyAttachVO> dutyAttachList) {
		this.dutyAttachList = dutyAttachList;
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
	public int getAttachCount() {
		return attachCount;
	}
	public void setAttachCount(int attachCount) {
		this.attachCount = attachCount;
	}
	public String getSearchDeadline() {
		return searchDeadline;
	}
	public void setSearchDeadline(String searchDeadline) {
		this.searchDeadline = searchDeadline;
	}
	public String getSearchState() {
		return searchState;
	}
	public void setSearchState(String searchState) {
		this.searchState = searchState;
	}
	public List<DutyReplyVO> getDutyReplyList() {
		return dutyReplyList;
	}
	public void setDutyReplyList(List<DutyReplyVO> dutyReplyList) {
		this.dutyReplyList = dutyReplyList;
	}
	public int getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}
	public String getSearchDept() {
		return searchDept;
	}
	public void setSearchDept(String searchDept) {
		this.searchDept = searchDept;
	}
	public String getDutyBoardCreateDtStr() {
		return dutyBoardCreateDtStr;
	}
	public void setDutyBoardCreateDtStr(String dutyBoardCreateDtStr) {
		this.dutyBoardCreateDtStr = dutyBoardCreateDtStr;
	}
	public String getDutyType() {
		return dutyType;
	}
	public void setDutyType(String dutyType) {
		this.dutyType = dutyType;
	}
	public String getModifiable() {
		return modifiable;
	}
	public void setModifiable(String modifiable) {
		this.modifiable = modifiable;
	}
	
}
