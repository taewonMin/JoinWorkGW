package com.joinwork.approval.dto;

import java.util.Date;

public class AgencyVO {
	private String empAgencyId;
	private String empGranterId;
	private String agencySecurity;
	private Date agencyUpdateDt;
	private String agencySt;
	private String agencyGroupName;
	private String empName;
	private String deptName;
	private String attendStName;
	private String officialName;
	
	
	
	
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getAttendStName() {
		return attendStName;
	}
	public void setAttendStName(String attendStName) {
		this.attendStName = attendStName;
	}
	public String getOfficialName() {
		return officialName;
	}
	public void setOfficialName(String officialName) {
		this.officialName = officialName;
	}
	public String getEmpAgencyId() {
		return empAgencyId;
	}
	public void setEmpAgencyId(String empAgencyId) {
		this.empAgencyId = empAgencyId;
	}
	public String getEmpGranterId() {
		return empGranterId;
	}
	public void setEmpGranterId(String empGranterId) {
		this.empGranterId = empGranterId;
	}
	public String getAgencySecurity() {
		return agencySecurity;
	}
	public void setAgencySecurity(String agencySecurity) {
		this.agencySecurity = agencySecurity;
	}
	public Date getAgencyUpdateDt() {
		return agencyUpdateDt;
	}
	public void setAgencyUpdateDt(Date agencyUpdateDt) {
		this.agencyUpdateDt = agencyUpdateDt;
	}
	public String getAgencySt() {
		return agencySt;
	}
	public void setAgencySt(String agencySt) {
		this.agencySt = agencySt;
	}
	public String getAgencyGroupName() {
		return agencyGroupName;
	}
	public void setAgencyGroupName(String agencyGroupName) {
		this.agencyGroupName = agencyGroupName;
	}
	
	
}
