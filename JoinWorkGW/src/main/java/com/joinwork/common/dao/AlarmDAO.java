package com.joinwork.common.dao;

import java.sql.SQLException;
import java.util.List;

import com.joinwork.common.dto.AlarmManageVO;
import com.joinwork.common.dto.AlarmVO;
import com.joinwork.emp.dto.EmpVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("alarmDAO")
public interface AlarmDAO {	
	
	public void insertAlarm(AlarmVO alarmVO) throws SQLException;
	
	public void updateAlarm(AlarmVO alarmVO) throws SQLException;
	
	public void updateAlarmUrl(AlarmVO alarmVO) throws SQLException;
	
	public void updateAlarmManage(AlarmManageVO alarmManageVO) throws SQLException;
	
	public void deleteAlarm(AlarmVO alarmVO) throws SQLException;
	
	public List<AlarmVO> selectAlarmList(EmpVO empVO) throws SQLException;
	
	public List<AlarmVO> selectAllAlarmList(EmpVO empVO) throws SQLException;
	
	public int selectNewAlarmCount(EmpVO empVO) throws SQLException;
	
	public AlarmManageVO selectAlarmManage(EmpVO empVO) throws SQLException;
}
