package com.joinwork.board.cac.dto;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.joinwork.common.dto.BaseVO;

public class CacVO extends BaseVO{

    private int cacBoardId;
    private String cacBoardTitle;
    private String cacBoardContent;
    private int  cacBoardReadcnt;
    private String cacBoardCreateDt;
    private String cacBoardUpdateDt;
    private String cacBoardUpdaterId;
    private String empWriterId;
    @JsonFormat(pattern = "MM/dd/yyyy")
    private String cacBoardEndDt;
    private String cacStartDt;
    private String cacEndDt;
    private String cacCategory;
    private String empName;
    private String officialName;
	
	//검색조건
	private String searchDt = "";
	private String searchState = "";
	
	
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


	public String getOfficialName() {
		return officialName;
	}


	public void setOfficialName(String officialName) {
		this.officialName = officialName;
	}


	public int getCacBoardId() {
		return cacBoardId;
	}


	public void setCacBoardId(int cacBoardId) {
		this.cacBoardId = cacBoardId;
	}


	public String getCacBoardTitle() {
		return cacBoardTitle;
	}


	public void setCacBoardTitle(String cacBoardTitle) {
		this.cacBoardTitle = cacBoardTitle;
	}


	public String getCacBoardContent() {
		return cacBoardContent;
	}


	public void setCacBoardContent(String cacBoardContent) {
		this.cacBoardContent = cacBoardContent;
	}


	public int getCacBoardReadcnt() {
		return cacBoardReadcnt;
	}


	public void setCacBoardReadcnt(int cacBoardReadcnt) {
		this.cacBoardReadcnt = cacBoardReadcnt;
	}




	public String getCacBoardUpdaterId() {
		return cacBoardUpdaterId;
	}


	public void setCacBoardUpdaterId(String cacBoardUpdaterId) {
		this.cacBoardUpdaterId = cacBoardUpdaterId;
	}


	public String getEmpWriterId() {
		return empWriterId;
	}


	public void setEmpWriterId(String empWriterId) {
		this.empWriterId = empWriterId;
	}


	public String getCacCategory() {
		return cacCategory;
	}


	public void setCacCategory(String cacCategory) {
		this.cacCategory = cacCategory;
	}


	
	public String getCacBoardCreateDt() {
		return cacBoardCreateDt;
	}


	public void setCacBoardCreateDt(String cacBoardCreateDt) {
		this.cacBoardCreateDt = cacBoardCreateDt;
	}


	public String getCacBoardUpdateDt() {
		return cacBoardUpdateDt;
	}


	public void setCacBoardUpdateDt(String cacBoardUpdateDt) {
		this.cacBoardUpdateDt = cacBoardUpdateDt;
	}


	public String getCacBoardEndDt() {
		return cacBoardEndDt;
	}


	public void setCacBoardEndDt(String cacBoardEndDt) {
		this.cacBoardEndDt = cacBoardEndDt;
	}


	public String getCacStartDt() {
		return cacStartDt;
	}


	public void setCacStartDt(String cacStartDt) {
		this.cacStartDt = cacStartDt;
	}


	public String getCacEndDt() {
		return cacEndDt;
	}


	public void setCacEndDt(String cacEndDt) {
		this.cacEndDt = cacEndDt;
	}


	public String getEmpName() {
		return empName;
	}


	public void setEmpName(String empName) {
		this.empName = empName;
	}


	@Override
	public String toString() {
		return "CacVO [cacBoardId=" + cacBoardId + ", cacBoardTitle=" + cacBoardTitle + ", cacBoardContent="
				+ cacBoardContent + ", cacBoardReadcnt=" + cacBoardReadcnt + ", cacBoardCreateDt=" + cacBoardCreateDt
				+ ", cacBoardUpdateDt=" + cacBoardUpdateDt + ", cacBoardUpdaterId=" + cacBoardUpdaterId
				+ ", empWriterId=" + empWriterId + ", cacBoardEndDt=" + cacBoardEndDt + ", cacStartDt=" + cacStartDt
				+ ", cacEndDt=" + cacEndDt + ", cacCategory=" + cacCategory + "]";
	}


	
}
    
    

