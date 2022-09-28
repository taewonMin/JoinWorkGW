package com.joinwork.doc.dto;

import java.util.Date;
import java.util.List;

import com.joinwork.common.dto.AttachVO;
import com.joinwork.common.dto.BaseVO;

public class DocVO extends BaseVO{
	
	private int docId;
	private String docTitle;
	private String docContent;
	private int docReadcnt;
	private Date docCreateDt = new Date();
	private Date docUpdateDt;
	private String docUpdaterId;
	private int docSecurity;
	private String empWriterId;
	private String codeDocId;
	private String docDel;
	private String docImportance;
	private String empDept;
	private String docIndividualCheck;
	private String empName;
	private int attachCount;	// 첨부 파일 개수
	
	
	private String officialName;
	private String deptId;
    private String deptName;
    private String teamName;
	
	private List<AttachVO> attachList;	// 첨부 파일 목록(저장용)
	private List<DocAttachVO> docAttachList;	// 첨부파일 목록(불러오기용)
//	private List<DocManagerCommand> docManagerList;	
	
	
	public DocVO() {}
	
	
	public List<DocAttachVO> getDocAttachList() {
		return docAttachList;
	}


	public void setDocAttachList(List<DocAttachVO> docAttachList) {
		this.docAttachList = docAttachList;
	}


	public List<AttachVO> getAttachList() {
		return attachList;
	}


	public void setAttachList(List<AttachVO> attachList) {
		this.attachList = attachList;
	}




	

	
	public int getAttachCount() {
		return attachCount;
	}


	public void setAttachCount(int attachCount) {
		this.attachCount = attachCount;
	}


	public String getEmpName() {
		return empName;
	}


	public void setEmpName(String empName) {
		this.empName = empName;
	}


	public int getDocId() {
		return docId;
	}


	public void setDocId(int docId) {
		this.docId = docId;
	}


	public String getDocTitle() {
		return docTitle;
	}


	public void setDocTitle(String docTitle) {
		this.docTitle = docTitle;
	}


	public String getDocContent() {
		return docContent;
	}


	public void setDocContent(String docContent) {
		this.docContent = docContent;
	}


	public int getDocReadcnt() {
		return docReadcnt;
	}


	public void setDocReadcnt(int docReadcnt) {
		this.docReadcnt = docReadcnt;
	}


	public Date getDocCreateDt() {
		return docCreateDt;
	}


	public void setDocCreateDt(Date docCreateDt) {
		this.docCreateDt = docCreateDt;
	}


	public Date getDocUpdateDt() {
		return docUpdateDt;
	}


	public void setDocUpdateDt(Date docUpdateDt) {
		this.docUpdateDt = docUpdateDt;
	}


	public String getDocUpdaterId() {
		return docUpdaterId;
	}


	public void setDocUpdaterId(String docUpdaterId) {
		this.docUpdaterId = docUpdaterId;
	}


	public int getDocSecurity() {
		return docSecurity;
	}


	public void setDocSecurity(int docSecurity) {
		this.docSecurity = docSecurity;
	}


	public String getEmpWriterId() {
		return empWriterId;
	}


	public void setEmpWriterId(String empWriterId) {
		this.empWriterId = empWriterId;
	}


	public String getCodeDocId() {
		return codeDocId;
	}


	public void setCodeDocId(String codeDocId) {
		this.codeDocId = codeDocId;
	}


	public String getDocDel() {
		return docDel;
	}


	public void setDocDel(String docDel) {
		this.docDel = docDel;
	}


	public String getDocImportance() {
		return docImportance;
	}


	public void setDocImportance(String docImportance) {
		this.docImportance = docImportance;
	}





	public String getEmpDept() {
		return empDept;
	}


	public void setEmpDept(String empDept) {
		this.empDept = empDept;
	}


	public String getDocIndividualCheck() {
		return docIndividualCheck;
	}


	public void setDocIndividualCheck(String docIndividualCheck) {
		this.docIndividualCheck = docIndividualCheck;
	}


	public String getOfficialName() {
		return officialName;
	}


	public void setOfficialName(String officialName) {
		this.officialName = officialName;
	}


	public String getDeptId() {
		return deptId;
	}


	public void setDeptId(String deptId) {
		this.deptId = deptId;
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


	

	
}