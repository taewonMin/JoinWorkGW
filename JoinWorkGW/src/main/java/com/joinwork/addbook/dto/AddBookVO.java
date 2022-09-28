package com.joinwork.addbook.dto;

import com.joinwork.common.dto.BaseVO;

public class AddBookVO extends BaseVO{

	// tb_add_book
	private int addBookId;		// PK 주소록 코드. 시퀀스로 계속 올리는 숫자 (자리수 제한X)
	private String addBookTitle;	// 주소록 그룹명
	private String empWriterId;	// FK 주소록 (그룹) 작성자 사원번호
	private String codeAddId;		// 주소록 코드 아이디( A + 숫자 2자리 : 코드그룹 참고.. )
					
	// tb_add_book_manage
	private int manageId;		// PK 관리번호
//	private int addBookId;		// FK. 중복이라 주석처리함!
	private String manageDisplayName; // 주소록 표시명
	private String manageHp;
	private String manageEmail;
	private String manageRemark;	// 비고란
	private String manageOfficialName;
	private String manageDeptName;
	private String managePicture;
	
	private String flag; //
	
	private String empId;
	private String deptId; // 부서아이디
	private int addBookCount; // 주소록에 속한 주소 개수
	private String[] manageIdArr; // 체크한 주소록 개수
	private String manageIdStr;
	private String deptTeamYn;
	
	
	
	public int getAddBookId() {
		return addBookId;
	}

	public void setAddBookId(int addBookId) {
		this.addBookId = addBookId;
	}

	public String getAddBookTitle() {
		return addBookTitle;
	}

	public void setAddBookTitle(String addBookTitle) {
		this.addBookTitle = addBookTitle;
	}

	public String getEmpWriterId() {
		return empWriterId;
	}

	public void setEmpWriterId(String empWriterId) {
		this.empWriterId = empWriterId;
	}

	public String getCodeAddId() {
		return codeAddId;
	}

	public void setCodeAddId(String codeAddId) {
		this.codeAddId = codeAddId;
	}

	public int getManageId() {
		return manageId;
	}

	public void setManageId(int manageId) {
		this.manageId = manageId;
	}

	public String getManageDisplayName() {
		return manageDisplayName;
	}

	public void setManageDisplayName(String manageDisplayName) {
		this.manageDisplayName = manageDisplayName;
	}

	public String getManageHp() {
		return manageHp;
	}

	public void setManageHp(String manageHp) {
		this.manageHp = manageHp;
	}

	public String getManageEmail() {
		return manageEmail;
	}

	public void setManageEmail(String manageEmail) {
		this.manageEmail = manageEmail;
	}

	public String getManageRemark() {
		return manageRemark;
	}

	public void setManageRemark(String manageRemark) {
		this.manageRemark = manageRemark;
	}

	public String getManageOfficialName() {
		return manageOfficialName;
	}

	public void setManageOfficialName(String manageOfficialName) {
		this.manageOfficialName = manageOfficialName;
	}

	public String getManageDeptName() {
		return manageDeptName;
	}

	public void setManageDeptName(String manageDeptName) {
		this.manageDeptName = manageDeptName;
	}

	public String getManagePicture() {
		return managePicture;
	}

	public void setManagePicture(String managePicture) {
		this.managePicture = managePicture;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	public int getAddBookCount() {
		return addBookCount;
	}

	public void setAddBookCount(int addBookCount) {
		this.addBookCount = addBookCount;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String[] getManageIdArr() {
		return manageIdArr;
	}

	public String getManageIdStr() {
		return manageIdStr;
	}

	public void setManageIdStr(String manageIdStr) {
		this.manageIdStr = manageIdStr;
	}

	public void setManageIdArr(String[] manageIdArr) {
		this.manageIdArr = manageIdArr;
	}

	public String getDeptTeamYn() {
		return deptTeamYn;
	}

	public void setDeptTeamYn(String deptTeamYn) {
		this.deptTeamYn = deptTeamYn;
	}

	
	
	
}
