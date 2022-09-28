package com.joinwork.common.dto;

public class DeptVO extends BaseVO{
	private String deptId;
	private String deptSupId;
	private String deptName;
	private String deptCreateDt; // Date
	private String deptUpdateDt; // Date
	private String deptSt;
	private String deptHp;
	private String deptLeaderId;
	private String deptTeamYn;
	
	private String deptLeaderName; // 담당자명
	private String deptSupName;
	private String empEmail;
	
	private int deptEmpCount; // 소속 직원 수
	
	private String empId; // 특정 직원의 부서 및 담당부서 조회를 위해 추가
	
	private String flag; // deptService 이용 시 제어하기 위해 추가
	
	
	public String getEmpEmail() {
		return empEmail;
	}
	public void setEmpEmail(String empEmail) {
		this.empEmail = empEmail;
	}
	public String getDeptSupName() {
		return deptSupName;
	}
	public void setDeptSupName(String deptSupName) {
		this.deptSupName = deptSupName;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getDeptSupId() {
		return deptSupId;
	}
	public void setDeptSupId(String deptSupId) {
		this.deptSupId = deptSupId;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getDeptCreateDt() {
		return deptCreateDt;
	}
	public void setDeptCreateDt(String deptCreateDt) {
		this.deptCreateDt = deptCreateDt;
	}
	public String getDeptUpdateDt() {
		return deptUpdateDt;
	}
	public void setDeptUpdateDt(String deptUpdateDt) {
		this.deptUpdateDt = deptUpdateDt;
	}
	public String getDeptSt() {
		return deptSt;
	}
	public void setDeptSt(String deptSt) {
		this.deptSt = deptSt;
	}
	public String getDeptHp() {
		return deptHp;
	}
	public void setDeptHp(String deptHp) {
		this.deptHp = deptHp;
	}
	public String getDeptLeaderId() {
		return deptLeaderId;
	}
	public void setDeptLeaderId(String deptLeaderId) {
		this.deptLeaderId = deptLeaderId;
	}
	public String getDeptTeamYn() {
		return deptTeamYn;
	}
	public void setDeptTeamYn(String deptTeamYn) {
		this.deptTeamYn = deptTeamYn;
	}
	public String getDeptLeaderName() {
		return deptLeaderName;
	}
	public void setDeptLeaderName(String deptLeaderName) {
		this.deptLeaderName = deptLeaderName;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public int getDeptEmpCount() {
		return deptEmpCount;
	}
	public void setDeptEmpCount(int deptEmpCount) {
		this.deptEmpCount = deptEmpCount;
	}
	
}
