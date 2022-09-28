package com.joinwork.addbook.command;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;

import org.apache.commons.lang3.StringUtils;

import com.joinwork.addbook.dto.AddBookVO;
import com.joinwork.common.dto.BaseVO;

public class AddBookRegistCommand extends BaseVO{
	
	private String addBookId;		// PK 주소록 코드. 시퀀스로 계속 올리는 숫자 (자리수 제한X)
	private String addBookTitle;	// 주소록 그룹명
	private String empWriterId;	// FK 주소록 (그룹) 작성자 사원번호
	private String codeAddId;		// 주소록 코드 아이디( A + 숫자 2자리 : 코드그룹 참고.. )
					
	// tb_add_book_manage
	private String manageId;		// PK 관리번호
//	private int addBookId;		// FK. 중복이라 주석처리함!
	
	@NotBlank
	private String manageDisplayName; // 주소록 표시명
	
	@Pattern(regexp="^[0-9]*$")
	private String[] manageHp;
	
	@Email
	private String[] manageEmail;
	private String manageRemark;	// 비고란
	private String manageOfficialName;
	private String manageDeptName;
	private String managePicture;
	
	private int flag = 0; // 0은 개인주소록, 1은 회사주소록 조회
	
	private String deptId;
	private int addBookCount;
	
	private String[] manageIdArr;


	public String getAddBookId() {
		return addBookId;
	}

	public void setAddBookId(String addBookId) {
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

	public String getManageId() {
		return manageId;
	}

	public void setManageId(String manageId) {
		this.manageId = manageId;
	}

	public String getManageDisplayName() {
		return manageDisplayName;
	}

	public void setManageDisplayName(String manageDisplayName) {
		this.manageDisplayName = manageDisplayName;
	}

	public String[] getManageHp() {
		return manageHp;
	}

	public void setManageHp(String[] manageHp) {
		this.manageHp = manageHp;
	}

	public String[] getManageEmail() {
		return manageEmail;
	}

	public void setManageEmail(String[] manageEmail) {
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

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
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
	public String[] getManageIdArr() {
		return manageIdArr;
	}
	public void setManageIdArr(String[] manageIdArr) {
		this.manageIdArr = manageIdArr;
	}
	
	public AddBookVO toAddBookVO() {
		String manageHpMerged = "";
		if(manageHp.length != 0 && manageHp[0].length() != 0) {
			manageHpMerged = manageHp[0] + "-" + manageHp[1] + "-" +manageHp[2];
		}
		
		String manageEmailMerged = "";
		if(manageEmail.length != 0 && manageEmail[0].length() != 0) {
			manageEmailMerged = manageEmail[0] + "@" + manageEmail[1];
		}
		
		
		AddBookVO addBookVO = new AddBookVO();

		if(StringUtils.isNotEmpty(addBookId)) addBookVO.setAddBookId(Integer.parseInt(addBookId));
		addBookVO.setAddBookTitle(addBookTitle);
		addBookVO.setEmpWriterId(empWriterId);
		addBookVO.setCodeAddId(codeAddId);
		
		if(StringUtils.isNotEmpty(manageId)) addBookVO.setManageId(Integer.parseInt(manageId));
		addBookVO.setManageDisplayName(manageDisplayName);
		addBookVO.setManageHp(manageHpMerged);
		addBookVO.setManageEmail(manageEmailMerged);
		addBookVO.setManageRemark(manageRemark);
		addBookVO.setManageOfficialName(manageOfficialName);
		addBookVO.setManageDeptName(manageDeptName);
		
		return addBookVO;
	}
	
}
