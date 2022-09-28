package com.joinwork.common.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joinwork.common.dao.AlarmDAO;
import com.joinwork.common.dto.AlarmManageVO;
import com.joinwork.common.dto.AlarmVO;
import com.joinwork.emp.dto.EmpVO;

@Service("alarmService")
public class AlarmService {
	
	@Autowired
	private AlarmDAO alarmDAO;
	
	public String saveAlarm(AlarmVO alarmVO) throws SQLException{
		EmpVO empVO = new EmpVO();
		empVO.setEmpId(alarmVO.getEmpReaderId());
		
		AlarmManageVO alarmManageVO = alarmDAO.selectAlarmManage(empVO);
		
		// 수신 거부설정 확인
		String category = alarmVO.getAlarmCategory();
		String check = "";
		switch(category) {
		case "업무관리":
			check = alarmManageVO.getAlarmDuty();
			break;
		case "전자결재":
			check = alarmManageVO.getAlarmApproval();
			break;
		case "시설예약":
			check = alarmManageVO.getAlarmReservation();
			break;
		case "게시판":
			check = alarmManageVO.getAlarmBoard();
			break;
		case "일정관리":
			check = alarmManageVO.getAlarmSchedule();
			break;
		case "근태관리":
			check = alarmManageVO.getAlarmAttend();
			break;
		case "관리자":
			check = "Y";
			break;
		}
		
		if("Y".equals(check)) {
			alarmDAO.insertAlarm(alarmVO);
			return "save";
		}
		
		return "ignore";
	}
	
	public void modifyAlarm(AlarmVO alarmVO) throws SQLException{
		alarmDAO.updateAlarm(alarmVO);
	}
	
	public void modifyAlarmManage(AlarmManageVO alarmManageVO) throws SQLException{
		alarmDAO.updateAlarmManage(alarmManageVO);
	}
	
	public void removeAlarm(AlarmVO alarmVO) throws SQLException{
		alarmDAO.deleteAlarm(alarmVO);
	}
	
	public List<AlarmVO> getAlarmList(EmpVO empVO) throws SQLException{
		return alarmDAO.selectAlarmList(empVO);
	}
	
	public List<AlarmVO> getAllAlarmList(EmpVO empVO) throws SQLException{
		return alarmDAO.selectAllAlarmList(empVO);
	}
	
	public int getNewAlarmCount(EmpVO empVO) throws SQLException{
		return alarmDAO.selectNewAlarmCount(empVO);
	}
	
	public AlarmManageVO getAlarmSetting(EmpVO empVO) throws SQLException{
		return alarmDAO.selectAlarmManage(empVO);
	}
}
