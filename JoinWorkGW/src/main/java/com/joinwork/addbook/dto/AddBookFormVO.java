package com.joinwork.addbook.dto;

import com.joinwork.addbook.command.AddBookRegistCommand;
import com.joinwork.common.dto.BaseVO;
import com.joinwork.emp.dto.EmpVO;

public class AddBookFormVO extends BaseVO{

	private AddBookVO addBookVO;
	private AddBookVO searchAddBookVO;
	private AddBookRegistCommand AddBookRegistCommand;


	public AddBookFormVO() {
		this.addBookVO = new AddBookVO();
		this.searchAddBookVO = new AddBookVO();
		this.AddBookRegistCommand = new AddBookRegistCommand();
	}

	public AddBookVO getAddBookVO() {
		return addBookVO;
	}
	public void setAddBookVO(AddBookVO addBookVO) {
		this.addBookVO = addBookVO;
	}
	public AddBookVO getSearchAddBookVO() {
		return searchAddBookVO;
	}
	public void setSearchAddBookVO(AddBookVO searchAddBookVO) {
		this.searchAddBookVO = searchAddBookVO;
	}
	public AddBookRegistCommand getAddBookRegistCommand() {
		return AddBookRegistCommand;
	}
	public void setAddBookRegistCommand(AddBookRegistCommand addBookRegistCommand) {
		AddBookRegistCommand = addBookRegistCommand;
	}
	
}
