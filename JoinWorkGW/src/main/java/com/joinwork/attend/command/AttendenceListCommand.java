package com.joinwork.attend.command;

import java.util.Date;

public class AttendenceListCommand {
	private String empId;
	private String empName;
	private String deptId;
	private String deptName;
	
	private Date historyAttendTime ;
	private Date historyLeavingTime;
	private int history;
	private String emp;
	private int attendSt;
	private String historyReason;
	private String attendStName;
	
	private String attendStId;
	
	public AttendenceListCommand() {
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

	public Date getHistoryAttendTime() {
		return historyAttendTime;
	}

	public void setHistoryAttendTime(Date historyAttendTime) {
		this.historyAttendTime = historyAttendTime;
	}

	public Date getHistoryLeavingTime() {
		return historyLeavingTime;
	}

	public void setHistoryLeavingTime(Date historyLeavingTime) {
		this.historyLeavingTime = historyLeavingTime;
	}

	public int getHistory() {
		return history;
	}

	public void setHistory(int history) {
		this.history = history;
	}

	public String getEmp() {
		return emp;
	}

	public void setEmp(String emp) {
		this.emp = emp;
	}

	public int getAttendSt() {
		return attendSt;
	}

	public void setAttendSt(int attendSt) {
		this.attendSt = attendSt;
	}

	public String getHistoryReason() {
		return historyReason;
	}

	public void setHistoryReason(String historyReason) {
		this.historyReason = historyReason;
	}

	public String getAttendStName() {
		return attendStName;
	}

	public void setAttendStName(String attendStName) {
		this.attendStName = attendStName;
	}

	public String getAttendStId() {
		return attendStId;
	}

	public void setAttendStId(String attendStId) {
		this.attendStId = attendStId;
	}
	
	
	
	
	
}
