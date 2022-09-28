package com.joinwork.board.qt.dto;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.joinwork.common.dto.BaseVO;

public class QtVO extends BaseVO{
	private int qtBoardId;
	private String qtBoardTitle;
	private int qtBoardReadcnt;
	private Date qtBoardCreateDt;
	private Date qtBoardUpdateDt;
	private String empWriterId;
	private String qtBoardUpdaterId;
	private String empName;
	private String officialName;
	private int participantCnt;
	
	@JsonFormat(pattern = "MM/dd/yyyy")
	private Date qtBoardEndDt;
	@JsonFormat(pattern = "MM/dd/yyyy")
	private Date qtBoardStartDt;
	private String qtBoardStYn;
	List<Map<String,Object>> itemArr;
	//검색조건
	private String searchDt = "";
	private String searchState = "";
	
	
	
	public String getSearchState() {
		return searchState;
	}
	public void setSearchState(String searchState) {
		this.searchState = searchState;
	}
	public int getParticipantCnt() {
		return participantCnt;
	}
	public void setParticipantCnt(int participantCnt) {
		this.participantCnt = participantCnt;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getOfficialName() {
		return officialName;
	}
	public void setOfficialName(String officialName) {
		this.officialName = officialName;
	}
	public String getSearchDt() {
		return searchDt;
	}
	public void setSearchDt(String searchDt) {
		this.searchDt = searchDt;
	}
	public List<Map<String, Object>> getItemArr() {
		return itemArr;
	}
	public void setItemArr(List<Map<String, Object>> itemArr) {
		this.itemArr = itemArr;
	}
	public int getQtBoardId() {
		return qtBoardId;
	}
	public void setQtBoardId(int qtBoardId) {
		this.qtBoardId = qtBoardId;
	}
	public String getQtBoardTitle() {
		return qtBoardTitle;
	}
	public void setQtBoardTitle(String qtBoardTitle) {
		this.qtBoardTitle = qtBoardTitle;
	}
	public int getQtBoardReadcnt() {
		return qtBoardReadcnt;
	}
	public void setQtBoardReadcnt(int qtBoardReadcnt) {
		this.qtBoardReadcnt = qtBoardReadcnt;
	}
	public Date getQtBoardCreateDt() {
		return qtBoardCreateDt;
	}
	public void setQtBoardCreateDt(Date qtBoardCreateDt) {
		this.qtBoardCreateDt = qtBoardCreateDt;
	}
	public Date getQtBoardUpdateDt() {
		return qtBoardUpdateDt;
	}
	public void setQtBoardUpdateDt(Date qtBoardUpdateDt) {
		this.qtBoardUpdateDt = qtBoardUpdateDt;
	}
	public String getEmpWriterId() {
		return empWriterId;
	}
	public void setEmpWriterId(String empWriterId) {
		this.empWriterId = empWriterId;
	}
	public String getQtBoardUpdaterId() {
		return qtBoardUpdaterId;
	}
	public void setQtBoardUpdaterId(String qtBoardUpdaterId) {
		this.qtBoardUpdaterId = qtBoardUpdaterId;
	}
	
	public Date getQtBoardEndDt() {
		return qtBoardEndDt;
	}
	public void setQtBoardEndDt(Date qtBoardEndDt) {
		this.qtBoardEndDt = qtBoardEndDt;
	}
	public Date getQtBoardStartDt() {
		return qtBoardStartDt;
	}
	public void setQtBoardStartDt(Date qtBoardStartDt) {
		this.qtBoardStartDt = qtBoardStartDt;
	}
	public String getQtBoardStYn() {
		return qtBoardStYn;
	}
	public void setQtBoardStYn(String qtBoardStYn) {
		this.qtBoardStYn = qtBoardStYn;
	}
	
	
}
