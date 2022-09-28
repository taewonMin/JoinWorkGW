package com.joinwork.addbook.service;

import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.joinwork.addbook.command.AddBookEmpCommand;
import com.joinwork.addbook.command.AddBookRegistCommand;
import com.joinwork.addbook.dao.AddBookDAO;
import com.joinwork.addbook.dto.AddBookFormVO;
import com.joinwork.addbook.dto.AddBookVO;
import com.joinwork.emp.dto.EmpVO;

public class AddBookService {

	private AddBookDAO addBookDAO;
	public void setAddBookDAO(AddBookDAO addBookDAO) {
		this.addBookDAO = addBookDAO;
	}
	
	@Resource(name="companyCodeAddId")
	private String companyCodeAddId;
	
	/** 개인 주소록 등록*/
	public void registPrivateAddBook(AddBookFormVO addBookFormVO) throws SQLException{
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		
		AddBookVO addBookVO = null;
		if(StringUtils.isEmpty((addBookFormVO.getAddBookVO()).getEmpId())) {
			AddBookRegistCommand addBookCommand = addBookFormVO.getAddBookRegistCommand();
			addBookVO = addBookCommand.toAddBookVO();
		}else {
			addBookVO = addBookFormVO.getAddBookVO();
//			BeanUtils.copyProperties(addBookRegistCommand, addBookVO);
		}
		addBookVO.setEmpWriterId(empId);
		
		addBookDAO.insertAddBookManage(addBookVO);
	}
	
	//TODO 아직 안쓰는 중
	/** 회사 주소록 등록*/
	public void registCompanyAddBook(List<AddBookVO> addBookList)  throws SQLException {
		for(AddBookVO vo : addBookList) {
			vo.setEmpWriterId("980221JW0001");
			addBookDAO.insertAddBookManage(vo);
		}
	}
	
	/** 주소록 그룹 생성*/
	public void registAddBookGroup(AddBookVO addBook)  throws SQLException{
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		
		addBook.setEmpWriterId(empId);
		addBookDAO.insertAddBook(addBook);
	}
	
