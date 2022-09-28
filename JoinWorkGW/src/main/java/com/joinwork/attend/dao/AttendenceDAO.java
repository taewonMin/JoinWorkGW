package com.joinwork.attend.dao;

import java.sql.SQLException;

import java.util.List;
import java.util.Map;

import com.joinwork.attend.command.AttendenceListCommand;
import com.joinwork.attend.dto.AttendenceVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
@Mapper("attendenceDAO")
public interface AttendenceDAO {
	
	List<AttendenceVO> selectAttendenceList(AttendenceVO attendenceVO)throws SQLException;
	
	List<AttendenceVO> selectDeptAttendenceList(AttendenceVO attendenceVO)throws SQLException;
	
	void insertStartWork(Map<String, Object> dataMap) throws SQLException;
	
	void insertStartWorkLate(Map<String, Object> dataMap) throws SQLException;
	
	AttendenceVO getResentWork(String empId)throws SQLException;
	
	void insertEndWork(Map<String, Object> dataMap)throws SQLException;

	List<AttendenceListCommand> selectDeptAttendenceLsit(String deptId)throws SQLException;

	List<AttendenceVO> selectDeptMember(String deptId)throws SQLException;

	String getHistoryAttendTime(String empId) throws SQLException;
	String getHistoryAttendEndTime(String empId) throws SQLException;

	String[] getMembersAttendenceST(Map<String, Object> empIdAndMinMaxDate)throws SQLException;

	String getAttendenceEmpDept(AttendenceVO attendenceVO)throws SQLException;

	String getAttendenceEmpTeamDept(AttendenceVO attendenceVO)throws SQLException;

	String getDeptName(String empId)throws SQLException;

	String getTeamDeptName(String empId)throws SQLException;
	
	void updateReason(AttendenceVO attendenceVO)throws SQLException;

	int selectAttendenceListCnt(AttendenceVO attendenceVO)throws SQLException;
	
	int selectDeptAttendenceListCnt(AttendenceVO attendenceVO)throws SQLException;

	int selectNomalCnt(AttendenceVO attendenceVO)throws SQLException;
	
	int selectLateCnt(AttendenceVO attendenceVO)throws SQLException;
	
	AttendenceVO selectDeptTotCnt(AttendenceVO attendenceVO)throws SQLException;
	
	List<AttendenceVO> selectDeptAttendenceNoPagingList(AttendenceVO attendenceVO)throws SQLException;
	
	void updateLeavingTimeScheduler()throws SQLException;
	
}
