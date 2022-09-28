package com.joinwork.common.service;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.joinwork.common.dao.DeptDAO;
import com.joinwork.common.dto.DeptVO;
import com.joinwork.emp.dto.EmpVO;

public class DeptService {
	
	private DeptDAO deptDAO;
	public void setDeptDAO(DeptDAO deptDAO) {
		this.deptDAO = deptDAO;
	}
	
	public List<DeptVO> selectAllDeptName() throws SQLException{
		List<DeptVO> deptNameList = deptDAO.selectAllDeptName();
		
		return deptNameList;
	}
	
	public List<DeptVO> selectDeptListByTeamYn(DeptVO deptVO) throws SQLException{
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String deptId = emp.getDeptId();
		String empId = emp.getEmpId();
		
		deptVO.setDeptId(deptId);
		if(StringUtils.isEmpty(deptVO.getFlag()) && !"adminDept".equals(deptVO.getFlag())) deptVO.setEmpId(empId);
		
		List<DeptVO> DeptList = deptDAO.selectDeptListByTeamYn(deptVO);
		return DeptList;
	}
	
	public List<DeptVO> selectDeptPagingList(DeptVO searchDeptVO) throws SQLException{
		List<DeptVO> deptList = deptDAO.selectDeptPagingList(searchDeptVO);
		
//		for(DeptVO deptVO : deptList) {
//			if(!"없음".equals(deptVO.getDeptLeaderId())) {
//				String leaderName = deptDAO.selectEmpNameByLeaderId(deptVO.getDeptLeaderId());
//				deptVO.setDeptLeaderName(leaderName);
//			}
//		}
		
		return deptList;
	}
	
	public int selectDeptCount(DeptVO searchDeptVO) throws SQLException{
		return deptDAO.selectDeptCount(searchDeptVO);
	}
	
	public int seletDeptEmpCount(DeptVO deptVO) throws SQLException{
		return deptDAO.seletDeptEmpCount(deptVO);
	}
	
	public void insertDept(DeptVO deptVO) throws SQLException{
		deptDAO.insertDept(deptVO);
	}

	public DeptVO selectDeptByDeptId(String deptId) {
		
		DeptVO deptVO = new DeptVO();
		
		deptVO.setDeptId(deptId);
		deptVO = deptDAO.selectDeptByDeptId(deptVO);
		
		return deptVO;
	}

	public void registDept(DeptVO deptVO) throws SQLException {
		deptDAO.insertDept(deptVO);
	}

	public int dupleCheckDeptName(String deptName) {
		int result = deptDAO.dupleCheckDeptName(deptName);
		return result;
	}

	public void modifyDept(DeptVO deptVO) {
		deptDAO.updateDept(deptVO);
	}
	
}
