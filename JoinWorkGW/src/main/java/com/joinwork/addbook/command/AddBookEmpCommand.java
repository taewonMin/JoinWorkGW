package com.joinwork.addbook.command;

import com.joinwork.addbook.dto.AddBookVO;

/** DB에서 emp정보 조회하여 주소록에 필요한 값 받기 위한 VO */
public class AddBookEmpCommand extends AddBookVO{
	private String empId;
	private String empName;
	private String empHp;
	private String empEmail;
	private String officialName;
	private String deptId;
	private String deptName;
	private String empPicture;
	private String addBookTitle;
	

	
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

	public String getEmpHp() {
		return empHp;
	}

	public void setEmpHp(String empHp) {
		this.empHp = empHp;
	}

	public String getEmpEmail() {
		return empEmail;
	}

	public void setEmpEmail(String empEmail) {
		this.empEmail = empEmail;
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

	public String getEmpPicture() {
		return empPicture;
	}

	public void setEmpPicture(String empPicture) {
		this.empPicture = empPicture;
	}
	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	
	public String getAddBookTitle() {
		return addBookTitle;
	}

	public void setAddBookTitle(String addBookTitle) {
		this.addBookTitle = addBookTitle;
	}

	public AddBookVO toAddBookVO() {
		AddBookVO addBookVO = new AddBookVO();
		
		addBookVO.setEmpId(empId);
		addBookVO.setManageDisplayName(empName);
		addBookVO.setManageHp(empHp);
		addBookVO.setManagePicture(empPicture);
		addBookVO.setManageEmail(empEmail);
		addBookVO.setManageOfficialName(officialName);
		addBookVO.setManageDeptName(deptName);
		addBookVO.setDeptId(deptId);
		addBookVO.setAddBookTitle(addBookTitle);
		
		return addBookVO;
	}
}