	/** 회사주소록 리스트 조회 */
	public List<AddBookVO> selectCompanyPagingList(AddBookVO searchAddBookVO)  throws SQLException{
		List<AddBookVO> addBookList = new ArrayList<AddBookVO>();
		try {
			addBookList = addBookDAO.selectCompanyPagingList(searchAddBookVO);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return addBookList;
	}
	
	/** 개인주소록 전체리스트 조회*/
	public List<AddBookVO> selectPrivatePagingList(AddBookVO searchAddBookVO) throws SQLException{
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		
		searchAddBookVO.setEmpWriterId(empId);
		
		List<AddBookVO> addBookList = addBookDAO.selectPrivatePagingList(searchAddBookVO);
		
//		for(AddBookVO vo : addBookList) {
//			if(vo.getAddBookId() == 0) {
//				vo.setAddBookTitle("전체주소록");
//			}else {
//				String title = (addBookDAO.selectAddBookManageByManageId(vo)).getAddBookTitle();
//				vo.setAddBookTitle(title);
//			}
//			
//		}
		
		
		return addBookList;
	}
	
	/** 개인주소록 리스트 전체 갯수*/
	public int selectPrivateListTotalCount(AddBookVO searchAddBookVO) throws SQLException{
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		
		searchAddBookVO.setEmpWriterId(empId);
		
		return addBookDAO.selectPrivateListTotalCount(searchAddBookVO);
	}
	
	/** 회사주소록 리스트 전체 갯수*/
	public int selectCompanyListTotalCount(AddBookVO searchAddBookVO) throws SQLException{
		return addBookDAO.selectCompanyListTotalCount(searchAddBookVO);
	}
	
	/** 주소록관리번호로 주소록 개별조회*/
	public AddBookFormVO selectAddBookManageByManageId(AddBookVO addBook) throws SQLException{
		
		AddBookVO returnAddBook = addBookDAO.selectAddBookManageByManageId(addBook);
		if(returnAddBook.getAddBookId() == 0) {
			returnAddBook.setAddBookTitle("전체주소록");
		}else {
			String addBookTitle = (addBookDAO.selectAddBookByAddBookId(returnAddBook)).getAddBookTitle();
			returnAddBook.setAddBookTitle(addBookTitle);
		}
		
		AddBookFormVO addBookFormVO = new AddBookFormVO();
		
		if("modify".equals(addBook.getFlag())) {
			AddBookRegistCommand addBookRegistCommand = new AddBookRegistCommand();
			try {
				BeanUtils.copyProperties(addBookRegistCommand, returnAddBook);
				
				String[] hp = addBookRegistCommand.getManageHp();
				String [] manageHpArr = null;
				if(hp.length > 0) manageHpArr = hp[0].split("-");
				
				
				
				addBookRegistCommand.setManageHp(manageHpArr);
				
				addBookFormVO.setAddBookRegistCommand(addBookRegistCommand);
				
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}
		}else {
			addBookFormVO.setAddBookVO(returnAddBook);
		}
		
		return addBookFormVO;
	}
	
	/**empid로 회사주소록 개별조회*/
	public AddBookVO selectEmpByEmpIdForAddBook(AddBookVO addBookVO) throws SQLException{
		AddBookEmpCommand addBookCommand = addBookDAO.selectEmpByEmpIdForAddBook(addBookVO);
		AddBookVO returnedAddBookVO = addBookCommand.toAddBookVO();
		returnedAddBookVO.setAddBookId(addBookVO.getAddBookId());
//		if(returnedAddBookVO.getAddBookId() == 1) {
//			returnedAddBookVO.setAddBookTitle("회사주소록");
//		}
		
		return returnedAddBookVO;
	}
	
	/** 주소록 그룹 목록 조회*/
	public List<AddBookVO> selectAddBookGroupList(AddBookVO addBookVO) throws SQLException{
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		addBookVO.setEmpWriterId(empId);
		
		List<AddBookVO> groupList = addBookDAO.selectAddBookGroupList(addBookVO);
		return groupList;
	}
	
	/** addBookId로 주소록 그룹 조회*/
	public AddBookVO selectAddBookByAddBookId(AddBookVO addBookVO) throws SQLException{
		AddBookVO returnedAddBookVO = addBookDAO.selectAddBookByAddBookId(addBookVO);
		
		return returnedAddBookVO;
		
	}

	
	/**주소록(addBookId)에 포함된 주소 갯수 조회*/
	public int selectAddBookCount(AddBookVO addBookVO) throws SQLException{
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		addBookVO.setEmpWriterId(empId);
		
		int count = addBookDAO.selectAddBookCount(addBookVO);
		
		return count ;
	}
	
	/**개인주소록 그룹 이름 조회(중복검사용)*/
	public int dupleCheckAddBookTitle(AddBookVO addBookVO) throws SQLException{
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		addBookVO.setEmpWriterId(empId);
		
		int count = addBookDAO.dupleCheckAddBookTitle(addBookVO);
		
		return count; 
	}
	
	/**manageId로 주소록 상세정보 조회*/
	public AddBookVO selectAddBookByManageId(AddBookVO addBookVO) throws SQLException{
		
		AddBookVO returnedAddBookVO = addBookDAO.selectAddBookManageByManageId(addBookVO);
		
		return returnedAddBookVO;
	}
	
	/**회사주소록 저장을 위한 직원리스트 조회*/
//	public List<AddBookEmpCommand> selectEmpForAddBook() throws SQLException{
//		List<AddBookEmpCommand> addBookList = addBookDAO.selectEmpForAddBook();
//		return addBookList;
//	}
	
	/** 주소록관리번호로 주소록 수정*/
	public void updateAddBookManage(AddBookFormVO addBookFormVO) throws SQLException{
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		addBookFormVO.getAddBookVO().setEmpWriterId(empId);
		
		AddBookRegistCommand addBookRegistCommand = new AddBookRegistCommand();
		try {
			BeanUtils.copyProperties(addBookRegistCommand, addBookFormVO.getAddBookVO());
			addBookFormVO.getAddBookRegistCommand().setEmpWriterId(empId);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		
		if(Integer.parseInt(addBookRegistCommand.getManageId()) == 0) { // 수정 시 진입.
			addBookDAO.updateAddBookManage(addBookFormVO.getAddBookRegistCommand().toAddBookVO());
		}else {
			AddBookVO addBookVO = addBookRegistCommand.toAddBookVO();
			addBookDAO.updateAddBookManage(addBookVO);
		}
	}
	
	/** 주소록 그룹번호로 주소록 그룹 수정*/
	public void updateAddBookIdToZero(AddBookVO addBookVO) throws SQLException{
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);
		
		EmpVO emp = (EmpVO) session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		addBookVO.setEmpWriterId(empId);
		try {
			addBookDAO.updateAddBookIdToZero(addBookVO);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/** 주소록 그룹 수정*/
	public void modifyAddBookGroup(AddBookVO addBookVO) throws SQLException{
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		addBookVO.setEmpWriterId(empId);
		
		addBookDAO.updateAddBookGroup(addBookVO);
	}
	
	/** 주소록 그룹 삭제*/
	public void removeAddBookGroup(AddBookVO addBookVO) throws SQLException{
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		addBookVO.setEmpWriterId(empId);
		
		addBookDAO.removeAddBookGroup(addBookVO);
		
	}
	
	/** 개인주소록 삭제*/
	public void removePrivateAddBook(AddBookVO addBookVO) throws SQLException{
		//TODO
//		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
//		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
//		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
//		String empId = emp.getEmpId();
		
		addBookDAO.deletePrivateAddBook(addBookVO);
	}
	
	/** 회사 주소록 등록 전 기존 주소록 삭제*/
	public void deleteAddBookManageBeforeSync(AddBookVO addBookVO) throws SQLException{
		addBookDAO.deleteAddBookManageBeforeSync(addBookVO);
	}
	
	


	
	

	


	
	
	

	

	
	
}
