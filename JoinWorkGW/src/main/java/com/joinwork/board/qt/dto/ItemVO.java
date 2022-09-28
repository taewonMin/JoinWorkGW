package com.joinwork.board.qt.dto;

public class ItemVO {
	private String itemContent;
	private int qtBoardId;
	private int itemId;
	private String itemMultiYn;
	private int selectorId;
	private String selectorName;
	private int itemCnt;
	private int selectedCnt;
	
	
	public int getItemCnt() {
		return itemCnt;
	}
	public void setItemCnt(int itemCnt) {
		this.itemCnt = itemCnt;
	}
	public int getSelectedCnt() {
		return selectedCnt;
	}
	public void setSelectedCnt(int selectedCnt) {
		this.selectedCnt = selectedCnt;
	}
	public int getSelectorId() {
		return selectorId;
	}
	public void setSelectorId(int selectorId) {
		this.selectorId = selectorId;
	}
	public String getSelectorName() {
		return selectorName;
	}
	public void setSelectorName(String selectorName) {
		this.selectorName = selectorName;
	}
	public String getItemContent() {
		return itemContent;
	}
	public void setItemContent(String itemContent) {
		this.itemContent = itemContent;
	}
	public int getQtBoardId() {
		return qtBoardId;
	}
	public void setQtBoardId(int qtBoardId) {
		this.qtBoardId = qtBoardId;
	}
	public int getItemId() {
		return itemId;
	}
	public void setItemId(int itemId) {
		this.itemId = itemId;
	}
	public String getItemMultiYn() {
		return itemMultiYn;
	}
	public void setItemMultiYn(String itemMultiYn) {
		this.itemMultiYn = itemMultiYn;
	}
	
}
