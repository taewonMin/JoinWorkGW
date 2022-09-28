package com.joinwork.emp.dto;

import java.util.Date;

import com.joinwork.common.command.FileUploadCommand;
import com.joinwork.common.dto.BaseVO;

public class EmpVO extends BaseVO{
	private String empId;
	private String empSupId;
	private String empName;
	private String empPwd;
	private String empRegno;
	private String empHp;
	private String empSign;
	private String empPicture;
	private int empSt;
	private String empAdd1;
	private String empAdd2;
	private String deptId;
	private Date empCreateDt;
	private Date empUpdateDt;
	private String empEmail;
	private String authId;
	private String codeOfficialId;
	private String codeRespId;
	private String attendStId;
	private String officialName;
	private String deptName;
	private String attendStName;
	private String empUpdateYn;
	private String teamId;
	private String teamName;
	private String authName;
	
	
	private String searchAuth;
	private String flag;
	

	private FileUploadCommand fileUploadCommand;
	
    
    public EmpVO() {
    	this.fileUploadCommand = new FileUploadCommand();
    }
    
    
	public FileUploadCommand getFileUploadCommand() {
		return fileUploadCommand;
	}
	public void setFileUploadCommand(FileUploadCommand fileUploadCommand) {
		this.fileUploadCommand = fileUploadCommand;
	}
	public String getEmpAdd1() {
		return empAdd1;
	}
	public void setEmpAdd1(String empAdd1) {
		this.empAdd1 = empAdd1;
	}
	public String getEmpAdd2() {
		return empAdd2;
	}
	public void setEmpAdd2(String empAdd2) {
		this.empAdd2 = empAdd2;
	}
	public String getEmpUpdateYn() {
		return empUpdateYn;
	}
	public void setEmpUpdateYn(String empUpdateYn) {
		this.empUpdateYn = empUpdateYn;
	}
	public String getAttendStName() {
		return attendStName;
	}
	public void setAttendStName(String attendStName) {
		this.attendStName = attendStName;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getOfficialName() {
		return officialName;
	}
	public void setOfficialName(String officialName) {
		this.officialName = officialName;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getEmpSupId() {
		return empSupId;
	}
	public void setEmpSupId(String empSupId) {
		this.empSupId = empSupId;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getEmpPwd() {
		return empPwd;
	}
	public void setEmpPwd(String empPwd) {
		this.empPwd = empPwd;
	}
	public String getEmpRegno() {
		return empRegno;
	}
	public void setEmpRegno(String empRegno) {
		this.empRegno = empRegno;
	}
	public String getEmpHp() {
		return empHp;
	}
	public void setEmpHp(String empHp) {
		this.empHp = empHp;
	}
	public String getEmpSign() {
		return empSign;
	}
	public void setEmpSign(String empSign) {
		this.empSign = empSign;
	}
	public String getEmpPicture() {
		return empPicture;
	}
	public void setEmpPicture(String empPicture) {
		this.empPicture = empPicture;
	}
	public int getEmpSt() {
		return empSt;
	}
	public void setEmpSt(int empSt) {
		this.empSt = empSt;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public Date getEmpCreateDt() {
		return empCreateDt;
	}
	public void setEmpCreateDt(Date empCreateDt) {
		this.empCreateDt = empCreateDt;
	}
	public Date getEmpUpdateDt() {
		return empUpdateDt;
	}
	public void setEmpUpdateDt(Date empUpdateDt) {
		this.empUpdateDt = empUpdateDt;
	}
	public String getEmpEmail() {
		return empEmail;
	}
	public void setEmpEmail(String empEmail) {
		this.empEmail = empEmail;
	}
	public String getAuthId() {
		return authId;
	}
	public void setAuthId(String authId) {
		this.authId = authId;
	}
	public String getCodeOfficialId() {
		return codeOfficialId;
	}
	public void setCodeOfficialId(String codeOfficialId) {
		this.codeOfficialId = codeOfficialId;
	}
	public String getCodeRespId() {
		return codeRespId;
	}
	public void setCodeRespId(String codeRespId) {
		this.codeRespId = codeRespId;
	}
	public String getAttendStId() {
		return attendStId;
	}
	public void setAttendStId(String attendStId) {
		this.attendStId = attendStId;
	}
	public String getTeamId() {
		return teamId;
	}
	public void setTeamId(String teamId) {
		this.teamId = teamId;
	}
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
    public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getAuthName() {
		return authName;
	}
	public void setAuthName(String authName) {
		this.authName = authName;
	}


	public String getSearchAuth() {
		return searchAuth;
	}


	public void setSearchAuth(String searchAuth) {
		this.searchAuth = searchAuth;
	}
	
	
}
