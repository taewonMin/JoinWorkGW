package com.joinwork.addbook.dao;

import java.sql.SQLException;
import java.util.List;

import com.joinwork.addbook.command.AddBookEmpCommand;
import com.joinwork.addbook.dto.AddBookVO;
import com.joinwork.emp.dto.EmpVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("addBookDAO")
public interface AddBookDAO {

	/** 주소록 등록*/
	public void insertAddBookManage(AddBookVO addBookVO) throws SQLException;

	/** 주소록 그룹(폴더) 등록*/
	public void insertAddBook(AddBookVO addBookVO) throws SQLException;
	
	/** 주소록 리스트 조회*/
	public List<AddBookVO> selectCompanyPagingList(AddBookVO searchAddBookVO) throws SQLException;
	
	/** 개인주소록 전체리스트 조회*/
	public List<AddBookVO> selectPrivatePagingList(AddBookVO searchAddBookVO) throws SQLException;
	
	/** 개인주소록 리스트 전체 갯수 조회*/
	public int selectPrivateListTotalCount(AddBookVO searchAddBookVO) throws SQLException;
	
	/** 회사주소록 리스트 전체 갯수 조회*/
	public int selectCompanyListTotalCount(AddBookVO searchAddBookVO) throws SQLException;
	
	/** 회사주소록용 직원목록 페이징 리스트.*/
	public List<EmpVO> selectEmpPagingList(AddBookVO searchAddBookVO) throws SQLException;
	
	/** 회사주소록 상세조회*/
	public AddBookEmpCommand selectEmpByEmpIdForAddBook(AddBookVO addBookVO) throws SQLException;
	
	/** 주소록관리번호로 주소록 개별조회*/
	public AddBookVO selectAddBookManageByManageId(AddBookVO addBookVO) throws SQLException;
	
	/** 주소록 그룹 목록 조회*/
	public List<AddBookVO> selectAddBookGroupList(AddBookVO addBookVO) throws SQLException;
	
	/** addBookId로 주소록 그룹 조회*/
	public AddBookVO selectAddBookByAddBookId(AddBookVO addBookVO) throws SQLException;

	/** 주소록(addBookId)에 포함된 주소 갯수 조회*/
	public int selectAddBookCount(AddBookVO addBookVO) throws SQLException;
	
	/** 회사주소록 저장을 위한 직원리스트 조회*/
	List<AddBookEmpCommand> selectEmpForAddBook() throws SQLException;
	
	/** 주소록 그룹 이름 조회*/
	public int dupleCheckAddBookTitle(AddBookVO addBookVO) throws SQLException;
	
	/**manageId로 주소록 상세정보 조회*/
	public AddBookVO selectAddBookByManageId(AddBookVO addBookVO) throws SQLException;
	
	/** 주소록관리번호로 주소록 수정*/
	public void updateAddBookManage(AddBookVO addBookVO) throws SQLException;

	/** 주소록 그룹번호로 주소록 그룹 수정 for 주소록그룹 삭제 시 전체로 이동*/
	public void updateAddBookIdToZero(AddBookVO addBookVO) throws SQLException;
	
	/** 주소록 그룹 수정*/
	public void updateAddBookGroup(AddBookVO addBookVO) throws SQLException;
	
	/** 주소록 그룹 삭제*/
	public void removeAddBookGroup(AddBookVO addBookVO) throws SQLException;
	
	/** 개인주소록 삭제*/
	public void deletePrivateAddBook(AddBookVO addBookVO) throws SQLException;
	
	/**회사 주소록 등록 전 기존 등록되어있던 주소 삭제*/
	public void deleteAddBookManageBeforeSync(AddBookVO addBookVO) throws SQLException;
	
	
}
