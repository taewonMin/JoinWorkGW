package com.joinwork.attend.dto;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.joinwork.common.dto.BaseVO;

/**
 * @author pc18
 *
 */
public class AttendenceVO extends BaseVO{
	private Date historyAttendTime ;
	private Date historyLeavingTime;
	
	@JsonFormat(pattern = "MM/dd/yyyy")
	private Date sysDate;//검색에 따라 변하는 날짜 (디폴트는 현재날짜)
//	private Date sysDate = new Date();//검색에 따라 변하는 날짜 (디폴트는 현재날짜)
	private Date mySysDate = new Date();
	private long weeklyAttendMilliSec;
	private String weeklyResult;
	private int historyId;
	private String empId;
	private String empHp;
	private int attendStId;
	private String historyReason;
	private String attendStName;
	private String empName;
	private String deptName;
	private String officialName;
	private String excessYN;
	private int nomalCnt;
	private int lateCnt;
	private int deptTotCnt;
	private String dateDateMin;
	private String dateDateMax;
	//검색조건
	private String searchDt = "";
	private String searchState = "";
	private String searchYear = "";
	private String searchMonth = "";

	public AttendenceVO() {}
	
	
	public Date getMySysDate() {
		return mySysDate;
	}


	public void setMySysDate(Date mySysDate) {
		this.mySysDate = mySysDate;
	}


	public String getEmpHp() {
		return empHp;
	}
	public void setEmpHp(String empHp) {
		this.empHp = empHp;
	}
	public int getDeptTotCnt() {
		return deptTotCnt;
	}
	public void setDeptTotCnt(int deptTotCnt) {
		this.deptTotCnt = deptTotCnt;
	}
	public String getOfficialName() {
		return officialName;
	}
	public void setOfficialName(String officialName) {
		this.officialName = officialName;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getSearchMonth() {
		return searchMonth;
	}
	public void setSearchMonth(String searchMonth) {
		this.searchMonth = searchMonth;
	}
	public String getSearchYear() {
		return searchYear;
	}
	public void setSearchYear(String searchYear) {
		this.searchYear = searchYear;
	}
	public String getSearchDt() {
		return searchDt;
	}
	public void setSearchDt(String searchDt) {
		this.searchDt = searchDt;
	}
	public String getSearchState() {
		return searchState;
	}
	public void setSearchState(String searchState) {
		this.searchState = searchState;
	}
	public String getDateDateMin() {
		return dateDateMin;
	}
	public void setDateDateMin(String dateDateMin) {
		this.dateDateMin = dateDateMin;
	}
	public String getDateDateMax() {
		return dateDateMax;
	}
	public void setDateDateMax(String dateDateMax) {
		this.dateDateMax = dateDateMax;
	}
	public int getNomalCnt() {
		return nomalCnt;
	}
	public void setNomalCnt(int nomalCnt) {
		this.nomalCnt = nomalCnt;
	}
	public int getLateCnt() {
		return lateCnt;
	}
	public void setLateCnt(int lateCnt) {
		this.lateCnt = lateCnt;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public long getWeeklyAttendMilliSec() {
		return weeklyAttendMilliSec;
	}
	public void setWeeklyAttendMilliSec(long weeklyAttendMilliSec) {
		this.weeklyAttendMilliSec = weeklyAttendMilliSec;
	}
	public String getWeeklyResult() {
		return weeklyResult;
	}
	public void setWeeklyResult(String weeklyResult) {
		this.weeklyResult = weeklyResult;
	}
	public String getExcessYN() {
		return excessYN;
	}
	public void setExcessYN(String excessYN) {
		this.excessYN = excessYN;
	}
	public Date getSysDate() {
		return sysDate;
	}
	public void setSysDate(Date sysDate) {
		this.sysDate = sysDate;
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
	public int getHistoryId() {
		return historyId;
	}
	public void setHistoryId(int historyId) {
		this.historyId = historyId;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public int getAttendStId() {
		return attendStId;
	}
	public void setAttendStId(int attendStId) {
		this.attendStId = attendStId;
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

		

	

}
