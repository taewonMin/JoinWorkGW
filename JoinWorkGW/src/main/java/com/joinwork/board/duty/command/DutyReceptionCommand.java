package com.joinwork.board.duty.command;

public class DutyReceptionCommand {
	private int dutyBoardId;
	private String empId;
	private String empName;
	
	public int getDutyBoardId() {
		return dutyBoardId;
	}
	public void setDutyBoardId(int dutyBoardId) {
		this.dutyBoardId = dutyBoardId;
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
	
	
}
