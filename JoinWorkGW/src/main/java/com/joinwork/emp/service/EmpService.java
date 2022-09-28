 package com.joinwork.emp.service;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.joinwork.approval.dto.ApprovalAttachVO;
import com.joinwork.board.BoardFormVO;
import com.joinwork.common.command.FileUploadCommand;
import com.joinwork.common.dao.DashboardDAO;
import com.joinwork.common.dto.AuthVO;
import com.joinwork.emp.dao.EmpDAO;
import com.joinwork.emp.dto.EmpVO;
import com.joinwork.exception.InvalidPasswordException;
import com.joinwork.exception.NotFoundIDException;
import com.joinwork.treeview.command.DeptDetailCommand;

public class EmpService {
	
	@Autowired
	private DashboardDAO dashboardDAO;
	
	private EmpDAO empDAO;
	public void setEmpDAO(EmpDAO empDAO) {
		this.empDAO = empDAO;
	}
	
	public EmpVO getEmp(String empId) throws SQLException {
		EmpVO emp = empDAO.selectEmpById(empId);
		
		return emp;
	}

	public String getEmpOfficialName(String empId) throws SQLException {
		String officialPositionName = empDAO.selectOfficialById(empId);
		return officialPositionName;
	}
	
	public String getDeptNameById(String empId) throws SQLException {
		String deptName = empDAO.selectDeptNameById(empId);
		return deptName;
	}

	public void login(String empId, String empPwd , HttpSession session)
			throws SQLException, NotFoundIDException, InvalidPasswordException {
		EmpVO emp = empDAO.selectEmpById(empId);
		if(emp == null)
			throw new NotFoundIDException();
		if(!empPwd.equals(emp.getEmpPwd()))
			throw new InvalidPasswordException();
		
		session.setAttribute("loginUser", emp);
			
	}
	
	public List<DeptDetailCommand> getDeptDetail(String deptId) throws SQLException {
		List<DeptDetailCommand> deptList = empDAO.selectDeptDetail(deptId);
		return deptList;
	}
	
	public List<EmpVO> selectEmpList() throws SQLException{
		List<EmpVO> empList = empDAO.selectEmpList();
		return empList;
	}
	
	public List<EmpVO> selectEmpPagingList(EmpVO searchEmpVO) throws SQLException{
		List<EmpVO> empList = empDAO.selectEmpPagingList(searchEmpVO);
		return empList;
	}
	
	public String createId(String empDate) throws SQLException{
		String empSeq = empDAO.selectNextEmpSeq();
		
		String[] dateArr = empDate.split("-");
	
		String empId = dateArr[0]+dateArr[1]+"JW"+empSeq;
		
		return empId;
		
	}
	
	public void registEmp(EmpVO emp) throws SQLException{
		empDAO.insertEmp(emp);
		dashboardDAO.insertDashboard(emp);
	}
	
	public List<EmpVO> selectEmpListByOfficialId(String codeOfficialId) throws SQLException{
		List<EmpVO> empList = empDAO.selectEmpListByOfficialId(codeOfficialId);
		return empList;
	}
	
	public List<EmpVO> selectEmpPagingListByOfficialId(EmpVO searchEmpVO) throws SQLException{
		List<EmpVO> empList = empDAO.selectEmpPagingListByOfficialId(searchEmpVO);
		return empList;
	}
	
	public int selectEmpCount(EmpVO searchEmpVO) throws SQLException{
		return empDAO.selectEmpCount(searchEmpVO);
	}
	
	public int selectOfficialEmpCount(EmpVO empVO) throws SQLException{
		return empDAO.selectOfficialEmpCount(empVO);
	}

	public void modify(BoardFormVO boardFormVO)throws SQLException {
		EmpVO empVO = boardFormVO.getEmpVO();
		empDAO.updateEmp(empVO);
		
	}
	
	public void modifyEmpByEmpVO(EmpVO empVO) throws SQLException{
		try {
			empDAO.updateEmp(empVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public List<EmpVO> selectEmpNameOfficialDeptByEmpId() throws SQLException{
		List<EmpVO> empList = empDAO.selectEmpNameOfficialDeptByEmpId();
		return empList;
	}
	
	public List<EmpVO> selectEmpIdListByDeptId(EmpVO empVO) throws SQLException{
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		
		if("dept".equals(empVO.getFlag())) {
			EmpVO emp = (EmpVO)session.getAttribute("loginUser");
			String deptId = emp.getDeptId();
			empVO.setDeptId(deptId);
		}else if("team".equals(empVO.getFlag())) {
			EmpVO emp = (EmpVO)session.getAttribute("loginUser");
			String teamId = emp.getTeamId();
			empVO.setTeamId(teamId);
			
		}
		List<EmpVO> empList = empDAO.selectEmpIdListByDeptId(empVO);
		return empList;
	}
	
	
	public void modifyEmpPwd(EmpVO empVO) throws SQLException{
		//session에서 사용자 정보 추출
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		empVO.setEmpId(empId);
		
		empDAO.updateEmpPwd(empVO);
	}

	public EmpVO checkEmpUdateYn() throws SQLException {
		//session에서 사용자 정보 추출
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		
		emp = empDAO.selectEmpById(empId);
		return emp;
	}
	
	public int compareEmpByPwd(EmpVO empVO) throws SQLException {
		//session에서 사용자 정보 추출
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		
		empVO.setEmpId(empId);
		int cnt = empDAO.selectEmpByPwd(empVO);
		
		return cnt;
	}
	
	public String checkSignYn() throws SQLException {
		//session에서 사용자 정보 추출
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		
		String checkYn = empDAO.checkSignYn(empId);
		return checkYn;
	}

	public void registSign(EmpVO empVO) throws IllegalStateException, IOException, SQLException {
		FileUploadCommand fileUploadCommand = empVO.getFileUploadCommand();
		String fileUploadPath = fileUploadCommand.getFileUploadPath();
		List<MultipartFile> files = (List<MultipartFile>)fileUploadCommand.getUploadFile();
		
		for(MultipartFile file : files) {
				
				File target = new File(fileUploadPath, empVO.getEmpId()+".png");
				
				if (!target.exists()) {
					target.mkdirs();
				}
				//파일 생성
				file.transferTo(target);
				//디비에 정보 입력
				empDAO.updateSign(empVO);
			}
		}

	public void modifyEmp(EmpVO empVO) throws SQLException {
		empDAO.updateEmpMyPage(empVO);
	}
	
	public List<EmpVO> searchLoginUserList(EmpVO empVO) throws SQLException{
		return empDAO.searchLoginUserList(empVO);
	}
	
	public List<EmpVO> getMyDeptEmpList(EmpVO empVO) throws SQLException{
		return empDAO.selectMyDeptEmpList(empVO);
	}
	
	//------------------------------- 권한 관련 -----------------------------------
	public List<AuthVO> selectAuth() throws SQLException{
		return empDAO.selectAuth();
	}
}
