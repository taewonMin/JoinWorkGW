package com.joinwork.common.dto;

import java.util.List;

import org.apache.commons.lang3.builder.ToStringBuilder;

public class BaseVO{


	public static final String[] PAGE_UNITS= {"10","5","25","50"};
		
	/** 검색조건 */
	private String searchCondition = "";

	/** 검색Keyword */
	private String searchKeyword = "";

	/** 검색사용여부 */
	private String searchUseYn = "";

	/** 현재페이지 */
	private int pageIndex = 1;

	/** 페이지갯수 */
	private int pageUnit = 10;

	/** 페이지사이즈 */
	private int pageSize = 10;

	/** firstIndex */
	private int firstIndex = 1;

	/** lastIndex */
	private int lastIndex = 1;

	/** recordCountPerPage */
	private int recordCountPerPage = 10;
	
	/** 목록 개수 값 */
	private String pageUnitValue;
	
	/** 목록 개수 라벨 */
	private String pageUnitLabel;
	
	/** 목록 개수 셀렉트 박스 item */
	private List<BaseVO> pageUnitSelector;
	
	/** 중복등록방지용 토큰 */
	private String saveToken;

	public int getFirstIndex() {
		return firstIndex;
	}

	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	public int getLastIndex() {
		return lastIndex;
	}

	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}

	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}

	public String getSearchCondition() {
		return searchCondition;
	}

	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	public String getSearchUseYn() {
		return searchUseYn;
	}

	public void setSearchUseYn(String searchUseYn) {
		this.searchUseYn = searchUseYn;
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	public int getPageUnit() {
		return pageUnit;
	}

	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public String getPageUnitValue() {
		return pageUnitValue;
	}

	public void setPageUnitValue(String pageUnitValue) {
		this.pageUnitValue = pageUnitValue;
	}

	public String getPageUnitLabel() {
		return pageUnitLabel;
	}

	public void setPageUnitLabel(String pageUnitLabel) {
		this.pageUnitLabel = pageUnitLabel;
	}
	
	public List<BaseVO> getPageUnitSelector() {
		return pageUnitSelector;
	}

	public void setPageUnitSelector(List<BaseVO> pageUnitSelector) {
		this.pageUnitSelector = pageUnitSelector;
	}
	
	public String getSaveToken() {
		return saveToken;
	}

	public void setSaveToken(String saveToken) {
		this.saveToken = saveToken;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}

}
