package com.joinwork.emp.dao;

import java.sql.SQLException;
import java.util.List;

import com.joinwork.addbook.command.AddBookEmpCommand;
import com.joinwork.common.dto.AuthVO;
import com.joinwork.emp.dto.EmpVO;
import com.joinwork.treeview.command.DeptDetailCommand;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("empDAO")
public interface EmpDAO {
	EmpVO selectEmpById(String empId) throws SQLException;
	
	String selectOfficialById(String empId) throws SQLException;
	
	List<DeptDetailCommand> selectDeptDetail(String deptId) throws SQLException;
	
	String selectDeptNameById(String empId) throws SQLException;
	
	/** 직원 전체 리스트 조회 */
	List<EmpVO> selectEmpList() throws SQLException;
	
	/** 직원 페이징 리스트 조회 */
	List<EmpVO> selectEmpPagingList(EmpVO searchEmpVO) throws SQLException;

	/** 사원번호 생성을 위한 시퀀스 번호*/
	String selectNextEmpSeq() throws SQLException;
	
	/** 해당 직책을 사용하는 직원리스트 조회  -- 삭제예정*/
	List<EmpVO> selectEmpListByOfficialId(String codeOfficialId) throws SQLException;
	
	/** 해당 직책을 사용하는 직원 페이징리스트 조회 */
	List<EmpVO> selectEmpPagingListByOfficialId(EmpVO searchEmpVO) throws SQLException;
	
	/** 해당 부서를 사용하는 직원리스트 조회 */
	List<EmpVO> selectEmpIdListByDeptId(EmpVO empVO) throws SQLException;
	
	/** 전체 직원 수 조회*/
	int selectEmpCount(EmpVO searchEmpVO) throws SQLException;
	
	/** 직책 사용하는 직원 수 조회*/
	int selectOfficialEmpCount(EmpVO empVO) throws SQLException;
	
	/** 직원 등록 */
	void insertEmp(EmpVO emp) throws SQLException;
	
	/**내정보 수정*/
	void updateEmp(EmpVO empVO)throws SQLException;
	
	/**사원명, 직급명, 직책명 조회*/
	List<EmpVO> selectEmpNameOfficialDeptByEmpId() throws SQLException;
	
	/**내정보에서 비밀번호 변경**/
	void updateEmpPwd(EmpVO empVO) throws SQLException;

	int selectEmpByPwd(EmpVO empVO) throws SQLException;

	String checkSignYn(String empId) throws SQLException;

	void updateSign(EmpVO empVO) throws SQLException;
	
	void updateEmpMyPage(EmpVO empVO) throws SQLException;
	
	List<EmpVO> searchLoginUserList(EmpVO empVO) throws SQLException;
	
	List<EmpVO> selectMyDeptEmpList(EmpVO empVO) throws SQLException;
	
	//------------------ 권한 관련 ----------------------------
	List<AuthVO> selectAuth() throws SQLException;
}
